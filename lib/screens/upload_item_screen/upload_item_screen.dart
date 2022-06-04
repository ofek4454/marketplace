// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weave_marketplace/dummy_data.dart';
import 'package:weave_marketplace/screens/upload_item_screen/local_widgets/image_uploader.dart';
import 'package:weave_marketplace/screens/upload_item_screen/local_widgets/multiselect.dart';
import 'package:weave_marketplace/screens/upload_item_screen/local_widgets/progress_bar.dart';

class UploadItemScreen extends StatefulWidget {
  const UploadItemScreen({Key? key}) : super(key: key);

  @override
  State<UploadItemScreen> createState() => _UploadItemScreenState();
}

class _UploadItemScreenState extends State<UploadItemScreen> {
  final _formKey = GlobalKey<FormState>();
  double progress = 0.0;
  List<File> images = [];
  Color? suffixColor;
  List<String> categories = [];

  final TextEditingController _categories_controller = TextEditingController();
  final TextEditingController _name_controller = TextEditingController();
  final TextEditingController _decription_controller = TextEditingController();
  final TextEditingController _price_controller = TextEditingController();

  Future<void> get_images() async {
    final int last_selection = images.length;
    final ImagePicker _picker = ImagePicker();
    final res = await _picker.pickMultiImage();
    if (res == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No photos selected'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    res.forEach((element) => images.add(File(element.path)));
    setState(() {
      if (res.isNotEmpty && last_selection == 0) {
        progress = min(progress + 20, 100);
      } else if (res.isEmpty && last_selection != 0) {
        progress = max(progress - 20, 0);
      }
    });
  }

  Future<void> clear_images() async {
    int last = images.length;
    images.clear();
    setState(() {
      if (last != 0) progress = max(progress - 20, 0);
    });
  }

  Widget _build_input_box({
    String? label,
    bool? multiline = false,
    TextEditingController? controller,
    TextInputType keyboard = TextInputType.text,
    Function? validator,
  }) {
    final String last_val = controller!.text;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        maxLines: multiline! ? 10 : 1,
        minLines: multiline ? 2 : 1,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.amber,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
          ),
        ),
        keyboardType: keyboard,
        onFieldSubmitted: (val) {
          if (val.isNotEmpty && last_val.isEmpty) {
            setState(() {
              progress = min(progress + 20, 100);
            });
          } else if (val.isEmpty && last_val.isNotEmpty) {
            progress = max(progress - 20, 0);
          }
        },
        validator: (val) {
          if (validator != null) return validator(val);
          if (val == null || val.isEmpty) return 'invalid input';
          return null;
        },
      ),
    );
  }

  Widget _build_category_picker() {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          suffixColor = hasFocus ? Colors.amber : null;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: _categories_controller,
          readOnly: true,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.amber,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            labelText: 'Categories',
            suffixIcon: Icon(
              Icons.arrow_drop_down_outlined,
              color: suffixColor,
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () => _showMultiSelect(),
          validator: (val) {
            if (val == null || val.isEmpty) return 'please select category';
            return null;
          },
        ),
      ),
    );
  }

  void _showMultiSelect() async {
    final String last_selection = _categories_controller.text;
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> _items = CATEGORIES;

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          items: _items,
          selected: categories,
        );
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        categories = results;
        String text = '';
        results.forEach((category) => text += '$category , ');
        if (results.isNotEmpty) text = text.substring(0, text.length - 2);

        _categories_controller.text = text;

        if (text.isNotEmpty && last_selection.isEmpty) {
          progress = min(progress + 20, 100);
        } else if (text.isEmpty && last_selection.isNotEmpty) {
          progress = max(progress - 20, 0);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: size.height,
            height: size.height,
            color: const Color(0x0F5F5F50),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Expanded(
                    child: ListView(
                      children: [
                        Row(
                          children: const [BackButton(color: Colors.black)],
                        ),
                        const SizedBox(height: 10),
                        ImageUploader(
                          images: images,
                          get_image: get_images,
                          clear_images: clear_images,
                        ),
                        const SizedBox(height: 10),
                        _build_input_box(
                          label: 'Product name',
                          controller: _name_controller,
                        ),
                        _build_input_box(
                          label: 'Description',
                          multiline: true,
                          controller: _decription_controller,
                        ),
                        _build_input_box(
                            label: 'Price',
                            keyboard: TextInputType.number,
                            controller: _price_controller,
                            validator: (String? val) {
                              if (val == null || val.isEmpty) {
                                return 'please select category';
                              }
                              return null;
                            }),
                        _build_category_picker(),
                      ],
                    ),
                  ),
                ),
                ProgressBar(progress: progress),
                const SizedBox(height: 10),
                SizedBox(
                  width: size.width * 0.85,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Upload',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

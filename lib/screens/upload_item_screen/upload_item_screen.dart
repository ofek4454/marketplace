// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:weave_marketplace/colors.dart';
import 'package:weave_marketplace/screens/upload_item_screen/local_widgets/image_uploader.dart';
import 'package:weave_marketplace/screens/upload_item_screen/local_widgets/multiselect.dart';
import 'package:weave_marketplace/screens/upload_item_screen/local_widgets/progress_bar.dart';
import 'package:weave_marketplace/services/item_service.dart';
import 'package:weave_marketplace/state_managment/marketplace_state.dart';
import 'package:weave_marketplace/state_managment/user_state.dart';

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
  bool isLoading = false;
  bool firstInit = true;
  int? itemsCount;

  final TextEditingController _categories_controller = TextEditingController();
  final TextEditingController _name_controller = TextEditingController();
  final TextEditingController _description_controller = TextEditingController();
  final TextEditingController _price_controller = TextEditingController();

  @override
  void didChangeDependencies() async {
    if (firstInit) {
      final userState = Provider.of<UserState>(context, listen: false);

      itemsCount = await _getCommunityItemsCount(userState.user!.communityId!);
      setState(() {
        firstInit = false;
      });
      checkIfCanUpload();
    }
    super.didChangeDependencies();
  }

  Future<void> _upload() async {
    bool validate = _formKey.currentState!.validate();
    if (!validate) return;

    if (images.length > 5) {
      validate = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Cannot upload more than 5 images, please remove some.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    try {
      final userState = Provider.of<UserState>(context, listen: false);

      setState(() {
        isLoading = true;
      });
      await ItemService().upload_item(
        user: userState.user,
        name: _name_controller.text,
        description: _description_controller.text,
        price: double.tryParse(_price_controller.text),
        category: categories,
        images: images,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Something went wrong!'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      print(e);
      setState(() {
        isLoading = false;
      });
      return;
    }
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Product uploaded successfully!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MAIN_COLOR,
      ),
    );
    Navigator.of(context).pop();
  }

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
      child: Focus(
        onFocusChange: (value) {
          if (value) return;
          final val = controller.text;
          if (val.isNotEmpty && last_val.isEmpty) {
            setState(() {
              progress = min(progress + 20, 100);
            });
          } else if (val.isEmpty && last_val.isNotEmpty) {
            progress = max(progress - 20, 0);
          }
        },
        child: TextFormField(
          controller: controller,
          maxLines: multiline! ? 10 : 1,
          minLines: multiline ? 2 : 1,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: MAIN_COLOR,
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
          cursorColor: MAIN_COLOR,
          keyboardType: keyboard,
          validator: (val) {
            if (validator != null) return validator(val);
            if (val == null || val.isEmpty) return 'invalid input';
            return null;
          },
        ),
      ),
    );
  }

  Widget _build_category_picker() {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          suffixColor = hasFocus ? MAIN_COLOR : null;
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
                color: MAIN_COLOR,
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
    final marketState = Provider.of<MarketPlaceState>(context, listen: false);
    final List<String> _items =
        marketState.categories!.map<String>((e) => e.name!).toList();
    _items.remove('All');

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

  Future<int?> _getCommunityItemsCount(String communityId) async {
    final _firestore = FirebaseFirestore.instance;
    int? retVal = -1;
    try {
      final doc = await _firestore
          .collection('communitys')
          .doc(communityId)
          .collection('marketplace')
          .get();
      retVal = doc.size;
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  void checkIfCanUpload() {
    if (itemsCount == -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Something went wrong!'),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
        Navigator.of(context).pop();
      });
    }

    if (itemsCount! > 50) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('maximun products to upload is 50!'),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
        Navigator.of(context).pop();
      });
    }
  }

  void removeSingleImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final userState = Provider.of<UserState>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: itemsCount == null
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : GestureDetector(
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
                                children: const [
                                  BackButton(color: Colors.black)
                                ],
                              ),
                              const SizedBox(height: 10),
                              ImageUploader(
                                images: images,
                                get_image: get_images,
                                clear_images: clear_images,
                                removeSingleImage: removeSingleImage,
                              ),
                              const SizedBox(height: 10),
                              _build_input_box(
                                label: 'Product name',
                                controller: _name_controller,
                              ),
                              _build_input_box(
                                label: 'Description',
                                multiline: true,
                                controller: _description_controller,
                              ),
                              _build_input_box(
                                  label: 'Price',
                                  keyboard: TextInputType.number,
                                  controller: _price_controller,
                                  validator: (String? val) {
                                    if (val == null ||
                                        val.isEmpty ||
                                        double.tryParse(val) == null) {
                                      return 'invalid input';
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
                          onPressed: isLoading ? null : () => _upload(),
                          child: isLoading
                              ? const CircularProgressIndicator.adaptive(
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(MAIN_COLOR),
                                )
                              : const Text(
                                  'Upload',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                          style: ElevatedButton.styleFrom(
                            primary: MAIN_COLOR,
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

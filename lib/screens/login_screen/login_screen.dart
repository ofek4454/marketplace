import 'package:flutter/material.dart';
import 'package:weave_marketplace/services/auth.dart';

enum CurrentState {
  Login,
  Signup,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();

  CurrentState state = CurrentState.Login;

  bool loading = false;

  Future<void> _onTap() async {
    final bool validate = _formKey.currentState!.validate();
    if (!validate) return;

    setState(() {
      loading = true;
    });
    try {
      final bool res = state == CurrentState.Login
          ? await Auth().logInUser(
              email: email_controller.text,
              password: password_controller.text,
            )
          : await Auth().signUpUser(
              email: email_controller.text,
              password: password_controller.text,
              name: name_controller.text,
            );
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${e}'),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          color: const Color(0x0F5F5F50),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: email_controller,
                  decoration: InputDecoration(
                    label: const Text('email'),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.amber,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(val)) {
                      return "Enter Correct Email Address";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: password_controller,
                  decoration: InputDecoration(
                    label: const Text('password'),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.amber,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty || val.length < 4)
                      return 'Enter password';
                    else
                      return null;
                  },
                ),
                const SizedBox(height: 20),
                if (state == CurrentState.Signup)
                  TextFormField(
                    controller: name_controller,
                    decoration: InputDecoration(
                      label: const Text('name'),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.amber,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty || val.length < 4)
                        return 'Enter name';
                      else
                        return null;
                    },
                  ),
                const SizedBox(height: 20),
                loading
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.amber),
                        onPressed: () => _onTap(),
                        child: Text(state.name),
                      ),
                const SizedBox(height: 20),
                if (!loading)
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      setState(() {
                        state = state == CurrentState.Login
                            ? CurrentState.Signup
                            : CurrentState.Login;
                      });
                    },
                    child:
                        Text(state == CurrentState.Login ? 'Signup' : 'Login'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

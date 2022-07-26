import 'package:flutter/material.dart';
import 'package:twich_ui_clone/screens/home_screen.dart';
import 'package:twich_ui_clone/utils/authMethods.dart';
import 'package:twich_ui_clone/widgets/custom_button.dart';
import 'package:twich_ui_clone/widgets/custom_text_field.dart';
import 'package:twich_ui_clone/widgets/loading_indicator.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthMethods _authMethods = AuthMethods();
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    bool res = await _authMethods.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passWordController.text,
      username: _userNameController.text,
    );
    if (res) {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _userNameController.dispose();
    _passWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
      ),
      body: _isLoading
          ? LoadingIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CustomTextField(controller: _emailController),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "UserName",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CustomTextField(controller: _userNameController),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CustomTextField(controller: _passWordController),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(onPressed: signUpUser, text: "Sign Up"),
                  ],
                ),
              ),
            ),
    );
  }
}

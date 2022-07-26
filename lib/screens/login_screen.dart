import 'package:flutter/material.dart';
import 'package:twich_ui_clone/screens/home_screen.dart';
import 'package:twich_ui_clone/utils/authMethods.dart';
import 'package:twich_ui_clone/widgets/custom_button.dart';
import 'package:twich_ui_clone/widgets/custom_text_field.dart';
import 'package:twich_ui_clone/widgets/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passWordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    bool res = await _authMethods.loginUser(
      context: context,
      email: _emailController.text,
      password: _passWordController.text,
    );
    if (res) {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                    CustomButton(onPressed: loginUser, text: "Login In"),
                  ],
                ),
              ),
            ),
    );
  }
}

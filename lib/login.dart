import 'package:flutter/material.dart';
import "auth.dart";
// import 'data.dart';
import 'constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String errorMessage = '';
  bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool showPassword = true;
  Future<void> _signIn() async {
    try {
      await auth.signIn(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'unknown':
            errorMessage = 'Please enter email and password!';
            break;
          case 'invalid-email':
            errorMessage = 'Please enter a valid email!';
            break;
          case 'missing-password':
            errorMessage = 'Please enter password!';
            break;
          case 'wrong-password':
            errorMessage = 'Password incorrect!';
            break;
        }
      });
    }
  }

  Widget _emailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: tFlabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: tfBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _controllerEmail,
            keyboardType: TextInputType.emailAddress,
            style: tFTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 15.0),
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your email',
              hintStyle: hintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: tFlabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: tfBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _controllerPassword,
            obscureText: showPassword,
            style: tFTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 15.0),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: 'Enter your password',
                hintStyle: hintTextStyle,
                suffixIcon: IconButton(
                  icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )),
          ),
        ),
      ],
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage,
      style: tFlabelStyle,
    );
  }

  Widget _submitButton() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 5.0,
              padding: const EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              backgroundColor: Colors.white),
          onPressed: () {
            _signIn();
          },
          child: Text(
            'Login',
            style: tFlabelStyle,
          ),
        ));
  }

  Widget _inputConfig() {
    return SizedBox(
        child: Column(
      children: <Widget>[
        Text(
          'Sign In',
          style: tFTextStyle.copyWith(fontSize: 30),
        ),
        const SizedBox(height: 20.0),
        _emailTF(),
        const SizedBox(
          height: 20.0,
        ),
        _passwordTF(),
        const SizedBox(
          height: 15.0,
        ),
        _errorMessage(),
        _submitButton(),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                padding: const EdgeInsets.fromLTRB(40, 80, 40, 50),
                color: const Color(0xff48a434),
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _inputConfig(),
                    Image.asset(
                      'assets/logo.png',
                      width: 100,
                      height: 100,
                    )
                  ],
                ))));
  }
}

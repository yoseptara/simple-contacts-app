import 'package:flutter/material.dart';
import 'package:simple_contacts_app/pages/contact-list/contact_list_page.dart';

final _findWhitespaceRegex = RegExp(r"\s");

class LoginPage extends StatelessWidget {
  static const route = '/login_page';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white, // Light blue at the top right
              Colors.lightBlue.shade200, // Old blue in the middle
              Colors.white,
            ],
            // Adjust the stops if needed to control the flow of the gradient
          ),
        ),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  color: Colors.white38,
                  border: Border.all(color: Colors.white, width: 2)),
              child: Center(
                child: Image.asset(
                  'images/ic_flutter.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
           const  Text(
              'Welcome To Flutter',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Please enter your details to continue',
              style: TextStyle(fontSize: 14, color: Colors.black38),
            ),
            const SizedBox(
              height: 20,
            ),
           const  _Form(),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }

    if (_findWhitespaceRegex.hasMatch(value)) {
      return 'Username with whitespace is not valid';
    }

    return null;
  }

  void submit() {
    if (_formKey.currentState?.validate() == true) {
      Navigator.pushNamed(context, ContactListPage.route);
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            validator: validateUsername,
            decoration: const InputDecoration(
              labelText: 'User Name',
              labelStyle: TextStyle(
                color: Colors.black54,
              ),
              filled: true,
              fillColor: Colors.white,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const InputPasswordField(),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Forgot password?',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 14, color: Colors.blue),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: submit,
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              backgroundColor: Colors.lightBlueAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class InputPasswordField extends StatefulWidget {
  const InputPasswordField({
    super.key,
  });

  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  bool isObscured = true;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (_findWhitespaceRegex.hasMatch(value)) {
      return 'Password with whitespace is not valid';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatePassword,
      obscureText: isObscured,
      decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: const TextStyle(
            color: Colors.black54,
          ),
          filled: true,
          fillColor: Colors.white,
          border: const UnderlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isObscured = !isObscured;
              });
            },
            icon: Icon(
              isObscured ? Icons.visibility : Icons.visibility_off,
              size: 24,
            ),
          )),
    );
  }
}

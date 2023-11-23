import 'package:flutter/material.dart';
import 'package:simple_contacts_app/pages/contact-list/contact_list_page.dart';

class LoginPage extends StatelessWidget {
  static const route = '/';

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
                  borderRadius: BorderRadius.all(
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
            Text(
              'Welcome To Flutter',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Please enter your details to continue',
              style: TextStyle(fontSize: 14, color: Colors.black38),
            ),
            const SizedBox(
              height: 20,
            ),
            _Form(),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    super.key,
  });

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final findWhitespaceRegex = RegExp(r"\s");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }

    if (findWhitespaceRegex.hasMatch(value)) {
      return 'Username with whitespace is not valid';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (findWhitespaceRegex.hasMatch(value)) {
      return 'Password with whitespace is not valid';
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
            decoration: InputDecoration(
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
          SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: validatePassword,
            decoration: InputDecoration(
              labelText: 'Password',
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

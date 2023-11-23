import 'package:flutter/material.dart';
import 'package:simple_contacts_app/pages/custom_widget_page.dart';
import 'package:simple_contacts_app/pages/login_page.dart';

class PageListPage extends StatelessWidget {
  static const route = '/';

  const PageListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.route);
                },
                child: Text('Contacts App Demo')),
            const SizedBox(
              height: 12,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, CustomWidgetPage.route);
                },
                child: Text('Custom Widget Demo')),
          ],
        ),
      ),
    );
  }
}

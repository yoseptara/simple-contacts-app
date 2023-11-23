import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_contacts_app/pages/contact-list/contact_list_page.dart';
import 'package:simple_contacts_app/pages/custom_widget_page.dart';
import 'package:simple_contacts_app/pages/login_page.dart';
import 'package:simple_contacts_app/pages/page_list_page.dart';
import 'package:simple_contacts_app/repositories/contact_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ContactRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'Simple Contacts App',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          PageListPage.route: (context) => const PageListPage(),
          LoginPage.route: (context) => const LoginPage(),
          ContactListPage.route: (context) => const ContactListPage(),
          CustomWidgetPage.route: (context) => const CustomWidgetPage(),
        },
        initialRoute: PageListPage.route,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ContactListPage extends StatelessWidget {
  static const route = '/contact_list_page';

  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      body: SafeArea(
        child: Column(
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_outlined),
                    suffixIcon: Icon(Icons.highlight_remove),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Contacts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            ListView.separated(
              itemBuilder: (context, index) => Card(
                child: Row(
                  children: [
                    Card(
                      shape: CircleBorder(),
                      child: Center(
                        child: Text(
                          'AA',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      children: [
                        Text(
                          'Sebastian',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'sebastian@gmail.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
              itemCount: 4,
            ),
          ],
        ),
      ),
    );
  }
}

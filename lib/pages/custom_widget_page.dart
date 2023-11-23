import 'package:flutter/material.dart';
import 'package:simple_contacts_app/shared/components/custom_widget.dart';
import 'package:simple_contacts_app/shared/models/segment_model.dart';

class CustomWidgetPage extends StatelessWidget {
  static const route = '/custom_widget_page';

  const CustomWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomWidget(
              title: 'Prospect by Status',
              innerTitle: 'Total Prospects',
              segments: [
                SegmentModel(value: 35, color: Colors.red, label: 'Hot'),
                SegmentModel(value: 35, color: Colors.orange, label: 'Warm'),
                SegmentModel(value: 90, color: Colors.blue, label: 'Cold'),
                // Add more segments as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}

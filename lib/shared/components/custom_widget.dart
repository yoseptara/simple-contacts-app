import 'package:flutter/material.dart';
import 'package:simple_contacts_app/shared/components/custom_gauge.dart';
import 'package:simple_contacts_app/shared/models/segment_model.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({
    super.key,
    required this.title,
    required this.innerTitle,
    required this.segments,
  });

  final String title;
  final String innerTitle;
  final List<SegmentModel> segments;

  @override
  Widget build(BuildContext context) {
    final int total = segments.fold(0, (sum, item) => sum + item.value);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 5,
                spreadRadius: -3,
                color: Colors.black45),
          ],
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SegmentedGaugeChart(
                    segments: segments,
                    width: 150,
                    height: 150,
                  ),
                  Column(
                    children: [
                      Text(
                        total.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        innerTitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: List<Widget>.generate(segments.length, (index) {
                    final segment = segments[index];
                    return Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: segment.color,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          segment.label,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          segment.value.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 12,)
                        ,
                        Text(
                          '${(segment.value / total * 100).round().toString()}%',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

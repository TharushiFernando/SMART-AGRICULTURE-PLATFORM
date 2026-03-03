import 'package:cocosmartapp/color_resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final String? title;
  final String? body;
  final DateTime? timeStamp;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.body,
    required this.timeStamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: ColorResources.MAIN_BACKGROUND_COLOR,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorResources.BORDER_COLOR),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          /// Left Accent Bar
          Container(
            width: 6,
            height: 110,
            decoration: const BoxDecoration(
              color: ColorResources.COLOR_PRIMARY,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Title
                  Text(
                    title ?? "No Title",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.MAIN_TEXT_COLOR,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// Body
                  Text(
                    body ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorResources.BLACK_COLOR,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Timestamp
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      timeStamp != null
                          ? DateFormat('MMM dd, yyyy • hh:mm a')
                          .format(timeStamp!)
                          : "",
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorResources.COLOR_PRIMARY,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
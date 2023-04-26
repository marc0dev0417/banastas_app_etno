import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;

  EventCard({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(date),
        ],
      ),
    );
  }
}
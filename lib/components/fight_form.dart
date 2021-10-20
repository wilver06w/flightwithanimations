import 'package:flutter/material.dart';

class FlightForm extends StatelessWidget {
  final VoidCallback onTap;

  const FlightForm({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.flight_takeoff, color: Colors.red),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: 'From'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

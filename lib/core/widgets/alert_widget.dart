import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  AlertWidget({Key? key, required this.message, this.isError = false})
      : super(key: key) {
    if (isError) {
      icon = Icons.error;
      color = 0xFFE57373;
    } else {
      icon = Icons.warning;
      color = 0xFFFFB74D;
    }
  }

  final String message;
  final bool isError;
  late final IconData icon;
  late final int color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Color(color).withOpacity(0.8),
          child: ListTile(
            leading: Icon(icon),
            title: Text("Error"),
            subtitle: Text(message),
          ),
        ),
      ),
    );
  }
}

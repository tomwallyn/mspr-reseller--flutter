import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Color? color, Key? key})
      : _color = color,
        super(key: key);

  final Color? _color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: _color),
    );
  }
}

import 'package:flutter/material.dart';


class ToggleTextWidget extends StatefulWidget {
  final String firstValue;
  final String secondValue;

  ToggleTextWidget({required this.firstValue, required this.secondValue});

  @override
  _ToggleTextWidgetState createState() => _ToggleTextWidgetState();
}

class _ToggleTextWidgetState extends State<ToggleTextWidget> {
  bool _isFirstValue = true;

  void _toggleValue() {
    setState(() {
      _isFirstValue = !_isFirstValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleValue,
      child: Text(
        _isFirstValue ? widget.firstValue : widget.secondValue,
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
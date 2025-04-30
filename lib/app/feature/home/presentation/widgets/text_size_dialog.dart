import 'package:flutter/material.dart';

class TextSizeDialog extends StatelessWidget {
  final double textSizeFactor;
  final Function(double) onTextSizeChanged;

  const TextSizeDialog({
    super.key,
    required this.textSizeFactor,
    required this.onTextSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Text Size'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<double>(
            title: Text('Small'),
            value: 0.8,
            groupValue: textSizeFactor,
            onChanged: (value) {
              if (value != null) {
                onTextSizeChanged(value);
                Navigator.pop(context);
              }
            },
          ),
          RadioListTile<double>(
            title: Text('Medium'),
            value: 1.0,
            groupValue: textSizeFactor,
            onChanged: (value) {
              if (value != null) {
                onTextSizeChanged(value);
                Navigator.pop(context);
              }
            },
          ),
          RadioListTile<double>(
            title: Text('Big'),
            value: 1.5,
            groupValue: textSizeFactor,
            onChanged: (value) {
              if (value != null) {
                onTextSizeChanged(value);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
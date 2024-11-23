import 'package:flutter/material.dart';

class ColorSlider extends StatelessWidget {
  final Color color;
  final int value;
  final ValueChanged<int> onChanged;
  final VoidCallback onSetPrimary;
  final bool allowFLoatingButton;

  const ColorSlider({
    super.key,
    required this.color,
    required this.value,
    required this.onChanged,
    required this.onSetPrimary,
    required this.allowFLoatingButton,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    value.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (allowFLoatingButton)
                IconButton(
                  icon: Icon(Icons.color_lens, color: color),
                  onPressed: onSetPrimary,
                ),
            ],
          ),
          Slider(
            min: 0,
            max: 255,
            divisions: 255,
            value: value.toDouble(),
            activeColor: color,
            onChanged: (newValue) => onChanged(newValue.toInt()),
          ),
        ],
      ),
    );
  }
}

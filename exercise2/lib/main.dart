import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _iconSize = 200.0;
  Color _iconColor = Colors.blue;
  double _red = 0.0, _green = 0.0, _blue = 255.0;
  bool _allowResize = true;
  bool _allowChangeColor = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Icon',
          style: TextStyle(color: Colors.white), // White text in the upper bar
        ),
        backgroundColor: Colors.brown,
        actions: _allowResize
            ? [
                _buildCircleButton(
                  icon: Icons.remove,
                  onPressed: () => setState(() {
                    _iconSize = (_iconSize - 20).clamp(50.0, 500.0);
                  }),
                ),
                _buildCircleButton(
                  label: 'S',
                  onPressed: () => setState(() => _iconSize = 100.0),
                ),
                _buildCircleButton(
                  label: 'M',
                  onPressed: () => setState(() => _iconSize = 200.0),
                ),
                _buildCircleButton(
                  label: 'L',
                  onPressed: () => setState(() => _iconSize = 300.0),
                ),
                _buildCircleButton(
                  icon: Icons.add,
                  onPressed: () => setState(() {
                    _iconSize = (_iconSize + 20).clamp(50.0, 500.0);
                  }),
                ),
              ]
            : null,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            CheckboxListTile(
              title: const Text('Allow resize'),
              value: _allowResize,
              onChanged: (value) => setState(() => _allowResize = value!),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Allow change primer color'),
              value: _allowChangeColor,
              onChanged: (value) => setState(() => _allowChangeColor = value!),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Custom Clock Icon
          Icon(
            Icons
                .access_alarm, // Clock icon updated to resemble the one in the image
            size: _iconSize,
            color: _iconColor,
          ),
          const SizedBox(height: 30),
          // Color sliders
          ColorSlider(
            label: 'Red',
            value: _red,
            color: Colors.red,
            onChanged: _allowChangeColor
                ? (value) => setState(() {
                      _red = value;
                      _updateIconColor();
                    })
                : null,
          ),
          ColorSlider(
            label: 'Green',
            value: _green,
            color: Colors.green,
            onChanged: _allowChangeColor
                ? (value) => setState(() {
                      _green = value;
                      _updateIconColor();
                    })
                : null,
          ),
          ColorSlider(
            label: 'Blue',
            value: _blue,
            color: Colors.blue,
            onChanged: _allowChangeColor
                ? (value) => setState(() {
                      _blue = value;
                      _updateIconColor();
                    })
                : null,
          ),
        ],
      ),
    );
  }

  void _updateIconColor() {
    setState(() {
      _iconColor =
          Color.fromRGBO(_red.toInt(), _green.toInt(), _blue.toInt(), 1);
    });
  }

  Widget _buildCircleButton(
      {IconData? icon, String? label, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        backgroundColor: Colors.transparent, // Transparent background
        radius: 20, // Smaller circle radius
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 2), // White outline
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: icon != null
                ? Icon(icon, color: Colors.white) // White icon
                : Text(
                    label!,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}

class ColorSlider extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final ValueChanged<double>? onChanged;

  const ColorSlider({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              value.toInt().toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 255,
            activeColor: color,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

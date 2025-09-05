// lib/donate_screen.dart
import 'package:flutter/material.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _deviceType;
  String? _condition;
  String _description = '';

  @override
  Widget build(BuildContext context) {
    // 💡 Force phone-sized viewport (mobile-like)
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate Device'),
        backgroundColor: const Color(0xFF66BB6A), // Soft green
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // ← Center all content
            children: [
              // Device Type Dropdown
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Device Type',
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () {
                    showDeviceTypePicker(context);
                  },
                  controller: TextEditingController(text: _deviceType),
                ),
              ),
              const SizedBox(height: 20),

              // Condition Dropdown
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Condition',
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () {
                    showConditionPicker(context);
                  },
                  controller: TextEditingController(text: _condition),
                ),
              ),
              const SizedBox(height: 20),

              // Description
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Describe the device and any issues',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _description = value),
                ),
              ),
              const SizedBox(height: 20),

              // Photo Upload Area
              GestureDetector(
                onTap: () {
                  // TODO: Implement image picker
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Image picker will open here')),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(Icons.upload, size: 40, color: Colors.grey),
                      const SizedBox(height: 10),
                      Text(
                        'Tap to upload photos',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Show the device from different angles',
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('✅ Device donated successfully!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Donate',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDeviceTypePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text('Phone'), onTap: () { setState(() => _deviceType = 'Phone'); Navigator.pop(ctx); }),
          ListTile(title: const Text('Laptop'), onTap: () { setState(() => _deviceType = 'Laptop'); Navigator.pop(ctx); }),
          ListTile(title: const Text('Tablet'), onTap: () { setState(() => _deviceType = 'Tablet'); Navigator.pop(ctx); }),
          ListTile(title: const Text('Desktop'), onTap: () { setState(() => _deviceType = 'Desktop'); Navigator.pop(ctx); }),
          ListTile(title: const Text('Monitor'), onTap: () { setState(() => _deviceType = 'Monitor'); Navigator.pop(ctx); }),
          ListTile(title: const Text('Printer'), onTap: () { setState(() => _deviceType = 'Printer'); Navigator.pop(ctx); }),
        ],
      ),
    );
  }

  void showConditionPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text('Excellent'), onTap: () { setState(() => _condition = 'Excellent'); Navigator.pop(ctx); }),
          ListTile(title: const Text('Good'), onTap: () { setState(() => _condition = 'Good'); Navigator.pop(ctx); }),
          ListTile(title: const Text('Fair'), onTap: () { setState(() => _condition = 'Fair'); Navigator.pop(ctx); }),
          ListTile(title: const Text('Poor'), onTap: () { setState(() => _condition = 'Poor'); Navigator.pop(ctx); }),
        ],
      ),
    );
  }
}
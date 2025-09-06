// lib/donate_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String? _deviceType;
  String? _condition;
  String _description = '';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Donate Device',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
        centerTitle: false,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Help others by donating your used devices',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),

                // Device Type Dropdown
                _buildDropdownField(
                  label: 'Device Type',
                  value: _deviceType,
                  icon: Icons.devices,
                  onTap: () => showDeviceTypePicker(context),
                ),
                const SizedBox(height: 20),

                // Condition Dropdown
                _buildDropdownField(
                  label: 'Condition',
                  value: _condition,
                  icon: Icons.grade,
                  onTap: () => showConditionPicker(context),
                ),
                const SizedBox(height: 20),

                // Description Field
                TextFormField(
                  maxLines: 4,
                  decoration: _buildInputDecoration(
                    label: 'Describe the device and any issues',
                    icon: Icons.edit_note,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a description';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() => _description = value),
                ),
                const SizedBox(height: 20),

                // Photo Upload Section
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('📷 Image picker will open here')),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.upload,
                            size: 40,
                            color: Colors.teal[600],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tap to upload photos',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal[800],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Show the device from different angles',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
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
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 4,
                      shadowColor: Colors.teal.withOpacity(0.4),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('✅ Device donated successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Future.delayed(const Duration(milliseconds: 800), () {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text(
                      'Donate Now',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({required String label, IconData? icon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.grey[600],
      ),
      prefixIcon: icon != null
          ? Icon(icon, color: Colors.teal[400], size: 20)
          : null,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.teal, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      alignLabelWithHint: true,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[300]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.teal[400], size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value ?? 'Select $label',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: value == null ? Colors.grey[500] : Colors.black87,
                  fontWeight: value == null ? FontWeight.w400 : FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey[600], size: 24),
          ],
        ),
      ),
    );
  }

   void showDeviceTypePicker(BuildContext context) {
    final List<String> types = [
      'Phone', 'Laptop', 'Tablet', 'Desktop', 'Monitor',
      'Printer', 'Keyboard', 'Mouse', 'Cable',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                'Select Device Type',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            // This makes the list take up the remaining space and become scrollable
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: types.length,
                itemBuilder: (context, index) {
                  final type = types[index];
                  return _buildOptionItem(type, () {
                    setState(() => _deviceType = type);
                    Navigator.pop(ctx);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MODIFICATION: This method is also updated to be scrollable for consistency.
  void showConditionPicker(BuildContext context) {
    final List<String> conditions = ['Excellent', 'Good', 'Fair', 'Poor'];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                'Select Condition',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            // This makes the list take up the remaining space and become scrollable
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: conditions.length,
                itemBuilder: (context, index) {
                  final cond = conditions[index];
                  return _buildOptionItem(cond, () {
                    setState(() => _condition = cond);
                    Navigator.pop(ctx);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[500]),
          ],
        ),
      ),
    );
  }
}

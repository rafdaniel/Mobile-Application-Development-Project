// lib/browse_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_donation/models/device.dart';
import 'package:flutter_application_donation/device_details.dart';
import 'package:google_fonts/google_fonts.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final List<Device> _allDevices = [
    Device(
      id: '1',
      name: 'Used Dell Laptop',
      category: 'Laptop',
      imageUrl: 'assets/images/dell_laptop.png',
      description: 'This laptop is in good condition and fully functional. It has been well-maintained and is perfect for students or those who appreciate classic technology.',
      brand: 'Dell',
      year: '1995',
      processor: 'Intel Pentium II',
      ram: '64MB',
      storage: '4GB HDD',
      condition: 'Good',
      uploaderNotes: 'This laptop has been stored in a climate-controlled environment and has minimal wear. It comes with the original charger and a carrying case.',
    ),
    Device(
      id: '2',
      name: 'Old Samsung Phone',
      category: 'Smartphone',
      imageUrl: 'assets/images/samsung_phone.png',
      description: 'A classic Samsung smartphone, in working condition. The battery life is not great, but it still works. Good for a backup phone.',
      brand: 'Samsung',
      year: '2015',
      processor: 'Exynos 7420 Octa',
      ram: '3GB',
      storage: '32GB',
      condition: 'Fair',
      uploaderNotes: 'The screen has a few scratches, but they are not visible when the screen is on. Comes with a charger.',
    ),
    Device(
      id: '3',
      name: 'Broken Mouse',
      category: 'Peripheral',
      imageUrl: 'assets/images/broken_mouse.png',
    ),
    Device(
      id: '4',
      name: 'USB Cable',
      category: 'Cable',
      imageUrl: 'assets/images/usb_cable.png',
    ),
    Device(
      id: '5',
      name: 'Old Keyboard',
      category: 'Keyboard',
      imageUrl: 'assets/images/old_keyboard.jpg',
    ),
    Device(
      id: '6',
      name: 'Printer (HP)',
      category: 'Printer',
      imageUrl: 'assets/images/used_printer.png',
    ),
  ];

  List<Device> _filteredDevices = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredDevices = _allDevices;
    _searchController.addListener(_filterDevices);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterDevices);
    _searchController.dispose();
    super.dispose();
  }

  void _filterDevices() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDevices = _allDevices.where((device) {
        return device.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Available Devices',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for devices...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    // TODO: Implement filter functionality
                  },
                  icon: const Icon(Icons.filter_list),
                  iconSize: 30,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: _filteredDevices.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final device = _filteredDevices[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DeviceDetails(device: device),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            device.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  device.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  device.category,
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_application_donation/models/device.dart';
import 'package:flutter_application_donation/device_details.dart';
import 'package:google_fonts/google_fonts.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> with TickerProviderStateMixin {
  // Your existing device list and state management logic remains the same
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
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _filteredDevices = _allDevices;
    _searchController.addListener(_filterDevices);
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterDevices);
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _filterDevices() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDevices = _allDevices.where((device) {
        final matchesSearch = device.name.toLowerCase().contains(query);
        final matchesFilter = _selectedFilter == 'All' || device.category == _selectedFilter;
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void _showFilterBottomSheet() {
    final categories = ['All', 'Laptop', 'Smartphone', 'Peripheral', 'Cable', 'Keyboard', 'Printer'];
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter by Category',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...categories.map((category) => _buildFilterOption(category)),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String category) {
    final isSelected = _selectedFilter == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = category;
        });
        _filterDevices();
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              _getCategoryIcon(category),
              color: isSelected ? Colors.teal : Colors.grey[600],
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              category,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.teal : Colors.black87,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.teal,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Laptop':
        return Icons.laptop;
      case 'Smartphone':
        return Icons.phone_android;
      case 'Peripheral':
        return Icons.mouse;
      case 'Cable':
        return Icons.cable;
      case 'Keyboard':
        return Icons.keyboard;
      case 'Printer':
        return Icons.print;
      default:
        return Icons.category;
    }
  }

  Widget _buildStatsRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal[400]!, Colors.teal[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  '${_allDevices.length}',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Total Devices',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '${_filteredDevices.length}',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Showing',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          Expanded(
            child: Column(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  'Helping',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(Device device, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        DeviceDetails(device: device),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: animation.drive(
                          Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                              .chain(CurveTween(curve: Curves.easeInOut)),
                        ),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.grey[100]!,
                                    Colors.grey[50]!,
                                  ],
                                ),
                              ),
                              child: Image.asset(
                                device.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          _getCategoryIcon(device.category),
                                          color: Colors.teal[300],
                                          size: 40,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          device.category,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                size: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          if (device.condition != null)
                            Positioned(
                              top: 12,
                              left: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getConditionColor(device.condition!),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  device.condition!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              device.name,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  _getCategoryIcon(device.category),
                                  size: 14,
                                  color: Colors.teal[400],
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    device.category,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            if (device.brand != null && device.year != null) ...[
                              const Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${device.brand} • ${device.year}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'excellent':
        return Colors.green;
      case 'good':
        return Colors.blue;
      case 'fair':
        return Colors.orange;
      case 'poor':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFFF8FAFB),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Available Devices',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            ),
          ),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  _buildStatsRow(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.08),
                                  spreadRadius: 0,
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search for devices...',
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                  size: 22,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: _showFilterBottomSheet,
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.teal[400]!, Colors.teal[600]!],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.teal.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: _filteredDevices.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 80,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No devices found',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your search or filters',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final device = _filteredDevices[index];
                        return _buildDeviceCard(device, index);
                      },
                      childCount: _filteredDevices.length,
                    ),
                  ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }
}
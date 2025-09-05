// lib/models/device.dart
class Device {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String description;
  final String brand;
  final String year;
  final String processor;
  final String ram;
  final String storage;
  final String condition;
  final String uploaderNotes;

  Device({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    this.description = '',
    this.brand = '',
    this.year = '',
    this.processor = '',
    this.ram = '',
    this.storage = '',
    this.condition = '',
    this.uploaderNotes = '',
  });
}

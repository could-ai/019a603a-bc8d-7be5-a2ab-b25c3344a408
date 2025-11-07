class DeliveryItem {
  final String id;
  final String title;
  final String description;
  final String category;
  final String pickupAddress;
  final String deliveryAddress;
  final double distance;
  final double price;
  final int estimatedTime;

  DeliveryItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.distance,
    required this.price,
    required this.estimatedTime,
  });

  // Convert to JSON for future API integration
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'pickupAddress': pickupAddress,
      'deliveryAddress': deliveryAddress,
      'distance': distance,
      'price': price,
      'estimatedTime': estimatedTime,
    };
  }

  // Create from JSON for future API integration
  factory DeliveryItem.fromJson(Map<String, dynamic> json) {
    return DeliveryItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      pickupAddress: json['pickupAddress'],
      deliveryAddress: json['deliveryAddress'],
      distance: json['distance'].toDouble(),
      price: json['price'].toDouble(),
      estimatedTime: json['estimatedTime'],
    );
  }
}

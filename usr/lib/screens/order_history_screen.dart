import 'package:flutter/material.dart';
import '../models/delivery_item.dart';
import '../widgets/history_card.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  // Mock order history data
  final List<Map<String, dynamic>> _orderHistory = [
    {
      'delivery': DeliveryItem(
        id: 'h1',
        title: 'Food Delivery',
        description: 'Sushi from Tokyo Express',
        category: 'Food',
        pickupAddress: '789 Restaurant Row',
        deliveryAddress: '234 Customer Lane',
        distance: 4.2,
        price: 10.00,
        estimatedTime: 30,
      ),
      'status': 'Delivered',
      'date': '2024-01-15 14:30',
      'earning': 10.00,
    },
    {
      'delivery': DeliveryItem(
        id: 'h2',
        title: 'Package Delivery',
        description: 'Electronics package',
        category: 'Package',
        pickupAddress: '456 Warehouse Blvd',
        deliveryAddress: '890 Residential Ave',
        distance: 8.5,
        price: 18.00,
        estimatedTime: 50,
      ),
      'status': 'Delivered',
      'date': '2024-01-15 10:15',
      'earning': 18.00,
    },
    {
      'delivery': DeliveryItem(
        id: 'h3',
        title: 'Grocery Delivery',
        description: 'Weekly groceries',
        category: 'Grocery',
        pickupAddress: '123 Supermarket Plaza',
        deliveryAddress: '567 Family Circle',
        distance: 3.8,
        price: 9.50,
        estimatedTime: 25,
      ),
      'status': 'Delivered',
      'date': '2024-01-14 16:45',
      'earning': 9.50,
    },
    {
      'delivery': DeliveryItem(
        id: 'h4',
        title: 'Medicine Delivery',
        description: 'Pharmacy prescription',
        category: 'Medicine',
        pickupAddress: '999 Health Center',
        deliveryAddress: '111 Senior Living',
        distance: 2.3,
        price: 6.00,
        estimatedTime: 15,
      ),
      'status': 'Delivered',
      'date': '2024-01-14 09:20',
      'earning': 6.00,
    },
    {
      'delivery': DeliveryItem(
        id: 'h5',
        title: 'Food Delivery',
        description: 'Burger and fries',
        category: 'Food',
        pickupAddress: '333 Fast Food St',
        deliveryAddress: '777 Student Dorms',
        distance: 1.9,
        price: 5.50,
        estimatedTime: 12,
      ),
      'status': 'Cancelled',
      'date': '2024-01-13 20:00',
      'earning': 0.00,
    },
  ];

  double get _totalEarnings {
    return _orderHistory.fold(0.0, (sum, order) => sum + (order['earning'] as double));
  }

  int get _completedDeliveries {
    return _orderHistory.where((order) => order['status'] == 'Delivered').length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Order History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Earnings summary card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      'Total Earnings',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${_totalEarnings.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.white30,
                ),
                Column(
                  children: [
                    const Text(
                      'Completed',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_completedDeliveries',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Orders list
          Expanded(
            child: _orderHistory.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No order history',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _orderHistory.length,
                    itemBuilder: (context, index) {
                      final order = _orderHistory[index];
                      return HistoryCard(
                        delivery: order['delivery'] as DeliveryItem,
                        status: order['status'] as String,
                        date: order['date'] as String,
                        earning: order['earning'] as double,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

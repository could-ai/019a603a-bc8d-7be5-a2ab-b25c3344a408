import 'package:flutter/material.dart';
import '../models/delivery_item.dart';
import '../widgets/delivery_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Mock delivery categories
  final List<String> _categories = [
    'All',
    'Food',
    'Grocery',
    'Medicine',
    'Package',
  ];
  
  String _selectedCategory = 'All';

  // Mock available deliveries
  final List<DeliveryItem> _availableDeliveries = [
    DeliveryItem(
      id: '1',
      title: 'Restaurant Delivery',
      description: 'Pizza from Mario\'s Restaurant',
      category: 'Food',
      pickupAddress: '123 Main St, Downtown',
      deliveryAddress: '456 Oak Ave, Suburb',
      distance: 3.5,
      price: 8.50,
      estimatedTime: 25,
    ),
    DeliveryItem(
      id: '2',
      title: 'Grocery Delivery',
      description: '5 bags from SuperMart',
      category: 'Grocery',
      pickupAddress: '789 Market St',
      deliveryAddress: '321 Pine Rd',
      distance: 5.2,
      price: 12.00,
      estimatedTime: 35,
    ),
    DeliveryItem(
      id: '3',
      title: 'Medicine Delivery',
      description: 'Prescription from City Pharmacy',
      category: 'Medicine',
      pickupAddress: '555 Health Plaza',
      deliveryAddress: '888 Wellness Blvd',
      distance: 2.1,
      price: 6.00,
      estimatedTime: 15,
    ),
    DeliveryItem(
      id: '4',
      title: 'Package Delivery',
      description: 'Express document delivery',
      category: 'Package',
      pickupAddress: '111 Business Park',
      deliveryAddress: '999 Commerce St',
      distance: 7.8,
      price: 15.00,
      estimatedTime: 45,
    ),
  ];

  List<DeliveryItem> get _filteredDeliveries {
    return _availableDeliveries.where((delivery) {
      final matchesCategory = _selectedCategory == 'All' || delivery.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          delivery.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          delivery.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Available Deliveries',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search deliveries...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),

          // Category filters
          Container(
            height: 50,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    selectedColor: Colors.orange,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),

          // Deliveries list
          Expanded(
            child: _filteredDeliveries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delivery_dining,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No deliveries found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredDeliveries.length,
                    itemBuilder: (context, index) {
                      return DeliveryCard(
                        deliveryItem: _filteredDeliveries[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

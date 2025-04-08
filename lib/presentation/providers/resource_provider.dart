import 'package:flutter/material.dart';
import '../../data/models/resource_model.dart';

class ResourceProvider with ChangeNotifier {
  List<ResourceModel> _resources = [];
  bool _isLoading = false;

  List<ResourceModel> get resources => _resources;
  bool get isLoading => _isLoading;

  Future<void> loadResources() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // Mock API call
    
    _resources = [
      ResourceModel(
        id: '1',
        title: 'Mindful Breathing',
        description: '5-minute guided breathing exercise',
        category: 'meditation',
        durationMinutes: 5,
      ),
      ResourceModel(
        id: '2',
        title: 'Stress Management',
        description: 'Learn techniques to manage academic stress',
        category: 'articles',
        durationMinutes: 10,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }
}
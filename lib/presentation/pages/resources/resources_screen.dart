import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/resource_constants.dart';
import '../../providers/resource_provider.dart';
import 'resource_detail_screen.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ResourceProvider>(context, listen: false).loadResources();
    });
  }

  @override
  Widget build(BuildContext context) {
    final resourceProvider = Provider.of<ResourceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
      ),
      body: resourceProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildCategorySection(context),
                  const SizedBox(height: 20),
                  _buildResourceList(resourceProvider),
                ],
              ),
            ),
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ResourceConstants.resourceCategories.length,
        itemBuilder: (context, index) {
          final category = ResourceConstants.resourceCategories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  color: Color(category['color'] as int).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category['icon'] as IconData,
                        color: Color(category['color'] as int)),
                    const SizedBox(height: 8),
                    Text(
                      category['title'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(category['color'] as int),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResourceList(ResourceProvider resourceProvider) {
    return Expanded(
      child: ListView.builder(
        itemCount: resourceProvider.resources.length,
        itemBuilder: (context, index) {
          final resource = resourceProvider.resources[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Feather.play),
              ),
              title: Text(resource.title),
              subtitle: Text(resource.description),
              trailing: Text('${resource.durationMinutes} min'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResourceDetailScreen(resource: resource),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
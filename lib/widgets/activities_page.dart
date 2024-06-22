import 'package:flutter/material.dart';
import 'package:project_24/data/testing_data.dart';
import 'package:project_24/models/activity.dart';
import 'activities.dart';
import 'package:project_24/view_models/activity_vm.dart';
import 'package:project_24/services/navigation.dart';
import 'package:provider/provider.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  void _selectActivity(BuildContext context, Activity activity) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    nav.goActivityInfoOnCategory(categoryId: categoryId, activityId: activity.activityId);
  }

  @override
  Widget build(BuildContext context) {
    final category = initialCategories[categoryId]!;
    ActivityViewModel allActivity = Provider.of<ActivityViewModel>(context);
    final activitiesShown = allActivity.activities
      .where((item) => item.category.contains(category.title)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title, style: const TextStyle(fontSize: 30),),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final nav = Provider.of<NavigationService>(context, listen: false);
              final viewModel = Provider.of<ActivityViewModel>(context, listen: false);
              nav.goCreateActivity();
            }
          ),
        ],
      ),
      body: Consumer<ActivityViewModel>(
        builder: (context, viewModel, _) {
          print(viewModel.activities);
          return Activities(activities: viewModel.activities, onSelectedActivity: _selectActivity);
        },
      )
    );
  }
}
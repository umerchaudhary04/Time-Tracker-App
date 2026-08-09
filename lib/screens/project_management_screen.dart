import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/time_entry_provider.dart';
import '../models/project.dart';
import '../widgets/add_project_dialog.dart';

class ProjectManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Projects'),
      ),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return provider.projects.isEmpty
              ? Center(child: Text('No projects available. Add one!'))
              : ListView.builder(
                  itemCount: provider.projects.length,
                  itemBuilder: (context, index) {
                    final project = provider.projects[index];
                    return ListTile(
                      title: Text(project.name),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => provider.deleteProject(project.id),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProjectName = await showDialog<String>(
            context: context,
            builder: (context) => AddProjectDialog(),
          );
          if (newProjectName != null && newProjectName.trim().isNotEmpty) {
            Provider.of<TimeEntryProvider>(context, listen: false).addProject(
              Project(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: newProjectName.trim(),
              ),
            );
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Add Project',
      ),
    );
  }
}
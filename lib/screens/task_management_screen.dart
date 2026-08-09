import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/time_entry_provider.dart';
import '../models/task.dart';
import '../widgets/add_task_dialog.dart';

class TaskManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Tasks'),
      ),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return provider.tasks.isEmpty
              ? Center(child: Text('No tasks available. Add one!'))
              : ListView.builder(
                  itemCount: provider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = provider.tasks[index];
                    return ListTile(
                      title: Text(task.name),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => provider.deleteTask(task.id),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTaskName = await showDialog<String>(
            context: context,
            builder: (context) => AddTaskDialog(),
          );
          if (newTaskName != null && newTaskName.trim().isNotEmpty) {
            Provider.of<TimeEntryProvider>(context, listen: false).addTask(
              Task(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: newTaskName.trim(),
              ),
            );
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Add Task',
      ),
    );
  }
}
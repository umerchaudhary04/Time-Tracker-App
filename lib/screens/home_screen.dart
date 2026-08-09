import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/time_entry_provider.dart';
import '../models/project.dart';
import '../models/task.dart';
import 'add_time_entry_screen.dart';
import 'project_management_screen.dart';
import 'task_management_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Time Entries'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'All Entries'),
              Tab(text: 'Grouped by Projects'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Settings', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              ListTile(
                leading: Icon(Icons.folder),
                title: Text('Projects'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectManagementScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.task),
                title: Text('Tasks'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskManagementScreen()));
                },
              ),
            ],
          ),
        ),
        body: Consumer<TimeEntryProvider>(
          builder: (context, provider, child) {
            return TabBarView(
              children: [
                // Tab 1: All Entries
                provider.entries.isEmpty
                    ? Center(child: Text('No time entries found.'))
                    : ListView.builder(
                        itemCount: provider.entries.length,
                        itemBuilder: (context, index) {
                          final entry = provider.entries[index];
                          // Finding names mapping to IDs 
                          final projectName = provider.projects.firstWhere((p) => p.id == entry.projectId, orElse: () => Project(id: '', name: 'Unknown Project')).name;
                          final taskName = provider.tasks.firstWhere((t) => t.id == entry.taskId, orElse: () => Task(id: '', name: 'Unknown Task')).name;
                          
                          return Dismissible(
                            key: Key(entry.id),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              provider.deleteTimeEntry(entry.id);
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            child: ListTile(
                              title: Text('$projectName - $taskName'),
                              subtitle: Text('${entry.date.toString().split(' ')[0]}\nNotes: ${entry.notes}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('${entry.totalTime} hrs', style: TextStyle(fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.grey),
                                    onPressed: () => provider.deleteTimeEntry(entry.id),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                // Tab 2: Grouped by Projects
                provider.entries.isEmpty
                    ? Center(child: Text('No time entries found.'))
                    : ListView(
                        children: provider.entriesGroupedByProject.entries.map((group) {
                          final projectName = provider.projects.firstWhere((p) => p.id == group.key, orElse: () => Project(id: '', name: 'Unknown Project')).name;
                          return ExpansionTile(
                            title: Text(projectName),
                            children: group.value.map((entry) {
                              final taskName = provider.tasks.firstWhere((t) => t.id == entry.taskId, orElse: () => Task(id: '', name: 'Unknown Task')).name;
                              return ListTile(
                                title: Text('$taskName - ${entry.totalTime} hours'),
                                subtitle: Text(entry.notes),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => provider.deleteTimeEntry(entry.id),
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTimeEntryScreen()),
            );
          },
          child: Icon(Icons.add),
          tooltip: 'Add Time Entry',
        ),
      ),
    );
  }
}
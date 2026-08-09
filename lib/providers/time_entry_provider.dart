import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:collection/collection.dart';
import 'dart:convert';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';

class TimeEntryProvider with ChangeNotifier {
  final LocalStorage storage = LocalStorage('time_tracker.json');

  List<TimeEntry> _entries = [];
  List<Project> _projects = [];
  List<Task> _tasks = [];

  List<TimeEntry> get entries => _entries;
  List<Project> get projects => _projects;
  List<Task> get tasks => _tasks;

  TimeEntryProvider() {
    _loadFromStorage();
  }

  void _loadFromStorage() async {
    await storage.ready;

    // Parse the JSON strings back into Maps
    var storedEntries = storage.getItem('entries');
    var storedProjects = storage.getItem('projects');
    var storedTasks = storage.getItem('tasks');

    if (storedEntries != null) {
      final List decodedEntries = jsonDecode(storedEntries);
      _entries = decodedEntries
          .map((item) => TimeEntry(
                id: item['id'],
                projectId: item['projectId'],
                taskId: item['taskId'],
                totalTime: item['totalTime'],
                date: DateTime.parse(item['date']),
                notes: item['notes'],
              ))
          .toList();
    }
    if (storedProjects != null) {
      final List decodedProjects = jsonDecode(storedProjects);
      _projects = decodedProjects
          .map((item) => Project(
                id: item['id'],
                name: item['name'],
              ))
          .toList();
    }
    if (storedTasks != null) {
      final List decodedTasks = jsonDecode(storedTasks);
      _tasks = decodedTasks
          .map((item) => Task(
                id: item['id'],
                name: item['name'],
              ))
          .toList();
    }
    notifyListeners();
  }

  void _saveToStorage() {
    // Convert the Lists of Maps into JSON Strings
    storage.setItem(
        'entries',
        jsonEncode(_entries
            .map((e) => {
                  'id': e.id,
                  'projectId': e.projectId,
                  'taskId': e.taskId,
                  'totalTime': e.totalTime,
                  'date': e.date.toIso8601String(),
                  'notes': e.notes,
                })
            .toList()));

    storage.setItem(
        'projects',
        jsonEncode(_projects
            .map((p) => {
                  'id': p.id,
                  'name': p.name,
                })
            .toList()));

    storage.setItem(
        'tasks',
        jsonEncode(_tasks
            .map((t) => {
                  'id': t.id,
                  'name': t.name,
                })
            .toList()));
  }

  void addTimeEntry(TimeEntry entry) {
    _entries.add(entry);
    _saveToStorage();
    notifyListeners();
  }

  void deleteTimeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    _saveToStorage();
    notifyListeners();
  }

  void addProject(Project project) {
    _projects.add(project);
    _saveToStorage();
    notifyListeners();
  }

  void deleteProject(String id) {
    _projects.removeWhere((project) => project.id == id);
    _saveToStorage();
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    _saveToStorage();
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _saveToStorage();
    notifyListeners();
  }

  Map<String, List<TimeEntry>> get entriesGroupedByProject {
    return groupBy(_entries, (TimeEntry entry) => entry.projectId);
  }
}

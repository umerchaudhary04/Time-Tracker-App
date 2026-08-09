import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/time_entry.dart';
import '../providers/time_entry_provider.dart';
import 'package:intl/intl.dart';

class AddTimeEntryScreen extends StatefulWidget {
  @override
  _AddTimeEntryScreenState createState() => _AddTimeEntryScreenState();
}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? projectId;
  String? taskId;
  double totalTime = 0.0;
  DateTime date = DateTime.now();
  String notes = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimeEntryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Time Entry'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: projectId,
                onChanged: (String? newValue) {
                  setState(() {
                    projectId = newValue;
                  });
                },
                decoration: InputDecoration(labelText: 'Project'),
                items: provider.projects.map<DropdownMenuItem<String>>((project) {
                  return DropdownMenuItem<String>(
                    value: project.id,
                    child: Text(project.name),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Please select a project' : null,
              ),
              DropdownButtonFormField<String>(
                value: taskId,
                onChanged: (String? newValue) {
                  setState(() {
                    taskId = newValue;
                  });
                },
                decoration: InputDecoration(labelText: 'Task'),
                items: provider.tasks.map<DropdownMenuItem<String>>((task) {
                  return DropdownMenuItem<String>(
                    value: task.id,
                    child: Text(task.name),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Please select a task' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Total Time (hours)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total time';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => totalTime = double.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some notes';
                  }
                  return null;
                },
                onSaved: (value) => notes = value!,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: Text('Date: ${DateFormat.yMd().format(date)}')),
                  TextButton(
                    child: Text('Select Date'),
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          date = selectedDate;
                        });
                      }
                    },
                  )
                ],
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    provider.addTimeEntry(TimeEntry(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      projectId: projectId!,
                      taskId: taskId!,
                      totalTime: totalTime,
                      date: date,
                      notes: notes,
                    ));
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskData>(context);
    final taskController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: taskData.tasks.length,
              itemBuilder: (context, index) {
                final task = taskData.tasks[index];
                return ListTile(
                  title: Text(
                    task.name,
                    style: TextStyle(
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      taskData.deleteTask(task);
                    },
                  ),
                  onTap: () {
                    taskData.toggleTask(task);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      hintText: 'Enter task name',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      taskData.addTask(taskController.text);
                      taskController.clear();
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'todo_provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 174, 165),
      appBar: AppBar(
        title: const Text('Yearly Calendar To-Do'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              locale: 'en_US', // Example locale value
              onDaySelected: (selectedDay, focusedDay) {},
              firstDay: DateTime(2024),
              lastDay: DateTime(2025),
              focusedDay: DateTime(2024),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<TodoProvider>(
                builder: (context, todoProvider, _) {
                  return ListView.builder(
                    itemCount: todoProvider.events.length,
                    itemBuilder: (context, index) {
                      final date = todoProvider.events.keys.elementAt(index);
                      final events = todoProvider.events[date]!;
                      return ListTile(
                        title: Text('$date'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: events
                              .map((event) => Text(event.toString()))
                              .toList(),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            Provider.of<TodoProvider>(context, listen: false)
                                .deleteEvent(date, events);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new task functionality
          // You can open a dialog here to input task details and add it to the provider
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

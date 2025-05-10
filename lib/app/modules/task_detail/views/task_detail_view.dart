import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/layout/custom_appbar.dart';
import '../controllers/task_detail_controller.dart';

class TaskDetailView extends GetView<TaskDetailController> {
  const TaskDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data dari arguments
    final String taskId = Get.arguments['taskId'] ?? '';
    final String title = Get.arguments['title'] ?? 'No title';
    final String description =
        Get.arguments['description'] ?? 'No description available';
    final int subtasksCount = Get.arguments['subtasksCount'] ?? 0;

    // Cek apakah taskId tersedia
    if (taskId.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Task Detail'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Task ID not found!'),
        ),
      );
    }

    return Scaffold(
      appBar: customAppBar(title: 'task_details'.tr, actions: [
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            // Aksi edit task
            Get.snackbar('information'.tr, "Dalam pengembangan",
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.blue,
                colorText: Colors.white);
          },
        ),
      ]),
      backgroundColor: const Color(0xFFF9FAFB),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan title task yang dikirimkan
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Menampilkan description task yang dikirimkan
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),

            // Menampilkan jumlah subtasks
            if (subtasksCount > 0)
              Text(
                'This task has $subtasksCount subtasks.',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            if (subtasksCount == 0)
              const Text(
                'No subtasks for this task.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/app/modules/addsubtasks/views/addsubtasks_view.dart';
import 'package:todolist/layout/custom_appbar.dart';
import 'package:todolist/widgets/loading_widget.dart';
import '../../task_detail/views/task_detail_view.dart';
import '../controllers/tasks_controller.dart';

class TasksView extends GetView<TasksController> {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "tasks".tr),
      backgroundColor: const Color(0xFFF9FAFB),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: LoadingWidget());
        }
        if (controller.tasks.isEmpty) {
          return Center(
            child: Text(
              'not_yet_tasks'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            final task = controller.tasks[index];
            final String taskId = task['id'] ?? '';
            final String title = task['title'] ?? 'Tanpa Judul';
            final String description = task['description'] ?? '';
            final List subtasks =
                task['subtasks'] is List ? task['subtasks'] : [];
            final int subtasksCount = subtasks.length;

            return GestureDetector(
              onTap: () {
                Get.to(TaskDetailView(), arguments: {
                  'taskId': taskId,
                  'title': title,
                  'description': description,
                  'subtasksCount': subtasksCount,
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(Icons.task_alt, color: Colors.blue),
                  ),
                  title: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  subtitle: description.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        )
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.green),
                        tooltip: 'Tambah Subtask',
                        onPressed: () {
                          Get.to(AddsubtasksView(),
                              arguments: {'taskId': taskId});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Hapus Task',
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'confirm'.tr,
                            middleText: 'delete_task_confirm'.tr,
                            textConfirm: 'yes'.tr,
                            textCancel: 'no'.tr,
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              Get.back(); // tutup dialog dulu
                              controller.deleteTask(taskId);
                            },
                            onCancel: () {},
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: () async {
          final result = await Get.toNamed('/addtask');
          if (result == true) {
            controller.fetchTasks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/layout/custom_appbar.dart';
import '../controllers/addtask_controller.dart';

class AddTaskView extends StatelessWidget {
  final controller = Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "add_task".tr),
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title
            _buildSectionTitle('task_title'.tr),
            _buildTextField(
              hintText: 'task_title'.tr,
              icon: Icons.title,
              controller: controller.taskTitleController,
            ),
            const SizedBox(height: 16),

            // Task Description
            _buildSectionTitle('task_description'.tr),
            _buildTextField(
              hintText: 'task_description'.tr,
              icon: Icons.description,
              maxLines: 5,
              controller: controller.taskDescriptionController,
            ),
            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.saveTask,
                icon: const Icon(Icons.save, color: Colors.white),
                label: Text("save_task".tr,
                    style: const TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF374151),
        ),
      ),
    );
  }

  Widget _buildTextField({
    String? hintText,
    IconData? icon,
    int maxLines = 1,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon:
              icon != null ? Icon(icon, color: Colors.blueAccent) : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

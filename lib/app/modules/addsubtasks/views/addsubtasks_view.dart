import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todolist/app/modules/addsubtasks/controllers/addsubtasks_controller.dart';
import 'package:todolist/layout/custom_appbar.dart';

class AddsubtasksView extends StatelessWidget {
  final AddsubtasksController controller = Get.put(AddsubtasksController());

  AddsubtasksView({super.key}) {
    final args = Get.arguments;
    if (args != null && args['taskId'] != null) {
      controller.taskId.value = args['taskId'];
      // Anda bisa memanggil loadTaskData(args['taskId']) jika diperlukan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'add_task'.tr),
      backgroundColor: const Color(0xFFF9FAFB),
      body: Obx(() => SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('task_title'.tr),
                TextField(
                  controller: controller.taskTitleController,
                  onChanged: (val) => controller.taskTitle = val,
                  decoration: _inputDecoration('task_title'.tr, Icons.title),
                ),
                const SizedBox(height: 16),
                _buildSectionTitle('task_description'.tr),
                TextField(
                  controller: controller.taskDescController,
                  onChanged: (val) => controller.taskDescription.value = val,
                  maxLines: 3,
                  decoration: _inputDecoration(
                      'task_description'.tr, Icons.description),
                ),
                const SizedBox(height: 24),
                _buildSectionTitle('deadline'.tr),
                _buildFlatTile(
                  icon: Icons.calendar_today,
                  title: DateFormat.yMMMMd()
                      .add_jm()
                      .format(controller.deadline.value),
                  onTap: () => _pickDateTime(context),
                ),
                const SizedBox(height: 24),
                _buildSectionTitle('Info'),
                Text(
                  '${"created_at".tr}: ${DateFormat.yMMMd().format(controller.createdAt.value)}',
                  style:
                      const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 4),
                Text(
                  '${"edited_at".tr}: ${DateFormat.yMMMd().format(controller.editedAt.value)}',
                  style:
                      const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: controller.saveTask,
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    label: Text(
                      "save_task".tr,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15.5,
        fontWeight: FontWeight.w600,
        color: Color(0xFF374151),
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText, IconData icon) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildFlatTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueAccent),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF111827),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: controller.deadline.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(controller.deadline.value),
      );
      if (pickedTime != null) {
        controller.deadline.value = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        controller.editedAt.value = DateTime.now();
      }
    }
  }
}

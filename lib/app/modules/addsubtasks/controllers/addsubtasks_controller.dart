import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddsubtasksController extends GetxController {
  var taskId = ''.obs;
  var taskTitle = '';
  var taskDescription = ''.obs;
  var deadline = DateTime.now().obs;
  var createdAt = DateTime.now().obs;
  var editedAt = DateTime.now().obs;

  final taskTitleController = TextEditingController();
  final taskDescController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // inisialisasi awal jika perlu
  }

  void saveTask() {
    // simpan logika
  }

  void pickAttachment() {
    // jika masih perlu fitur ini nanti
  }
}

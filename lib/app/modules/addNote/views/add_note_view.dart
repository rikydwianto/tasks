import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import '../../../../layout/custom_appbar.dart';
import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? note = Get.arguments;
    final titleController = TextEditingController(text: note?['title'] ?? '');
    final descriptionController =
        TextEditingController(text: note?['description'] ?? '');
    final descriptionFocusNode = FocusNode();

    return WillPopScope(
      onWillPop: () async {
        // Konfirmasi sebelum kembali
        if (titleController.text.isNotEmpty ||
            descriptionController.text.isNotEmpty) {
          _showDiscardChangesDialog(titleController.text.trim(),
              descriptionController.text.trim(), note);
          return false; // Jangan kembali jika ada perubahan
        }
        return true; // Kembali jika tidak ada perubahan
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(
          title: 'write_something'.tr,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // Konfirmasi sebelum kembali
              if (titleController.text.isNotEmpty ||
                  descriptionController.text.isNotEmpty) {
                _showDiscardChangesDialog(titleController.text.trim(),
                    descriptionController.text.trim(), note);
              } else {
                Get.back();
              }
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.draw),
              onPressed: () => null,
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            // Fokuskan ke deskripsi ketika bagian bawah diklik
            descriptionFocusNode.requestFocus();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title - tanpa border, lebih clean
                TextField(
                  controller: titleController,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText: "title".tr,
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 8),
                //divider
                const Divider(
                  color: Colors.grey,
                  thickness: 1.5,
                ),

                // Description
                TextField(
                  controller: descriptionController,
                  focusNode: descriptionFocusNode, // Set focusNode di sini
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "write_something".tr,
                    border: InputBorder.none,
                  ),
                ),

                const SizedBox(height: 20),

                // Preview Gambar
                Obx(() {
                  final image = controller.selectedImage.value;
                  return image != null
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Image.file(
                            File(image.path),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox();
                }),

                // Preview Coretan
                Obx(() {
                  final image = controller.drawnImage.value;
                  return image != null
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Image.memory(
                            image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox();
                }),

                const SizedBox(height: 80), // ruang untuk FAB
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _saveNote(titleController.text.trim(),
                descriptionController.text.trim(), note);
          },
          label: Text("save".tr, style: TextStyle(color: Colors.white)),
          icon: const Icon(
            Icons.save_outlined,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  // Fungsi untuk menyimpan atau memperbarui catatan
  void _saveNote(String title, String desc, Map<String, dynamic>? note) {
    if (title.isEmpty || desc.isEmpty) {
      Get.snackbar("Error", "Title and description are required!",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (note == null) {
      controller.saveNote(title, desc);
    } else {
      controller.updateNote(note['id'], title, desc);
    }
  }

  // Fungsi untuk menampilkan dialog konfirmasi
  void _showDiscardChangesDialog(
      String title, String desc, Map<String, dynamic>? note) {
    Get.defaultDialog(
      title: "discard_changes".tr,
      middleText: "are_you_sure".tr,
      onCancel: () => {Get.back()},
      onConfirm: () {
        _saveNote(title, desc, note);
        Get.back(); // Tutup dialog
      },
    );
  }
}

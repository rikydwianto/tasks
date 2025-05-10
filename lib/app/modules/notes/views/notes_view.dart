import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todolist/app/modules/addNote/controllers/add_note_controller.dart';
import 'package:todolist/app/utils/tanggal_helper.dart';
import 'package:todolist/layout/custom_appbar.dart';
import 'package:todolist/widgets/loading_widget.dart';
import '../controllers/notes_controller.dart';

class NotesView extends StatelessWidget {
  final NotesController controller = Get.put(NotesController());

  NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'notes'.tr),
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: controller.fetchNotes,
          child: controller.isLoading.value
              ? const Center(child: LoadingWidget())
              : controller.notes.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.note_alt_outlined,
                                    size: 90, color: Colors.grey),
                                const SizedBox(height: 20),
                                Text(
                                  'notes'.tr,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'not_yet_notes'.tr,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      itemCount: controller.notes.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final note = controller.notes[index];
                        final createdAt = note['createdAt'];
                        final formattedDate =
                            TanggalHelper.formatFullDateTime(createdAt);
                        final noteId = note['id'];

                        return Dismissible(
                          key: Key(noteId.toString()),
                          background: Container(
                            color: Colors.redAccent,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          secondaryBackground: Container(
                            color: Colors.redAccent,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          confirmDismiss: (direction) async {
                            return await Get.defaultDialog(
                              title: "delete_note".tr,
                              middleText: "are_you_sure".tr,
                              textCancel: "cancel".tr,
                              textConfirm: "delete".tr,
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                Get.back(result: true); // lanjutkan hapus
                              },
                              onCancel: () {
                                Get.back(result: false); // batalkan
                              },
                            );
                          },
                          onDismissed: (direction) {
                            deleteNote(noteId);
                            Get.snackbar(
                                "deleted".tr, "note_deleted_successfully".tr,
                                snackPosition: SnackPosition.BOTTOM);
                          },
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed('/add-note', arguments: note)
                                  ?.then((_) {
                                controller.fetchNotes();
                              });
                            },
                            onLongPress: () {
                              Get.defaultDialog(
                                title: "delete_note".tr,
                                middleText: "are_you_sure".tr,
                                textCancel: "cancel".tr,
                                textConfirm: "delete".tr,
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  Get.back();
                                  deleteNote(noteId);
                                  Get.snackbar("deleted".tr,
                                      "note_deleted_successfully".tr,
                                      snackPosition: SnackPosition.BOTTOM);
                                },
                              );
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note['title'] ?? 'no_title'.tr,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    note['description'] ?? 'no_description'.tr,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time,
                                          size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        formattedDate,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add-note')?.then((_) {
            controller.fetchNotes();
          });
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'add_note'.tr,
      ),
    );
  }

  void deleteNote(String id) async {
    AddNoteController addNoteController =
        Get.put(AddNoteController(), tag: 'deleteNote');
    await addNoteController.deleteNote(id);
    controller.fetchNotes();
    Get.snackbar(
      "deleted".tr,
      "note_deleted_successfully".tr,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

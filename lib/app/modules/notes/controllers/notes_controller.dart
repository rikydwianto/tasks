import 'package:get/get.dart';
import '../../../../services/firebase_service.dart';

class NotesController extends GetxController {
  var notes = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    isLoading.value = true;
    try {
      final data = await FirebaseService.getData(
        'users/${FirebaseService.currentUid}/notes',
      );

      if (data != null) {
        final sortedNotes = data.entries
            .map((e) => {'id': e.key, ...Map<String, dynamic>.from(e.value)})
            .toList()
          ..sort((a, b) {
            final aCreated = a['createdAt'] ?? 0;
            final bCreated = b['createdAt'] ?? 0;
            return bCreated.compareTo(aCreated); // Urutan terbaru di atas
          });

        notes.assignAll(sortedNotes);
      } else {
        notes.clear();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch notes: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    try {
      final data = await FirebaseService.getData(
        'users/${FirebaseService.currentUid}/notes',
      );

      if (data != null) {
        return data.entries.map((e) {
          return {'id': e.key, ...Map<String, dynamic>.from(e.value)};
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch notes: $e');
      return [];
    }
  }
}

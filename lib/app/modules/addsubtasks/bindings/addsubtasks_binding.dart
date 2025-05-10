import 'package:get/get.dart';

import '../controllers/addsubtasks_controller.dart';

class AddsubtasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddsubtasksController>(
      () => AddsubtasksController(),
    );
  }
}

import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/addNote/bindings/add_note_binding.dart';
import '../modules/addNote/views/add_note_view.dart';
import '../modules/addsubtasks/bindings/addsubtasks_binding.dart';
import '../modules/addsubtasks/views/addsubtasks_view.dart';
import '../modules/addtask/bindings/addtask_binding.dart';
import '../modules/addtask/views/addtask_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notes/bindings/notes_binding.dart';
import '../modules/notes/views/notes_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/productdetail/bindings/productdetail_binding.dart';
import '../modules/productdetail/views/productdetail_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/task_detail/bindings/task_detail_binding.dart';
import '../modules/task_detail/views/task_detail_view.dart';
import '../modules/tasks/bindings/tasks_binding.dart';
import '../modules/tasks/views/tasks_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const LOGIN = Routes.LOGIN;
  static const HOME = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTDETAIL + '/:productId',
      page: () {
        // Mengambil parameter dari URL
        var productId = Get.parameters['productId']!;
        return ProductdetailView(productId: productId);
      },
      binding: ProductdetailBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.TASKS,
      page: () => const TasksView(),
      binding: TasksBinding(),
    ),
    GetPage(
      name: _Paths.ADDTASK,
      page: () => AddTaskView(),
      binding: AddtaskBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTES,
      page: () => NotesView(),
      binding: NotesBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NOTE,
      page: () => const AddNoteView(),
      binding: AddNoteBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.ADDSUBTASKS,
      page: () => AddsubtasksView(),
      binding: AddsubtasksBinding(),
    ),
    GetPage(
      name: _Paths.TASK_DETAIL,
      page: () => TaskDetailView(),
      binding: TaskDetailBinding(),
    ),
  ];
}

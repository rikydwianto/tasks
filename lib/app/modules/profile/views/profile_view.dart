import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../layout/main_layout.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'profile'.tr,
      child: SingleChildScrollView(
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover Section
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        controller.coverColor.value,
                        controller.coverColor.value.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Welcome, ${controller.userName.value.split(' ').first}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black45,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),

                // Profile Picture
                Center(
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: controller.profileImage.value.isNotEmpty
                          ? Image.network(
                              controller.profileImage.value,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildInitialsAvatar(
                                    controller.userName.value);
                              },
                            )
                          : _buildInitialsAvatar(controller.userName.value),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // User Info
                Center(
                  child: Column(
                    children: [
                      Text(
                        controller.userName.value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 6.0,
                              color: Colors.black26,
                              offset: Offset(1.5, 1.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.email.value,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Editable Bio Card
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bio',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: controller.bio.value,
                        maxLines: null,
                        onChanged: (value) => controller.bio.value = value,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Write something about yourself...',
                          border: InputBorder.none,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                _buildActionButton('Edit Profile', Icons.edit),
              ],
            )),
      ),
    );
  }

  /// Reusable card
  Widget _buildCard({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        shadowColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }

  /// Reusable action button
  Widget _buildActionButton(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            // TODO: Navigate to edit profile screen
            controller.saveUserInfo();
            Get.snackbar(
              'Success',
              'Profile updated successfully',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: const Duration(seconds: 2),
            );
          },
          icon: Icon(icon),
          label: Text(title.tr, style: const TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
          ),
        ),
      ),
    );
  }

  /// Fallback avatar using initials
  Widget _buildInitialsAvatar(String name) {
    return Container(
      width: 120,
      height: 120,
      color: Colors.grey[200],
      child: Center(
        child: Text(
          _getInitials(name),
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  /// Get initials from name
  String _getInitials(String name) {
    List<String> parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
  }
}

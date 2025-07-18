import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/third_screen_controller.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ThirdScreenController());
    final userController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose a User"),
      ),
      body: Obx(() {
        if (controller.isEmpty.value) {
          return const Center(child: Text("No data found."));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchUsers(isRefresh: true);
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent &&
                  !controller.isLoading.value) {
                controller.fetchUsers();
              }
              return false;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: controller.users.length + 1,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                if (index < controller.users.length) {
                  User user = controller.users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                    onTap: () {
                      userController.selectedUserName.value =
                      '${user.firstName} ${user.lastName}';
                      Get.back(); // Kembali ke second screen
                    },
                  );
                } else {
                  return controller.isLoading.value
                      ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                      : const SizedBox.shrink();
                }
              },
            ),
          ),
        );
      }),
    );
  }
}

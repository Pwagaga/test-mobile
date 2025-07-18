import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import 'third_screen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Welcome", style: TextStyle(fontSize: 16)),
            Obx(() => Text(
              userController.userName.value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "Selected User Name",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Obx(() => Text(
                userController.selectedUserName.value.isNotEmpty
                    ? userController.selectedUserName.value
                    : '-',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Get.to(() => const ThirdScreen());
                },
                child: const Text("Choose a User"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

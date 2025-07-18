import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_mobile/controllers/user_controller.dart';
import 'second_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final palindromeController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF1E90FF),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 40),

                // Input Nama
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Input Palindrom
                TextField(
                  controller: palindromeController,
                  decoration: InputDecoration(
                    hintText: 'Palindrome',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Tombol Cek
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    final text = palindromeController.text.trim();
                    final isPalindrome = _checkPalindrome(text);

                    Get.dialog(AlertDialog(
                      title: const Text("Hasil"),
                      content: Text(isPalindrome
                          ? "isPalindrome"
                          : "bukan palindrom"),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text("OK"),
                        )
                      ],
                    ));
                  },
                  child: const Text("CHECK"),
                ),
                const SizedBox(height: 16),

                // Tombol Next
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    if (nameController.text.trim().isEmpty) {
                      Get.snackbar("Error", "Nama tidak boleh kosong",
                          snackPosition: SnackPosition.BOTTOM);
                      return;
                    }

                    // Set nama ke controller global
                    Get.put(UserController()).userName.value =
                        nameController.text.trim();

                    Get.to(() => const SecondScreen());
                  },
                  child: const Text("NEXT"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _checkPalindrome(String text) {
    final cleaned = text.replaceAll(RegExp(r'\s+'), '').toLowerCase();
    return cleaned == cleaned.split('').reversed.join();
  }
}

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF64C5B1), Color(0xFF3955A3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person_add, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 40),

                  // Input Nama
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input Palindrom
                  TextField(
                    controller: palindromeController,
                    decoration: InputDecoration(
                      hintText: 'Palindrome',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Tombol Check
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Colors.white, width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        final text = palindromeController.text.trim();
                        final isPalindrome = _checkPalindrome(text);

                        Get.dialog(AlertDialog(
                          title: const Text("Hasil"),
                          content: Text(isPalindrome ? "isPalindrome" : "bukan palindrom"),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text("OK"),
                            )
                          ],
                        ));
                      },
                      child: const Text(
                        "CHECK",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tombol Next
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Colors.white, width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
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
                      child: const Text(
                        "NEXT",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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

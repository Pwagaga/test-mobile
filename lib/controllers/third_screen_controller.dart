import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ThirdScreenController extends GetxController {
  var users = <User>[].obs;
  var page = 1;
  var perPage = 6;
  var isLoading = false.obs;
  var isEmpty = false.obs;

  @override
  void onInit() {
    fetchUsers(isRefresh: true);
    super.onInit();
  }

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isLoading.value) return;

    isLoading.value = true;
    if (isRefresh) {
      page = 1;
      users.clear();
    }

    final url = Uri.parse('https://reqres.in/api/users?page=$page&per_page=$perPage');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> list = data['data'];

      if (list.isEmpty && page == 1) {
        isEmpty.value = true;
      } else {
        users.addAll(list.map((e) => User.fromJson(e)).toList());
        page++;
      }
    }

    isLoading.value = false;
  }
}

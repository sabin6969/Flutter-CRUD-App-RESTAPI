import 'dart:convert';

import 'package:crud_rest_api/constants/app_strings.dart';
import 'package:crud_rest_api/models/api_response.dart';
import 'package:crud_rest_api/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userAgeController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Map<String, String> headers = {"Content-Type": "application/json"};

  Future<ApiResponse> addUser(User user) async {
    Response response = await post(
      headers: headers,
      Uri.parse(
        "http://$ipAddress:3000/add",
      ),
      body: jsonEncode({
        "userName": user.userName,
        "userAge": user.userAge!,
      }),
    );
    return ApiResponse.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Add User",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: userNameController,
                validator: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Enter User Name",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: userAgeController,
                validator: (value) =>
                    value!.isEmpty ? "This field is required" : null,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter User Age",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                elevation: 0,
                color: Colors.blue,
                height: size.height * 0.06,
                minWidth: double.infinity,
                shape: const StadiumBorder(),
                onPressed: () {
                  if (globalKey.currentState!.validate()) {
                    addUser(
                      User(
                        userName: userNameController.text,
                        userAge: int.tryParse(userAgeController.text) ?? 0,
                      ),
                    ).then(
                      (value) {
                        SnackBar snackBar = SnackBar(
                          content: Text(value.message!),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        userAgeController.clear();
                        userNameController.clear();
                      },
                    );
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:crud_rest_api/constants/app_strings.dart';
import 'package:crud_rest_api/models/users.dart';
import 'package:crud_rest_api/views/add_user_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Users> listOfUsers = [];

  Future<List<Users>> getListOfUsers() async {
    Response response = await get(Uri.parse("http://$ipAddress:3000/getAll"));
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      listOfUsers.clear();
      for (Map<String, dynamic> i in jsonBody) {
        listOfUsers.add(Users.fromJson(i));
      }
      return listOfUsers;
    }
    return listOfUsers;
  }

  Future<void> fetchUser() async {
    await getListOfUsers();
    setState(() {});
  }

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "CRUD App",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchUser();
        },
        child: FutureBuilder(
          future: getListOfUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (listOfUsers.isNotEmpty) {
                return ListView.builder(
                  itemCount: listOfUsers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {},
                      title: Text(listOfUsers[index].userName!),
                      subtitle: Text(listOfUsers[index].userAge!.toString()),
                      leading: Text(
                        listOfUsers[index].userId!.toString(),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("No users found"),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUserView(),
            ),
          ).then((value) {
            fetchUser();
          });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

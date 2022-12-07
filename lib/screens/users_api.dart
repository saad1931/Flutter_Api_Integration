// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:restapi/models/users_model.dart';

class UsersApi extends StatefulWidget {
  const UsersApi({super.key});

  @override
  State<UsersApi> createState() => _UsersApiState();
}

class _UsersApiState extends State<UsersApi> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUser() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var i in data) {
        //print(i['name']); for 1 thing
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Api"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUser(),
            builder: ((context, AsyncSnapshot<List<UserModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              RowWidget(title: "Name:",value:snapshot.data![index].name.toString()),
                              RowWidget(title: "Username:",value:snapshot.data![index].username.toString()),
                              RowWidget(title: "Email:",value:snapshot.data![index].email.toString()),
                              RowWidget(title: "Address:",
                              value:
                              snapshot.data![index].address!.street.toString()
                              +
                              ' , '
                              +
                              snapshot.data![index].address!.geo!.lat.toString()
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }),
          ))
        ],
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  String  value,title;
  RowWidget({Key? key, required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserApiWithoutModel extends StatefulWidget {
  const UserApiWithoutModel({super.key});

  @override
  State<UserApiWithoutModel> createState() => _UserApiWithoutModelState();
}

class _UserApiWithoutModelState extends State<UserApiWithoutModel> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Api Without Model'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUserApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            RowWidget2(
                                value: data[index]['id'].toString(),
                                title: "Id"),
                            RowWidget2(
                                value: data[index]['name'].toString(),
                                title: "Name"),
                            RowWidget2(
                                value: data[index]['username'].toString(),
                                title: "Username"),
                            RowWidget2(
                                value: data[index]['address']['street'].toString(),
                                title: "Address"),
                            RowWidget2(
                                value: data[index]['address']['geo']['lat'].toString(),
                                title: "Geo"),        
                          ],
                        ),
                      );
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}

class RowWidget2 extends StatelessWidget {
  String value, title;
  RowWidget2({Key? key, required this.value, required this.title})
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

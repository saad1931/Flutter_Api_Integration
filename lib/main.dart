import 'package:flutter/material.dart';
import 'package:restapi/screens/photos_api.dart';
import 'package:restapi/screens/post_api.dart';
import 'package:restapi/screens/product_api.dart';
import 'package:restapi/screens/singn_up_api.dart';
import 'package:restapi/screens/user_api_without_mpdel.dart';
import 'package:restapi/screens/users_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const PostApi(),
      // home: const PhotosApi(),
      // home: const UsersApi(),
      // home: const UserApiWithoutModel(),
      home: const SignUpApi(),
    );
  }
}



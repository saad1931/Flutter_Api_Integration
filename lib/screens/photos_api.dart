import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restapi/models/photos_model.dart';
import 'package:http/http.dart' as http;

class PhotosApi extends StatefulWidget {
  const PhotosApi({super.key});

  @override
  State<PhotosApi> createState() => _PhotosApiState();
}

class _PhotosApiState extends State<PhotosApi> {
  List<PhotosModel> photosList = [];
  Future<List<PhotosModel>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var i in data) {
        PhotosModel photosModel = PhotosModel(title: i['title'], url: i['url'],id: i['id']);
        photosList.add(photosModel);
      }
      return photosList;
    }
    return photosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photos Api"),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
              future: getPhotos(),
              builder: (context,AsyncSnapshot<List<PhotosModel>> snapshot) {
                return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading:CircleAvatar(backgroundImage:  NetworkImage(snapshot.data![index].url.toString()),),
                        title: Text("Notes Id: "+snapshot.data![index].id.toString()),
                        subtitle:Text(snapshot.data![index].title.toString()),
                      );
                    });
              }),
        )
      ]),
    );
  }
}

// Task 5 - Fetch Data from the api and display title and image, and onClick on image

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:full_screen_image/full_screen_image.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  List<dynamic> photos = [];

  void fetchPhotos() async {
    print('Fetch Photos Called');
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      photos = json;
    });
    print('Fetch Photos Completed');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text(
            'Task 5',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final post = photos[index];
              // final albumId = post['albumId'];
              final id = post['id'];
              final title = post['title'];
              final url = post['url'];
              // final thumbnailUrl = post['thumbnailUrl'];

              return Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: FullScreenWidget(
                            disposeLevel: DisposeLevel.Low,
                            child: Image.network(url),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Title: $title',
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

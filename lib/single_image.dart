import 'dart:io';

import 'package:camera/constant/app_color.dart';
import 'package:camera/gallery.dart';
import 'package:camera/helper/database.dart';
import 'package:flutter/material.dart';

class SingleImagePage extends StatefulWidget {
  final int id;
  final File imageUrl;
  // final Function stateQuery;

  SingleImagePage({required this.imageUrl, required this.id});

  @override
  State<SingleImagePage> createState() => _SingleImagePageState();
}

class _SingleImagePageState extends State<SingleImagePage> {
  doYouWnatToAdd(context, int id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text("Do you want to add to favourite?")),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  elevation: 0,
                                  color: AppColor.defaultButton,
                                  height: 50,
                                  // minWidth: 500,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  onPressed: () async {
                                    final dbHelper = DBHelper();
                                    final imagesData =
                                        await dbHelper.toFavourite(id);
                                    setState(() {});
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    // widget.stateQuery;
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  elevation: 0,
                                  color: AppColor.defaultButton,
                                  height: 50,
                                  // minWidth: 500,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        print('Image deleted successfully');
      } else {
        print('Image not found');
      }
    } catch (e) {
      print('Failed to delete image: $e');
    }
  }

  doYouWnatToDelete(context, int id, String path) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text("Do you want to delete image?")),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  elevation: 0,
                                  color: AppColor.defaultButton,
                                  height: 50,
                                  // minWidth: 500,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  onPressed: () async {
                                    final dbHelper = DBHelper();
                                    final imagesData =
                                        await dbHelper.deleteImage(id);
                                    deleteImage(path);
                                    print("reached ----------------");
                                    GalleryPage.reload(context);
                                    setState(() {});
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  elevation: 0,
                                  color: AppColor.defaultButton,
                                  height: 50,
                                  // minWidth: 500,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.defaultcard,
        title: Text('Single Image Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.file(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          AppColor.defaultButton, // Set the background color
                    ),
                    onPressed: () async {
                      doYouWnatToAdd(context, widget.id);
                      // Add your logic for adding to favorites here
                    },
                    child: Text('Add to Favorites'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent, // Set the background color
                    ),
                    onPressed: () async {
                      // doYouWnatToAdd(context, widget.id);
                      doYouWnatToDelete(
                          context, widget.id, widget.imageUrl.path);
                      // Add your logic for adding to favorites here
                    },
                    child: Text('Delete'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

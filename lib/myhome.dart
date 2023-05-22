import 'dart:convert';

// import 'package:encrypt/encrypt.dart';
import 'package:camera/constant/app_color.dart';
import 'package:camera/favourite_gallery.dart';
import 'package:camera/favourite_single_image.dart';
import 'package:camera/gallery.dart';
import 'package:camera/helper/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
// import 'package:majascan/majascan.dart';
// import 'package:super_qr_reader/super_qr_reader.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  String? _imagepath;
  String? image_name;
  int uploaded = 0;
  // String result = "Hey there !";
  openCamera() async {
    try {
      var pickedfiles = await imgpicker.pickImage(source: ImageSource.camera);
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        setState(() {
          // imagefiles = pickedfiles;
          _imagepath = pickedfiles.path;
        });
        // uploadImage();
        print(_imagepath!);
        GallerySaver.saveImage(_imagepath!);

        final dbHelper = DBHelper();
        var data = {
          "path": _imagepath!,
          "is_favourite": false
        };
        final historydata = await dbHelper.insertImages(data);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  // Future _scanQR() async {
  //   try {
  //     String? qrResult = await MajaScan.startScan(
  //         title: "QRcode scanner",
  //         titleColor: AppColor.defaultApp,
  //         qRCornerColor: AppColor.defaultButton,
  //         qRScannerColor: AppColor.defaultButton);
  //     setState(() {
  //       result = qrResult ?? 'null string';
  //     });
  //   } on PlatformException catch (ex) {
  //     if (ex.code == MajaScan.CameraAccessDenied) {
  //       setState(() {
  //         result = "Camera permission was denied";
  //       });
  //     } else {
  //       setState(() {
  //         result = "Unknown Error $ex";
  //       });
  //     }
  //   } on FormatException {
  //     setState(() {
  //       result = "You pressed the back button before scanning anything";
  //     });
  //   } catch (ex) {
  //     setState(() {
  //       result = "Unknown Error $ex";
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Camera app",
            style: TextStyle(color: Colors.black),
          ),
          
        ),

        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bannerImage(context),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Service",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                _navigationCards(context),
                // _timetableTime()
                // _navigationCards(context),
              ],
            )));
  }

  // ignore: unused_element
  Widget _navigationCards(context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _createdCard(context)),
            Expanded(child: _sharedCard(context)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _createCard(context)),
            Expanded(child: _newsCard(context)),
          ],
        )
      ],
    );
  }

  // ignore: unused_element
  Widget _bannerImage(context) {
    return Container(
        height: 200,
        decoration: const BoxDecoration(
          // color: AppColor.defaultcard,
          image: DecorationImage(
              image: AssetImage("assets/images/camera.png"),
              // image: NetworkImage(
              // "https://images.pexels.com/photos/5208356/pexels-photo-5208356.jpeg?auto=compress&cs=tinysrgb&w=1600"),
              fit: BoxFit.fitWidth),
          // Fit(),
        ));
    // return Image.asset(
    //   "assets/images/timetable_front.png",
    //   width: MediaQuery.of(context).size.width,
    //   height: 250,
    // );
  }

  // ignore: unused_element
  Widget _createdCard(context) {
    return InkWell(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            // width: 180.0,
            decoration: BoxDecoration(
                color: AppColor.defaultcard,
                // border: Border.all(
                //   color: Colors.black,
                //   width: 2.0,
                // ),
                borderRadius: BorderRadius.circular(10.0),
                // gradient: const LinearGradient(
                //   colors: [
                //     Colors.black,
                //     Colors.greenAccent
                //   ]
                // ),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      offset: Offset(2.0, 2.0))
                ]),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      Icon(
                        Icons.camera,
                        color: Colors.black26,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Camera"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        openCamera();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const HistoryPage()),
        // );
      },
    );
    // );
  }

  Widget _sharedCard(context) {
    return InkWell(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            // width: 180.0,
            decoration: BoxDecoration(
                color: AppColor.defaultcard,
                // border: Border.all(
                //   color: Colors.black,
                //   width: 2.0,
                // ),
                borderRadius: BorderRadius.circular(10.0),
                // gradient: const LinearGradient(
                //   colors: [
                //     Colors.black,
                //     Colors.greenAccent
                //   ]
                // ),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      offset: Offset(2.0, 2.0))
                ]),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      Icon(
                        Icons.folder_shared,
                        color: Colors.black26,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Gallery"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  GalleryPage()),
        );
      },
    );
    // );
  }

  Widget _createCard(context) {
    return InkWell(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: 180.0,
            decoration: BoxDecoration(
                color: AppColor.defaultcard,
                // border: Border.all(
                //   color: Colors.black,
                //   width: 2.0,
                // ),
                borderRadius: BorderRadius.circular(10.0),
                // gradient: const LinearGradient(
                //   colors: [
                //     Colors.black,
                //     Colors.greenAccent
                //   ]
                // ),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      offset: Offset(2.0, 2.0))
                ]),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      Icon(
                        Icons.add_circle,
                        color: Colors.black26,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Favourite"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavouriteGalleryPage()),
        );
      },
    );
    // );
  }

  Widget _newsCard(context) {
    return InkWell(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: 180.0,
            decoration: BoxDecoration(
                color: AppColor.defaultcard,
                // border: Border.all(
                //   color: Colors.black,
                //   width: 2.0,
                // ),
                borderRadius: BorderRadius.circular(10.0),
                // gradient: const LinearGradient(
                //   colors: [
                //     Colors.black,
                //     Colors.greenAccent
                //   ]
                // ),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      offset: Offset(2.0, 2.0))
                ]),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      Icon(
                        Icons.new_releases,
                        color: Colors.black26,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("News"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const NewsPage()),
        // );
      },
    );
    // );
  }

  
}
  

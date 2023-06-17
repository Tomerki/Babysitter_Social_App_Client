import 'dart:convert';
import 'dart:io';
import 'parent_main_screen.dart';
import 'package:baby_sitter/server_manager.dart';
import 'package:baby_sitter/widgets/loading.dart';
import 'package:baby_sitter/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/appUser.dart';
import '../../widgets/map_place_picker.dart';

class EditParentProfileScreen extends StatefulWidget {
  String? image;
  String? address;

  static const routeName = 'babysitter-register-screen';

  EditParentProfileScreen(
      {super.key, this.image, this.address = "Pick Address"});

  @override
  State<EditParentProfileScreen> createState() =>
      _EditParentProfileScreenState();
}

class _EditParentProfileScreenState extends State<EditParentProfileScreen> {
  Future<dynamic>? parentFuture;
  Future<dynamic> fetchParent() async {
    final result =
        await ServerManager().getRequest('items/' + AppUser.getUid(), 'Parent');
    return json.decode(result.body);
  }

  callback(String newAddress) {
    setState(() {
      widget.address = newAddress;
    });
  }

  @override
  void initState() {
    parentFuture = fetchParent();
    super.initState();
  }

  final _formKey2 = GlobalKey<FormState>();
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: parentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the future to complete, show a progress indicator
            return Loading();
          } else if (snapshot.hasError) {
            // If there's an error, display an error message
            return Text('Error: ${snapshot.error}');
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                      fit: BoxFit.cover,
                      opacity: 0.3)),
              child: Form(
                key: _formKey2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      UserImagePicker(
                        image: widget.image,
                        onPickImage: (pickedImage) {
                          _selectedImage = pickedImage;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              Navigator.of(context).pushNamed(
                                MapPlacePicker.routeName,
                                arguments: callback,
                              );
                            },
                            child: Text(
                              widget.address!,
                              style: GoogleFonts.workSans(
                                color: Colors.black,
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                child: Text(
                                  'Save Changes',
                                  style: GoogleFonts.workSans(
                                    color: Colors.white,
                                    textStyle: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.8),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                ),
                                onPressed: () async {
                                  if (_selectedImage != null) {
                                    final storageRef = FirebaseStorage.instance
                                        .ref()
                                        .child('user_images')
                                        .child('${AppUser.getUid()}.jpg');

                                    await storageRef.putFile(_selectedImage!);
                                    widget.image =
                                        await storageRef.getDownloadURL();
                                  }
                                  await ServerManager()
                                      .putRequest(
                                    'items/' + AppUser.getUid(),
                                    'Parent',
                                    body: jsonEncode(
                                      {
                                        'image': widget.image,
                                        'address': widget.address,
                                      },
                                    ),
                                  )
                                      .then((value) async {
                                    await ServerManager()
                                        .getRequest('items/' + AppUser.getUid(),
                                            'Parent')
                                        .then((val) {
                                      Navigator.of(context).popAndPushNamed(
                                        ParentMainScreen.routeName,
                                        arguments: val.body,
                                      );
                                    });
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                child: Text(
                                  'Cancle',
                                  style: GoogleFonts.workSans(
                                    color: Colors.white,
                                    textStyle: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  backgroundColor:
                                      Color.fromARGB(255, 81, 26, 26)
                                          .withOpacity(0.8),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                ),
                                onPressed: () async {
                                  await ServerManager()
                                      .getRequest(
                                          'items/' + AppUser.getUid(), 'Parent')
                                      .then((val) {
                                    Navigator.of(context).popAndPushNamed(
                                      ParentMainScreen.routeName,
                                      arguments: val.body,
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

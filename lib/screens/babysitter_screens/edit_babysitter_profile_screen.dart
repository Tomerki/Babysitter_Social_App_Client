import 'dart:convert';
import 'dart:io';
import 'package:baby_sitter/server_manager.dart';
import 'package:baby_sitter/widgets/loading.dart';
import 'package:baby_sitter/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/appUser.dart';
import '../../widgets/map_place_picker.dart';
import 'babysitter_main_screen.dart';

class EditBabysitterProfileScreen extends StatefulWidget {
  final Map<String, bool> texts;
  String? about;
  double? price;
  String? age;
  String? image;
  String? address;

  static const routeName = 'babysitter-register-screen';

  EditBabysitterProfileScreen(
      {super.key,
      required this.texts,
      this.about = '',
      this.price = -0.1,
      this.age = '18',
      this.image,
      this.address = "Pick Address"});

  @override
  State<EditBabysitterProfileScreen> createState() =>
      _EditBabysitterProfileScreenState();
}

class _EditBabysitterProfileScreenState
    extends State<EditBabysitterProfileScreen> {
  Future<dynamic>? babysitterFuture;
  Future<dynamic> fetchBabysitter() async {
    final result = await ServerManager()
        .getRequest('items/' + AppUser.getUid(), 'Babysitter');
    return json.decode(result.body);
  }

  @override
  void initState() {
    babysitterFuture = fetchBabysitter();
    super.initState();
  }

  callback(String newAddress) {
    setState(() {
      widget.address = newAddress;
    });
  }

  final _formKey2 = GlobalKey<FormState>();
  File? _selectedImage;

  List<String> ageList =
      List.generate(165, (index) => (18 + (index * 0.5)).toStringAsFixed(1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: babysitterFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the future to complete, show a progress indicator
            return Loading();
          } else if (snapshot.hasError) {
            // If there's an error, display an error message
            return Text('Error: ${snapshot.error}');
          } else {
            dynamic babysitter = snapshot.data;
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
                      Container(
                        padding: const EdgeInsets.only(
                            top: 60, bottom: 30, right: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            UserImagePicker(
                              image: widget.image,
                              onPickImage: (pickedImage) {
                                _selectedImage = pickedImage;
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'About',
                                  style: GoogleFonts.workSans(
                                    color: Colors.black.withOpacity(0.5),
                                    textStyle: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 50,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Me',
                                  style: GoogleFonts.workSans(
                                    color: Colors.black.withOpacity(0.5),
                                    textStyle: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          margin: EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  widget.about = value;
                                });
                              },
                              maxLines: 6,
                              decoration: InputDecoration.collapsed(
                                hintText: babysitter['about'],
                              ),
                              style: GoogleFonts.workSans(
                                color: Colors.black,
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: DropdownButtonFormField(
                          menuMaxHeight:
                              MediaQuery.of(context).size.height * 0.5,
                          items: ageList.map((age) {
                            return DropdownMenuItem<String>(
                              value: age,
                              child: Text(
                                double.parse(age).toStringAsFixed(
                                    age.endsWith('.0') ? 0 : 1),
                                style: GoogleFonts.workSans(
                                  color: Colors.black,
                                  textStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              widget.age = value!;
                            });
                          },
                          hint: Text(
                            babysitter['age'],
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          isExpanded: true,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextField(
                          style: GoogleFonts.workSans(
                            color: Colors.black,
                            textStyle: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          decoration: InputDecoration(
                            hintText: babysitter['price'] > 0
                                ? babysitter['price'].toString()
                                : 'price per hour',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              widget.price = double.parse(value);
                            });
                          },
                        ),
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
                      Container(
                        padding: EdgeInsets.only(top: 30, bottom: 15),
                        child: Text(
                          'Your skills:',
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
                      ...widget.texts.keys.map(
                        (key) {
                          return CheckboxListTile(
                            value: widget.texts[key],
                            onChanged: (val) {
                              setState(() {
                                widget.texts[key] = val!;
                              });
                            },
                            title: Text(
                              key,
                              style: GoogleFonts.workSans(
                                color: Colors.black,
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                          );
                        },
                      ),
                      Divider(),
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
                                  bool good = await ServerManager.checkLanguage(
                                      widget.about!);
                                  if (!good) {
                                    if (_selectedImage != null) {
                                      final storageRef = FirebaseStorage
                                          .instance
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
                                      'Babysitter',
                                      body: jsonEncode(
                                        {
                                          'price': widget.price == ''
                                              ? 0
                                              : widget.price,
                                          'about': widget.about,
                                          'age': widget.age,
                                          'image': widget.image,
                                          'address': widget.address,
                                          'ComeToClient': widget
                                              .texts['Come to client']
                                              .toString(),
                                          'InMyPlace': widget
                                              .texts['In my place']
                                              .toString(),
                                          'HelpingWithHouseWork': widget
                                              .texts['Helping with housework']
                                              .toString(),
                                          'KnowsHowToCook': widget
                                              .texts['Knows how to cook']
                                              .toString(),
                                          'FirstAidCertified': widget
                                              .texts['First aid certified']
                                              .toString(),
                                          'HasDriverLicense': widget
                                              .texts['Has a driver\'s license']
                                              .toString(),
                                          'HasPastExperience': widget
                                              .texts['Has past experience']
                                              .toString(),
                                          'HasAnEducationInEducation': widget
                                              .texts[
                                                  'Has an education in education']
                                              .toString(),
                                          'TakesToActivities': widget
                                              .texts['Takes to/from activities']
                                              .toString(),
                                          'ChangeADiaper': widget
                                              .texts['Change a diaper']
                                              .toString(),
                                        },
                                      ),
                                    )
                                        .then(
                                      (value) async {
                                        await ServerManager()
                                            .getRequest(
                                                'items/' + AppUser.getUid(),
                                                'Babysitter')
                                            .then(
                                          (val) {
                                            Navigator.of(context)
                                                .popAndPushNamed(
                                              BabysitterMainScreen.routeName,
                                              arguments: val.body,
                                            );
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        elevation: 5,
                                        content: Text(
                                          "Please Use with an appropriate language",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  }
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
                                      .getRequest('items/' + AppUser.getUid(),
                                          'Babysitter')
                                      .then((val) {
                                    Navigator.of(context).popAndPushNamed(
                                      BabysitterMainScreen.routeName,
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

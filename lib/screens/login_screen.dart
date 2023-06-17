import 'dart:convert';
import 'dart:developer';
import 'parent_screens/parent_main_screen.dart';
import 'package:baby_sitter/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/appUser.dart';
import '../models/sharedPreferencesHelper.dart';
import '../server_manager.dart';
import '../services/auth.dart';
import '../services/validation.dart';
import '../widgets/loading.dart';
import 'babysitter_screens/babysitter_main_screen.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => loginScreenState();
}

class loginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  String? email, password;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isBabysitter = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                      fit: BoxFit.cover,
                      opacity: 0.3)),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.network(
                            'https://assets6.lottiefiles.com/packages/lf20_k9wsvzgd.json',
                            animate: true,
                            height: 120,
                            width: 600),
                        Text(
                          'Login',
                          style: GoogleFonts.indieFlower(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                            ),
                          ),
                        ),
                        Text(
                          'Please login to continue using our app',
                          style: GoogleFonts.workSans(
                            textStyle: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20, top: 20),
                                  child: TextFormField(
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Email field cannot be empty";
                                      } else if (emailAddressValidator(value)) {
                                        return 'Please Enter a valid email';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.purple,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Email",
                                      hintText: 'your-email@domain.com',
                                      labelStyle:
                                          TextStyle(color: Colors.purple),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: TextFormField(
                                    obscuringCharacter: '*',
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.purple,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Password",
                                      hintText: '*********',
                                      labelStyle:
                                          TextStyle(color: Colors.purple),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "pasaword field cannot be empty";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      backgroundColor: Colors.purple,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          vertical: 20)),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState == null) {
                                      print('_formKey.currentState == null');
                                    } else if (_formKey.currentState!
                                        .validate()) {
                                      setState(() {
                                        () => loading = true;
                                      });
                                      dynamic result = await _auth
                                          .signInWithEmailAndpassword(
                                              email!, password!);
                                      if (result == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(255, 120, 12, 5),
                                          content: Center(
                                            child: Text(
                                              "email or password incorrect",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ));
                                        setState(() {
                                          () => loading = false;
                                        });
                                      } else {
                                        await ServerManager()
                                            .getRequest(
                                                'search/uid/' +
                                                    result.uid.toString(),
                                                'Users')
                                            .then((value) async {
                                          isBabysitter = json.decode(value.body
                                              .toString())['isBabysitter'];

                                          final type = isBabysitter
                                              ? 'Babysitter'
                                              : 'Parent';
                                          AppUser.updateInstance(
                                            uid: result.uid.toString(),
                                            isBabysitter: isBabysitter,
                                            userType: type,
                                          );
                                          if (isBabysitter) {
                                            await ServerManager()
                                                .getRequest(
                                                    'search/email/' + email!,
                                                    'Babysitter')
                                                .then((user) async {
                                              await SharedPreferencesHelper
                                                  .setLoggedInUser(
                                                json.decode(user.body)['uid'],
                                                'Babysitter',
                                                email!,
                                              );
                                              Navigator.of(context)
                                                  .popAndPushNamed(
                                                BabysitterMainScreen.routeName,
                                                arguments: user.body,
                                              );
                                            });
                                          } else {
                                            await ServerManager()
                                                .getRequest(
                                              'search/email/' + email!,
                                              'Parent',
                                            )
                                                .then(
                                              (user) async {
                                                await SharedPreferencesHelper
                                                    .setLoggedInUser(
                                                  json.decode(user.body)['uid'],
                                                  'Parent',
                                                  email!,
                                                );
                                                Navigator.of(context)
                                                    .popAndPushNamed(
                                                  ParentMainScreen.routeName,
                                                  arguments: user.body,
                                                );
                                              },
                                            );
                                          }
                                        });
                                        AuthService.setUserData();
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Log In',
                                    style: GoogleFonts.workSans(
                                      textStyle: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not registered yet?',
                              style: GoogleFonts.workSans(
                                color: Colors.black,
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.routeName);
                              },
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.workSans(
                                  color: Colors.purple,
                                  textStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

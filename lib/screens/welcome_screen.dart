import 'package:google_fonts/google_fonts.dart';
import './register_screen.dart';
import './login_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = 'welcome-screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget buildRow(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.workSans(
              textStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Icon(icon),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                  fit: BoxFit.cover,
                  opacity: 0.3)),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Welcome',
                        style: GoogleFonts.workSans(
                          textStyle: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'To BabyMe',
                        style: GoogleFonts.workSans(
                          textStyle: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildRow('Finding nanny from everywhere!', Icons.public),
                    buildRow(
                        'Easy and Simple to use!', Icons.accessibility_new),
                    buildRow('Safety for your child!', Icons.safety_check),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.purple,
                            padding: EdgeInsets.symmetric(vertical: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(LoginScreen.routeName);
                          },
                          child: Text(
                            'Click to Login',
                            style: GoogleFonts.workSans(
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.purple,
                            padding: EdgeInsets.symmetric(vertical: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegisterScreen.routeName);
                          },
                          child: Text(
                            'Click to Sign-Up',
                            style: GoogleFonts.workSans(
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

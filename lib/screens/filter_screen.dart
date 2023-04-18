import 'package:baby_sitter/screens/babysitter_search_results_screen.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../widgets/input_box.dart';

const kTextLabelTheme = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700);
const kCardTextStyle = TextStyle(color: Colors.white, fontSize: 15);
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

enum LocationOprions { at_your_house, at_her_house, never_mind }

class FilterScreen extends StatefulWidget {
  static final routeName = 'FilterSecScreen';

  @override
  State<FilterScreen> createState() => _FilterScreennState();
}

class _FilterScreennState extends State<FilterScreen>
    with TickerProviderStateMixin {
  final AuthService _auth = AuthService();
  late TabController _tabController;

  late double selectedValue;
  int? fromDropdownValue;
  int? toDropdownValue;
  int? numOfChildren;

  Map<String, bool> currentAdditionsFilters = {
    'Take out of school or kindergarten': false,
    'Knowledge of first aid': false,
    'Helping with housework': false,
    'Take to outdoor activities': false,
    'Have a driver\'s license': false,
    'change a diaper': false,
    'have experience': false,
    'Studied education': false,
  };
  List<String> currentAdditionsFiltersList = [
    'Take out of school or kindergarten',
    'Knowledge of first aid',
    'Helping with housework',
    'Take to outdoor activities',
    'Have a driver\'s license',
    'change a diaper',
    'have experience',
    'Studied education',
  ];

  bool isCheckedOne = false;
  bool isCheckedTwo = false;
  bool _isHide = false;
  RangeValues priceValues = RangeValues(0.0, 100.0);
  RangeValues distanceValues = RangeValues(0.0, 50.0);
  LocationOprions? _locationOprions = LocationOprions.at_your_house;
  var _formKey = GlobalKey<FormState>();
  String? name;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    // .then((pickDate) {
    //   if (pickDate == null) {
    //     return;
    //   } else {
    //     setState(() {
    //       _selectedDate = pickDate;
    //     });
    //   }
    // });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter By'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              child: Text(
                'By Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Tab(
              child: Text(
                'By Criteria',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 219, 163, 154),
      ),
      floatingActionButton: ElevatedButton(
        // onPressed: () async {
        //   await _auth.singOut();
        // },
        onPressed: () {
          Navigator.of(context)
              .pushNamed(BabysitterSearchResultsScreen.routeName);
        },
        child: Text('Search'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 174, 194, 182),
          padding: EdgeInsets.all(15),
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 5,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: InputBox(
              keyType: TextInputType.name,
              text: 'Enter a name',
              onChanged: (value) {
                name = value;
              },
              validator: () {},
            ),
          ),
          Container(
            height: (queryData.size.height) * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Price Per An Hour:',
                            style: kTextLabelTheme,
                          ),
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        // rangeThumbShape: CustomRangeThumbShape(),
                        activeTrackColor: Color.fromARGB(255, 129, 91, 91),
                        inactiveTrackColor: Color(0xffDFDFDF),
                        showValueIndicator: ShowValueIndicator.always,
                        valueIndicatorColor: Colors.white,
                        // rangeValueIndicatorShape: CustomRangeValueIndicatorShape(),
                        valueIndicatorTextStyle: TextStyle(color: Colors.black),
                        valueIndicatorShape: SliderComponentShape.noOverlay,
                        thumbColor: Colors.black,
                      ),
                      child: RangeSlider(
                        values: priceValues,
                        divisions: 100,
                        min: 0.0,
                        max: 100.0,
                        labels: RangeLabels('\$${priceValues.start.toInt()}',
                            '\$${priceValues.end.toInt()}'),
                        onChanged: (value) {
                          setState(() {
                            priceValues = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Distance:',
                            style: kTextLabelTheme,
                          ),
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        // rangeThumbShape: CustomRangeThumbShape(),
                        activeTrackColor: Color.fromARGB(255, 129, 91, 91),
                        inactiveTrackColor: Color(0xffDFDFDF),
                        showValueIndicator: ShowValueIndicator.always,
                        valueIndicatorColor: Colors.white,
                        // rangeValueIndicatorShape: CustomRangeValueIndicatorShape(),
                        valueIndicatorTextStyle: TextStyle(color: Colors.black),
                        valueIndicatorShape: SliderComponentShape.noOverlay,
                        thumbColor: Colors.black,
                      ),
                      child: RangeSlider(
                        values: distanceValues,
                        divisions: 100,
                        min: 0.0,
                        max: 50.0,
                        labels: RangeLabels('${distanceValues.start.toInt()}km',
                            '${distanceValues.end.toInt()}km'),
                        onChanged: (value) {
                          setState(() {
                            distanceValues = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Location:',
                        style: kTextLabelTheme,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RadioListTile<LocationOprions>(
                            contentPadding: EdgeInsets.all(0),
                            title: const Text('At Your House'),
                            value: LocationOprions.at_your_house,
                            groupValue: _locationOprions,
                            onChanged: (LocationOprions? value) {
                              setState(() {
                                _locationOprions = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<LocationOprions>(
                            contentPadding: EdgeInsets.all(0),
                            title: const Text('At Her House'),
                            value: LocationOprions.at_her_house,
                            groupValue: _locationOprions,
                            onChanged: (LocationOprions? value) {
                              setState(() {
                                _locationOprions = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<LocationOprions>(
                            contentPadding: EdgeInsets.all(0),
                            title: const Text('Never Mind'),
                            value: LocationOprions.never_mind,
                            groupValue: _locationOprions,
                            onChanged: (LocationOprions? value) {
                              setState(() {
                                _locationOprions = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  'Date:',
                                  style: kTextLabelTheme,
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: _presentDatePicker,
                                  child: Text('choose a date'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Color.fromARGB(255, 219, 163, 154),
                                    padding: EdgeInsets.all(15),
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  'Time: ',
                                  style: kTextLabelTheme,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DropdownButton<int>(
                                          hint: Text('from'),
                                          value: fromDropdownValue,
                                          items: List<int>.generate(
                                                  24, (index) => index)
                                              .map<DropdownMenuItem<int>>(
                                                  (int value) {
                                            return DropdownMenuItem<int>(
                                              value: value,
                                              child: Text(
                                                  '${value.toString().padLeft(2, '0')}:00'),
                                            );
                                          }).toList(),
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              fromDropdownValue = newValue!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DropdownButton<int>(
                                          hint: Text('to'),
                                          value: toDropdownValue,
                                          items: List<int>.generate(
                                                  24, (index) => index)
                                              .map<DropdownMenuItem<int>>(
                                                  (int value) {
                                            return DropdownMenuItem<int>(
                                              value: value,
                                              child: Text(
                                                  '${value.toString().padLeft(2, '0')}:00'),
                                            );
                                          }).toList(),
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              toDropdownValue = newValue!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: Text(
                        'Number Of Children: ',
                        style: kTextLabelTheme,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<int>(
                          hint: Text('num of children'),
                          value: numOfChildren,
                          items: List<int>.generate(5, (index) => index + 1)
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('${value.toString()}'),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              numOfChildren = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    numOfChildren == null
                        ? Text('')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                  'Ages: ',
                                  style: kTextLabelTheme,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List<int>.generate(
                                        numOfChildren!, (index) => index + 1)
                                    .map((number) {
                                  return Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          labelText: '${number.toString()}'),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        'Additions: ',
                        style: kTextLabelTheme,
                      ),
                    ),
                    Column(
                      children: List.generate(
                          currentAdditionsFiltersList.length, (index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentAdditionsFiltersList[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateColor.resolveWith(
                                (states) => Color.fromARGB(255, 219, 163, 154),
                              ),
                              value: currentAdditionsFilters[
                                  currentAdditionsFiltersList[index]],
                              onChanged: (bool? value) {
                                // print(currentAdditionsFiltersList[index]);
                                // print(currentAdditionsFilters[
                                //     currentAdditionsFiltersList[index]]);
                                setState(() {
                                  currentAdditionsFilters[
                                          currentAdditionsFiltersList[index]] =
                                      value!;
                                });
                              },
                            )
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // body: Container(
      //   height: (queryData.size.height) * 0.9,
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //   ),
      //   child: SingleChildScrollView(
      //     child: Container(
      //       margin: EdgeInsets.all(20.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Container(
      //             padding: EdgeInsets.only(top: 10.0),
      //             child: Row(
      //               children: <Widget>[
      //                 Text(
      //                   'Price Per An Hour:',
      //                   style: kTextLabelTheme,
      //                 ),
      //               ],
      //             ),
      //           ),
      //           SliderTheme(
      //             data: SliderTheme.of(context).copyWith(
      //               // rangeThumbShape: CustomRangeThumbShape(),
      //               activeTrackColor: Color.fromARGB(255, 129, 91, 91),
      //               inactiveTrackColor: Color(0xffDFDFDF),
      //               showValueIndicator: ShowValueIndicator.always,
      //               valueIndicatorColor: Colors.white,
      //               // rangeValueIndicatorShape: CustomRangeValueIndicatorShape(),
      //               valueIndicatorTextStyle: TextStyle(color: Colors.black),
      //               valueIndicatorShape: SliderComponentShape.noOverlay,
      //               thumbColor: Colors.black,
      //             ),
      //             child: RangeSlider(
      //               values: priceValues,
      //               divisions: 100,
      //               min: 0.0,
      //               max: 100.0,
      //               labels: RangeLabels('\$${priceValues.start.toInt()}',
      //                   '\$${priceValues.end.toInt()}'),
      //               onChanged: (value) {
      //                 setState(() {
      //                   priceValues = value;
      //                 });
      //               },
      //             ),
      //           ),
      //           Container(
      //             padding: EdgeInsets.only(top: 10.0),
      //             child: Row(
      //               children: <Widget>[
      //                 Text(
      //                   'Distance:',
      //                   style: kTextLabelTheme,
      //                 ),
      //               ],
      //             ),
      //           ),
      //           SliderTheme(
      //             data: SliderTheme.of(context).copyWith(
      //               // rangeThumbShape: CustomRangeThumbShape(),
      //               activeTrackColor: Color.fromARGB(255, 129, 91, 91),
      //               inactiveTrackColor: Color(0xffDFDFDF),
      //               showValueIndicator: ShowValueIndicator.always,
      //               valueIndicatorColor: Colors.white,
      //               // rangeValueIndicatorShape: CustomRangeValueIndicatorShape(),
      //               valueIndicatorTextStyle: TextStyle(color: Colors.black),
      //               valueIndicatorShape: SliderComponentShape.noOverlay,
      //               thumbColor: Colors.black,
      //             ),
      //             child: RangeSlider(
      //               values: distanceValues,
      //               divisions: 100,
      //               min: 0.0,
      //               max: 50.0,
      //               labels: RangeLabels('${distanceValues.start.toInt()}km',
      //                   '${distanceValues.end.toInt()}km'),
      //               onChanged: (value) {
      //                 setState(() {
      //                   distanceValues = value;
      //                 });
      //               },
      //             ),
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(top: 10.0),
      //             child: Text(
      //               'Location:',
      //               style: kTextLabelTheme,
      //             ),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //               Expanded(
      //                 child: RadioListTile<LocationOprions>(
      //                   contentPadding: EdgeInsets.all(0),
      //                   title: const Text('At Your House'),
      //                   value: LocationOprions.at_your_house,
      //                   groupValue: _locationOprions,
      //                   onChanged: (LocationOprions? value) {
      //                     setState(() {
      //                       _locationOprions = value;
      //                     });
      //                   },
      //                 ),
      //               ),
      //               Expanded(
      //                 child: RadioListTile<LocationOprions>(
      //                   contentPadding: EdgeInsets.all(0),
      //                   title: const Text('At Her House'),
      //                   value: LocationOprions.at_her_house,
      //                   groupValue: _locationOprions,
      //                   onChanged: (LocationOprions? value) {
      //                     setState(() {
      //                       _locationOprions = value;
      //                     });
      //                   },
      //                 ),
      //               ),
      //               Expanded(
      //                 child: RadioListTile<LocationOprions>(
      //                   contentPadding: EdgeInsets.all(0),
      //                   title: const Text('Never Mind'),
      //                   value: LocationOprions.never_mind,
      //                   groupValue: _locationOprions,
      //                   onChanged: (LocationOprions? value) {
      //                     setState(() {
      //                       _locationOprions = value;
      //                     });
      //                   },
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //               Expanded(
      //                 child: Column(
      //                   children: [
      //                     Padding(
      //                       padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      //                       child: Text(
      //                         'Date:',
      //                         style: kTextLabelTheme,
      //                       ),
      //                     ),
      //                     Center(
      //                       child: ElevatedButton(
      //                         onPressed: _presentDatePicker,
      //                         child: Text('choose a date'),
      //                         style: ElevatedButton.styleFrom(
      //                           foregroundColor: Colors.white,
      //                           backgroundColor:
      //                               Color.fromARGB(255, 219, 163, 154),
      //                           padding: EdgeInsets.all(15),
      //                           textStyle: TextStyle(
      //                             color: Colors.black,
      //                             fontSize: 16,
      //                           ),
      //                           shape: RoundedRectangleBorder(
      //                             borderRadius: BorderRadius.circular(10),
      //                           ),
      //                           elevation: 5,
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Expanded(
      //                 child: Column(
      //                   children: [
      //                     Padding(
      //                       padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      //                       child: Text(
      //                         'Time: ',
      //                         style: kTextLabelTheme,
      //                       ),
      //                     ),
      //                     Row(
      //                       children: [
      //                         Expanded(
      //                           child: Column(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               DropdownButton<int>(
      //                                 hint: Text('from'),
      //                                 value: fromDropdownValue,
      //                                 items: List<int>.generate(
      //                                         24, (index) => index)
      //                                     .map<DropdownMenuItem<int>>(
      //                                         (int value) {
      //                                   return DropdownMenuItem<int>(
      //                                     value: value,
      //                                     child: Text(
      //                                         '${value.toString().padLeft(2, '0')}:00'),
      //                                   );
      //                                 }).toList(),
      //                                 onChanged: (int? newValue) {
      //                                   setState(() {
      //                                     fromDropdownValue = newValue!;
      //                                   });
      //                                 },
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                         SizedBox(
      //                           width: 10,
      //                         ),
      //                         Expanded(
      //                           child: Column(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               DropdownButton<int>(
      //                                 hint: Text('to'),
      //                                 value: toDropdownValue,
      //                                 items: List<int>.generate(
      //                                         24, (index) => index)
      //                                     .map<DropdownMenuItem<int>>(
      //                                         (int value) {
      //                                   return DropdownMenuItem<int>(
      //                                     value: value,
      //                                     child: Text(
      //                                         '${value.toString().padLeft(2, '0')}:00'),
      //                                   );
      //                                 }).toList(),
      //                                 onChanged: (int? newValue) {
      //                                   setState(() {
      //                                     toDropdownValue = newValue!;
      //                                   });
      //                                 },
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               )
      //             ],
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
      //             child: Text(
      //               'Number Of Children: ',
      //               style: kTextLabelTheme,
      //             ),
      //           ),
      //           Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               DropdownButton<int>(
      //                 hint: Text('num of children'),
      //                 value: numOfChildren,
      //                 items: List<int>.generate(5, (index) => index + 1)
      //                     .map<DropdownMenuItem<int>>((int value) {
      //                   return DropdownMenuItem<int>(
      //                     value: value,
      //                     child: Text('${value.toString()}'),
      //                   );
      //                 }).toList(),
      //                 onChanged: (int? newValue) {
      //                   setState(() {
      //                     numOfChildren = newValue!;
      //                   });
      //                 },
      //               ),
      //             ],
      //           ),
      //           numOfChildren == null
      //               ? Text('')
      //               : Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Padding(
      //                       padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      //                       child: Text(
      //                         'Ages: ',
      //                         style: kTextLabelTheme,
      //                       ),
      //                     ),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                       children: List<int>.generate(
      //                               numOfChildren!, (index) => index + 1)
      //                           .map((number) {
      //                         return Expanded(
      //                           child: TextField(
      //                             keyboardType: TextInputType.number,
      //                             decoration: InputDecoration(
      //                                 labelText: '${number.toString()}'),
      //                           ),
      //                         );
      //                       }).toList(),
      //                     ),
      //                   ],
      //                 ),
      //           Padding(
      //             padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      //             child: Text(
      //               'Additions: ',
      //               style: kTextLabelTheme,
      //             ),
      //           ),
      //           Column(
      //             children: List.generate(currentAdditionsFiltersList.length,
      //                 (index) {
      //               return Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     currentAdditionsFiltersList[index],
      //                     style: TextStyle(
      //                       fontSize: 18,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                   Checkbox(
      //                     checkColor: Colors.white,
      //                     fillColor: MaterialStateColor.resolveWith(
      //                       (states) => Color.fromARGB(255, 219, 163, 154),
      //                     ),
      //                     value: currentAdditionsFilters[
      //                         currentAdditionsFiltersList[index]],
      //                     onChanged: (bool? value) {
      //                       // print(currentAdditionsFiltersList[index]);
      //                       // print(currentAdditionsFilters[
      //                       //     currentAdditionsFiltersList[index]]);
      //                       setState(() {
      //                         currentAdditionsFilters[
      //                             currentAdditionsFiltersList[index]] = value!;
      //                       });
      //                     },
      //                   )
      //                 ],
      //               );
      //             }),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

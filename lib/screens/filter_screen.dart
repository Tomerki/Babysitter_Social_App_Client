import 'package:flutter/material.dart';

const kTextLabelTheme = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700);
const kCardTextStyle = TextStyle(color: Colors.white, fontSize: 15);
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

enum LocationOprions { at_your_house, at_her_house, never_mind }

class FilterScreen extends StatefulWidget {
  static final routeName = 'FilterSecScreen';

  @override
  State<FilterScreen> createState() => _FilterScreennState();
}

class _FilterScreennState extends State<FilterScreen> {
  late double selectedValue;
  int? fromDropdownValue;
  int? toDropdownValue;
  bool isCheckedOne = false;
  bool isCheckedTwo = false;
  RangeValues values = RangeValues(0.0, 100.0);
  LocationOprions? _locationOprions = LocationOprions.at_your_house;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter By'),
        backgroundColor: Color.fromARGB(255, 219, 163, 154),
      ),
      body: Container(
        color: Color(0xff757575),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
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
                    values: values,
                    divisions: 100,
                    min: 0.0,
                    max: 100.0,
                    labels: RangeLabels(
                        '\$${values.start.toInt()}', '\$${values.end.toInt()}'),
                    onChanged: (value) {
                      setState(() {
                        values = value;
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
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                      padding: EdgeInsets.all(15),
                      primary: Color.fromARGB(255, 219, 163, 154),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    'Time: ',
                    style: kTextLabelTheme,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton<int>(
                            hint: Text('from'),
                            value: fromDropdownValue,
                            items: List<int>.generate(24, (index) => index)
                                .map<DropdownMenuItem<int>>((int value) {
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton<int>(
                            hint: Text('to'),
                            value: toDropdownValue,
                            items: List<int>.generate(24, (index) => index)
                                .map<DropdownMenuItem<int>>((int value) {
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
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    'Additions: ',
                    style: kTextLabelTheme,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'one',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 219, 163, 154),
                                  ),
                                  value: isCheckedOne,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedOne = value!;
                                    });
                                  },
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'two',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 219, 163, 154),
                                  ),
                                  value: isCheckedTwo,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedTwo = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'two',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 219, 163, 154),
                                  ),
                                  value: isCheckedTwo,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedTwo = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'two',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 219, 163, 154),
                                  ),
                                  value: isCheckedTwo,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedTwo = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'two two two two two two two two two two two two two two two two two two two two two two',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 219, 163, 154),
                                  ),
                                  value: isCheckedTwo,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedTwo = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

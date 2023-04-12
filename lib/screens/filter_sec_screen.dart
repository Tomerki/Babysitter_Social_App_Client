import 'package:flutter/material.dart';

const kTextLabelTheme = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700);
const kCardTextStyle = TextStyle(color: Colors.white, fontSize: 15);
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class FilterSecScreen extends StatefulWidget {
  static final routeName = 'FilterSecScreen';

  @override
  State<FilterSecScreen> createState() => _FilterSecScreenState();
}

class _FilterSecScreenState extends State<FilterSecScreen> {
  late double selectedValue;
  String? minDropdownValue;
  String? maxDropdownValue;
  bool isChecked = false;
  RangeValues values = RangeValues(17.0, 100.0);
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
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
                  padding: EdgeInsets.only(top: 40.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Price',
                        style: kTextLabelTheme,
                      ),
                      Text(
                        ' Range',
                        style: TextStyle(fontSize: 20.0),
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
                    'Location',
                    style: kTextLabelTheme,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {},
                      child: Text(
                        'At Your House',
                        style: TextStyle(
                          color: Color.fromARGB(255, 129, 91, 91),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'At Her House',
                        style: TextStyle(
                          color: Color.fromARGB(255, 129, 91, 91),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Never Mind',
                        style: TextStyle(
                          color: Color.fromARGB(255, 129, 91, 91),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    'Date',
                    style: kTextLabelTheme,
                  ),
                ),
                ElevatedButton(
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
                          DropdownButton<String>(
                            hint: Text('from'),
                            value: minDropdownValue,
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                minDropdownValue = value!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            }).toList(),
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
                          DropdownButton<String>(
                            hint: Text('to'),
                            value: maxDropdownValue,
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                maxDropdownValue = value!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            }).toList(),
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
                Container(
                  child: Column(
                    children: [
                      Row(
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
                              (states) => Color.fromARGB(255, 219, 163, 154),
                            ),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          )
                        ],
                      ),
                      Row(
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
                              (states) => Color.fromARGB(255, 219, 163, 154),
                            ),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
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
      ),
    );
  }
}

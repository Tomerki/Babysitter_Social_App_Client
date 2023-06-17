import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kTextLabelTheme = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700);
const kCardTextStyle = TextStyle(color: Colors.white, fontSize: 15);


class FilterScreen extends StatefulWidget {
  static final routeName = 'FilterScreen';
  Function(Map<String, bool> booleanFilters, RangeValues priceValues,
      RangeValues distanceValues) callback;

  FilterScreen({required this.callback});

  @override
  State<FilterScreen> createState() => _FilterScreennState();
}

class _FilterScreennState extends State<FilterScreen>
    with TickerProviderStateMixin {
  late double selectedValue;
  int? fromDropdownValue;
  int? toDropdownValue;

  Map<String, bool> currentAdditionsFilters = {
    'At your house': false,
    'At her house': false,
    'Takes to/from activities': false,
    'Knows how to cook': false,
    'First aid certified': false,
    'Helping with housework': false,
    'Has a driver\'s license': false,
    'Change a diaper': false,
    'Has past experience': false,
    'Has an education in education': false,
  };

  List<String> currentAdditionsFiltersList = [
    'At your house',
    'At her house',
    'Takes to/from activities',
    'Knows how to cook',
    'First aid certified',
    'Helping with housework',
    'Has a driver\'s license',
    'Change a diaper',
    'Has past experience',
    'Has an education in education',
  ];

  bool isCheckedOne = false;
  bool isCheckedTwo = false;
  RangeValues priceValues = RangeValues(0.0, 100.0);
  RangeValues distanceValues = RangeValues(0.0, 50.0);
  String? name;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Filter By',
            style: GoogleFonts.workSans(
              color: Colors.black,
              textStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 129, 100, 110).withOpacity(0.2),
          elevation: 5.0,
          centerTitle: true,
        ),
        body: Container(
          height: (queryData.size.height) * 0.9,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                  fit: BoxFit.cover,
                  opacity: 0.3)),
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
                          style: GoogleFonts.workSans(
                            color: Colors.black,
                            textStyle: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Color.fromARGB(255, 129, 91, 91),
                      inactiveTrackColor: Color(0xffDFDFDF),
                      showValueIndicator: ShowValueIndicator.always,
                      valueIndicatorColor: Colors.white,
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
                          style: GoogleFonts.workSans(
                            color: Colors.black,
                            textStyle: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Color.fromARGB(255, 129, 91, 91),
                      inactiveTrackColor: Color(0xffDFDFDF),
                      showValueIndicator: ShowValueIndicator.always,
                      valueIndicatorColor: Colors.white,
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
                    padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text(
                      'Additions: ',
                      style: GoogleFonts.workSans(
                        color: Colors.black,
                        textStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(currentAdditionsFiltersList.length,
                        (index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentAdditionsFiltersList[index],
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black.withOpacity(0.8),
                            ),
                            value: currentAdditionsFilters[
                                currentAdditionsFiltersList[index]],
                            onChanged: (bool? value) {
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
                  Center(
                    child: ElevatedButton(
                        child: Text(
                          'Apply',
                          style: GoogleFonts.workSans(
                            textStyle: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.black.withOpacity(0.8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 20)),
                        onPressed: () {
                          widget.callback(currentAdditionsFilters, priceValues,
                              distanceValues);
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

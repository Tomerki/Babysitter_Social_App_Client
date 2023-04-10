import 'package:flutter/material.dart';

const kTextLabelTheme = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700);

const kCardTextStyle = TextStyle(color: Colors.white, fontSize: 15);

class FilterSecScreen extends StatefulWidget {
  static final routeName = 'FilterSecScreen';

  @override
  State<FilterSecScreen> createState() => _FilterSecScreenState();
}

class _FilterSecScreenState extends State<FilterSecScreen> {
  late double selectedValue;

  RangeValues values = RangeValues(17.0, 100.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff757575),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Filter',
                      style: kTextLabelTheme,
                    ),
                    Text(
                      ' your search',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
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
                    activeTrackColor: Color(0xff143896),
                    inactiveTrackColor: Color(0xffDFDFDF),
                    showValueIndicator: ShowValueIndicator.always,
                    valueIndicatorColor: Colors.white,
                    // rangeValueIndicatorShape: CustomRangeValueIndicatorShape(),
                    valueIndicatorTextStyle: TextStyle(color: Colors.black),
                    valueIndicatorShape: SliderComponentShape.noOverlay,
                    thumbColor: Color(0xff143896),
                  ),
                  child: RangeSlider(
                    values: values,
                    divisions: 5,
                    min: 17.0,
                    max: 100.0,
                    labels: RangeLabels('\$${values.start.toInt()}k',
                        '\$${values.end.toInt()}k'),
                    onChanged: (value) {
                      setState(() {
                        values = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    'Rooms',
                    style: kTextLabelTheme,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: Text('Any'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {},
                      child: Text('1'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('2'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('3+'),
                    ),
                  ],
                ),
                Text(
                  'Bathrooms',
                  style: kTextLabelTheme,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                      elevation: 10.0,
                      onPressed: () {},
                      child: Text('Any'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('1'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('2'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('3+'),
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

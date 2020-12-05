import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Widgets/template.dart';
import 'dart:convert';

class AddingPage extends StatefulWidget {
  final String receivedTitle;
  final DateTime receivedDate;
  final int receivedIndex;

  AddingPage({this.receivedDate, this.receivedIndex, this.receivedTitle});

  @override
  _AddingPageState createState() => _AddingPageState();
}

class _AddingPageState extends State<AddingPage> {
  DateTime _dateTime;
  final TextEditingController myController = TextEditingController();
  // ScrollController _controller;
  String titleSave = '';
  final _formKey = GlobalKey<FormState>();

  List<CounterClass> countingitems = [];
  SharedPreferences prefs;

  int radioGroup = 1;

  final List imglist = [
    'assets/images/baby.jpg',
    'assets/images/ball.jpg',
    'assets/images/baloon.jpg',
    'assets/images/beach.jpg',
    'assets/images/christmas.jpg',
    'assets/images/couple.jpg',
    'assets/images/cupcake.jpg',
    'assets/images/heart.jpg',
    'assets/images/joystick.jpg',
    'assets/images/love.jpg',
    'assets/images/road.jpg',
  ];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> splist =
        countingitems.map((item) => json.encode(item.toMap())).toList();
    prefs.setStringList('counter', splist);
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> splist = prefs.getStringList('counter');
    countingitems =
        splist.map((item) => CounterClass.fromMap(json.decode(item))).toList();
    setState(() {});
  }

  void fileAvailability() {
    if (widget.receivedIndex != null) {
      radioGroup = widget.receivedIndex;
    }
  }

  String _titleAvailable() {
    if (widget.receivedTitle == null) {
      return titleSave;
    } else {
      String gotTitle = widget.receivedTitle;
      titleSave = gotTitle;
      return titleSave;
    }
  }

  BoxDecoration _decor(int i) {
    if (radioGroup == i) {
      return BoxDecoration(
        border: Border.all(
          width: 4,
          color: Colors.green,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      );
    } else {
      return BoxDecoration(
        border: Border.all(
          width: 3,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      );
    }
  }

  void _decorOntap(int i) {
    setState(() {
      radioGroup = i;
      // _decor(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Color(0xFFF5F5F5),
          body: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        //background color of box
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 25.0, // soften the shadow
                          spreadRadius: 5.0, //extend the shadow
                          offset: Offset(
                            4.0, // Move to right 10  horizontally
                            8.0, // Move to bottom 10 Vertically
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(38)),
                      color: Color(0xFF364F6B)),
                  height: deviceHeight * 0.85,
                  width: deviceWidth - 2 * 15,
                  // color: Colors.blue,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 10, top: 4),
                          child: Text(
                            'Add Event',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: TextFormField(
                            initialValue: _titleAvailable(),
                            style: TextStyle(
                                color: Color(0xFF444040),
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Enter Title',
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35.0),
                                borderSide: BorderSide(
                                  color: Color(0xFFFC5185),
                                  width: 3.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              titleSave = value;
                            },
                            onSaved: (newValue) {
                              titleSave = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RaisedButton.icon(
                              onPressed: () {
                                // _dateDetect();
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2200),
                                ).then((value) {
                                  setState(() {
                                    _dateTime = value;
                                  });
                                });
                              },
                              icon: Icon(Icons.calendar_today),
                              label: Text(
                                'Pick a Date',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36.0),
                                  side:
                                      BorderSide(color: Colors.red, width: 2)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 22),
                              padding: EdgeInsets.symmetric(
                                  horizontal: deviceWidth * 0.2, vertical: 8),
                              decoration: BoxDecoration(
                                color: Color(0xFF3FC1C9),
                                borderRadius: new BorderRadius.circular(5.0),
                              ),
                              child: _dateDetect(),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 18),
                          height: deviceHeight / 3,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              color: Color(0xFFF5F5F5)),
                          child: ListView(
                            // controller: _controller,
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (String i in imglist)
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 14),
                                    child: GestureDetector(
                                      onTap: () {
                                        print(
                                            'You picked ${imglist.indexOf(i)} container');
                                        _decorOntap(imglist.indexOf(i));
                                        // setState(() {});
                                      },
                                      child: Container(
                                        decoration: _decor(imglist.indexOf(i)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.asset(
                                            i,
                                            fit: BoxFit.cover,
                                            width: 125,
                                          ),
                                        ),
                                      ),
                                    )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Builder(
                            builder: (context) => Container(
                              child: RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState
                                      .validate()) if (_dateTime != null) {
                                    // _formKey.currentState.save();
                                    // _formKey.currentState.validate();
                                    _checkExistance();
                                    saveData();
                                    Navigator.of(context).pop();
                                    titleSave = '';
                                  } else if (_dateTime == null) {
                                    Scaffold.of(context)
                                      ..showSnackBar(SnackBar(
                                        content: Text(
                                          'Do not forget to pick a Date!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.grey[700],
                                        shape: StadiumBorder(),
                                      ));
                                  }
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Color(0xFFF5F5F5),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                color: Color(0xFF3FC1C9),
                                padding: EdgeInsets.symmetric(
                                    horizontal: deviceWidth * 0.2,
                                    vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36.0),
                                    side: BorderSide(
                                        color: Color(0xFFF5F5F5), width: 3)),
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
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.solidTimesCircle,
                        size: 48,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  void _checkExistance() {
    List<String> namelist = countingitems.map((e) => e.title).toList();
    if (namelist.contains(widget.receivedTitle)) {
      int titleIndex = namelist.indexOf(widget.receivedTitle);
      countingitems.removeAt(titleIndex);
      _formKey.currentState.save();
      _dateDetect();
      countingitems.insert(
          titleIndex,
          CounterClass(
            title: titleSave,
            datePicked: _dateTime,
            fileIndex: radioGroup,
          ));
      // setState(() {});
    } else {
      countingitems.add(CounterClass(
        title: titleSave,
        datePicked: _dateTime,
        fileIndex: radioGroup,
      ));
    }
  }

  Widget _dateDetect() {
    if (widget.receivedDate == null && _dateTime == null) {
      return Text(
        'No date is selected',
        style: TextStyle(
          color: Color(0xFFF5F5F5),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (widget.receivedDate != null && _dateTime == null) {
      _dateTime = widget.receivedDate;
      return Text(
        DateFormat.yMMMEd().format(_dateTime).toString(),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFFF5F5F5),
        ),
      );
    } else {
      return Text(
        DateFormat.yMMMEd().format(_dateTime).toString(),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFFF5F5F5),
        ),
      );
    }
  }
}

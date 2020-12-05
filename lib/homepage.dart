import 'dart:convert';
import 'dart:ui';

import 'package:dayscounter/Widgets/template.dart';
import 'package:dayscounter/addingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CounterClass> countinghome = [];
  int itemIndex = 0;

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
        countinghome.map((item) => json.encode(item.toMap())).toList();
    prefs.setStringList('counter', splist);
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> splist = prefs.getStringList('counter');
    countinghome =
        splist.map((item) => CounterClass.fromMap(json.decode(item))).toList();
    print('Homepage list \n  $splist');
    setState(() {});
  }

  void _removeItem(int index) {
    print('Length before deleting ${countinghome.length}');
    countinghome.removeAt(index);
    saveData();
    print('Length after deleting ${countinghome.length}');
    setState(() {});
  }

  int noofDays(int index) {
    var calcDate = countinghome[index].datePicked;
    final todayDate = DateTime.now();
    int totalDays = todayDate.difference(calcDate).inDays;
    return totalDays;
  }

  Icon _updownIcon(int index) {
    noofDays(index);
    if (noofDays(index) < 0) {
      return Icon(
        Icons.arrow_upward,
        color: Colors.green[400],
        size: 48,
      );
    } else {
      return Icon(
        Icons.arrow_downward,
        color: Colors.red,
        size: 48,
      );
    }
  }

  Text _dateAgoRemain(int index) {
    noofDays(index);
    if (noofDays(index) < 0) {
      return Text(
        'Days\nUntil',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 8.0,
              color: Colors.grey[400],
            ),
          ],
        ),
      );
    } else {
      return Text('Days\nAgo',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 8.0,
                color: Colors.grey[400],
              ),
            ],
          ));
    }
  }

  AssetImage _bgrdImage(int index) {
    itemIndex = index;
    print('Image number $itemIndex');
    return AssetImage(imglist[countinghome[index].fileIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: countinghome.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add new Event!',
                      style: TextStyle(
                          fontSize: 32,
                          color: Color(0xFF364F6B),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddingPage(),
                            )).then((value) {
                          loadData();
                          setState(() {});
                        });
                      },
                      child: Text(
                        'Click Me!',
                        style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      color: Color(0xFF3FC1C9),
                      elevation: 8,
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36.0),
                          side: BorderSide(color: Color(0xFFF5F5F5), width: 3)),
                    )
                  ],
                ),
              )
            : Container(
                child: Swiper(
                  index: 0,
                  itemCount: countinghome.length,
                  control: SwiperControl(color: Colors.white),
                  scrollDirection: Axis.horizontal,
                  pagination: SwiperPagination(
                      margin:
                          EdgeInsets.symmetric(vertical: 85, horizontal: 12),
                      builder: DotSwiperPaginationBuilder(
                          activeSize: 14,
                          size: 6,
                          activeColor: Colors.white,
                          color: Colors.grey)),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 20.0,
                                spreadRadius: 5.0,
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35),
                            ),
                            child: Container(
                              height: deviceHeight - 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.1),
                                      BlendMode.darken),
                                  image: _bgrdImage(index),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                overflow: Overflow.visible,
                                // alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    child: Container(
                                      width: deviceWidth - 100,
                                      child: Text(
                                        countinghome[index].title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 38,
                                          fontWeight: FontWeight.bold,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 10.0,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    top: 65,
                                    left: 30,
                                  ),
                                  Positioned(
                                    child: _updownIcon(index),
                                    bottom: 140,
                                    right: 20,
                                  ),
                                  Positioned(
                                    child: _dateAgoRemain(index),
                                    bottom: 90,
                                    right: 30,
                                  ),
                                  Positioned(
                                    child: Text(
                                      noofDays(index).abs().toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 120,
                                        fontWeight: FontWeight.bold,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(3.0, 3.0),
                                            blurRadius: 12.0,
                                            color: Colors.grey[600],
                                          ),
                                        ],
                                      ),
                                    ),
                                    bottom: 45,
                                    right: 80,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.trash,
                                    size: 24,
                                    color: Color(0xFF364F6B),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AssetGiffyDialog(
                                        image: Image.asset(
                                            'assets/images/delete.gif'),
                                        title: Text(
                                          'Delete',
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red),
                                        ),
                                        description: Text(
                                          'Are you sure to delete this event?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(),
                                        ),
                                        entryAnimation: EntryAnimation.DEFAULT,
                                        onOkButtonPressed: () {
                                          _removeItem(index);
                                          saveData();
                                          // Navigator.of(context).pop();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyHomePage()));
                                          setState(() {});
                                        },
                                      ),
                                    );
                                  }),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.plusCircle,
                                      size: 46,
                                      color: Color(0xFFFC5185),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddingPage(),
                                          )).then((value) {
                                        loadData();
                                        setState(() {});
                                      });
                                    }),
                              ),
                              IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.penNib,
                                    size: 24,
                                    color: Color(0xFF364F6B),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => AddingPage(
                                                  receivedTitle:
                                                      countinghome[index].title,
                                                  receivedDate:
                                                      countinghome[index]
                                                          .datePicked,
                                                  receivedIndex:
                                                      countinghome[index]
                                                          .fileIndex,
                                                )))
                                        .then((value) {
                                      loadData();
                                      setState(() {});
                                    });
                                  }),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ));
  }
}

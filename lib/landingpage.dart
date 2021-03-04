import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msbmportal_app/inappbrowser.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _currentIndex = 0;

  List cardList = [
    Item1(),
    Item2(),
    Item3(),
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData(fontFamily: 'Circular STD');
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 000000);
    }

    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);

    printScreenInformation();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Welcome to MSBM",
        home: new Scaffold(
          body: SingleChildScrollView(
            child: new Container(
                color: Colors.white,
                child: new Container(
                    child: new Column(children: [
                  new Padding(
                      padding: EdgeInsets.only(
                    top: 40.0,
                  )),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 340.h),
                    ],
                  ),
                  Container(
                    height: 250.h,
                    width: 450.w,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('images/Logo2.png'),
                        fit: BoxFit.contain,
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 105.h),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Column(children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: false,
                          autoPlayInterval: Duration(seconds: 100),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: cardList.map((card) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.30,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Card(
                                elevation: 0,
                                child: card,
                              ),
                            );
                          });
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: map<Widget>(cardList, (index, url) {
                          return Container(
                            width: 30.0,
                            height: 2.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: _currentIndex == index
                                  ? Color.fromRGBO(173, 0, 0, 1)
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ]))),
          ),
          bottomNavigationBar: Container(
              height: 90.h,
              color: Color.fromRGBO(173, 0, 0, 1),
              child: RaisedButton(
                  color: Color.fromRGBO(173, 0, 0, 1),
                  elevation: 0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyAP()),
                    );
                  },
                  child: Text(
                    "PROCEED",
                    style: TextStyle(
                      fontFamily: 'Circular STD',
                      fontSize: ScreenUtil().setSp(24),
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ))),
        ));
  }

  void printScreenInformation() {
    print('Device width dp:${ScreenUtil().screenWidth}');
    print('Device height dp:${ScreenUtil().screenHeight}');
    print('Device pixel density:${ScreenUtil().pixelRatio}');
    print('Bottom safe zone distance dp:${ScreenUtil().bottomBarHeight}');
    print('Status bar height px:${ScreenUtil().statusBarHeight}dp');
    print(
        'Ratio of actual width dp to design draft px:${ScreenUtil().scaleWidth}');
    print(
        'Ratio of actual height dp to design draft px:${ScreenUtil().scaleHeight}');
    print(
        'The ratio of font and width to the size of the design:${ScreenUtil().scaleWidth * ScreenUtil().pixelRatio}');
    print(
        'The ratio of  height width to the size of the design:${ScreenUtil().scaleHeight * ScreenUtil().pixelRatio}');
    print('System font scaling:${ScreenUtil().textScaleFactor}');
    print('0.5 times the screen width:${0.5.sw}');
    print('0.5 times the screen height:${0.5.sh}');
  }
}

//Carousel Items
class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 30,
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: SizedBox(
        width: 700.w,
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Trying to join MSBM?',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(35),
                  fontFamily: 'Circular STD',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                "You can't sign up for MSBM now on the app.We know it might be stressful.The app is only for exisiting members with already signed up courses",
                style: TextStyle(
                    fontFamily: 'Circular STD',
                    fontSize: ScreenUtil().setSp(22),
                    color: Colors.black),
                maxLines: 8,
                textAlign: TextAlign.center,
              ),
            ]),
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 10,
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: SizedBox(
        width: 700.w,
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Learn at your pace',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(35),
                  fontFamily: 'Circular STD',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                "Self study online courses available 24/7 so you can learn at your pace.",
                style: TextStyle(
                    fontFamily: 'Circular STD',
                    fontSize: ScreenUtil().setSp(22),
                    color: Colors.black),
                maxLines: 6,
                textAlign: TextAlign.center,
              ),
            ]),
      ),
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 30,
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: SizedBox(
        width: 700.w,
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Accredited Courses',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(35),
                  fontFamily: 'Circular STD',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                "Gain direct admission into University top-up degree with our OFQUAL certificates.",
                style: TextStyle(
                    fontFamily: 'Circular STD',
                    fontSize: ScreenUtil().setSp(22),
                    color: Colors.black),
                maxLines: 6,
                textAlign: TextAlign.center,
              ),
            ]),
      ),
    );
  }
}

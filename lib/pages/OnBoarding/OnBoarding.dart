//import 'package:kide/main.dart';
import './dots_indicator.dart';
import 'package:flutter/material.dart';
import './Page1.dart';
import './Page2.dart';
import './Page3.dart';

//void main() => runApp(MyApp());

// routes: <String, WidgetBuilder>{
//       '/OnBoarding': (BuildContext context) => new OnBoarding(),
//       '/MyApp': (BuildContext context) => new MyApp()
//     },

class OnboardingMainPage extends StatefulWidget {
  OnboardingMainPage({Key key}) : super(key: key);

  @override
  _OnboardingMainPageState createState() => new _OnboardingMainPageState();
}

class _OnboardingMainPageState extends State<OnboardingMainPage> {
  final _controller = new PageController();
  final List<Widget> _pages = [
    Page1(),
    Page2(),
    Page3(),
  ];
  int page = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDone = page == _pages.length - 1;
      return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Stack(
        children: <Widget>[
          new Positioned.fill(
            child: new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
              onPageChanged: (int p){
                setState(() {
                  page = p;
                });
              },
            ),
          ),
          new Positioned(
            bottom: 10.0,
            left: 0.0,
            right: 0.0,
            child: new SafeArea(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DotsIndicator(
                      controller: _controller,
                      itemCount: _pages.length,
                      onPageSelected: (int page) {
                        _controller.animateToPage(
                          page,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        child: Text('SKIP',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.5)
                          ),
                        ),
                        onPressed: () {
                          print('Skip pressed');
                          Navigator.popAndPushNamed(
                          context, 
                          '/MyApp'
                          );
                        } 
                      ),
                      RaisedButton(
                        child: Text(
                          isDone ? 'DONE' : 'NEXT',
                          style: TextStyle(
                            color: Colors.black
                          ),
                        ),
                        onPressed: isDone ? (){
                          print('Done pressed');
                        Navigator.popAndPushNamed(
                          context,
                          '/MyApp'
                        );
                        } : (){
                            print('Next pressed');
                          _controller.animateToPage(page + 1, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                          },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
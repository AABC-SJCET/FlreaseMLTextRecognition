import 'package:firebase_ml_text_recognition/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../style/assetname.dart';
import '../main.dart';

class PageViewBuilder extends StatelessWidget {
  final PageController controller = PageController(initialPage: 0);

  Widget _pageBuilder(
    String svgImage,
    String text,
  ) {
    return Stack(
      children: [
        Container(
          color: Color.fromRGBO(00, 00, 00, .23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(svgImage),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Dohyeon',
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 4,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.black87,
                      dotWidth: 20,
                      dotHeight: 20,
                    ),
                    onDotClicked: (index) => controller.animateToPage(index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.linearToEaseOut),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String title = 'Text Recognition';

    return Scaffold(
      body: PageView(
        controller: controller,
        children: <Widget>[
          _pageBuilder(readingHard, 'Feeling lazy to read'),
          _pageBuilder(
              workInprogress, 'We are  working on something cool for you '),
          _pageBuilder(textToAudio, 'Stop looking start listening'),
          Container(
            color: Color.fromRGBO(00, 00, 00, .23),
            child: Center(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(4),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) {
                        return Colors.white;
                      },
                    )),
                label: Text('Start Scanning',
                    style: TextStyle(color: Colors.black)),
                icon: Icon(
                  Icons.arrow_right_outlined,
                  color: Color.fromRGBO(00, 00, 00, 1),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (cxt) => MainPage(title: title)));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

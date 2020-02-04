import 'package:flutter/material.dart';

class PageThree extends StatelessWidget {
  PageThree({Key key, this.title}) : super(key: key);
  final String title;

  goBack(BuildContext context, String data) {
    Navigator.pop(context, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MaterialButton(
              child: Text('Button 1'),
              onPressed: () {
                goBack(context, 'btn1');
              },
              color: Colors.grey,
            ),
            MaterialButton(
              child: Text('Button 2'),
              onPressed: () {
                goBack(context, 'btn2');
              },
              color: Colors.grey,
            ),
            MaterialButton(
              child: Text('Button 3'),
              onPressed: () {
                goBack(context, 'btn3');
              },
              color: Colors.grey,
            )
          ],
        )
    );
  }

}

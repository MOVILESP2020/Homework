import 'package:flutter/material.dart';
import 'dart:math';

class PageTwo extends StatefulWidget {
  PageTwo({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PageTwoState createState() => _PageTwoState();

}

class _PageTwoState extends State<PageTwo> {
  int randomNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.blue[200],
            Colors.blue[200],
            Colors.blue[100],
            Colors.blue[50],
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 48)),
                  Text(
                    'Generate random number',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 24)),
                  Text(
                    '$randomNumber',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                  ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 24)),
                  MaterialButton(
                    child: Text('Generate'),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        randomNumber = new Random().nextInt(200);
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 12)),
                  MaterialButton(
                    child: Text('Save'),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context, '$randomNumber');
                    },
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }

}

import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Map<String, String> data;
  ListItem({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Image.network(
                    data['image'],
                    fit: BoxFit.fill,
                ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                  )
                ),
                child: Column(
                  children: <Widget>[
                    Text(data['title']),
                    Text(data['description'])
                  ],
                ),
              ),
            )
          ],
        ),

      ),
    );
  }
}
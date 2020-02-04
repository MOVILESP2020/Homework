import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homework_01/screens/pagethree.dart';
import 'package:homework_01/screens/pagetwo.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();
  var pageTwoData = '', pageThreeData = '';
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<dynamic> createAlertDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('Enter data'),
          content: TextField(
            controller: textController,
            maxLength: 10,
            decoration: new InputDecoration(
                hintText: 'Type a word',
            )
            ,
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Text('Accept'),
              onPressed: () async {
                Navigator.pop(context);
                var pageTwoDataAux = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PageTwo(title: 'Page 2',);
                    },
                  ),
                );
                textController.clear(); // Clear TextField after send the data
                if (pageTwoDataAux == null) {
                  pageTwoDataAux = '';
                }
                setState(() {
                  pageTwoData = pageTwoDataAux;
                });
              },
            )
          ],
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Text('WELCOME', style: new TextStyle(
                  fontSize: 36,
                  fontFamily: 'Pacifico'),
                ),
                ImageWidget('assets/dart_side.png'),
                Expanded(
                  child: Center(
                    child: Text(
                      'Select an option:',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MaterialButton(
                      child: Text(
                          'Page 2',
                          style: new TextStyle(
                            color: Colors.white
                        )
                      ),
                      onPressed: () {
                        createAlertDialog(context);
                      },
                      color: Colors.blueAccent,
                    ),
                    MaterialButton(
                      child: Text(
                          'Page 3',
                          style: new TextStyle(
                              color: Colors.white
                          )
                      ),
                      onPressed: () async {
                        var pageThreeDataAux = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) {
                                  return PageThree(title: 'Page 3',);
                                }
                            )
                        );
                        if (pageThreeDataAux == null) {
                          pageThreeDataAux = '';
                        }
                        setState(() {
                          pageThreeData = pageThreeDataAux;
                        });
                      },
                      color: Colors.blueAccent,

                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Page 2 => $pageTwoData'),
                      Text('Page 3 => $pageThreeData')
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String _path;
  ImageWidget(this._path);

  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(_path);
    var image = new Image(image: assetsImage);
    return new Container(child: image);
  }
}
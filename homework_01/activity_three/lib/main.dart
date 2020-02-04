import 'package:activity_three/list_item.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Actividad 3'),
    );
  }
}



class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  final List<Map<String, String>> _listElements = [
    {
      "title": "La vida de la perra",
      "description": "Ranking: ★",
      "image": "https://scontent-dfw5-2.xx.fbcdn.net/v/t1.0-9/318889_210572048996708_2718119_n.jpg?_nc_cat=107&_nc_ohc=aFjmO0CWs9MAX9xqm3w&_nc_ht=scontent-dfw5-2.xx&oh=4a78f919ca305bbcf9a9258b9962466e&oe=5ED83AFC",
    },
    {
      "title": "Black widow",
      "description": "Ranking: ★★★★",
      "image": "https://i.imgur.com/0NTTbFn.jpg",
    },
    {
      "title": "Frozen 2",
      "description": "Ranking: ★★★",
      "image": "https://i.imgur.com/noNCN3V.jpg",
    },
    {
      "title": "Joker",
      "description": "Ranking: ★★★★",
      "image": "https://i.imgur.com/trdzMAl.jpg",
    },
  ];
  Future<void> _showDialog(BuildContext context, String title) async {
    await showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Selccionado"),
        content: Text('Seleccionado: $title'),
        actions: <Widget>[
          FlatButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
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
        title: Text(this.title),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff324aa8)
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  'Seleccione una película',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/4,
                child: ListView.builder(
                  itemCount : _listElements.length,
                  itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        child: ListItem(data: _listElements[index]),
                        onTap: () {
                          _showDialog(context, _listElements[index]["title"]);
                        },
                      );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          )
        ],
       ),
    );
  }
}

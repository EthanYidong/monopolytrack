import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'player_drag.dart';
import 'bank_drag.dart';

class GameScreen extends StatefulWidget {
  final int numPlayers;
  final List<int> initValues;

  GameScreen(this.numPlayers, {this.initValues});

  @override
  createState() => GameScreenState(numPlayers, saveData: initValues);
}

class GameScreenState extends State<GameScreen> {
  final int numPlayers;

  final colors = [
    Colors.lightBlue,
    Colors.red,
    Colors.purple,
    Colors.green,
    Colors.pink,
    Colors.brown,
    Colors.teal,
    Colors.yellow
  ];

  List<int> saveData;

  GameScreenState(this.numPlayers, {this.saveData});

  void _save() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList('gamestate', saveData.map((i) => i.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    List<PlayerDrag> players = [];

    if (saveData == null) {
      saveData = [];
      for (int i = 0; i < numPlayers; i++) {
        players.add(PlayerDrag(color: colors[i], setCallback: (val) {
          saveData[i] = val;
          _save();
        }));
        saveData.add(1500);
      }
      _save();
    } else {
      for (int i = 0; i < numPlayers; i++) {
        players.add(PlayerDrag(color: colors[i], value: saveData[i], setCallback: (val) {
          saveData[i] = val;
          print(val);
          _save();
        }));
      }
    }

    players.add(BankDrag());
    return WillPopScope(
        onWillPop: () async {
          return (await showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                  content: new Text('Do you want to exit?'),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: new Text('No'),
                    ),
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: new Text('Yes'),
                    ),
                  ],
                ),
              )) ??
              false;
        },
        child: Scaffold(
            appBar: AppBar(title: Text('$numPlayers player game')),
            body: Padding(
                padding: EdgeInsets.all(24.0),
                child: GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 4,
                  children: players,
                ))));
  }
}

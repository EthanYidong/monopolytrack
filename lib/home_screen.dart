import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_screen.dart';

const MIN_PLAYERS = 2;
const MAX_PLAYERS = 8;

class HomeScreen extends StatelessWidget {
  void _loadGame(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('gamestate')) {
      var data = prefs.getStringList('gamestate');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GameScreen(data.length,
                  initValues: data.map(int.parse).toList())));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> dropdownItems = [];

    for (var i = MIN_PLAYERS; i <= MAX_PLAYERS; i++) {
      dropdownItems.add(DropdownMenuItem(value: i, child: Text(i.toString())));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Monopoly Money Tracker')),
      body: Padding(
          padding: EdgeInsets.all(24.0),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(r'$$$ tracker',
                  style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 40.0),
              DropdownButton(
                  items: dropdownItems,
                  hint: Text('Number of players'),
                  onChanged: (val) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameScreen(val)))),
              SizedBox(height: 40.0),
              RaisedButton(
                  child: Text('Load game'), onPressed: () => _loadGame(context))
            ],
          ))),
    );
  }
}

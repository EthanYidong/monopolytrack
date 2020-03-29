import 'package:flutter/material.dart';
import 'money_dialog.dart';

class PlayerDrag extends StatefulWidget {
  final Color color;
  final int value;
  final void Function(int) setCallback;

  PlayerDrag({this.color, this.value = 1500, this.setCallback});

  @override
  createState() => PlayerDragState(color: color, amtMoney: value, setCallback: setCallback);
}

class PlayerDragState extends State<PlayerDrag> {
  final Color color;
  final void Function(int) setCallback;

  int amtMoney;

  PlayerDragState({this.color, this.amtMoney, this.setCallback});

  void changeMoney(int amt) {
    setState(() {
      amtMoney += amt;
      setCallback(amtMoney);
    });
  }

  String getText() {
    return amtMoney.toString();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Draggable<void Function(int)>(
      data: changeMoney,
      feedback: Container(
          height: constraints.biggest.height,
          width: constraints.biggest.width,
          color: color,
          child: Center(child: Text(getText(),
              style: Theme.of(context).textTheme.button))),
      maxSimultaneousDrags: 1,
      childWhenDragging: Container(color: Colors.grey),
      child: DragTarget<void Function(int)>(
          builder: (BuildContext context, cData, rData) {
            return Container(
                color: color,
                child: Center(
                  child: Text(getText(),
                      style: Theme.of(context).textTheme.button),
                ));
          },
          onWillAccept: (data) {
            return true;
          },
          onAccept: (data) {
            showDialog(context: context, builder: (BuildContext context) {
              return MoneyDialog(from: data, to: changeMoney);
            });
          }),
    ));
  }
}

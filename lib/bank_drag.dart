import 'package:flutter/material.dart';
import 'player_drag.dart';

class BankDrag extends PlayerDrag {
  @override
  createState() => BankDragState();
}

class BankDragState extends PlayerDragState {
  BankDragState(): super(color: Colors.blueGrey);
  @override changeMoney(int amt) {}
  @override getText() => "Bank";
}
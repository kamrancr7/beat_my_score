import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int diceNumber = 1;
  int totalFirstPlayer = 0;
  int totalSecondPlayer = 0;
  bool firstPlayerOut = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'First Player Score: $totalFirstPlayer',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Second Player Score: $totalSecondPlayer',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 60,
          ),
          FlatButton(
            child: Image.asset(
              'assets/dice$diceNumber.png',
              color: Colors.black,
              width: 200,
              height: 200,
            ),
            onPressed: () {
              randomNumber();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Reset'),
              onPressed: () {
                setState(() {
                  totalFirstPlayer = 0;
                  totalSecondPlayer = 0;
                  firstPlayerOut = false;
                  diceNumber = 1;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  void firstPlayerBatting() {
    print(diceNumber);
    if (diceNumber > 6) {
      diceNumber = 1;
      showFirstPlayerOutDialog();
      firstPlayerOut = true;
    } else {
      totalFirstPlayer = totalFirstPlayer + diceNumber;
    }
  }

  void secondPlayerBatting() {
    if (diceNumber > 6) {
      diceNumber = 1;
      if (totalFirstPlayer == totalSecondPlayer) {
        showResultDialog('Match Tied');
      } else {
        showResultDialog('First Player Wins');
      }
    } else {
      totalSecondPlayer = totalSecondPlayer + diceNumber;
      if (totalSecondPlayer > totalFirstPlayer) {
        showResultDialog('Second Player Wins');
      }
    }
  }

  void showFirstPlayerOutDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You are out!!!'),
            content: Image.asset('assets/out.png'),
            actions: <Widget>[
              FlatButton(
                child: Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void showResultDialog(String playerName) async{
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Win!!!'),
            content: Text(playerName),
            actions: <Widget>[
              FlatButton(
                child: Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void randomNumber() {
    setState(() {
      diceNumber = Random().nextInt(7) + 1;
      if (!firstPlayerOut) {
        firstPlayerBatting();
      } else {
        secondPlayerBatting();
      }
    });
  }
}

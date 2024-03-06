import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(NumberGuessingGame());
}

class NumberGuessingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Guessing Game',
      home: FrontPage(),
    );
  }
}

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Guessing Game', style: TextStyle(color: Colors.black)),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.grey[400]!,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Number Guessing Game',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.pink[100]!,
                        width: 2,
                      ),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.play_arrow, size: 40, color: Colors.pink[100]),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NumberGuessingPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Number Guessing Game Developed by Shahzaib Kamal Arshad',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NumberGuessingPage extends StatefulWidget {
  @override
  _NumberGuessingPageState createState() => _NumberGuessingPageState();
}

class _NumberGuessingPageState extends State<NumberGuessingPage> {
  TextEditingController _controller = TextEditingController();
  int? _randomNumber;
  String _result = '';
  int _guesses = 0;

  @override
  void initState() {
    super.initState();
    _generateRandomNumber();
  }

  void _generateRandomNumber() {
    final random = Random();
    _randomNumber = random.nextInt(40) + 1;
  }

  void _checkGuess(int? guess) {
    if (guess != null) {
      setState(() {
        _guesses++;
        if (guess == _randomNumber) {
          _result = 'Congratulations! You guessed the number $_randomNumber in $_guesses guesses!';
        } else if (guess < _randomNumber!) {
          _result = 'Try a higher number';
        } else {
          _result = 'Try a lower number';
        }
      });
    }
  }

  void _resetGame() {
    setState(() {
      _generateRandomNumber();
      _result = '';
      _guesses = 0;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Guessing Game'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.lightBlue[200]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Guess the number between 1 and 40',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your guess',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  int? guess = int.tryParse(_controller.text);
                  _checkGuess(guess);
                },
                child: Text('Check'),
              ),
              SizedBox(height: 20),
              Text(
                _result,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetGame,
                child: Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

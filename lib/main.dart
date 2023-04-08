import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  void _calculate(){
    //TextEditingController needs to be transformed in String
    String inputValue = _controller.text;
    if(inputValue.isNotEmpty) {
      int number = int.parse(inputValue);
      bool isSquare = squareNumber(number);
      bool isTriangular = triangularNumber(number);

      if (isSquare == true && isTriangular == true) {
        printAlert('Number $number is SQUARE and TRIANGULAR.');
      }
      else if (isSquare == true) {
        printAlert('Number $number is SQUARE.');
      }
      else if (isTriangular == true) {
        printAlert('Number $number is TRIANGULAR.');
      }
      else {
        printAlert('Number $number is neither SQUARE or TRIANGULAR.');
      }
    }
  }

  bool squareNumber(int number){
    double root = sqrt(number);
    return root * root == number;
  }

  bool triangularNumber(int number){
    if(number == 0 || number == 1){
      return true;
    }
    else {
      for (int i = 2; i * i * i <= number; i++) {
        if (i * i * i == number) {
          return true;
        }
      }
    }
    return false;
  }

  void printAlert(String result){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Result'),
            content: Text(result),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Patrate perfecte'
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
                'Please input a number to see if it is a square or triangular.\n',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Input the value here',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _controller,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _calculate,
        child: const Icon(Icons.check),
      ),

    );
  }
}


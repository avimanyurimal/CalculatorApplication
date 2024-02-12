// Import necessary packages for Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// The main function where the app starts execution
void main() {
  // Ensure that Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Set preferred screen orientations to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Run the app by calling the MyApp widget
  runApp(calculator());
}

// MyApp class represents the overall structure of the application
class calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define the MaterialApp with specific theme and title
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.red,
        // scaffoldBackgroundColor: Colors.pink,
      ),
      title: 'AviCalculator',
      // Set the home screen to Calculator widget
      home: Calculator(),
    );
  }
}

// Calculator class represents the main calculator screen
class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

// _CalculatorState class manages the state of the Calculator widget
class _CalculatorState extends State<Calculator> {
  // Variables to store calculator input, numbers, operator, and theme mode
  String _output = '0';
  String _currentInput = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';
  bool _isDarkMode = false;

  // Function to handle button clicks and update calculator state
  void _handleButtonClick(String value) {
    setState(() {
      // Check which button was pressed and perform corresponding action
      if (value == 'Clr') {
        // Clear all values
        _output = '0';
        _currentInput = '';
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      } else if (value == '+' || value == '-' || value == '*' || value == '%') {
        // Handle arithmetic operators
        if (_currentInput.isNotEmpty) {
          if (_num1 == 0) {
            _num1 = double.parse(_currentInput);
            _output = _currentInput;
          } else {
            _num2 = double.parse(_currentInput);
            _performOperation();
          }
          _operator = value;
          _currentInput = '';
        }
      } else if (value == '=') {
        // Handle equals button
        if (_currentInput.isNotEmpty) {
          _num2 = double.parse(_currentInput);
          _performOperation();
          _operator = '';
          _currentInput = '';
        }
      } else if (value == 'Dark Mode') {
        // Switch to dark mode
        _isDarkMode = true;
      } else if (value == 'Light Mode') {
        // Switch to light mode
        _isDarkMode = false;
      } else {
        // Concatenate digits for input
        _currentInput += value;
        _output = _currentInput;
      }
    });
  }

  // Function to perform arithmetic operations
  void _performOperation() {
    switch (_operator) {
      case '+':
        _output = (_num1 + _num2).toString();
        break;
      case '-':
        _output = (_num1 - _num2).toString();
        break;
      case '*':
        _output = (_num1 * _num2).toString();
        break;
      case '%':
        _output = (_num1 / _num2).toString();
        break;
    }
    _num1 = double.parse(_output);
  }

  // Widget to create individual calculator buttons
  Widget _buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _handleButtonClick(value),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20.0),
          backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.grey[300],
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 25.0,
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // Build method to construct the entire calculator UI
  @override
  Widget build(BuildContext context) {
    return Theme(
      // Apply the selected theme to the entire app
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: _isDarkMode ? Colors.black12 : Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: _isDarkMode ? Colors.transparent : Colors.white,
          title: Text(
            'AviCalculator',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          actions: [
            // Toggle button for switching between dark and light mode
            IconButton(
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
              icon: Icon(
                _isDarkMode ? Icons.brightness_7 : Icons.brightness_4,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        body: _buildPortraitLayout(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Copyright text at the bottom of the screen
              Text(
                '@ 2024 Avimanyu Rimal. All Right Reserved Calculator.',
                style: TextStyle(
                  fontSize: 12,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to create the main layout of the calculator in portrait mode
  Widget _buildPortraitLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          // Display the current input in a text widget
          Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.centerRight,
            child: Text(
              _currentInput,
              style: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white60 : Colors.black54,
              ),
            ),
          ),
          // Display the calculated output in a text widget
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          // Divider for better visual separation
          const Divider(),
          // Rows of calculator buttons arranged in a grid
          Row(
            children: [
              _buildButton('7'),
              const SizedBox(width: 15.0),
              _buildButton('8'),
              const SizedBox(width: 15.0),
              _buildButton('9'),
              const SizedBox(width: 15.0),
              _buildButton('%'),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              _buildButton('4'),
              const SizedBox(width: 15.0),
              _buildButton('5'),
              const SizedBox(width: 15.0),
              _buildButton('6'),
              const SizedBox(width: 15.0),
              _buildButton('*'),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              _buildButton('1'),
              const SizedBox(width: 15.0),
              _buildButton('2'),
              const SizedBox(width: 15.0),
              _buildButton('3'),
              const SizedBox(width: 15.0),
              _buildButton('-'),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              _buildButton('0'),
              const SizedBox(width: 15.0),
              _buildButton('Clr'),
              const SizedBox(width: 15.0),
              _buildButton('='),
              const SizedBox(width: 15.0),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }
}

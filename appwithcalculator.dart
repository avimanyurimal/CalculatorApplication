
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(appwithcalculator());
}

class appwithcalculator extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<appwithcalculator> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleDarkMode() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      title: 'AviCalculator',
      home: HomePage(toggleDarkMode: toggleDarkMode, themeMode: _themeMode),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback toggleDarkMode;
  final ThemeMode themeMode;

  HomePage({required this.toggleDarkMode, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).primaryColor, // Adjust the color as needed
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white70,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.calculate),
                title: Text('Avi Calculator'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Calculator(isDarkMode: themeMode == ThemeMode.dark)));
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.brightness_6),
                title: Text('Dark Mode'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  toggleDarkMode(); // Toggle dark mode
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text('Welcome to the Home Page'),
      ),
    );
  }
}

class AviCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avi Calculator'),
      ),
      body: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  final bool isDarkMode;

  // Corrected constructor
  const Calculator({Key? key, this.isDarkMode = false}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  String _currentInput = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';

  void _handleButtonClick(String value) {
    setState(() {
      if (value == 'Clr') {
        _output = '0';
        _currentInput = '';
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      } else if (value == '+' || value == '-' || value == '*' || value == '%') {
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
        if (_currentInput.isNotEmpty) {
          _num2 = double.parse(_currentInput);
          _performOperation();
          _operator = '';
          _currentInput = '';
        }
      } else {
        _currentInput += value;
        _output = _currentInput;
      }
    });
  }

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

  Widget _buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _handleButtonClick(value),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20.0),
          backgroundColor: widget.isDarkMode ? Colors.grey[900] : Colors.grey[300],
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 25.0,
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.centerRight,
            child: Text(
              _currentInput,
              style: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          const Divider(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPortraitLayout(),
    );
  }
}




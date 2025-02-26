import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

class BrickBreaker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brick Breaker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: BrickBreakerGame(),
    );
  }
}

class BrickBreakerGame extends StatefulWidget {
  @override
  _BrickBreakerGameState createState() => _BrickBreakerGameState();
}

class _BrickBreakerGameState extends State<BrickBreakerGame> {
  double _paddlePosition = 0.0;
  List<Offset> _brickPositions = [];
  Timer? _timer;
  Timer? _movementTimer;
  FocusNode _focusNode = FocusNode();
  bool _isMovingLeft = false;
  bool _isMovingRight = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeBricks();
      setState(() {
        _paddlePosition = (MediaQuery.of(context).size.width - 100) / 2;
      });
    });
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _paddlePosition += event.x * 10; // Use event.x for landscape mode
        if (_paddlePosition < 0) {
          _paddlePosition = 0;
        } else if (_paddlePosition > MediaQuery.of(context).size.width - 100) {
          _paddlePosition = MediaQuery.of(context).size.width - 100;
        }
      });
    });
    _startBrickMovement();
  }

  void _initializeBricks() {
    double brickWidth = 50.0;
    double brickHeight = 20.0;
    double padding = 5.0;
    double totalBrickWidth = 8 * (brickWidth + padding) - padding;
    double startX = (MediaQuery.of(context).size.width - totalBrickWidth) / 2;

    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 8; j++) {
        _brickPositions.add(Offset(
            startX + j * (brickWidth + padding), i * (brickHeight + padding)));
      }
    }
  }

  void _startBrickMovement() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        for (int i = 0; i < _brickPositions.length; i++) {
          _brickPositions[i] = _brickPositions[i].translate(0, 10);
        }
      });
    });
  }

  void _startMovementTimer() {
    _movementTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        if (_isMovingLeft) {
          _paddlePosition -= 5;
          if (_paddlePosition < 0) {
            _paddlePosition = 0;
          }
        } else if (_isMovingRight) {
          _paddlePosition += 5;
          if (_paddlePosition > MediaQuery.of(context).size.width - 100) {
            _paddlePosition = MediaQuery.of(context).size.width - 100;
          }
        }
      });
    });
  }

  void _stopMovementTimer() {
    _movementTimer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _movementTimer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Brick Breaker',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      body: Focus(
        focusNode: _focusNode,
        autofocus: true,
        onKey: (FocusNode node, RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.keyA) {
              _isMovingLeft = true;
              _startMovementTimer();
            } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
              _isMovingRight = true;
              _startMovementTimer();
            }
          } else if (event is RawKeyUpEvent) {
            if (event.logicalKey == LogicalKeyboardKey.keyA) {
              _isMovingLeft = false;
              if (!_isMovingRight) {
                _stopMovementTimer();
              }
            } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
              _isMovingRight = false;
              if (!_isMovingLeft) {
                _stopMovementTimer();
              }
            }
          }
          return KeyEventResult.handled;
        },
        child: Stack(
          children: <Widget>[
            ..._brickPositions.map((position) => Positioned(
                  left: position.dx,
                  top: position.dy,
                  child: Container(
                    width: 50,
                    height: 20,
                    color: Colors.purple,
                  ),
                )),
            Positioned(
              bottom: 20,
              left: _paddlePosition,
              child: Container(
                width: 140,
                height: 20,
                color: Colors.purple,
              ),
            ),
            // Add other game elements here
          ],
        ),
      ),
    );
  }
}

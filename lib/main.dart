import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
      ),
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int _inputTime;
  late Duration _duration;
  late Timer _timer;
  bool _isPaused = false;
  bool _isTimeUp = false; // Variable untuk menunjukkan apakah waktu sudah habis
  bool _isStarted =
      false; // Variable untuk menunjukkan apakah countdown sudah dimulai

  @override
  void initState() {
    super.initState();
    _inputTime = 0;
    _duration = Duration(seconds: 0);
  }

  void _startCountdown() {
    if (_inputTime > 0) {
      _duration = Duration(seconds: _inputTime);
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (!_isPaused) {
          setState(() {
            if (_duration.inSeconds > 0) {
              _duration -= Duration(seconds: 1);
            } else {
              _timer.cancel();
              _isTimeUp = true; // Mengatur waktu habis ketika countdown selesai
            }
          });
        }
      });
      _isStarted =
          true; // Set countdown sudah dimulai setelah tombol "Start" ditekan
    }
  }

  void _pauseCountdown() {
    setState(() {
      _isPaused = true;
    });
  }

  void _resumeCountdown() {
    setState(() {
      _isPaused = false;
    });
  }

  void _resetCountdown() {
    _timer.cancel();
    setState(() {
      _duration = Duration(seconds: 0);
      _isPaused = false;
      _isTimeUp = false; // Reset variabel waktu habis saat mereset countdown
      _isStarted =
          false; // Reset variabel countdown sudah dimulai saat mereset countdown
    });
  }

  void _restartCountdown() {
    setState(() {
      _inputTime = 0;
      _duration = Duration(seconds: 0);
      _isPaused = false;
      _isTimeUp = false;
      _isStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Masukkan Waktu (detik)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _inputTime = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isStarted ? null : _startCountdown,
              child: Text('Start'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      _isTimeUp
                          ? 'Waktu Anda Sudah Habis!'
                          : '${_duration.inHours.toString().padLeft(2, '0')}:${(_duration.inMinutes % 60).toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: _isTimeUp ? 20 : 48,
                        color: _isTimeUp ? Colors.red : Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    if (_isTimeUp)
                      ElevatedButton(
                        onPressed: _restartCountdown,
                        child: Text('Restart'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor:
                              const Color.fromARGB(255, 101, 104, 105),
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed:
                                _isPaused ? _resumeCountdown : _pauseCountdown,
                            child: Text(_isPaused ? 'Resume' : 'Pause'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromARGB(255, 83, 50, 1),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: _resetCountdown,
                            child: Text('Reset'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 110, 33, 27),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            // Kolom Nama dan NIM
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Nama: Natasya Ryka Syafa Kamila',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
                Text(
                  'NIM: 222410102060',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

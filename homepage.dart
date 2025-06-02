import 'package:clock_app/clock_view.dart';
import 'package:clock_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clock_app/auth/timer_view.dart';
import 'package:clock_app/auth/stopwatch_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String time = "Fetching...";
  String date = "Fetching...";
  String timezone = "Fetching...";
  String apiData = "Fetching data...";

  @override
  void initState() {
    super.initState();
    fetchApiData();
  }

  void fetchApiData() async {
    try {
      var data = await ApiService.fetchTimeData();
      print("API Response: $data");

      if (data.containsKey('datetime') && data['datetime'] != null) {
        DateTime dateTime = DateTime.parse(data['datetime']);
        setState(() {
          time = DateFormat('HH:mm').format(dateTime);
          date = DateFormat('EEE, d MMM').format(dateTime);
        });
      }

      if (data.containsKey('utc_offset') && data['utc_offset'] != null) {
        timezone = "UTC ${data['utc_offset']}";
      } else {
        timezone = "Unknown Timezone";
      }

      setState(() {
        apiData = "Timezone: $timezone";
      });
    } catch (e) {
      print("Error fetching data: $e");
      DateTime now = DateTime.now();
      setState(() {
        time = DateFormat('HH:mm').format(now);
        date = DateFormat('EEE, d MMM').format(now);
        timezone =
            "UTC ${now.timeZoneOffset.inHours}:${(now.timeZoneOffset.inMinutes % 60).toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 25, 34),
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: fetchApiData,
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 24, 25, 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/clock_icon.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Clock',
                      style: TextStyle(
                        color: Color.fromARGB(255, 246, 246, 246),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 24, 25, 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/Alarm_icon.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Alarm',
                      style: TextStyle(
                        color: Color.fromARGB(255, 246, 246, 246),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimerView()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 24, 25, 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/timer_icon.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Timer',
                      style: TextStyle(
                        color: Color.fromARGB(255, 246, 246, 246),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StopwatchView()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 24, 25, 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/stopwatch_icon.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Stopwatch',
                      style: TextStyle(
                        fontFamily: 'avenir',
                        color: Color.fromARGB(255, 246, 246, 246),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          VerticalDivider(
            color: const Color.fromARGB(32, 255, 255, 255),
            width: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Clock',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    SizedBox(height: 32),
                    Text(
                      time,
                      style: TextStyle(color: Colors.white, fontSize: 64),
                    ),
                    Text(
                      date,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    ClockView(),
                    SizedBox(height: 20),
                    Text(
                      'Timezone',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 24, 25, 34),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.language, color: Colors.white),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              timezone,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

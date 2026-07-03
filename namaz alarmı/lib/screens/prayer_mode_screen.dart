import 'package:flutter/material.dart';
import '../services/alarm_service.dart';
import 'wudu_screen.dart';

class PrayerModeScreen extends StatelessWidget {
  final String prayerName;
  const PrayerModeScreen({super.key, required this.prayerName});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${prayerName} Namazı'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.access_alarm, size: 120, color: Colors.red),
                const SizedBox(height: 30),
                Text(
                  '$prayerName vakti!\nSosyal medya kilitlendi.\nAlarm devam ediyor...',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WuduScreen()),
                    );
                  },
                  child: const Text('Vudu Almaya Başla'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
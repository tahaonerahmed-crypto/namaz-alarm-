import 'package:flutter/material.dart';
import '../services/alarm_service.dart';

class SalahScreen extends StatefulWidget {
  const SalahScreen({super.key});

  @override
  State<SalahScreen> createState() => _SalahScreenState();
}

class _SalahScreenState extends State<SalahScreen> {
  int currentRakat = 1;

  Future<void> _completeSalah() async {
    await AlarmService.cancelPrayerAlarm();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Namaz tamamlandı! Alarm ve bloklama kaldırıldı.')),
      );
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Namaz Kıl')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Rekat: $currentRakat', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                setState(() => currentRakat++);
                if (currentRakat > 4) _completeSalah();
              },
              child: const Text('Rekat Tamamla (+1)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _completeSalah,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Namazı Tamamla'),
            ),
          ],
        ),
      ),
    );
  }
}
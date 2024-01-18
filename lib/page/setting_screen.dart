import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/schedulling_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 17, left: 17, top: 20),
              child: Text(
                "Pengaturan",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Material(
              child: ListTile(
                title: const Text('Scheduling Restaurant',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: scheduled.isScheduled,
                      onChanged: (value) async {
                        scheduled.scheduledRestaurant(value);
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

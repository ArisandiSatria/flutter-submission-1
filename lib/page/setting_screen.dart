import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
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
            Consumer<SharedPrefProvider>(
              builder: (context, provider, child) {
                return Material(
                  child: ListTile(
                    title: const Text('Rekomendasi Restoran',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13)),
                    trailing: Consumer<SchedulingProvider>(
                      builder: (context, scheduled, _) {
                        return Switch.adaptive(
                          value: provider.isDailyActive,
                          onChanged: (value) async {
                            scheduled.scheduledRestaurant(value);
                            provider.enableDailyActive(value);
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

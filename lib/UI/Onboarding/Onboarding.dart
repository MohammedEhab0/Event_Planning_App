import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Onboarding extends StatelessWidget {
  static const routeName = 'Onboarding';

  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Image.asset(AppAssets.logo),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.05, horizontal: width * 0.05),
        child: Column(
          children: [
            Image.asset(AppAssets.Onboarding),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'personalize'.tr(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Description Text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'prg_personalize'.tr(), // This should also be translated
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),

            _buildActionRow(context, 'language'.tr()),
            _buildActionRow(context, 'theme'.tr()),
          ],
        ),
      ),
    );
  }

  Widget _buildActionRow(BuildContext context, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: Icon(Icons.swap_horizontal_circle),
          onPressed: () {},
        ),
      ],
    );
  }
}

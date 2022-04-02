import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Privacy polisy',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            buildText(context),
          ],
        ),
      ),
    );
  }

  Widget buildText(BuildContext context) {
    return ReadMoreText(
      AppLocalizations.of(context).privacyPolicyText,
      trimLines: 60,
      trimMode: TrimMode.Line,
      trimCollapsedText: AppLocalizations.of(context).readMoreText,
      trimExpandedText: AppLocalizations.of(context).readLessText,
      style: TextStyle(fontSize: 15.0),
    );
  }
}

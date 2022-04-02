import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermOfUse extends StatelessWidget {
  //String text = """""";
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
                  'Term of use',
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
      AppLocalizations.of(context).termOfUseText,
      trimLines: 60,
      trimMode: TrimMode.Line,
      trimCollapsedText: AppLocalizations.of(context).readMoreText,
      trimExpandedText: AppLocalizations.of(context).readLessText,
      style: TextStyle(fontSize: 15.0),
    );
  }
}

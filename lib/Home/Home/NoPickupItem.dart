import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoPickupItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.6,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context).youHaveNoPickup,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 20,
          ),
          Image(
              height: screenSize.width * 0.4,
              image: AssetImage('assets/images/sad_man2.png')),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

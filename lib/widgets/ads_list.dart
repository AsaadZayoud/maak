import 'package:flutter/material.dart';
import 'package:maak/widgets/ads.dart';

class AdsList extends StatelessWidget {
  const AdsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Material(
      child: Container(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context,i){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Ads(),
            );
          },
        ),
      ),
    );
  }
}

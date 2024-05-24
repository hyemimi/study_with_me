import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/bookBanner.jpg'),
        ),
      ),
    );
  }
}

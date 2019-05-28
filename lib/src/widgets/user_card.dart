import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {

  const UserCard(this.data, {this.index, this.onTap});

  final data;
  final int index;
  final Function onTap;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.white
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(20.0) 
        ),
        color: Colors.black
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showImage()
        ]
      )
    );
  }



  Widget _showImage() {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage.assetNetwork(
        fadeInDuration: Duration(milliseconds: 300),
        placeholder: 'assets/images/loader.png',
        image: 'https://image.tmdb.org/t/p/original/' + data.image,
        height: (index == 0) ? 160.0 : null,
        fit: BoxFit.fitWidth,
        fadeInCurve: Curves.easeInCirc,
      ),
    );
  }

}
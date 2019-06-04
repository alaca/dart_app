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
          _showImage(),
          _showName()
        ]
      )
    );
  }


  Widget _showName() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text( data.name, 
        style: TextStyle(color: Colors.white )
      )
    );
          
  }

  Widget _showImage() {
    return  ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0), 
        topRight: Radius.circular(20.0)
      ),
      child: FadeInImage.assetNetwork(
        excludeFromSemantics: true,
        fadeInDuration: Duration(milliseconds: 300),
        placeholder: 'assets/images/loader.png',
        image: 'https://image.tmdb.org/t/p/w300/' + data.image,
        height: 160.0,
        fit: BoxFit.fitWidth
      )
      
    );
  }

}
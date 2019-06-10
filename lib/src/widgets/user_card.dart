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
        color: Colors.black,
      ),
      child: Stack(
        alignment: Alignment.center,  
        children: <Widget>[
          _showImage(),
          _showTopIcon(),
          _showBottomIcons()
        ],
      )
    );
  }

  Widget _showTopIcon() {

    return Positioned(
      top: 10.0,
      right: 0.0,
      child: Row(
        children: <Widget>[
          Icon( 
            Icons.more_vert, 
            size: 30.0,
            color: Colors.white,
          )
        ],
      )
    );

  }

  Widget _showBottomIcons() {

    return Positioned(
      bottom: 10.0,
      right: 10.0,
      child: Row(
        children: <Widget>[
          Icon( 
            Icons.favorite_border, 
            size: 22.0,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only( top: 4.0, right: 10.0),
            child: Text(
              data.popularity.toStringAsFixed(1) + 'k',
              style: TextStyle(
                color: Colors.white, 
                fontSize: 10.0
                ),

            ),
          ),
          Icon( 
            Icons.share, 
            size: 22.0,
            color: Colors.white,
          ),
        ],
      )
    );

  }

  Widget _showImage() {

    final imageWidget = data.image.isEmpty 
      ? Image.asset('assets/images/loader.png')
      : FadeInImage.assetNetwork(
          excludeFromSemantics: true,
          fadeInDuration: Duration(milliseconds: 300),
          placeholder: 'assets/images/loader.png',
          image: 'https://image.tmdb.org/t/p/w300/' + data.image,
          height: 180.0,
          fit: BoxFit.fitWidth
        );
 
    return  SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: imageWidget
      ),
    );
  }

}
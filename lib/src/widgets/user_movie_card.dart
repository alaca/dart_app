import 'package:flutter/material.dart';

class UserMovieCard extends StatefulWidget {

  const UserMovieCard(this.data, {this.index});

  final data;
  final int index;

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<UserMovieCard> {

  var favorite = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.white.withOpacity(0.3)
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(21.0) 
        ),
        color: Colors.black,
      ),
      child: _showImage(context)
    );
  }

  Widget _showImage(context) {

    final imageWidget = widget.data.poster.isEmpty 
      ? Image.asset('assets/images/loader.png')
      : FadeInImage.assetNetwork(
          excludeFromSemantics: true,
          fadeInDuration: Duration(milliseconds: 300),
          placeholder: 'assets/images/loader.png',
          image: 'https://image.tmdb.org/t/p/w300/' + widget.data.poster,
          height: widget.index % 2 == 0 ? 180.0 : 225.0,
          fit: BoxFit.fitWidth
        );
 
    return  SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: GestureDetector(
          onTap: () {
            print('presssed');
          },
          child: imageWidget,
        )
      ),
    );
  }
}
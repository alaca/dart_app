import 'package:flutter/material.dart';
import 'package:share/share.dart';

class UserCard extends StatefulWidget {

  const UserCard(this.data, {this.index});

  final data;
  final int index;

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {

  var favorite = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.white.withOpacity(0.4)
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(21.0) 
        ),
        color: Colors.black,
      ),
      child: Stack(
        alignment: Alignment.center,  
        children: <Widget>[
          _showImage(context),
          _showTopIcon(),
          _showBottomIcons(context)
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

  Widget _showBottomIcons(context) {

    return Positioned(
      bottom: 0.0,
      right: 10.0,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              ( favorite ) ? Icons.favorite : Icons.favorite_border,
              size: 22,
              color: ( favorite ) ? Colors.red : Colors.white
            ),
            onPressed: () {
              setState(() {
                favorite = !favorite;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only( top: 4.0),
            child: Text(
              widget.data.popularity.toStringAsFixed(1) + 'k',
              style: TextStyle(
                color: Colors.white, 
                fontSize: 10.0
                ),

            ),
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              size: 22,
              color: Colors.white
            ),
            onPressed: () {
              final RenderBox box = context.findRenderObject();
              Share.share('Check user ' + widget.data.name,
                  sharePositionOrigin:
                  box.localToGlobal(Offset.zero) &
                  box.size);
            },
          ),
        ],
      )
    );

  }

  Widget _showImage(context) {

    final imageWidget = widget.data.image.isEmpty 
      ? Image.asset('assets/images/loader.png')
      : FadeInImage.assetNetwork(
          excludeFromSemantics: true,
          fadeInDuration: Duration(milliseconds: 300),
          placeholder: 'assets/images/loader.png',
          image: 'https://image.tmdb.org/t/p/w300/' + widget.data.image,
          height: widget.index % 2 == 0 ? 180.0 : 225.0,
          fit: BoxFit.cover
        );
 
    return  SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: GestureDetector(
          onTap: () {
              Navigator.pushNamed(
                context,
                'user',
                arguments: widget.data,
              );
          },
          child: imageWidget,
        )
      ),
    );
  }
}
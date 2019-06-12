import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../providers/tmdb_provider.dart';
import '../widgets/loader.dart';



class UserScreen extends StatefulWidget {

  final userData;

  UserScreen( this.userData );

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  TmdbProvider tmdbProvider;
  ScrollController _moviesController = ScrollController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();


  @override
  Widget build(BuildContext context) {

    tmdbProvider = Provider.of<TmdbProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text( widget.userData.name ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu, size: 30.0),
            onPressed:() {
              _scaffoldKey.currentState.openDrawer();
            }
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.white,
        )
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: tmdbProvider.fetchUser(widget.userData.id),
          builder: ( context, snapshot ) {

            if (snapshot.hasData) {

              return ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _showImage(snapshot.data),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Column(
                            children: <Widget>[
                              _showInfo('Name', snapshot.data.name ),
                              _showInfo('Date of birth', snapshot.data.birthday ),
                              _showInfo('Place of birth', snapshot.data.pob ),
                              _showInfo('Popularity', snapshot.data.popularity )
                            ],
                          ),
                        ),
                      ),
                    ]
                  ),
                  _showInfo('Biography', snapshot.data.biography ),
                  _showInfo('Movies', '' ),
                  _showMovies(snapshot.data.movies)
                ]

              );
              

            } 

            return Loader();

          },
        )
      )
    );

  }


  Widget _showImage(data) {

    final imageWidget = data.image.isEmpty 
      ? Image.asset('assets/images/loader.png', width: 150.0)
      : FadeInImage.assetNetwork(
          excludeFromSemantics: true,
          fadeInDuration: Duration(milliseconds: 300),
          placeholder: 'assets/images/loader.png',
          image: 'https://image.tmdb.org/t/p/w300/' + data.image,
          width: 150.0,
          fit: BoxFit.cover
        );
 
    return  SizedBox(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: imageWidget
      ),
    );
  }




  Widget _showInfo( name, value ) {

    TextStyle textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,      
    );

    TextStyle textInfoStyle = TextStyle(
      color: Colors.white
    );

    return Padding(
      padding: EdgeInsets.only( bottom: 10.0, top: 10.0 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(name + ':', style: textStyle ),
          Text(value.toString(), style: textInfoStyle ),
        ],
      ),
    );

  }

  Widget _showMovies(movies) {
    print(movies);

    return Container();
  }


}
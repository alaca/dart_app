import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../providers/auth_provider.dart';
import '../resources/tmdb_repository.dart';
import '../models/user_model.dart';
import '../widgets/user_card.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List<UserModel>> users;

  @override
  void initState() {
    super.initState();
    
    users = TMDBRepository().getTopRated();

  }

  Widget build(context) {

    AuthProvider auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('iTrak'),
        backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed:() {

              return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Sign Out?'),
                    content: Text('Sign out from application?'),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('YES'),
                        textColor: Color(0xffffcc00),
                        onPressed: () async {
                          await auth.signOut();
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, 'login');
                        },
                      ),
                      FlatButton(
                        child: Text('NO'),
                        textColor: Color(0xffffcc00),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                }
              );

            }
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.white,
        )

      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.black,
        child: FutureBuilder(
          future: users,
          builder: ( context, snapshot ) {

            if (snapshot.hasData) {

              return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int i) {
                  return UserCard( snapshot.data[i], index: i, );
                },
                staggeredTileBuilder: (int i) {
                  if ( i == 0 ) {
                    return StaggeredTile.fit(2);
                  }

                  return StaggeredTile.fit(1);
                },
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
              );

            } 

            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffffcc00))
              )
            );


          },
        )
      ) 
    );

  }

  _getImageInfo( image ) async {

      Image downloadImage = Image.network(image);

      final ImageStream stream = downloadImage.image.resolve(ImageConfiguration.empty);
      final Completer<void> completer = Completer<void>();
      stream.addListener((ImageInfo info, bool syncCall) => completer.complete());

      return FutureBuilder(
        future: completer.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.width;
          }
        },
      );

  }


}
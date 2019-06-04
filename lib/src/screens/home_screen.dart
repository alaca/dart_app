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

  int _initialPage;
  Future<List<UserModel>> _users;
  ScrollController _controller;

  @override
  void initState() {

    _initialPage = 1;
    _users = TMDBRepository().getTopRated(page: _initialPage);
    _controller = ScrollController();
    _controller.addListener(_scrollListener);


    super.initState();

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
          future: _users,
          builder: ( context, snapshot ) {

            if (snapshot.hasData) {

              return StaggeredGridView.countBuilder(
                controller: _controller,
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


  _scrollListener() {

    if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
      setState(() {

        final Future<List<UserModel>> freshUsers = TMDBRepository().getTopRated(page: _initialPage++);

        _users.add(freshUsers);
      });
    }

  }



}
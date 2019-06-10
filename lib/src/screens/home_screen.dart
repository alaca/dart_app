import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../providers/auth_provider.dart';
import '../providers/users_provider.dart';
import '../widgets/user_card.dart';



class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentPage = 1;
  ScrollController _controller = ScrollController();
  UsersProvider usersProvider;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void initState() {

    super.initState();
    _controller.addListener(_scrollListener);

  }

  Widget build(context) {

   AuthProvider auth = Provider.of<AuthProvider>(context);
   usersProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('iTrak'),
        backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
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
        padding: EdgeInsets.all(10.0),
        color: Colors.black,
        child: FutureBuilder(
          future: usersProvider.getUsers(),
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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 100.0,
              child: DrawerHeader(
                child: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 22.00),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                margin : EdgeInsets.all(0.0),
                padding: EdgeInsets.all(15.0)
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Sign out'),
              onTap: () {

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

            ),
          ],
        ),
      ),
    );

  }


  _scrollListener() {

    if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange)
      usersProvider.fetchUsers(++_currentPage); 
    
  }



}
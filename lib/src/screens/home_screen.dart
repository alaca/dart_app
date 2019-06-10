import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../providers/auth_provider.dart';
import '../providers/users_provider.dart';
import '../widgets/user_card.dart';



class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  int _currentPage = 1;
  ScrollController _controller = ScrollController();
  TabController _tabControllerTop;
  TabController _tabControllerBottom;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  UsersProvider usersProvider;

  void initState() {
     _tabControllerTop = TabController(length: 5, vsync: this );
     _tabControllerBottom = TabController(length: 5, vsync: this );
    _controller.addListener(_scrollListener);

    
    super.initState();

  }

  Widget build(context) {

    usersProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
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
        ),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Color(0xffffcc00),
          isScrollable: false,
          tabs: [
            Tab( text: 'Live'),
            Tab( text: 'Movies' ),
            Tab( text: 'Games' ),
            Tab( text: 'Podcast' ),
            Tab( text: 'Photos' ),
          ],
          controller: _tabControllerTop,
          indicatorColor: Color(0xffffcc00),
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: EdgeInsets.all(0.00),
  
        )
      ),
      body: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(10.0),
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
              onTap: () => _showDialog( context )
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.transparent], // wtf. looks like scaffold is adding background color to bottomNavigationBar so this is not working
            stops: [0.0, 1.0],
          ),
        ),
        child: TabBar(

          tabs: [
            Tab(
              icon: Icon( 
                Icons.my_location, 
                size: 30.00
              ),
              text: 'TrakIT'
            ),
            Tab(
              icon: Icon(Icons.videocam, size: 30.00),
              text: 'CreateIT'
            ),
            Tab(
              icon: Icon(Icons.next_week, size: 30.00),
              text: 'WorkIT'
            ),
            Tab(
              icon: Icon(Icons.share, size: 30.00),
              text: 'SocialIT'
            ),
            Tab(
              icon: Icon(Icons.tune, size: 30.00),
              text: 'ManageIT'
            )
          ],
          controller: _tabControllerBottom,
          labelColor: Color(0xffffcc00),
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Color(0xffffcc00),
          labelPadding: EdgeInsets.all(0.00),
          labelStyle: TextStyle(fontSize: 12.00)
        ),
      )
    );

  }


  _scrollListener() {

    if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange)
      usersProvider.fetchUsers(++_currentPage); 
    
  }

  _showDialog( BuildContext context ) {

    AuthProvider auth = Provider.of<AuthProvider>(context);

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



}
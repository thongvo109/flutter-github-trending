import 'package:flutter/material.dart';
import 'package:golang/provider/pref.dart';
import 'package:golang/screen/signin.dart';
import 'package:golang/widget/homepage/bookmark.dart';
import 'package:golang/widget/homepage/profile.dart';
import 'package:golang/widget/homepage/trending.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    TrendingRepo(),
    BookMarkRepo(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: _currentIndex == 0
            ? Text(
                'Github Trending',
                style: TextStyle(color: Colors.white),
              )
            : _currentIndex == 1
                ? Text('Bookmark List', style: TextStyle(color: Colors.white))
                : _currentIndex == 2
                    ? Text("Profile", style: TextStyle(color: Colors.white))
                    : Container(),
        actions: <Widget>[
          if (_currentIndex == 0) ...[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await PrefProvider.instance.set("token", null);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            )
          ]
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapper,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.grey[900],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text('Trending'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            title: Text('Bookmark'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('User'),
          ),
        ],
      ),
    );
  }

  void onTabTapper(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

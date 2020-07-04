import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golang/api/base.dart';
import 'package:golang/model/github_model.dart';
import 'package:golang/provider/hex_color.dart';

class TrendingRepo extends StatefulWidget {
  @override
  _TrendingRepoState createState() => _TrendingRepoState();
}

class _TrendingRepoState extends State<TrendingRepo> {
  StreamController _streamController = StreamController<List<GithubModel>>();
  List<GithubModel> _listRepo = List();

  @override
  void initState() {
    super.initState();
    GithubBaseApi().githubTrending().then((value) {
      _listRepo = value;
      _streamController.sink.add(value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GithubModel>>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return ListView.separated(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            print(snapshot.data[index].name);
            return _buildRepo(index, snapshot.data[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              color: Colors.black,
            );
          },
        );
      },
    );
  }

  Widget _buildRepo(int index, GithubModel repo) {
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Image.network(
                  'https://cdn.iconscout.com/icon/free/png-256/repo-5-433148.png',
                  width: 25,
                  height: 25,
                ),
              ),
              Expanded(
                child: Text(
                  repo.name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            child: Text(
              repo.description,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 2),
                      width: 15,
                      height: 15,
                      decoration: new BoxDecoration(
                        color: HexColor(repo.color),
                        shape: BoxShape.circle,
                      ),
                      child: Text(''),
                    ),
                    Text(repo.lang.isEmpty ? 'Unkown' : repo.lang)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 2),
                      child: Icon(Icons.star),
                    ),
                    Text(repo.stars),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 2),
                      child: Image.network(
                        'https://cdn.iconscout.com/icon/free/png-256/repo-2-433145.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Text(repo.stars)
                  ],
                ),
                !repo.bookmarked
                    ? GestureDetector(
                        onTap: () {
                          print("add bookmark" + repo.name);
                          GithubBaseApi().bookmark(repo.name).then(
                            (res) {
                              _listRepo.elementAt(index).bookmarked = true;
                              _streamController.sink.add(_listRepo);
                            },
                          );
                        },
                        child: Container(
                          child: Icon(Icons.bookmark_border),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          print("del bookmark" + repo.name);
                          GithubBaseApi().delBookmark(repo.name).then(
                            (res) {
                              _listRepo.elementAt(index).bookmarked = false;
                              _streamController.sink.add(_listRepo);
                            },
                          );
                        },
                        child: Container(
                          child: Icon(Icons.bookmark),
                        ),
                      ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ...buildAvatarContributors(repo.contributors),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(repo.starsToday)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildAvatarContributors(List<String> avatars) {
    List<Widget> avatarWidgets = List();
    avatars.forEach((avatar) {
      avatarWidgets.add(
        Container(
          margin: EdgeInsets.only(right: 5),
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(4),
            child: Image.network(
              avatar,
              height: 20,
              width: 20,
            ),
          ),
        ),
      );
    });
    return avatarWidgets;
  }
}

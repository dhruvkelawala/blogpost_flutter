import 'package:blogpost/models/blogpost.dart';
import 'package:flutter/material.dart';
import 'api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedTitle;
  Blogpost selectedPost;
  List allPosts;

  List<String> getTitleList(List<dynamic> list) {
    List<String> newList = [];

    for (var blogpost in list) {
      newList.add(blogpost.title);
    }

    return newList;
  }

  void setPost(String title) {
    selectedPost = allPosts.firstWhere((e) => e.title == title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogposts'),
      ),
      body: Container(
        child: FutureBuilder(
          future: getBlogs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<String> titleList = [];

            if (snapshot.hasData) {
              allPosts = snapshot.data;
              titleList = getTitleList(snapshot.data);
              // print(selectedPost.title);
            }
            return snapshot.hasData
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        child: DropdownButton(
                          items: titleList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedTitle = newValue;
                              setPost(selectedTitle);
                            });
                          },
                          value: selectedTitle ?? snapshot.data[0].title,
                          focusColor: Colors.black,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 150),
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: selectedTitle == null
                              ? <Widget>[
                                  Text('Description: ' + snapshot.data[0].des),
                                  Text('Author: ' + snapshot.data[0].author),
                                  Text(
                                      'Posted-On: ' + snapshot.data[0].postedOn)
                                ]
                              : <Widget>[
                                  Text('Description: ' + selectedPost.des),
                                  Text('Author: ' + selectedPost.author),
                                  Text('Posted-On: ' + selectedPost.postedOn),
                                ],
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

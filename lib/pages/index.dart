import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:github_finder/theme/colors.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List users = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }
  fetchUser() async {
    var url = "https://api.github.com/users";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var items = json.decode(response.body);
      print(items);
      setState(() {
        users = items;
      });
    }else{
      users = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(60/2),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                        NetworkImage("https://image.flaticon.com/icons/png/512/25/25231.png")
                    )
                ),
              ),
              Text("  GitHub Users"),
            ],
        ),
      ),
      body: getBody(),
    );
  }
  Widget getBody(){
    List items = [
      "1",
      "2"
    ];
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context,index){
      return getCard(users[index]);
    });
  }
  Widget getCard(item){
    var fullName = item['login'];
    var htmlUrl = item['html_url'];
    var profileUrl = item['avatar_url'];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
          child: ListTile(
              title: Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(60/2),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                        NetworkImage(profileUrl.toString())
                    )
                    ),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(fullName.toString(),style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(height: 10,),
                      Text(htmlUrl.toString(),style: TextStyle(color: Colors.grey),)
                    ],
                  )
                ],
              )
          )
      )
    );
  }
  }

import 'dart:async';
import 'package:flip_box_bar_plus/flip_box_bar_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmail/main.dart';
import 'package:gmail/start.dart';

import 'SizeConfig.dart';
import 'home.dart';

class history extends StatefulWidget {

  List userList;
  history({required this.userList});
  @override
  _historyState createState() => _historyState(userList);
}

class _historyState extends State<history> {

  int selectedindex = 1;
  late List userList;
  _historyState(this.userList);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: FlipBoxBarPlus(
          selectedIndex: selectedindex,
          items: [
            FlipBarItem(
                icon: InkWell(
                    onTap: ()
                    {
                      Timer(Duration(seconds: 1),(){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> start()));
                      });
                    },
                    child: Icon(Icons.home)),
                text: Text("Home"),
                frontColor: Color(0xffF0A9A9),
              backColor: Color(0xff4BD0D7),
            ),
            FlipBarItem(
                icon: InkWell(
                    onTap: (){
                      Timer(Duration(seconds: 1),(){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ghg()));
                      });
                    },
                    child: Icon(Icons.login)),
                text: Text("Login "),
                frontColor: Color(0xffF0A9A9),
              backColor: Color(0xff4BD0D7),
            ),
            FlipBarItem(
                icon: InkWell(
                    onTap: (){
                      Timer(Duration(seconds: 1),(){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
                      });
                    },
                    child: Icon(Icons.mail)),
                text: Text("Mailer"),
                frontColor: Color(0xffF0A9A9),
              backColor: Color(0xff4BD0D7),
            ),
          ],
          onIndexChanged: (newIndex){
            setState(() {
              selectedindex = newIndex;
            });
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff4BD0D7),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(55),bottomLeft: Radius.circular(55))
              ),
              child: Row(
                children: [
                  SizedBox(width: 75,),
                  Image.asset("assets/clock.png",height: 50,width: 50,),
                  SizedBox(width: 10,),
                  Text("HISTORY OF MAIL",style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff03373A)
                  ),)
                ],
              ),
            ),
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context,index)
                  {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage("assets/man.png"),
                          ),
                          title: Text(userList[index].sendermail.toString()),
                          subtitle: Text(userList[index].head2.toString())),
                        ),
                      );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

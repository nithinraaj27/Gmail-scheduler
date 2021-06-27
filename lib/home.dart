import 'dart:async';
import 'dart:ffi';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gmail/history.dart';
import 'package:gmail/util.dart';
import 'package:mailer/mailer.dart';
import 'package:pimp_my_button/pimp_my_button.dart';
import 'package:ripple_effect/ripple_effect.dart';
import 'package:toast/toast.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'SizeConfig.dart';

class ghg extends StatefulWidget {

  @override
  _ghgState createState() => _ghgState();
}

class _ghgState extends State<ghg> {

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  List<user> userList = [];
  user ss = new user();

  void _addcollection(user ss)
  {
    setState(() {
      userList.add(ss);
      this.ss = new user();
    });
  }

  void finalmail()
  {
    print(ss.sendermail);
    print(ss.msg);
    _addcollection(ss);
    if(_formkey.currentState!.validate()){
      _formkey.currentState!.save();
      if(_formkey.currentState!.validate())
      {
        sendmail();
      }
    }
    setState(() {
      _formkey.currentState!.reset();
    });
  }


  sendmail() async {
    String username = "sample@gmail.com"; //Use your gmail account
    String password = "Password"; // Use your password

    String head1 = ss.head1.toString();
    String head2 = ss.head2.toString();
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, "Sample Name") //Sample name
      ..recipients.add(ss.sendermail)
      ..subject = '$ss.msg ${DateTime.now()}'
      ..text = "subject"
      ..html = "<h1> $head1  </h1>\n<p> $head2 </p>";

    try {
      final sendreport = await send(message, smtpServer);
      print('Message sent: ' + sendreport.toString());
      Toast.show(
          "You have clicked the Button! and email sent", context, duration: 3,
          gravity: Toast.CENTER);
    } on MailerException catch (e) {
      print(e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

   @override
    Widget build(BuildContext context) {
     SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body:DraggableBottomSheet(
        backgroundWidget: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 25),
                padding: EdgeInsets.only(top: 50),
                width: 50,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xffA6EAED),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(55),bottomRight: Radius.circular(55))
                ),
                child: PimpedButton(
                  particle: DemoParticle(),
                  pimpedWidgetBuilder: (context,controller){
                    return FloatingActionButton(
                      backgroundColor: Colors.black,
                        child: Image.asset("assets/mail.png",height: 35,width: 35,fit: BoxFit.fill,),
                        onPressed: () {
                          controller.forward(from: 0.0);
                          Timer(Duration(seconds: 2),(){
                            Key key ;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> history(userList: userList)));
                          });
                        });
                  },
                )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 100,top: 80),
                  child: Text("WELCOME HOME",style: TextStyle(
                    fontSize: 35,
                    fontFamily: "RobotoMono",
                    color: Color(0xff089CA4),
                    letterSpacing: 1,
                    fontWeight: FontWeight.w800
                  ),)),
              Padding(
                  padding: EdgeInsets.only(left: 100,top: 180),
                  child: Text("Let's Connect world by mail",style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontFamily: "fantasy",
                      color: Color(0xff089CA4),
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800
                  ),)),
              Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: Image.asset("assets/home.png")),
             // // Container(
             //    height: 300,
             //    width: MediaQuery.of(context).size.width,
             //    child: ListView.builder(
             //        itemCount: userList.length,
             //        itemBuilder: (context,index)
             //        {
             //          return Card(
             //            child: Padding(
             //              padding: EdgeInsets.all(16),
             //              child: Text(userList[index].sendermail.toString() + "   " + userList[index].head1.toString() + "    " + userList[index].head2.toString()),
             //            ),
             //          );
             //        }
             //    ),
             //  ),
              Padding(
                  padding: EdgeInsets.only(top: 640,left: 15),
                  child: Image.asset("assets/robot.png",height: 75,width: 75,))
            ],
          ),
        ),
        previewChild: Container(
          height: 250,
          padding: EdgeInsets.only(left: 98,top: 10),
          decoration: BoxDecoration(
            color: Color(0xffA6EAED ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
          ),
          child: Text("DRAG TO SEND MAIL",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 25
            ),)
        ),
        expandedChild: Container(
          decoration: BoxDecoration(
            color: Color(0xffF2FEFF),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
          ),
          child: Column(
            children: [
              SizedBox(height: 40,),
              Image.asset("assets/mail.png",height: 75,width: 75,),
              SizedBox(height: 20,),
              Text("COMPOSE MAIL",style: TextStyle(
                color: Colors.red.shade400,
                fontFamily: "RobotoMono",
                letterSpacing: 1,
                fontWeight: FontWeight.w800,
                fontSize: 35,
                decoration: TextDecoration.underline
              ),),
              SizedBox(height: 25,),
              Container(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || !value.contains("@")) {
                              return "invalid email";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            ss.sendermail = value!;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: "E-mail"),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "invalid msg";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            ss.msg = value!;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: "Topic "),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "invalid body";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            ss.head1 = value!;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: "Heading"),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "invalid head2";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            ss.head2 = value!;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: "Body Msg"),
                        ),
                      ),
                      SizedBox(height: 25,),
                      ArgonButton(
                        height: 50,
                        roundLoadingShape: true,
                        width: MediaQuery.of(context).size.width * 0.45,
                        onTap: (startLoading, stopLoading, btnState) {
                          if (btnState == ButtonState.Idle) {
                            startLoading();
                            finalmail();
                          } else {
                            stopLoading();
                          }
                        },
                        child: Text(
                          "Send Mail",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        loader: Container(
                          padding: EdgeInsets.all(10),
                          child: SpinKitHourGlass(
                            color: Colors.white,
                            // size: loaderWidth ,
                          ),
                        ),
                        borderRadius: 5.0,
                        color: Color(0xffA4B5E9),
                      ),
                      SizedBox(height: 10,),
                      //Image.asset("assets/mailbig.jpg",height: 210)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        minExtent: 50,
        maxExtent: MediaQuery.of(context).size.height,
      )
    ));
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }






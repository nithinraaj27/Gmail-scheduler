// @dart=2.9
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gmail/SizeConfig.dart';

import 'package:gmail/home.dart';
import 'package:gmail/signup.dart';
import 'package:gmail/start.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'backround_painter.dart';

void main() =>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
        home: splashscreen(),
        debugShowCheckedModeBanner: false,
      );
  }
}

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => start()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              // width: double.infinity,
              color: Colors.black,
              child: Image.asset("assets/robotics.png"),
            ),
            Padding(
                padding: EdgeInsets.only(top: 620,left: 140),
                child: Text("GMAIL BOT",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 25,
                      letterSpacing: 2,
                      fontFamily: "fantasy"
                  ),)
            )
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  bool _isLoggedIn = false;
  GoogleSignIn _userObj;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    }
    catch(err)
    {
      print(err);
    }
  }

  _logout()
  {
    setState(() {
      _googleSignIn.signOut();
      _isLoggedIn = false;
    });
  }

  String email;
  String password;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new AnimationController(vsync: this,duration: Duration(seconds: 2));
    //_controller.initialize().then((_) {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void login()
  {
    if(_formkey.currentState.validate()){
      _formkey.currentState.save();
      if(_formkey.currentState.validate())
        {
          _controller.forward(from: 0);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ghg()));
        }
    }
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: BackgroundPainter(
                  animation: _controller.view,
                ),
              )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 250,),
                Padding(
                    padding: EdgeInsets.only(left: 23,bottom: 20),
                    child: Text("Login Here,",style: TextStyle(
                      fontSize: 25,
                      color: Color(0xff1E1717),
                      fontFamily: "fantasy",
                      //fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1
                    ),)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            validator:(value)
                            {
                              if(value.isEmpty || !value.contains("@"))
                                {
                                  return "invalid email";
                                }
                              return null;
                            },
                            onSaved: (value)
                            {
                              email = value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "E-mail"
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(25),
                          child: TextFormField(
                            obscureText: true,
                            validator:(value)
                            {
                              if(value.isEmpty || value.length<5)
                              {
                                return "invalid Password";
                              }
                              return null;
                            },
                            onSaved: (value)
                            {
                              password = value;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password"
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 52,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xffBFE4E6)
                          ),
                          child: InkWell(
                            onTap: () => login(),
                            child: Text("Login",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff3E5657),
                              letterSpacing: 2,
                              fontStyle: FontStyle.italic
                            ),),
                          ),
                        ),
                        SizedBox(height: 25,),
                        Container(
                          margin: EdgeInsets.only(left: 100),
                          child: Row(
                            children: [
                              Text("Don't have an Account?",style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey.shade600
                              ),),
                              InkWell(
                                onTap: ()
                                {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
                                },
                                child: Text(" Sign Up",style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.red.shade500,
                                    decoration: TextDecoration.underline,
                                ),),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 50,),
                        Text("-----------------------Or Login With-----------------------",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey.shade600
                        ),),
                        SizedBox(height: 25,),
                        Container(
                          alignment: Alignment.center,
                          height: 45,
                          width: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xff116569),
                          ),
                          child: _isLoggedIn ?
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                actions: [
                                  Center(
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.network(_googleSignIn.currentUser.photoUrl,height: 50,width: 50,),
                                          Text(_googleSignIn.currentUser.displayName),
                                          Text(_googleSignIn.currentUser.email),
                                          OutlineButton(
                                            onPressed: () => _logout(),
                                            child: Text("Logout"),
                                          )
                                        ],
                                      )
                                  )
                                ],
                              )
                          ) : InkWell(
                            onTap: ()
                            {
                              _googleSignIn.signIn().then((userData){
                                setState(() {
                                  _isLoggedIn = true;
                                  _userObj = userData as GoogleSignIn;
                                });
                              }).catchError((e){
                                print(e);
                              });
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  SizedBox(width: 19,),
                                  Image.asset("assets/google.png",height: 25,width: 25,),
                                  SizedBox(width: 8,),
                                  Text("Sign in with google",style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w600
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}


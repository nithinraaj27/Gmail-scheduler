import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'SizeConfig.dart';
import 'backround_painter.dart';
import 'main.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late String email;
  late String password;
  late String name;
  late String mob_num;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 2));
    //_controller.initialize().then((_) {});
  }

  void signUp()
  {
    if(_formkey.currentState!.validate()){
      _formkey.currentState!.save();
      if(_formkey.currentState!.validate())
      {
        _controller.forward(from: 0);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
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
              painter: BackgroundPainter(animation: _controller.view),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 150, left: 10),
                  child: Text(
                    "Sign Up here,",
                    style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff1E1717),
                    ),
                  )),
              SizedBox(height: 25,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "invalid name";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            name = value!;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Name"),
                        ),
                      ),
                      SizedBox(height: 10,),
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
                            email = value!;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "E-mail"),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length <10) {
                              return "invalid Mobile Number";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            mob_num = value!;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Mobile Number"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25,right: 25,top: 10),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 5) {
                              return "invalid Password";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = value!;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25,right: 25,top: 10),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "invalid Password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Re-Type Password"),
                        ),
                      ),
                      SizedBox(height: 45,),
                      Container(
                        alignment: Alignment.center,
                        height: 52,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xffBFE4E6)),
                        child: InkWell(
                          onTap: () => signUp(),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(0xff3E5657),
                                letterSpacing: 2,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 100),
                        child: Row(
                          children: [
                            Text(
                              "Already have an Account?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey.shade600),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              },
                              child: Text(
                                " Sign In",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red.shade500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}

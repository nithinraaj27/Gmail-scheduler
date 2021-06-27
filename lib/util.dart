import 'dart:convert';

import 'package:flutter/material.dart';

class user
{
  String? sendermail;
  String? msg;
  String? sub;
  String? head1;
  String? head2;

  user({
    this.sendermail,
    this.msg,
    this.sub,
    this.head1,
    this.head2
});

  factory user.fromJson(Map<String, dynamic> json) => new user(
  sendermail: json["sendermail"],
  msg: json["msg"],
  sub: json["sub"],
  head1: json["head1"],
  head2: json["head2"]
  );

  Map<String, dynamic> toJson() =>{
    "sendermail" : sendermail,
    "msg" : msg,
    "sub" : sub,
    "head1" : head1,
    "head2" : head2
  };

}
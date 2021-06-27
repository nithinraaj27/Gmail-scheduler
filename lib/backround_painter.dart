import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class  BackgroundPainter extends CustomPainter
{

  BackgroundPainter({required Animation<double> animation}):
      bluePaint = Paint()
        ..color = Color(0xff043433)
        ..style = PaintingStyle.fill,
      grey = Paint()
        ..color = Color(0xffA1E6E5)
        ..style = PaintingStyle.fill,
      orangePaint = Paint()
        ..color = Color(0xff219D9B)
        ..style = PaintingStyle.fill,
       liquidAnim = CurvedAnimation(
           curve: Curves.elasticInOut,
            reverseCurve: Curves.easeInBack,
            parent: animation,
       ),
       orangeAnim = CurvedAnimation(
           parent: animation,
           curve: const Interval(0, 0.7,curve: Interval(0,0.8,curve: SpringCurve())),
          reverseCurve: Curves.linear,
       ),
        greyAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(0, 0.8,curve: Interval(0,0.9,curve: SpringCurve())),
          reverseCurve: Curves.linear,
        ),
        blueAnim = CurvedAnimation(
          parent: animation,
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),
        super(repaint: animation);

  final Animation<double> liquidAnim;
  final Animation<double> blueAnim;
  final Animation<double> greyAnim;
  final Animation<double> orangeAnim;

  final Paint bluePaint;
  final Paint grey;
  final Paint orangePaint;

  void PaintBlue(Canvas canvas, Size size)
  {
    final path = Path();
    path.moveTo(size.width, size.height/2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0,0);
    path.lineTo(
      0,
      lerpDouble(0, size.height, blueAnim.value)!.toDouble(),
    );
    _addPoint(path, [
      Point(
         lerpDouble(0, size.width/3, blueAnim.value)!.toDouble(),
        lerpDouble(0, size.height, blueAnim.value)!.toDouble(),
      ),
      Point(
        lerpDouble(size.width/2, size.width/ 4*3, liquidAnim.value)!.toDouble(),
        lerpDouble(size.height / 2, size.height / 4*3, liquidAnim.value)!.toDouble(),
      ),
      Point(
        size.width,
        lerpDouble(size.height/2, size.height/ 4*3, liquidAnim.value)!.toDouble(),
      ),
    ]);
    canvas.drawPath(path, grey);
  }

  void PaintGrey(Canvas canvas, Size size)
  {
    final path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
        0,
        lerpDouble(size.height/4, size.height/2, greyAnim.value)!.toDouble(),
    );
    _addPoint(path, [
      Point(
        size.width/4,
        lerpDouble(size.height/2, size.height * 3/4, liquidAnim.value)!.toDouble(),
      ),
      Point(
        size.width * 3/5,
        lerpDouble(size.height / 4, size.height / 2, liquidAnim.value)!.toDouble(),
      ),
      Point(
        size.width * 4/5,
        lerpDouble(size.height/6, size.height/ 3, greyAnim.value)!.toDouble(),
      ),
      Point(
        size.width,
        lerpDouble(size.height/5, size.height/ 4, greyAnim.value)!.toDouble(),
      ),
    ]);
    canvas.drawPath(path, orangePaint);
  }
  void PaintOrange(Canvas canvas, Size size)
  {
    if(orangeAnim.value > 0)
      {
        final path = Path();
        path.moveTo(size.width * 3/4, 0);
        path.lineTo(0, 0);
        path.lineTo(0,
            lerpDouble(0, size.height/12, orangeAnim.value)!.toDouble()
        );
        _addPoint(path, [
          Point(
            size.width/7,
            lerpDouble(0, size.height/6, liquidAnim.value)!.toDouble(),
          ),
          Point(
            size.width/3,
            lerpDouble(0, size.height / 10, liquidAnim.value)!.toDouble(),
          ),
          Point(
            size.width / 3*2,
            lerpDouble(0, size.height/ 8, liquidAnim.value)!.toDouble(),
          ),
          Point(
            size.width * 3/4,
            0,
          ),
        ]);
        canvas.drawPath(path, bluePaint);
      }
  }
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    //print("painting");
    PaintBlue(canvas, size);
    PaintGrey(canvas, size);
    PaintOrange(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  void _addPoint(Path path, List<Point> points)
  {
    if(points.length<3)
      {
        throw UnsupportedError("Need three or more");
      }

    for(var i=0; i<points.length-2; i++)
      {
        final xc = (points[i].x + points[i+1].x) /2;
        final yc = (points[i].y + points[i+1].y) /2;
        path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
      }
    path.quadraticBezierTo(
      points[points.length - 2].x,
      points[points.length - 2].y,
      points[points.length - 1].x,
      points[points.length - 1].y,
    );
  }
}

class Point {
  final double x;
  final double y;
  Point(this.x, this.y);
}

class SpringCurve extends Curve
{
  const SpringCurve({this.a = 0.15, this.w = 19.4});

  final double a;
  final double w;

  @override
  double transform(double t) {
    // TODO: implement transform
    return (-(pow(e, -t/a) * cos(t*w)) + 1).toDouble();
  }
}
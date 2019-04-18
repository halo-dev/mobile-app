import 'dart:ui';

import 'package:flutter/material.dart';

class CustomViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomViewPageState();
}

class CustomViewPageState extends State<CustomViewPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _doubleAnimation;
  AnimationController _controller;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _doubleAnimation = Tween(begin: 0.0, end: 360.0).animate(_controller);

    _controller.addListener(() {
      this.setState(() {});
    });
    onAnimationStart();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text('自定义View'),
        ),
      body: Container(
        color: Colors.cyan,
        width: 100.0,
        height: 100.0,
        margin: EdgeInsets.all(8.0),
        child: CustomPaint(
          child: Center(
              child: Text((_doubleAnimation.value / 3.6).round().toString())),
              painter:

              LabelViewPainter(
                labelColor: Colors.redAccent,
                labelAlignment: LabelAlignment.leftTop,
                useAngle: true,)//书角标
          ),
        ),
      ));
  }

  void onAnimationStart() {
    _controller.forward(from: 0.0);
  }

  @override
  void reassemble() {
    super.reassemble();
    onAnimationStart();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class LinePainter extends CustomPainter {
  Paint _paint = new Paint()
    ..color = Colors.blueAccent
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 5.0
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(100.0, 100.0), 50.0, _paint);
    canvas.drawColor(Colors.red, BlendMode.colorDodge);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class LabelViewPainter extends CustomPainter {
  Paint _paint;
  final Color labelColor;
  final int labelAlignment;
  final bool useAngle;

  LabelViewPainter({
                     this.labelColor = Colors.blue,
                     this.labelAlignment = LabelAlignment.leftTop,
                     this.useAngle = false,
                   })
  {
    _paint = Paint()
      ..color = labelColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 5.0
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print(size);

    Path path = new Path();
    drawThisPath(size, path);
    path.close();
    canvas.drawPath(path, _paint);
  }

  void drawThisPath(
      Size size,
      Path path,
      ) {
    switch (labelAlignment) {
      case LabelAlignment.leftTop:
        if (useAngle) {
//          path.moveTo(0.0, size.height / 2);
          path.lineTo(size.width / 2, 0.0);
        }
        path.lineTo(size.width, 0.0);
        path.lineTo(0.0, size.height);

        break;
      case LabelAlignment.leftBottom:
        if (useAngle) {
          path.lineTo(0.0, size.height / 2);
          path.lineTo(size.width / 2, size.height);
        }
        path.lineTo(size.width, size.height);
        path.lineTo(0.0, 0.0);
        break;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class LabelAlignment {
  int labelAlignment;

  LabelAlignment(this.labelAlignment);

  static const leftTop = 0;
  static const leftBottom = 1;
  static const rightTop = 2;
  static const rightBottom = 3;
}

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ProgressBarCircularPage extends StatefulWidget {
  const ProgressBarCircularPage({Key? key}) : super(key: key);

  @override
  _ProgressBarCircularPageState createState() =>
      _ProgressBarCircularPageState();
}

class _ProgressBarCircularPageState extends State<ProgressBarCircularPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double porcentaje = 0.0;
  double nuevoPorcentaje = 0.0;

  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));

    controller.addListener(() {
      setState(() {
        porcentaje = lerpDouble(porcentaje, nuevoPorcentaje, controller.value)!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            porcentaje = nuevoPorcentaje;
            nuevoPorcentaje += 10;

            if (porcentaje > 100) {
              porcentaje = 0;
              nuevoPorcentaje = 10;
            }
            controller.forward(from: 0.0);
            setState(() {});
          },
          child: Icon(
            Icons.refresh,
          ),
          backgroundColor: Colors.pink,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(5),
            width: 300,
            height: 300,
            child: CustomPaint(
              painter: _MyRadialProgress(porcentaje),
            ),
          ),
        ));
  }
}

class _MyRadialProgress extends CustomPainter {
  final porcentaje;
  _MyRadialProgress(this.porcentaje);

  @override
  //Circulo completado
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..strokeWidth = 4
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    Offset center = new Offset(size.width * 0.5, size.height / 2);
    double radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, paint);
    //Arco
    final paintArco = new Paint()
      ..strokeWidth = 10
      ..color = Colors.pink
      ..style = PaintingStyle.stroke;

    //Parte que se debería ir llenando
    double arcAngle = 2 * pi * (porcentaje / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paintArco);

    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

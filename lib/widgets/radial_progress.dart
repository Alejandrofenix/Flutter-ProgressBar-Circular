import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final porcentaje;

  const RadialProgress({this.porcentaje});
  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double porcentajeAnterior;

  @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, child) {
        return Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
          child: CustomPaint(
            painter: _MyRadialProgress((widget.porcentaje - diferenciaAnimar) +
                (diferenciaAnimar * controller.value)),
          ),
        );
      },
    );
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

import 'package:flutter/material.dart';
import 'package:progressbar_circular/widgets/radial_progress.dart';

class GraficasCircularesPage extends StatefulWidget {
  @override
  _GraficasCircularesPageState createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {
  double porcentaje = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              porcentaje += 10;
              if (porcentaje > 100) porcentaje = 0;
            });
          },
          child: Icon(Icons.refresh)),
      body: Center(
          child: Container(
        width: 300,
        height: 300,
        child: RadialProgress(porcentaje: porcentaje),
      )),
    );
  }
}

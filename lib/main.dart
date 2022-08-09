import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        seriesList: [
          charts.Series<PiePiece, String>(
            id: "Test",
            domainFn: (piece, index) => piece.text,
            measureFn: (PiePiece piece, _) => piece.value,
            labelAccessorFn: (PiePiece piece, _) => '${piece.value.round()}',
            colorFn: (PiePiece piece, _) => piece.color,
            data: [
              PiePiece(
                'started',
                20,
                charts.Color.fromHex(code: "#44FF44"),
              ),
              PiePiece(
                'paused',
                2,
                charts.Color.fromHex(code: "#CCCCCC"),
              ),
              PiePiece(
                'stopped',
                1,
                charts.Color.fromHex(code: "#FF6666"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.seriesList}) : super(key: key);

  final List<charts.Series<PiePiece, String>> seriesList;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 253, //outsideLabel is missing when height is < 254
              child: charts.PieChart<String>(
                widget.seriesList,
                animate: false,
                defaultRenderer: charts.ArcRendererConfig(
                  arcWidth: 40,
                  // startAngle: pi / 2,
                  arcRendererDecorators: [
                    charts.ArcLabelDecorator(
                      outsideLabelStyleSpec: charts.TextStyleSpec(
                        color: charts.Color.fromHex(code: "#000000"),
                        fontSize: 15,
                      ),
                      labelPosition: charts.ArcLabelPosition.outside,
                    )
                  ],
                ),
                behaviors: [
                  charts.DatumLegend(
                    position: charts.BehaviorPosition.start,
                    horizontalFirst: false,
                    cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PiePiece {
  PiePiece(
    this.text,
    this.value,
    this.color,
  );
  String text;
  double value;
  charts.Color color;
}

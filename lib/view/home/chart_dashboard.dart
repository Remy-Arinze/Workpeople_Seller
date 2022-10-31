import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/chart_service.dart';

class ChartDashboard extends StatefulWidget {
  const ChartDashboard({Key? key}) : super(key: key);

  @override
  _ChartDashboardState createState() => _ChartDashboardState();
}

class _ChartDashboardState extends State<ChartDashboard> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartService>(
      builder: (context, provider, child) => Stack(
        children: <Widget>[
          provider.chartDataListMap.isNotEmpty
              ? AspectRatio(
                  aspectRatio: 1.70,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        // color: Color(0xff232d37)
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 18.0, left: 12.0, top: 24, bottom: 12),
                      child: LineChart(
                        mainData(provider.chartDataListMap),
                      ),
                    ),
                  ),
                )
              : Container(),
          // SizedBox(
          //   width: 60,
          //   height: 34,
          //   child: TextButton(
          //     onPressed: () {
          //       setState(() {
          //         showAvg = !showAvg;
          //       });
          //     },
          //     child: Text(
          //       'avg',
          //       style: TextStyle(
          //           fontSize: 12,
          //           color:
          //               showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget bottomTitleWidgets(double value, TitleMeta meta,m) {
  //   const style = TextStyle(
  //     color: Color(0xff68737d),
  //     fontWeight: FontWeight.bold,
  //     fontSize: 12,
  //   );
  //   Widget text;
  //   switch (value.toInt()) {
  //     case 0:
  //       text = Text(monthName[0], style: style);
  //       break;
  //     case 1:
  //       text = const Text('Feb', style: style);
  //       break;
  //     case 2:
  //       text = const Text('Mar', style: style);
  //       break;
  //     case 3:
  //       text = const Text('Apr', style: style);
  //       break;
  //     case 4:
  //       text = const Text('May', style: style);
  //       break;
  //     case 5:
  //       text = const Text('Jun', style: style);
  //       break;
  //     case 6:
  //       text = const Text('Jul', style: style);
  //       break;
  //     case 7:
  //       text = const Text('Aug', style: style);
  //       break;
  //     case 8:
  //       text = const Text('Sep', style: style);
  //       break;
  //     case 9:
  //       text = const Text('Oct', style: style);
  //       break;
  //     case 10:
  //       text = const Text('Nov', style: style);
  //       break;
  //     case 11:
  //       text = const Text('Dec', style: style);
  //       break;
  //     default:
  //       text = const Text('', style: style);
  //       break;
  //   }

  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     space: 8.0,
  //     child: text,
  //   );
  // }

  // Widget leftTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     color: Color(0xff67727d),
  //     fontWeight: FontWeight.bold,
  //     fontSize: 15,
  //   );
  //   String text;
  //   switch (value.toInt()) {
  //     case 1:
  //       text = '10K';
  //       break;
  //     case 3:
  //       text = '30k';
  //       break;
  //     case 5:
  //       text = '50k';
  //       break;
  //     default:
  //       return Container();
  //   }

  //   return Text(text, style: style, textAlign: TextAlign.left);
  // }

  LineChartData mainData(monthAndValue) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            // color: const Color(0xff37434d),
            color: Colors.grey.withOpacity(.2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            // color: const Color(0xff37434d),
            color: Colors.grey.withOpacity(.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (double value, TitleMeta meta) {
              const style = TextStyle(
                color: Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              );
              Widget text;
              switch (value.toInt()) {
                case 0:
                  text = Text(monthAndValue[0]['monthName'], style: style);
                  break;
                case 1:
                  text = Text(monthAndValue[1]['monthName'], style: style);
                  break;
                case 2:
                  text = Text(monthAndValue[2]['monthName'], style: style);
                  break;
                case 3:
                  text = Text(monthAndValue[3]['monthName'], style: style);
                  break;
                case 4:
                  text = Text(monthAndValue[4]['monthName'], style: style);
                  break;
                case 5:
                  text = Text(monthAndValue[5]['monthName'], style: style);
                  break;
                case 6:
                  text = Text(monthAndValue[6]['monthName'], style: style);
                  break;
                case 7:
                  text = Text(monthAndValue[7]['monthName'], style: style);
                  break;
                case 8:
                  text = Text(monthAndValue[8]['monthName'], style: style);
                  break;
                case 9:
                  text = Text(monthAndValue[9]['monthName'], style: style);
                  break;
                case 10:
                  text = Text(monthAndValue[10]['monthName'], style: style);
                  break;
                case 11:
                  text = Text(monthAndValue[11]['monthName'], style: style);
                  break;
                default:
                  text = const Text('', style: style);
                  break;
              }

              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 8.0,
                child: text,
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            // getTitlesWidget: leftTitleWidgets,
            reservedSize: 10,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(
              // color: const Color(0xff37434d),
              color: Colors.grey.withOpacity(.3),
              width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, monthAndValue[0]['orders']),
            FlSpot(1, monthAndValue[1]['orders']),
            FlSpot(2, monthAndValue[2]['orders']),
            FlSpot(3, monthAndValue[3]['orders']),
            FlSpot(4, monthAndValue[4]['orders']),
            FlSpot(5, monthAndValue[5]['orders']),
            FlSpot(6, monthAndValue[6]['orders']),
            FlSpot(7, monthAndValue[7]['orders']),
            FlSpot(8, monthAndValue[8]['orders']),
            FlSpot(9, monthAndValue[9]['orders']),
            FlSpot(10, monthAndValue[10]['orders']),
            FlSpot(11, monthAndValue[11]['orders']),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}

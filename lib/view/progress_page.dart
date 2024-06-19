import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'custom_appbar.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  List<Color> gradientColors = [
    Colors.red,
    Colors.green,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: Column(
          children: [
            const CustomAppBar(titleTxt: "Progress",showNotificationIcon: false,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width - 30,
                child: LineChart(
                          showAvg ? avgData() : mainData(),
                        ),
              ),
            ),
            Row(children: [Column(children: [const Text('Low'),Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                width: 15,height: 15,
                decoration: const BoxDecoration(color: Colors.red,shape: BoxShape.circle),
                ),
            )],),
            Column(children: [const Text('Low-Moderate'),Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                width: 15,height: 15,
                decoration: const BoxDecoration(color: Colors.orange,shape: BoxShape.circle),
                ),
            )],),],),
            
            // Stack(
            //   children: <Widget>[
            //     AspectRatio(
            //       aspectRatio: 1.70,
            //       child: Padding(
            //         padding: const EdgeInsets.only(
            //           right: 18,
            //           left: 12,
            //           top: 24,
            //           bottom: 12,
            //         ),
            //         child: LineChart(
            //           showAvg ? avgData() : mainData(),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 60,
            //       height: 34,
            //       child: TextButton(
            //         onPressed: () {
            //           setState(() {
            //             showAvg = !showAvg;
            //           });
            //         },
            //         child: Text(
            //           'avg',
            //           style: TextStyle(
            //             fontSize: 12,
            //             color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text =  Container(
          color: Colors.grey.shade700,
          child: Column(children: [
            Text('Oct 4'),
            Image.asset("assets/images/Dermatolgist6.png",height: 60,width:40,fit: BoxFit.fitHeight,),
            Text('21%'),
          ],),
        );
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }


  Widget topTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
       
      case 2:
        text =  Column(children: [
          Text('Oct 4'),
          Image.asset("assets/images/Dermatolgist6.png",height: 60,width:40,fit: BoxFit.fitHeight,),
          Text('21%'),
        ],);
        break;
      case 5:
        text =  Column(children: [
          Text('Oct 4'),
          Image.asset("assets/images/Dermatolgist6.png",height: 60,width:40,fit: BoxFit.fitHeight,),
          Text('35%'),
        ],);
        break;
      case 8:
        text =  Column(children: [
          Text('Oct 4'),
          Image.asset("assets/images/Dermatolgist6.png",height: 60,width:40,fit: BoxFit.fitHeight,),
          Text('38%'),
        ],);
        break;
      case 11:
        text =  Column(children: [
          Text('Oct 4'),
          Image.asset("assets/images/Dermatolgist6.png",height: 60,width:40,fit: BoxFit.fitHeight,),
          Text('32%'),
        ],);
        break;
      case 13:
        text =  Column(children: [
          Text('Oct 4'),
          Image.asset("assets/images/Dermatolgist6.png",height: 60,width:40,fit: BoxFit.fitHeight,),
          Text('32%'),
        ],);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.black,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 110,
            getTitlesWidget: topTitleWidgets,
            interval: 1,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.transparent//const Color(0xff37434d)
          ),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          show: true,
          spots: const [
            FlSpot(0, 3),
            FlSpot(2, 2),
            FlSpot(4.9, 5),
            // FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            // FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          axisNameWidget: const Icon(Icons.abc,color: Colors.white,),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
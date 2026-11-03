import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ChernPetHospital/app.dart';

class chartsview1 extends StatelessWidget {
  Widget bottomTitles1(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '00';
        break;
      case 1:
        text = '02';
        break;
      case 2:
        text = '04';
        break;
      case 3:
        text = 'PD';
        break;

      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: const TextStyle(fontSize: 10)),
    );
  }

  Widget leftTitles1(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }

    return SideTitleWidget(
      meta: meta,
      child: Text(meta.formattedValue, style: const TextStyle(fontSize: 10)),
    );
  }

  List<BarChartGroupData> getData1(double barsWidth, double barsSpace) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(glo_netsale[0]["net_sale00"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale00"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(glo_netsale[0]["net_sale02"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale02"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(glo_netsale[0]["net_sale04"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale04"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(glo_netsale[0]["net_salePD"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_salePD"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
    ];
  }

  const chartsview1({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isFolded
          ? const EdgeInsets.symmetric(horizontal: 100)
          : const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: Colors.blueAccent,
          style: BorderStyle.solid,
        ),
      ),

      child: Center(
        child: AspectRatio(
          aspectRatio: 1, // 1.66,
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final barsSpace = 4.0 * constraints.maxWidth / 100; //400;
                final barsWidth = 8.0 * constraints.maxWidth / 50; // 400;
                return BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.center,
                    barTouchData: const BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 20,
                          getTitlesWidget: bottomTitles1,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: leftTitles1,
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      checkToShowHorizontalLine: (value) => value % 10 == 0,
                      getDrawingHorizontalLine: (value) =>
                          const FlLine(color: Colors.black, strokeWidth: 1),
                      drawVerticalLine: false,
                    ),
                    borderData: FlBorderData(show: false),
                    groupsSpace: barsSpace,
                    barGroups: getData1(barsWidth, barsSpace),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

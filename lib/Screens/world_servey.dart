import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:practivecovid19/Model/WorldModel.dart';
import 'package:practivecovid19/Services/services.dart';
import 'package:practivecovid19/Screens/country_statistic.dart';

class WorldScreen extends StatefulWidget {
  const WorldScreen({super.key});

  @override
  State<WorldScreen> createState() => _WorldHaveState();
}

class _WorldHaveState extends State<WorldScreen> with TickerProviderStateMixin {

  //colorlist

  late final AnimationController controller=AnimationController
    (
      vsync: this,
      duration: Duration(seconds: 3))..repeat();
  AllService service=AllService();
  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
         child: Padding(
           padding: const EdgeInsets.all(20),
           child: Column(
             children: [
               FutureBuilder<WorldModel>
                 (future: service.fetchWorld(),
                   builder: (context,snapshot)
               {
                 if(snapshot.hasData){
                   var list=snapshot.data!;
                   return Column(
                     children: [
                       PieChart(

                         chartValuesOptions: ChartValuesOptions(
                           showChartValuesInPercentage: true,
                         ),
                         dataMap: {
                         "Total": double.parse(list.cases.toString()),
                         "Recovary":double.parse(list.recovered.toString()),
                         "Today Recovary": double.parse(list.todayRecovered.toString())
                       },
                         animationDuration: Duration(milliseconds: 1200),
                         chartType: ChartType.ring,
                         legendOptions:LegendOptions(
                             legendPosition: LegendPosition.left
                         ),
                         chartRadius: MediaQuery.of(context).size.width/3.2,
                         colorList: colorList,
                       ),
                       SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                       Card(
                         color: Color(0xAB5A5A57),
                         child: Padding(
                           padding: const EdgeInsets.all(10),
                           child: Column(
                             children: [
                               RowNow(title: "Total", id: list.cases.toString()),
                               RowNow(title: "Recovary", id: list.recovered.toString()),
                               RowNow(title: "Today Recovary", id: list.todayRecovered.toString()),
                               RowNow(title: "Populations", id: list.population.toString()),
                               RowNow(title: "Updated", id: list.updated.toString()),
                               RowNow(title: "Case", id: list.todayCases.toString()),
                             ],
                           ),
                         ),
                       ),
                       SizedBox(height: 10),
                       GestureDetector(
                         onTap:(){Navigator
                         .push(context, MaterialPageRoute(builder: (context)=>CountryStatistic()));
                           },
                         child: Container(
                           height: 50,
                           child: Center(child: Text("Tra country")),
                           decoration: BoxDecoration(
                               color: Colors.blue,
                               borderRadius: BorderRadius.circular(10)
                           ),
                         ),
                       )
                     ],
                   );
                 }
                 else{
                   return Expanded(
                     flex: 4,
                     child: SpinKitCircle(
                       color: Colors.grey,
                       size: 50,
                       controller: controller,
                     ),
                   );
                 }
               }),
             ],
           ),
         )
     ),
    );
  }
}
class RowNow extends StatelessWidget {
  String title;
  String id;
  RowNow({super.key,required this.title,required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(id)
          ],
        ),
        SizedBox(height: 20),
        Divider()
      ],
    );
  }
}

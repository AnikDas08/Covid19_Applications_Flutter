import 'package:flutter/material.dart';
import 'package:practivecovid19/Screens/world_servey.dart';

class DetailScreen extends StatefulWidget {
  String name,image;
  int totalCases,totalRecovary,todayRecovary,population,updated;
  DetailScreen({required this.name,required this.image,required this.totalCases,required this.totalRecovary,required this.todayRecovary,required this.population,required this.updated});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment:Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.1),
                child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*.067),
                          RowNow(title: "Total", id: widget.totalCases.toString()),
                          RowNow(title: "Recovary", id: widget.totalRecovary.toString()),
                          RowNow(title: "Today Recovary", id: widget.todayRecovary.toString()),
                          RowNow(title: "Populations", id: widget.population.toString()),
                          RowNow(title: "Updated", id: widget.updated.toString()),
                        ],
                                        ),
                    ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}

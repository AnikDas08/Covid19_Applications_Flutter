
import 'package:flutter/material.dart';
import 'package:practivecovid19/Screens/seceenDetails.dart';
import 'package:practivecovid19/Services/services.dart';
import 'package:shimmer/shimmer.dart';

class CountryStatistic extends StatefulWidget {
  CountryStatistic({super.key});

  @override
  State<CountryStatistic> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountryStatistic> {
  TextEditingController controller=TextEditingController();

  AllService service=AllService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("All country"),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller,
              textAlign: TextAlign.left,
              onChanged: (value) {
                setState(() {

                });
              },
              decoration: InputDecoration(
                hintText: "Search Here",
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder<List<dynamic>>(
                  future: service.fetchCountry(),
                  builder: (context,snapshot){
                    var list=snapshot.data;
                    if(snapshot.connectionState==ConnectionState.waiting){//if there is data coming
                      return _buildShimmerEffect();
                    }
                    else if(snapshot.hasData){//if there is data
                      return
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(//show the data in list view image,name
                            itemCount: list!.length,
                              itemBuilder: (context,index){
                              String name=snapshot.data![index]["country"];
                              if(controller.text.isEmpty){//for search have no text
                                return
                                  countryList(list, index);
                              }
                              else if(name.toLowerCase().contains(controller.text.toLowerCase())){//for search
                                return
                                  countryList(list,index);
                              }
                              else{
                                return Container();
                              }

                              }),
                        );
                    }else{
                      return Text("Loading");
                    }

                  }))
        ],
      ),
    );
  }
  Widget countryList(data,index){
    return Column(
      children: [
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
              name: data[index]["country"],
              image: data[index]["countryInfo"]["flag"],
              totalCases: data[index]["cases"],
              totalRecovary: data[index]["recovered"],
              todayRecovary: data[index]["todayRecovered"],
              population: data[index]["population"],
              updated: data[index]["updated"],
            )));
          },
          child: ListTile(
            leading: Image(
              image: NetworkImage(
                  data[index]["countryInfo"]["flag"]
              ),
              width: 50,
              height: 50,
            ),
            title: Text(data[index]["country"]),
            subtitle: Text(data[index]["cases"].toString()),
          ),
        )
      ],
    );
  }
}
Widget _buildShimmerEffect() {
  return ListView.builder(
    itemCount: 10, // Show 10 shimmer items while loading
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: [
              // 🔹 Circular Avatar Placeholder
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              SizedBox(width: 10),
              // 🔹 Text Placeholder
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    width: 100,
                    color: Colors.white,
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 10,
                    width: 50,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

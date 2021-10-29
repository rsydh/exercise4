import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:rusydiahex4/Person.dart';
//import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wanted List',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State <MyHomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'People List'
        )
      ),
      body:
      Center(
        child: Container(
          child: FutureBuilder(
            future: readJsonData(),
            builder: (context,data) {
              if(data.hasError){
                return Center(
                  child: Text("${data.error}"),
                );
              }else if(data.hasData){
                var items = data.data as List<Person>;
                return ListView.builder(
                    itemCount: items == null ? 0: items.length,
                    itemBuilder: (context,index){
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(horizontal: 10,
                            vertical: 6),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                child: Image(
                                  image: NetworkImage(
                                    items[index].avatar == null
                                        ? 'https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg'
                                        : items[index].avatar.toString(),
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Expanded(child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left:18,right:8),
                                      child: Text(
                                        items[index].firstname.toString()
                                            +" "+ items[index].lastname.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 18,right:8),
                                      child: Text(
                                        items[index].username.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),),
                                    Padding(padding: EdgeInsets.only(left:18,right:8),
                                      child: Text(
                                        items[index].status == null? 'Status' :
                                        items[index].status.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ),
                              Expanded(child: Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 8,right:8),
                                      child: Text(items[index].lastseen.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    //Padding(padding: EdgeInsets.only(left:8,right:8),
                                    CircleAvatar(
                                      child: Text(items[index].message == null? '0'
                                            : items[index].message.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),))
                                  ],
                                ),
                              ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),

      )

    );
  }
//fetch data
  Future<List<Person>>readJsonData() async{
    final jsondata =
    await rootBundle.rootBundle.loadString('jsonfile/MOCK_DATA.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Person.fromJson(e)).toList();
  }
}
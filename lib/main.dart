import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search App',
      home:new HomeScreen()
    );
  }
}

class HomeScreen extends StatelessWidget {

        Future<List<User>> _getUsers() async{
      final String url="http://www.mocky.io/v2/5d13b91c0e000041c8b4a782";
      var data=await http.get(url);
      var jsonData=json.decode(data.body);
      List<User> users = [];
      for (var u in jsonData)
      {
        User user=User(u["id"],u["name"],u["houseno"],u["phoneno"]);
        users.add(user);
      }
      print(users.length);
      return users;
    }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          leading: new IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: () {
              print('it will ready now');
            }, // null disables the button
          ),
           title: Text('Search App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: (){
                showSearch(context: context,delegate: DataSearch());
              },
            ),
          ],
        ),
        body:myBody(),
        drawer: Drawer(),
    );
  }
}
        
       /* body: Center(
          child: Text('Hello World'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_a_photo),
          onPressed: (){
            print("photo object pressed");
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          color:Colors.blue[400],
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.menu), onPressed: () {},),
              IconButton(icon: Icon(Icons.search), onPressed: () {},),
            ],
          ),
        ),*/

class myBody extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}


  Widget _myListView(BuildContext context)
  {

Future<List<User>> _getUsers() async{
      final String url="http://www.mocky.io/v2/5d13b91c0e000041c8b4a782";
      var data=await http.get(url);
      var jsonData=json.decode(data.body);
      List<User> users = [];
      for (var u in jsonData)
      {
        User user=User(u["id"],u["name"],u["houseno"],u["phoneno"]);
        users.add(user);
      }
      print(users.length);
      return users;
    }


    return Container(
          child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context , AsyncSnapshot snapshot){
              if(snapshot.data==null){
                return Container(
                  child:Center(
                    child:Text("Loading.."))
                );
              }
              else{
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context,int index){
                    return ListTile(
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].houseno),
                      onTap: () => launch("tel://"+snapshot.data[index].phoneno),
                    );
                  },
                );
              }
            },
            ),

        );

        /*
     final cities = ["Albania", "Andorra", "Armenia", "Austria",
    "Azerbaijan", "Belarus", "Belgium", "Bosnia and Herzegovina", "Bulgaria",
    "Croatia", "Cyprus", "Czech Republic", "Denmark", "Estonia", "Finland",
    "France", "Georgia", "Germany", "Greece", "Hungary", "Iceland", "Ireland",
    "Italy", "Kazakhstan", "Kosovo", "Latvia", "Liechtenstein", "Lithuania",
    "Luxembourg", "Macedonia", "Malta", "Moldova", "Monaco", "Montenegro",
    "Netherlands", "Norway", "Poland", "Portugal", "Romania", "Russia",
    "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden",
    "Switzerland", "Turkey", "Ukraine", "United Kingdom", "Vatican City"];
    return ListView.separated(
    itemCount: cities.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: Icon(Icons.location_city),
        title: Text(cities[index].toUpperCase()),

        /* onTap: () {
          print(europeanCountries[index]);
        },*/
        onTap: () => launch("tel://+919846676792"),
      );
    },
    separatorBuilder: (context, index) {
      return Divider();
    },
  );*/


  }
class User{
  final int id;
  final String name;
  final String houseno;
  final String phoneno;
  User(this.id,this.name,this.houseno,this.phoneno);
}

class DataSearch extends SearchDelegate<String>{






    final cities = ["Albania", "Andorra", "Armenia", "Austria",
    "Azerbaijan", "Belarus", "Belgium", "Bosnia and Herzegovina", "Bulgaria",
    "Croatia", "Cyprus", "Czech Republic", "Denmark", "Estonia", "Finland",
    "France", "Georgia", "Germany", "Greece", "Hungary", "Iceland", "Ireland",
    "Italy", "Kazakhstan", "Kosovo", "Latvia", "Liechtenstein", "Lithuania",
    "Luxembourg", "Macedonia", "Malta", "Moldova", "Monaco", "Montenegro",
    "Netherlands", "Norway", "Poland", "Portugal", "Romania", "Russia",
    "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden",
    "Switzerland", "Turkey", "Ukraine", "United Kingdom", "Vatican City"];
  
  final recentCities = ["Albania", "Andorra"];

  @override
  List<Widget> buildActions(BuildContext context)
  {
    return[
      IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        query = "";
      })
      ];
  }
  @override
  Widget buildLeading(BuildContext context)
  {
    return IconButton(
      icon: AnimatedIcon(
        icon:AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        });
  }
  @override
  Widget buildResults(BuildContext context)
  {
    
  }
  @override
  Widget buildSuggestions(BuildContext context)
  {
    

    final suggestionList= query.isEmpty ? recentCities : cities.where((p)=>p.toUpperCase().startsWith(query.toUpperCase())).toList();
//.where((p) => p.contains(query)).toList();
  
   return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.location_city),
          title: Text(suggestionList[index].toUpperCase()),
        ),
      
      /*separatorBuilder: (context, index) {
        return Divider();
      },*/
    );
    
    
    return ListView.separated(
    itemCount: suggestionList.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: Icon(Icons.location_city),
        title: Text(suggestionList[index].toUpperCase()),

        /* onTap: () {
          print(europeanCountries[index]);
        },*/
        onTap: () => launch("tel://+919846676792"),
      );
    },
    separatorBuilder: (context, index) {
      return Divider();
    },
  );
  }
}
/*
[
    {
        "id": 0,
        "name": "A",
        "houseno": "1",
        "phoneno":"99999"
  },
  {
        "id": 1,
        "name": "B",
    	"houseno": "2",
    	"phoneno":"99911"
  }
]*/
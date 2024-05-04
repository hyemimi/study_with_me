import 'package:flutter/material.dart';
import 'package:study_with_me/service/api_service.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';
import 'package:study_with_me/models/coins.dart';

class AlarmScreen extends StatefulWidget {
  AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  late Future<List<WebtoonModel>> coins;

  @override
  void initState() {
    super.initState();
    coins = ApiService().getCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
        ),
        body: FutureBuilder(
          future: coins,
          builder: (context, AsyncSnapshot snapshot) {
            print(snapshot);
            if (snapshot.hasData) {
              return Center(
                  child: ListView.builder(itemBuilder: (context, index) {
                var coin = snapshot.data![index];
                return Text(coin.title);
              }));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

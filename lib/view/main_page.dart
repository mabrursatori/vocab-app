import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vocab_app/model/monster.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Hive.openBox("monsters"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                var monstersBox = Hive.box("monsters");
                if (monstersBox.length == 0) {
                  monstersBox.add(Monster("Vampire", 1));
                  monstersBox.add(Monster("Jelly Guardian", 5));
                }
                return ValueListenableBuilder(
                  valueListenable: monstersBox.listenable(),
                  builder: (BuildContext context, Box<dynamic> value,
                      Widget? child) {
                    return Container(
                      margin: EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: monstersBox.length,
                        itemBuilder: (context, index) {
                          Monster monster = monstersBox.getAt(index);
                          return Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(3, 3),
                                  blurRadius: 6),
                            ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(monster.name +
                                    " [" +
                                    monster.level.toString() +
                                    "]"),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.trending_up),
                                      color: Colors.green,
                                      onPressed: () {
                                        monstersBox.putAt(
                                            index,
                                            Monster(monster.name,
                                                monster.level + 1));
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.content_copy),
                                      color: Colors.amber,
                                      onPressed: () {
                                        monstersBox.add(Monster(
                                            monster.name, monster.level));
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.redAccent,
                                      onPressed: () {
                                        monstersBox.deleteAt(index);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

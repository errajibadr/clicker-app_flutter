import 'dart:async';

import 'package:clicker_app/model/result_manager.dart';

import 'generated/l10n.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String playername = '';
  late TextEditingController name;
  final ResultManager gameManager = ResultManager();
  // List<Result> listofResults = [
  //   Result(playerName: 'Cedric', score: 40),
  //   Result(playerName: 'Cedric', score: 45),
  //   Result(playerName: 'Cedric', score: 49),
  //   Result(playerName: 'Badr', score: 47)
  // ];

  @override
  void initState() {
    //
    super.initState();
    name = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: const Text(' clicker Game ')),
        body: FutureBuilder(
          future: gameManager.getdata(),
          builder: (context, snapshopt) {
            if (snapshopt.hasData || snapshopt.hasError) {
              return game_screen(context);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }

  Column game_screen(BuildContext context) {
    return Column(
      children: [
        TextField(
          enabled: !gameManager.isGameinProgress(),
          controller: name,
          decoration: InputDecoration(
              icon: const Icon(Icons.person),
              label: Text(S.of(context).homepage_namefield)),
          onChanged: (value) {
            setState(() {
              playername = value;
            });
          },
        ),
        if (!gameManager.isGameinProgress())
          ElevatedButton(
              onPressed: () {
                setState(() {
                  if (name.text != '') {
                    gameManager.startGame(playername);
                    Timer(const Duration(seconds: 3), endGame);
                  } else {
                    showDialog(
                        context: context,
                        builder: (ctxt) {
                          return AlertDialog(
                            title: Text(S.of(context).homepage_nouserwarning),
                          );
                        });
                  }
                });
              },
              child: const Text('Start clicking')),
        if (gameManager.isGameinProgress())
          Text(
              S.of(context).homepage_score(gameManager.currentRes?.score ?? 0)),
        if (gameManager.isGameinProgress())
          TextButton(onPressed: addScore, child: const Icon(Icons.add)),
        hallOfFame(),
      ],
    );
  }

  Widget hallOfFame() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(' Hall of Fame '),
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width / 2,
            child: ListView.separated(
                itemBuilder: (buildctx, index) {
                  return ListTile(
                    leading: Text((index + 1).toString()),
                    title: Text(gameManager.previousgames[index].playerName),
                    trailing:
                        Text(gameManager.previousgames[index].score.toString()),
                  );
                },
                separatorBuilder: (buildctx, index) => const Divider(),
                itemCount: gameManager.previousgames.length),
          ),
        ],
      ),
    );
  }

  void addScore() {
    setState(() {
      gameManager.currentRes?.scoredPoint();
    });
  }

  void endGame() {
    setState(() {
      gameManager.endGame();
      showDialog(
          context: context,
          builder: (ctxt) {
            return const AlertDialog(
              title: Text('Partie terminée'),
            );
          });
    });
  }
}

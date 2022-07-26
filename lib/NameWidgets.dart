import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});
  @override
  State<Saved> createState() => _Saved();
}

class _Saved extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    globals.saved.sort((a, b) => a.IsBoy && !b.IsBoy ? -1 : 1);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Names"),
      ),
      body: globals.saved.isEmpty
          ? Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "No Saved Names",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.of(context).popUntil(
                  (route) => route.isFirst,
                ),
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: globals.saved.length * 2,
              itemBuilder: (context, i) {
                if (i.isOdd) {
                  return const Divider();
                }
                final index = i ~/ 2;

                return ListTile(
                  title: Text(
                    globals.saved[index].Name.toString(),
                    style: globals.font,
                  ),
                  trailing: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    semanticLabel: 'Remove?',
                  ),
                  tileColor: (globals.saved[index].IsBoy)
                      ? Colors.blue.shade50
                      : Colors.pink.shade50,
                  onTap: () {
                    setState(() {
                      globals.saved.removeAt(index);
                    });
                  }, //on tap
                );
              }, //item builder
            ),
    );
  }
}

class Names extends StatefulWidget {
  const Names({super.key});
  @override
  State<Names> createState() => _Names();
}

class _Names extends State<Names> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: globals.boy ? Colors.blue : Colors.pink,
          title: Text(globals.boy ? "Boy Names" : "Girl Names"),
          actions: [
            IconButton(
                icon: const Icon(Icons.list),
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Saved()),
                  );
                  setState(() {});
                },
                tooltip: "Saved Names"),
          ],
        ),
        body: ListView.builder(
          itemCount: globals.boy
              ? globals.allBoyNames.length * 2
              : globals.allGirlNames.length * 2,
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();

            final index = i ~/ 2;
            final names =
                globals.boy ? globals.allBoyNames : globals.allGirlNames;
            final isBoy = globals.allBoyNames.contains(names[index]);
            final alreadySaved =
                globals.saved.contains(globals.Names(names[index], isBoy));
            return ListTile(
              title: Text(
                names[index],
                style: globals.font,
              ),
              trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
                semanticLabel: alreadySaved ? 'Remove?' : 'Save?',
              ),
              onTap: () {
                setState(() {
                  alreadySaved
                      ? globals.saved.remove(globals.Names(names[index], isBoy))
                      : globals.saved
                          .add(globals.Names(names[index], globals.boy));
                });
              }, //on tap
            );
          }, //item builder
        ));
  }
}

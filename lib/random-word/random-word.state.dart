import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'random-words.dart';

class RandomWordsState extends State<RandomWords> {
  static const NUM_VALUES = 10;
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return Row(children: <Widget>[
      IconButton(
          icon: Icon(Icons.menu), tooltip: 'Navigation menu', onPressed: null),
      Expanded(
        child: Text(
          pair.asPascalCase,
          style: _biggerFont,
          textDirection: TextDirection.ltr,
        ),
      ),
      IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Olá!'),
                    content: Text(
                        "You have clicked ${pair.asPascalCase.toString()} !"),
                    actions: <Widget>[
                      new FlatButton(
                          child: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                    ],
                  );
                });
          }),
      IconButton(
          icon: Icon(
            alreadySaved ? Icons.star : Icons.star_border,
            color: alreadySaved ? Colors.red : null,
          ),
          tooltip: 'Save',
          onPressed: () {
            setState(() {
              alreadySaved ? _saved.remove(pair) : _saved.add(pair);
            });
          }),
    ]);
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(NUM_VALUES));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text('Name Generator', textDirection: TextDirection.ltr),
              ),
              IconButton(
                icon: Icon(Icons.list),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    final Iterable<ListTile> tiles = _saved.map((pair) {
                      return ListTile(
                        title: Text(pair.asPascalCase),
                      );
                    });
                    return Scaffold(
                        appBar: AppBar(
                          title: Row(
                            children: <Widget>[Expanded(child: Text('List'))],
                          ),
                        ),
                        body: ListView(
                            children: ListTile.divideTiles(
                                    context: context, tiles: tiles)
                                .toList()));
                  }));
                },
              ),
              IconButton(
                icon: Icon(Icons.power_settings_new),
                onPressed: () {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Bye'),
                          content:
                              Text('The finish button has no effect (yet)'),
                          actions: <Widget>[
                            new FlatButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(),
        child: _buildSuggestions(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: () {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Hello'),
                  content: Text('The add button has no effect (yet)'),
                  actions: <Widget>[
                    new FlatButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                );
              });
        },
      ),
    );
  }
}

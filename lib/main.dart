import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoppie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(10, 36, 55, 1),
      ),
      home: WordList(),
    );
  }
}

class WordList extends StatefulWidget {
  WordList({Key key}) : super(key: key);
  @override
  _State createState() => _State();
}

class StrikeThrough extends StatelessWidget {
  final String listItem;
  final bool listCheck;
  StrikeThrough(this.listItem, this.listCheck) : super();

  Widget _striket() {
    if (listCheck) {
      return Text(listItem,
          style: TextStyle(
            decoration: TextDecoration.lineThrough,
            fontStyle: FontStyle.normal,
            fontSize: 18.0,
            color: Colors.lightBlueAccent[700],
          ));
    } else {
      return Text(listItem, style: TextStyle(fontSize: 18.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _striket();
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem {
  String listItem;
  bool listCheck;
  ListItem(this.listItem, this.listCheck);
}

class _State extends State<WordList> with TickerProviderStateMixin {
  final List<ListItem> listitems = <ListItem>[];

  bool completed = false;
  var counter = 0;
  var textController = TextEditingController();
  var popUpTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  TextEditingController listController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shoppie'),
        backgroundColor: Color.fromRGBO(10, 36, 55, 1),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: listController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Add Item',
            ),
          ),
        ),
        RaisedButton(
          onPressed: () {
            if (listController.text.isNotEmpty) {
              listitems.add(new ListItem(listController.text, false));
              setState(() {
                listController.clear();
              });
            }
          },
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color.fromRGBO(10, 36, 55, 1),
                  Color.fromRGBO(10, 36, 55, 1),
                  Color.fromRGBO(10, 36, 55, 1),
                ],
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: const Text('Add Items to list'),
          ),
        ),
        Expanded(
          child: ReorderableListView(
            children: <Widget>[
              for (final items in listitems)
                GestureDetector(
                  key: Key(items.listItem),
                  child: Dismissible(
                    key: Key(items.listItem),
                    child: CheckboxListTile(
                      value: items.listCheck,
                      title: StrikeThrough(items.listItem, items.listCheck),
                      onChanged: (checkValue) {
                        setState(() {
                          if (!checkValue) {
                            items.listCheck = false;
                          } else {
                            items.listCheck = true;
                          }
                        });
                      },
                    ),
                  ),
                )
            ],
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                var replaceList = listitems.removeAt(oldIndex);
                listitems.insert(newIndex, replaceList);
              });
            },
          ),
        ),
      ]),
    );
  }

// about developer
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('About the Developer'),
              backgroundColor: Color.fromRGBO(10, 36, 55, 1),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromRGBO(10, 36, 55, 1),
                          Color.fromRGBO(10, 36, 55, 1),
                        ])),
                    child: Container(
                      width: double.infinity,
                      height: 350.0,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://scontent-iad3-1.xx.fbcdn.net/v/t1.0-9/73318959_3607242515959917_2599841144191844352_n.jpg?_nc_cat=103&_nc_sid=e3f864&_nc_eui2=AeF-x0rZ6GnvZvugEQnrlQg81Hj2qQkL0lbUePapCQvSVjs0ft9_GNHLuhqZT_UhxpoizOjri9DCunv9KOM9ol0p&_nc_ohc=BfR1UJFg4uAAX837uAs&_nc_ht=scontent-iad3-1.xx&oh=6358110a9499f2ed8868844a728a7be1&oe=5F92DB00",
                              ),
                              radius: 60.0,
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            Text(
                              "Akeem A. Shaw",
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Software Engineer",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Bio:",
                          style: TextStyle(
                              color: Colors.indigo.shade900,
                              fontStyle: FontStyle.normal,
                              fontSize: 22.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "  My Name is Akeem Shaw, I am a future Software Engineer and a final year student of Northern Caribbean University Where I am doing a Bsc in Computer Science."
                          "My skills include: Java, Java script, HTML5, CSS, Php, Laravel, React.js, C# .NetCore, C++. I use tools such as webDev , Node.js, gitHub, gitBash Adnorid studio,"
                          "visual studio ,Visual Studio Code, phpStorm to create web applications and Mobile. I am currently learning Flutter and I intend to build my skills and be able to"
                          "create beautiful apllications in the near future.\n\n"
                          "  Two Projects that I have worked on includes a career service web application developed for the usage of the students of the Northern Caribbean University to make"
                          "the process of job searching easier this application begon developing in febuary 2020 and now is at its final stages. Another application is a website for a international"
                          "company called Opendoor Christian Religious Counselling for which the application allowed users to make appointment, make payment and donate to the organization, both applications "
                          "were developed using laravel 7.",
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

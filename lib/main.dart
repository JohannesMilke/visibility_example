import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final String title = 'Visibility Example';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.green),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final key = GlobalKey<ScaffoldState>();

  bool isVisible = true;
  bool isTransparent = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        key: key,
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            buildBox(text: 'None', color: Colors.grey),
            const SizedBox(height: 16),
            Visibility(
              visible: isVisible,
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                child: buildBox(text: 'Visibilty', color: Colors.pink),
              ),
            ),
            IgnorePointer(
              ignoring: isTransparent,
              child: Opacity(
                opacity: isTransparent ? 0 : 1,
                child: buildBox(text: 'Opacity', color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            buildBox(text: 'None', color: Colors.grey),
            const SizedBox(height: 24),
            buildButton(
              text: 'Toggle Visibility',
              color: Colors.pink,
              onClicked: () => setState(() => isVisible = !isVisible),
            ),
            const SizedBox(height: 16),
            buildButton(
              text: 'Toggle Opacity',
              color: Colors.blue,
              onClicked: () => setState(() => isTransparent = !isTransparent),
            ),
          ],
        ),
      );

  Widget buildBox({
    @required String text,
    @required Color color,
  }) =>
      GestureDetector(
        onTap: () {
          final snackBar = SnackBar(
            padding: EdgeInsets.symmetric(vertical: 8),
            backgroundColor: color,
            content: Text(
              '$text is clickable!!',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          );

          key.currentState
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
        },
        child: Container(
          width: double.infinity,
          height: 80,
          color: color,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

  Widget buildButton({
    @required String text,
    @required Color color,
    @required VoidCallback onClicked,
  }) =>
      RaisedButton(
        color: color,
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        onPressed: onClicked,
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(vertical: 16),
      );
}

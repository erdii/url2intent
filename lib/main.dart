import "package:flutter/material.dart";
import "package:android_intent_plus/android_intent.dart";
import "dart:io" show Platform;
import "package:flutter/services.dart";

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "url2intent",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: "url2intent"),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final inputController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputController.dispose();
    super.dispose();
  }

  void _createIntent() {
    if (Platform.isAndroid) {
      AndroidIntent intent =
          AndroidIntent(action: "action_view", data: inputController.text);
      intent.launch();
    }
  }

  void _handlePaste() {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      inputController.text = value?.text ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 10,
                    controller: inputController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Enter a url."),
                  ),
                ))
          ],
        ),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: FloatingActionButton(
            onPressed: _handlePaste,
            tooltip: "Paste",
            child: const Icon(Icons.paste),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 2),
          child: FloatingActionButton(
            onPressed: _createIntent,
            tooltip: "Create Intent",
            child: const Icon(Icons.send),
          ),
        ),
      ]),
    );
  }
}

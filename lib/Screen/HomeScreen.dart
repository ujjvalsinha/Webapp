import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * .04),
        child: AppBar(
          leading: InkWell(
            child: Container(
              margin: EdgeInsets.only(bottom: 2),
              child: Icon(Icons.arrow_back_ios),
            ),
            onTap: () {
              if (webView != null) {
                webView.goBack();
                print("Back to privies page");
              }
              //flutterWebviewPlugin.goBack(); // for going back
            },
          ),

          backgroundColor: Colors.grey,
          title: Container(
            margin: EdgeInsets.only(left: size.width * .12),
            child: Text("Browser App"),
          ),
          centerTitle: false,
          elevation: 1, // give the appbar shadows
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            InkWell(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(Icons.refresh),
              ),
              onTap: () {
                if (webView != null) {
                  webView.reload();
                  print("Refreshing page");
                }
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          InAppWebView(
            initialUrl: "https://flutter.dev/",
            initialHeaders: {},
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              print("Website is loading");
              webView = controller;
            },
            onLoadStart: (InAppWebViewController controller, String url) {
              setState(
                () {
                  this.url = url;
                },
              );
            },
            onLoadStop: (InAppWebViewController controller, String url) async {
              print("Website loaded succesfully");
              setState(
                () {
                  this.url = url;
                },
              );
            },
            onProgressChanged:
                (InAppWebViewController controller, int progress) {
              setState(
                () {
                  this.progress = progress / 100;
                },
              );
            },
          ),
          progress < 1.0
              ? Center(
                  child: loader(),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget loader() {
    return CupertinoActivityIndicator(
      radius: 20,
    );
  }
}

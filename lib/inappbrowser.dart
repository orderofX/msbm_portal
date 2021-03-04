import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:flutter/foundation.dart';

class MyAP extends StatefulWidget {
  @override
  _MyAPState createState() => new _MyAPState();
}

class _MyAPState extends State<MyAP> {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;
  InAppWebViewController webViewController;
  bool showErrorPage = false;

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Are you sure?',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(27),
                fontFamily: 'Circular STD',
                color: Color.fromRGBO(173, 0, 0, 1),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            content: new Text(
              'Do you want to exit MSBM',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(22),
                fontFamily: 'Circular STD',
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  "NO",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(25),
                    fontFamily: 'Circular STD',
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 16,
                width: 50,
              ),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text(
                  "YES",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(25),
                    fontFamily: 'Circular STD',
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 16,
                width: 70,
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);

    printScreenInformation();
    return new WillPopScope(
        onWillPop: _onBackPressed,
        child: MaterialApp(
          theme: ThemeData(accentColor: Color.fromRGBO(173, 0, 0, 1)),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Container(
              padding: EdgeInsets.fromLTRB(0, 32, 0, 0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent)),
                    child: InAppWebView(
                      initialUrl: 'https://portal.msbm.org.uk?mapwa=v1/',
                      initialOptions: InAppWebViewGroupOptions(
                          crossPlatform: InAppWebViewOptions(
                        debuggingEnabled: false,
                        useOnDownloadStart: true,
                      )),
                      onWebViewCreated: (InAppWebViewController controller) {
                        webViewController = controller;
                      },

                      ///      onLoadError: (InAppWebViewController controller,
                      ///           String url, int i, String s) async {
                      ///       print('CUSTOM_HANDLER: $i, $s');

                      ///      webViewController.loadFile(
                      ///          assetFilePath: "assets/index.html");
                      ///       },
                      ///        onLoadHttpError: (InAppWebViewController controller,
                      ///           String url, int i, String s) async {
                      ///       print('CUSTOM_HANDLER: $i, $s');

                      ///       webViewController.loadFile(
                      ///        assetFilePath: "assets/index.html");
                      ///     },
                      onLoadError: (InAppWebViewController controller,
                          String url, int code, String message) async {
                        print("error $url: $code, $message");

                        //  var tRexHtml = await controller.getTRexRunnerHtml();
                        // var tRexCss = await controller.getTRexRunnerCss();

                        controller.loadData(data: """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<style>
    body{
        font-family: Arial, Helvetica, sans-serif;
        margin: 0;
        padding: 0;
    }
    .issues-screen-response-sect{
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        text-align: center;
    }

    .container{
        padding-left: 15px;
        padding-right: 15px;
    }

    .btn{
        display: inline-block;
        font-weight: 400;
        color: #212529;
        text-align: center;
        vertical-align: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        background-color: transparent;
        border: 1px solid transparent;
        padding: .375rem .75rem;
        font-size: 1rem;
        line-height: 1.5;
        border-radius: .25rem;
        transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out
    }

    .btn-main{
        background-color: #ad0000;
        color: #fff;
    }

    .btn-block{
        width: 100%;
    }

    .img-fluid{
        max-width: 100%;
        height: auto;
    }
</style>
<body>
    <div class="issues-screen-response-sect">
        <div class="container">
            <div class="issues-responses">
                <!-- <img src="img/no-internet.png" class="img-fluid" width="100" /> -->
                <h2>Failed to Load</h2>
                <p> Make sure Wi-Fi or cellular data is turned on, then try again.</p>
                <!-- <button class="btn btn-main btn-block">Retry</button> -->
            </div>
        </div>
    </div>
</body>
</html>
                  """);
                      },
                      onLoadHttpError: (InAppWebViewController controller,
                          String url,
                          int statusCode,
                          String description) async {
                        print("HTTP error $url: $statusCode, $description");
                      },

                      onLoadStart:
                          (InAppWebViewController controller, String url) {
                        setState(() {
                          this.url = url;
                        });
                      },
                      onLoadStop: (InAppWebViewController controller,
                          String url) async {
                        setState(() {
                          this.url = url;
                        });
                      },
                      onProgressChanged:
                          (InAppWebViewController controller, int progress) {
                        setState(() {
                          this.progress = progress / 100;
                        });
                      },
                      onDownloadStart: (controller, url) async {
                        print("onDownloadStart $url");

                        final taskId = await FlutterDownloader.enqueue(
                          url: url,
                          savedDir: (await getExternalStorageDirectory()).path,
                          showNotification: true,
                          openFileFromNotification: true,
                        );
                        print(taskId);
                      },
                    ),
                  ),
                  Container(
                    width: 1000.w,
                    height: 90.h,
                    color: Colors.white,
                    child: Row(
                      //  alignment: MainAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 90.h,
                          width: 190.w,
                          child: RaisedButton.icon(
                            elevation: 0,
                            color: Colors.white,
                            onPressed: () {
                              if (webViewController != null) {
                                webViewController.goBack();
                              }
                            },
                            icon: Icon(Icons.arrow_back_ios),
                            label: Text(
                              'Back',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(25),
                                fontFamily: 'Circular STD',
                                color: Colors.black,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70.w,
                        ),
                        Container(
                            padding: EdgeInsets.all(10.0),
                            child: progress < 1.0
                                ? CircularProgressIndicator(value: progress)
                                : Container()),
                        SizedBox(
                          width: 70.w,
                        ),
                        Container(
                          width: 260.w,
                          height: 90.h,
                          child: RaisedButton.icon(
                            elevation: 0,
                            color: Colors.white,
                            icon: Icon(Icons.av_timer),

                            onPressed: () {
                              if (webViewController != null) {
                                webViewController.loadUrl(
                                    url:
                                        "https://portal.msbm.org.uk?mapwa=v1/");
                              }
                            },

                            ///    onPressed: _launchURL,
                            label: Text(
                              'Dashboard',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(25),
                                fontFamily: 'Circular STD',
                                color: Colors.black,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void showError() {
    setState(() {
      showErrorPage = false;
    });
  }

  void hideError() {
    setState(() {
      showErrorPage = false;
    });
  }

  void printScreenInformation() {
    print('Device width dp:${ScreenUtil().screenWidth}');
    print('Device height dp:${ScreenUtil().screenHeight}');
    print('Device pixel density:${ScreenUtil().pixelRatio}');
    print('Bottom safe zone distance dp:${ScreenUtil().bottomBarHeight}');
    print('Status bar height px:${ScreenUtil().statusBarHeight}dp');
    print(
        'Ratio of actual width dp to design draft px:${ScreenUtil().scaleWidth}');
    print(
        'Ratio of actual height dp to design draft px:${ScreenUtil().scaleHeight}');
    print(
        'The ratio of font and width to the size of the design:${ScreenUtil().scaleWidth * ScreenUtil().pixelRatio}');
    print(
        'The ratio of  height width to the size of the design:${ScreenUtil().scaleHeight * ScreenUtil().pixelRatio}');
    print('System font scaling:${ScreenUtil().textScaleFactor}');
    print('0.5 times the screen width:${0.5.sw}');
    print('0.5 times the screen height:${0.5.sh}');
  }
}

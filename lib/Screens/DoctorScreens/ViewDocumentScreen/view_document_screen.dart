// import 'package:flutter/material.dart';
//
// class ViewDocumentScreen extends StatelessWidget {
//   const ViewDocumentScreen({
//     super.key,
//     required this.url
//   });
//
//   final String url;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: WebView(
//           // initialUrl: "https://wlbet.com/",
//           initialUrl: url,
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController webViewController){
//             webViewController = webViewController;
//           },
//           // navigationDelegate: (NavigationRequest request){
//             // if(request.url.contains("upi://pay")){
//             //   log("page enter");
//             //   // launchUrlStart(url: request.url.toString());
//             //   return NavigationDecision.navigate;
//             // }else{
//             //   // _launchURL(request.url);
//             //   return NavigationDecision.prevent;
//             // }
//           // },
//         ),
//       ),
//     );
//   }
// }

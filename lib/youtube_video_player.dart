import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YouTubeInContainer extends StatefulWidget {
  const YouTubeInContainer({super.key});

  @override
  State<YouTubeInContainer> createState() => _YouTubeInContainerState();
}

class _YouTubeInContainerState extends State<YouTubeInContainer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.loadHtmlString(_generateHtml("QUx1anKHYuI"));
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          debugPrint('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (String url) {
          debugPrint('Page started loading: $url');
        },
        onPageFinished: (String url) {
          debugPrint('Page finished loading: $url');
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            debugPrint('blocking navigation to ${request.url}');
            String videoId = extractVideoId(request.url) ?? "QUx1anKHYuI";
            _controller.loadHtmlString(_generateHtml(videoId));
            return NavigationDecision.prevent;
          }
          debugPrint('allowing navigation to ${request.url}');
          return NavigationDecision.navigate;
        },
        onHttpError: (HttpResponseError error) {
          debugPrint('Error occurred on page: ${error.response?.statusCode}');
        },
        onUrlChange: (UrlChange change) {
          debugPrint('url change to ${change.url}');
        },
        onHttpAuthRequest: (HttpAuthRequest request) {},
      ),
    );
  }

  String _generateHtml(String videoId) {
    return '''
    <!DOCTYPE html>
    <html>
    <head>
        <style>
            body {
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #FFFFFF;
            }
        </style>
    </head>
    <body>
        <iframe
            id="ytplayer"
            type="text/html"
            width="100%"
            height="30%"
            src="https://www.youtube.com/embed/$videoId?autoplay=0&controls=1&rel=1&modestbranding=1"
            frameborder="0"
            allowfullscreen
        ></iframe>
    </body>
    </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Promilo Task"),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}

String? extractVideoId(String url) {
  try {
    final uri = Uri.parse(url);
    return uri.queryParameters['v'];
  } catch (e) {
    return null;
  }
}

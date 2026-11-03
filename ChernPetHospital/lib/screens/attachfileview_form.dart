import 'package:docx_viewer/docx_viewer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class attachfileview extends StatefulWidget {
  final String FilePath, FileExtension;

  const attachfileview({
    Key? key,
    required this.FilePath,
    required this.FileExtension,
  }) : super(key: key);

  @override
  State<attachfileview> createState() => _attachfileviewState();
}

class _attachfileviewState extends State<attachfileview> {
  // final viewerUrl = widget.FilePath;

  WebViewController get controller => WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(widget.FilePath));

  Widget _previewtype(String FileExts) {
    if (FileExts == 'pdf') {
      return SfPdfViewer.network(widget.FilePath);
    } else if (FileExts == 'doc' || FileExts == 'docx') {
      return DocxView(
        filePath: widget.FilePath,
        fontSize: 18, // Optional: Adjust the font size
        onError: (error) {
          print('Error: $error');
        },
      );
    } else if (FileExts == 'xls' || FileExts == 'xlsx') {
      //   widget.FilePath,
      // );
      // readExcelFromUrl(widget.FilePath);
      return WebViewWidget(controller: controller);
    } else {
      return Center(
        child: InteractiveViewer(
          // Set min and max scale for zoom levels
          minScale: 0.1,
          maxScale: 4.0,
          // Enable pinch to zoom and pan gestures by default
          child: Image.network(
            widget.FilePath, // Replace with your image URL
            fit: BoxFit.cover, // Adjust how the image is fitted into the box,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "AttactFile Viewer",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.share), onPressed: () {}),
        // ],
      ),
      body: _previewtype(widget.FileExtension),
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewScreen extends StatefulWidget {
  @override
  _PdfViewScreenState createState() => new _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String pathPDF = "";

   //move to controller
 Future<File> createFileOfPdfUrl() async {
    final url = "https://www.scribendi.com/whitepapers/101_Free_Online_Journal_and_Research_Databases_for_Academics_Free_Resource.pdf";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  void initState(){
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdf viewer Demo'),
      ),  
      body: Center(
        child: RaisedButton(
          child: Text("Open PDF URL"),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)),
          ),
        ),
      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context){
    print("this screen");
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text('Demo Document'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){},
          ),
        ],
      ),
      path: pathPDF,
    );
  }
}

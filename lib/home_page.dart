import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pdf = pw.Document();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pdf.addPage(
    
      pw.Page(
        pageFormat: PdfPageFormat(58, 40),
        build: (context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Container(
                  height: 20,
                  width: 29,
                  child: pw.Container(
                    alignment: pw.Alignment.center,
                    child: pw.BarcodeWidget(
                      barcode: pw.Barcode.ean13(),
                      data: "123456789123",
                      textStyle: pw.TextStyle(fontSize: 3),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Networking Printer..."),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Uint8List data = await pdf.save();
          await Printing.layoutPdf(
            onLayout: (format) => data,
          );
        },
        child: Icon(Icons.download),
      ),
      body: Center(
        child: Container(
          height: 200,
          child: SfBarcodeGenerator(
            value: "www.google.com",
            symbology: QRCode(),
            showValue: true,

          ),
        ),
      ),
    );
  }
}


// pw.Container(
//                   height: 150,
//                   child: pw.BarcodeWidget(
//                     barcode: pw.Barcode.qrCode(),
//                     data: "www.google.com",
//                   ),
//                 ),
        
//                 pw.SizedBox(
//                   height: 100
//                 ),
//                 
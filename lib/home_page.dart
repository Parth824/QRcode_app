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
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Container(
                  height: 150,
                  child: pw.BarcodeWidget(
                    barcode: pw.Barcode.qrCode(),
                    data: "www.freelancer.com",
                  ),
                ),

                pw.SizedBox(
                  height: 100
                ),
                pw.Container(
                  height: 100,
                  width: 250,
                  child: pw.BarcodeWidget(
                    barcode: pw.Barcode.code128(),
                    data: "www.freelancer.com",
                    
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
            value: 'www.google.com',
            symbology: QRCode(),
            showValue: true,
          ),
        ),
      ),
    );
  }
}

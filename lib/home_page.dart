import 'dart:math';

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
        pageFormat: PdfPageFormat(58, 40).landscape,
        // orientation: pw.PageOrientation.natural,

        build: (context) {
          return pw.Padding(
            padding: pw.EdgeInsets.all(10),
            child: pw.Container(
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                // crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Column(children: [
                    pw.Transform.translate(
                      offset: PdfPoint(5, -3),
                      child: pw.Transform.rotate(
                        angle: pi / 2,
                        child: pw.Text(
                          "QAZAX UCUZLUQ",
                          style: pw.TextStyle(
                            fontSize: 2,
                          ),
                        ),
                      ),
                    ),
                  ]),
                  pw.Transform.translate(
                    offset: PdfPoint(-7.5, 4),
                    child: pw.Transform.rotate(
                      angle: pi / 2,
                      child: pw.Container(
                        height: 10,
                        width: 20,
                        child: pw.Container(
                          child: pw.BarcodeWidget(
                            barcode: pw.Barcode.ean13(),
                            data: "2603871760301",
                            textStyle: pw.TextStyle(
                              fontSize: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  pw.Transform.translate(
                    offset: PdfPoint(-19, 1.2),
                    child: pw.Transform.rotate(
                      angle: pi / 2,
                      child: pw.Text(
                        "Vanna Sobahan",
                        style: pw.TextStyle(
                          fontSize: 2,
                        ),
                      ),
                    ),
                  ),
                  pw.Transform.translate(
                    offset: PdfPoint(-30.5, 4),
                    child: pw.Transform.rotate(
                      angle: pi / 2,
                      child: pw.Text(
                        "3.40        AZN",
                        style: pw.TextStyle(
                          fontSize: 3,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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

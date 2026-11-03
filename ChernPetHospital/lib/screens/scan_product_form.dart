import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class scan_product extends StatefulWidget {
  const scan_product({super.key});

  @override
  State<scan_product> createState() => _MobileScannerSimpleState();
}

class _MobileScannerSimpleState extends State<scan_product> {
  Barcode? _barcode;
  String barcodeResult = '';

  MobileScannerController controller = MobileScannerController();

  // Widget _barcodePreview(Barcode? value) {
  //   if (value == null || value == '') {
  //     return const Text(
  //       'Scan ....!',
  //       overflow: TextOverflow.fade,
  //       style: TextStyle(color: Colors.white),
  //     );
  //   }

  //   return Text(
  //     value.displayValue ?? 'No display value.',
  //     overflow: TextOverflow.fade,
  //     style: const TextStyle(color: Colors.white),
  //   );
  // }

  // Future<void> _handleBarcode(BarcodeCapture barcodes) async {
  //   if (mounted) {
  //     _barcode = await barcodes.barcodes.firstOrNull;
  //     barcodeResult = _barcode!.displayValue!;

  //     setState(() {
  //       if (barcodeResult == '') {
  //         print(barcodeResult);
  //       } else {
  //         controller.stop(); // Stop the camera
  //         controller.dispose(); // Release resources
  //         Navigator.pop(context, barcodeResult);
  //       }
  //     });
  //   }
  // }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      _barcode = barcodes.barcodes.firstOrNull;
      barcodeResult = _barcode!.displayValue!;

      setState(() {
        if (barcodeResult == '') {
          print(barcodeResult);
        } else {
          controller.stop(); // Stop the camera
          controller.dispose(); // Release resources
          Navigator.pop(context, barcodeResult);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Scan Barcode",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        actions: const [],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(onDetect: _handleBarcode),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              //  child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // children: [
              //   Expanded(child: Center(child: _barcodePreview(_barcode))),
              // ],
              //    ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanDialog extends StatefulWidget {
  final void Function(String)? onScan;
  const ScanDialog({Key? key, this.onScan}) : super(key: key);

  @override
  State<ScanDialog> createState() => _ScanDialogState();
}

class _ScanDialogState extends State<ScanDialog> {
  String? scanResult;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Scan For Search',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Scan Booking Confirmation\nHere!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 32),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: MobileScanner(
                      fit: BoxFit.cover,
                      onDetect: (capture) {
                        final barcode = capture.barcodes.first;
                        if (barcode.rawValue != null) {
                          setState(() {
                            scanResult = barcode.rawValue;
                          });
                          if (widget.onScan != null) widget.onScan!(barcode.rawValue!);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  scanResult ?? 'No result',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Positioned(
            top: 12, 
            right: 12,
            child: IconButton(
              icon: const Icon(Icons.close, size: 24),
              onPressed: () => Navigator.of(context).pop(),
              splashRadius: 24,
            ),
          ),
        ],
      ),
    );
  }
}

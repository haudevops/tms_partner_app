import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/logs/logger.dart';
import 'package:tms_partner_app/utils/screen_util.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key, required this.arguments}) : super(key: key);
  static const routeName = '/ScanPage';

  final ScreenArguments arguments;

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  Barcode? result;
  QRViewController? _controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Function(String?) _onScanner;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller?.pauseCamera();
    }
    _controller?.resumeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _onScanner = widget.arguments.arg1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(),
          Positioned(
            bottom: ScreenUtil.getInstance().getHeight(130),
            left: ScreenUtil.getInstance().getWidth(70),
            right: ScreenUtil.getInstance().getWidth(70),
            child: Text(
              'Di chuyển camera đến vùng chứa mã code cần quét',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil.getInstance().getSp(14)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView() {
    var scanArea = _checkScreen() ? 150.0 : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 2,
          borderLength: 30,
          borderWidth: 2,
          overlayColor: Color(0xFF808080),
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this._controller = controller;
    });
    _controller?.scannedDataStream.listen((scanData) {
      _controller?.pauseCamera();
      _onScanner(scanData.code);
      Navigator.pop(context);
    });
  }

  void _onPermissionSet(
      BuildContext context, QRViewController ctrl, bool permission) {
    DebugLog.show('_onPermissionSet $permission');
    if (!permission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bạn chưa cấp quyền!')),
      );
    }
  }

  bool _checkScreen() {
    return (ScreenUtil.getInstance().screenWidth < 400 ||
        ScreenUtil.getInstance().screenHeight < 400);
  }
}

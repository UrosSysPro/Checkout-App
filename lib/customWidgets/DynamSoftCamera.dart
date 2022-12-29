import 'package:check_out_app/AppState.dart';
import 'package:check_out_app/customWidgets/AddReceiptPopUp.dart';
import 'package:check_out_app/customWidgets/CameraReaderWidget.dart';
import 'package:check_out_app/customWidgets/ExpandableSearch.dart';
import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';

class DynamSoftCamera extends StatefulWidget {
  DynamSoftCamera({ Key? key }) : super(key: key);

  @override
  DynamSoftCameraState createState() => DynamSoftCameraState();
}

class DynamSoftCameraState extends State<DynamSoftCamera> with WidgetsBindingObserver {
  late final DCVBarcodeReader _barcodeReader;
  late final DCVCameraEnhancer _cameraEnhancer;
  final DCVCameraView _cameraView = DCVCameraView();
  bool popUpOpened=false;

  List<BarcodeResult> decodeRes = [];
  String? resultText;
  String? base64ResultText;
  bool faceLens = false;
  bool isTorchOn=false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _sdkInit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraEnhancer.close();
    _barcodeReader.stopScanning();
    super.dispose();
  }

  void _sdkInit() async {
    // Create a barcode reader instance.
    _barcodeReader = await DCVBarcodeReader.createInstance();
    _cameraEnhancer = await DCVCameraEnhancer.createInstance();
    // Get the current runtime settings of the barcode reader.
    DBRRuntimeSettings currentSettings =
        await _barcodeReader.getRuntimeSettings();
    currentSettings.barcodeFormatIds = EnumBarcodeFormat.BF_QR_CODE;
    currentSettings.minResultConfidence = 70;
    // currentSettings.minBarcodeTextLength = 50;
    currentSettings.expectedBarcodeCount = 1;
    await _barcodeReader.updateRuntimeSettings(currentSettings);
    _cameraEnhancer.setScanRegion(Region(
        regionTop: 0,
        regionLeft: 0,
        regionBottom: 100,
        regionRight: 100,
        regionMeasuredByPercentage: 1));

    await _barcodeReader.enableResultVerification(true);

    _barcodeReader.receiveResultStream().listen((List<BarcodeResult>? res) {
      if (mounted&&popUpOpened==false&&res!=null) {
        showLoadingMenu(res[0].barcodeText);
      }
    });

    await _cameraEnhancer.open();

    _barcodeReader.startScanning();
  }

  @override
  Widget build(BuildContext context) {
    return _cameraView;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _barcodeReader.startScanning();
        _cameraEnhancer.open();
        break;
      case AppLifecycleState.inactive:
        _cameraEnhancer.close();
        _barcodeReader.stopScanning();
        break;
      default:
        break;
    }
  }

  void toggleTorch(){
    isTorchOn=!isTorchOn;
    if(isTorchOn){
      _cameraEnhancer.turnOnTorch();
    }else{
      _cameraEnhancer.turnOffTorch();
    }
  }

  void showLoadingMenu(String value){
    var appState=context.read<AppState>();
    popUpOpened=true;
    appState.addReceipt(value).then((statusCode){
      if(statusCode==200){
        showAddReceiptPopUp(value);
      }else{
        var text="error:$value";
        if(value==500)text="Nije Qr code sa racuna";
        if(value==409)text="Neko je vec skenirao ovaj racun";
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text(text),
            actions: [ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"))],
          );
        }).then((value) => popUpOpened=false);
      }
    });
  }

  void showAddReceiptPopUp(String value){
    popUpOpened=true;
    var res=showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context, builder: (context){
        return Wrap(
          children: [
            StatefulBuilder(
              builder: (context,setState) {
                return AddReceiptPopUp(receiptUrl: value);
              }
            ),
          ],
        );
      }
    );
    res.whenComplete(() {
      popUpOpened=false;
      context.read<AppState>().loadReceipts();
    });

  }
}
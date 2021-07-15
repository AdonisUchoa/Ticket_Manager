import 'package:flutter/material.dart';
import 'package:ticket_manager/modules/barcode_scanner.dart/barcode_scanner_controller.dart';
import 'package:ticket_manager/modules/barcode_scanner.dart/barcode_scanner_status.dart';
import 'package:ticket_manager/shared/themes/app_colors.dart';
import 'package:ticket_manager/shared/themes/app_text_styles.dart';
import 'package:ticket_manager/shared/widgets/bottom_shett/bottom_sheet_widget.dart';
import 'package:ticket_manager/shared/widgets/set_label_button/set_label_buttons.dart';

class BarcodescannerPage extends StatefulWidget {
  const BarcodescannerPage({Key? key}) : super(key: key);

  @override
  _BarcodePageState createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodescannerPage> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(
          context,
          "/insert_boleto",
          arguments: controller.status.barcode,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.showCamera) {
                return Container(
                  child: controller.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.orange,
                title: Text(
                  "Escanei o código de barras do boleto",
                  style: TextStyles.buttonBackground,
                ),
                centerTitle: true,
                leading: BackButton(
                  color: AppColors.background,
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.black.withOpacity(0.7),
                  )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.transparent,
                      )),
                  Expanded(
                      child: Container(
                    color: Colors.black.withOpacity(0.7),
                  )),
                ],
              ),
              bottomNavigationBar: SetLabelButtons(
                primaryLabel: "Inserir código do boleto",
                primaryOnpressed: () {
                  Navigator.pushReplacementNamed(context, "/insert_boleto");
                },
                secondaryLabel: "Adicionar da galeria",
                secondaryOnpressed: () {},
              ),
            ),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.hasError) {
                return BottomSheetWidget(
                  title: "Não foi possivel identificar um código de barras",
                  subtitle:
                      "Tente escanear novamente ou digite o código do seu boleto",
                  primaryLabel: "Escanear novamente",
                  primaryOnpressed: () {
                    controller.scanWithCamera();
                  },
                  secondaryLabel: "Digitar código",
                  secondaryOnpressed: () {
                    Navigator.pushReplacementNamed(context, "/insert_boleto");
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

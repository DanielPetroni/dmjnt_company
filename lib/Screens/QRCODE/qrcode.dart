import 'package:dmjnt_company/constants.dart';
import 'package:dmjnt_company/controllers/qrController.dart';
import 'package:dmjnt_company/models/Qrcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class QrCodeOne extends StatelessWidget {
  QrCodeOne(this.qr);
  Qrs qr;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              child: QrImage(
                data: qr.qrCode,
                version: QrVersions.auto,
                size: size.height * 0.4,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            GestureDetector(
                child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 5),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'Realizar pagamento!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                onTap: () => QrController().use(
                    id: qr.sId,
                    onSucess: (value) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/confirmado.svg",
                                      height: size.height * .2,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${value['message']}',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                      child: Text(
                                        "Fechar",
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      })
                                ]);
                          });
                    })),
          ],
        ),
      ),
    );
  }
}

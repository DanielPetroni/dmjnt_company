import 'package:dmjnt_company/Screens/QRCODE/qrcode.dart';
import 'package:dmjnt_company/constants.dart';
import 'package:dmjnt_company/controllers/qrController.dart';
import 'package:dmjnt_company/models/Qrcode.dart';
import 'package:dmjnt_company/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class FeedQr extends StatefulWidget {
  FeedQr({this.listQr, this.user});
  List<Qrs> listQr;
  User user;

  @override
  _FeedQrState createState() => _FeedQrState();
}

class _FeedQrState extends State<FeedQr> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/feedlista.svg",
              height: size.height * 0.25),
          SizedBox(height: 5),
          SizedBox(
            height: size.height * 0.58,
            child: ListView.builder(
                itemCount: widget.listQr.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                        title: Row(
                          children: [
                            Text('Criado em:'),
                            SizedBox(width: size.width * 0.05),
                            Column(
                              children: [
                                Text(
                                    '${DateTime.parse(widget.listQr[index].dateCreate).hour}:${DateTime.parse(widget.listQr[index].dateCreate).minute}'),
                                Text(
                                    '${DateTime.parse(widget.listQr[index].dateCreate).day}/${DateTime.parse(widget.listQr[index].dateCreate).month}/${DateTime.parse(widget.listQr[index].dateCreate).year}'),
                              ],
                            ),
                          ],
                        ),
                        leading: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      QrCodeOne(widget.listQr[index]))),
                          child: QrImage(
                            data: widget.listQr[index].qrCode,
                            version: QrVersions.auto,
                            size: 80.0,
                          ),
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.delete, color: kPrimaryColor),
                            onPressed: () {
                              QrController().delete(
                                  id: widget.listQr[index].sId,
                                  userid: widget.user.id,
                                  onSucess: (value) {
                                    setState(() {
                                      widget.listQr.removeAt(index);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/images/deletado.svg",
                                                      height: size.height * .2,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text('Deletado com sucesso!'),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      child: Text(
                                                        "Fechar",
                                                        style: TextStyle(
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      })
                                                ]);
                                          });
                                    });
                                  });
                            })),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

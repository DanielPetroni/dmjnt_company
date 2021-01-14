import 'package:dmjnt_company/Screens/EditUser/editUser_screen.dart';
import 'package:dmjnt_company/Screens/QRCODE/feedQr.dart';
import 'package:dmjnt_company/constants.dart';
import 'package:dmjnt_company/controllers/qrController.dart';
import 'package:dmjnt_company/controllers/userController.dart';
import 'package:dmjnt_company/models/Qrcode.dart';
import 'package:dmjnt_company/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  Homepage({this.user});
  bool used;
  final User user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  List<String> imagens = [
    'dmjnt-novidades.jpeg',
    'linhas-reativadas.jpeg',
    'decreto.jpeg',
    'tarifas.jpeg',
    'manutencao.jpeg',
  ];
  List<Qrs> listQr;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _formKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                height: size.height * 0.3,
                width: size.width,
                child: Stack(children: [
                  Positioned(
                      top: size.height * 0.08,
                      width: size.width * 0.90,
                      left: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Bem vindo, ${widget.user.name}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              icon: Icon(Icons.account_circle,
                                  size: 40, color: Colors.white),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditUserScreen(
                                            user: widget.user,
                                          )))),
                        ],
                      )),
                  Positioned(
                      top: size.height * 0.15,
                      left: 20,
                      child: Text(
                        'Seu saldo atual é de:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  Positioned(
                      top: size.height * 0.20,
                      width: size.width * 0.9,
                      left: 20,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'R\$ ${widget.user.balance.toDouble().toStringAsFixed(2)}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            GestureDetector(
                                child: Text(
                                  'Atualizar saldo',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                                onTap: () {
                                  UserController().getBalance(
                                      id: widget.user.id,
                                      onSucess: (value) {
                                        setState(() {
                                          widget.user.balance =
                                              value['balance'];
                                        });
                                      });
                                })
                          ]))
                ])),
            SizedBox(height: 10),
            Text(
              'QR Code',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => QrController().create(
                    id: widget.user.id,
                    onSucess: (valueCreate) {
                       print(valueCreate);
                      UserController().getBalance(
                          id: widget.user.id,
                          onSucess: (value) {
                            setState(() {
                              widget.user.balance = value['balance'];
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Column(children: [
                                          SvgPicture.asset(
                                            "assets/images/confirmado.svg",
                                            height: size.height * .2,
                                          ),
                                          SizedBox(height: 10),
                                         
                                          Text(valueCreate["message"])
                                        ]),
                                        actions: <Widget>[
                                          FlatButton(
                                              child: Text(
                                                "Fechar",
                                                style: TextStyle(
                                                    color: kPrimaryColor),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              })
                                        ]);
                                  });
                            });
                          });
                    },
                    onFail: (erro) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Column(children: [
                                SvgPicture.asset(
                                  "assets/images/erro.svg",
                                  height: size.height * .2,
                                ),
                                SizedBox(height: 5),
                                Text('${erro["message"]}!',
                                    textAlign: TextAlign.center),
                              ]),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text(
                                      "Fechar",
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ]);
                        },
                      );
                    },
                  ),
                  child: Card(
                      elevation: 5,
                      child: Container(
                        height: size.height * 0.13,
                        width: size.width * 0.4,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add,
                                color: kPrimaryColor, size: size.height * 0.07),
                            Text(' QR Code', style: TextStyle(fontSize: 18)),
                          ],
                        )),
                      )),
                ),
                SizedBox(width: size.width * 0.05),
                GestureDetector(
                  onTap: () => QrController().search(
                      id: '${widget.user.id}',
                      onSucess: (value) {
                        listQr = value;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedQr(
                                      listQr: listQr,
                                      user: widget.user,
                                    )));
                      }),
                  child: Card(
                      elevation: 5,
                      child: Container(
                        height: size.height * 0.13,
                        width: size.width * 0.4,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.list,
                                color: kPrimaryColor, size: size.height * 0.07),
                            Text('Mostrar todos',
                                style: TextStyle(fontSize: 18)),
                          ],
                        )),
                      )),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(
              height: size.height * 0.4,
              child: Swiper(
                  itemHeight: size.height * 0.8,
                  itemWidth: size.width ,
                  layout: SwiperLayout.TINDER,
                  scrollDirection: Axis.horizontal,
                  itemCount: imagens.length,
                  itemBuilder: (contex, index) {
                    return Card(
                        elevation: 5,
                        child: Image.asset(
                          'assets/images/${imagens[index]}',
                          fit: BoxFit.fill,
                        ));
                  }),
            ),
            SizedBox(height: size.height * 0.05),
            Text('Fale conosco',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.01),
            Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading:
                              Icon(Icons.phone_android, color: kPrimaryColor),
                          title: Text('96186-2329'),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: Icon(Icons.phone, color: kPrimaryColor),
                          title: Text('4538-5931'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: Icon(Icons.email, color: kPrimaryColor),
                          title: Text('dmjnt@company.cloud'),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          leading:
                              Icon(Icons.location_on, color: kPrimaryColor),
                          title:
                              Text('Avenida da Saudade, Centro, Itatiba - SP.'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

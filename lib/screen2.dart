import 'dart:math';

import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key, required this.args}) : super(key: key);
  final ScreenArgument args;
  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<CardHorizontal> listHorizontal = [];
  
  @override
  void onAddItem(){
    // neu rong thi khong them vao list
    if(idController.text.isEmpty || usernamesController.text.isEmpty) return;
    setState(() {
      final cardadd = CardHorizontal(card: "assets/images/card.png", idcard: idController.text,username: usernamesController.text,cardInvisible: false);
      listHorizontal.add(cardadd);
    });
    idController.clear();
    usernamesController.clear();
  }
  late final TextEditingController usernamesController;
  late final TextEditingController idController;
  String usernamesValue='';
  String idValue='';
  String? usernamesError;
  String? idError;
  @override
  void initState() {
    // TODO: implement initState
    idController=TextEditingController(text: idValue);
    usernamesController=TextEditingController(text: usernamesValue);
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    usernamesController.dispose();
    idController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Danh sách thẻ"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              //card
              Stack(
                children: <Widget>[
                  Positioned(
                    child:
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Image.asset('assets/images/card.png')),
                  ),
                  Positioned(
                    bottom: 70,
                    left: 30,
                    child: Container(margin: EdgeInsets.only(left: 10), child: Text(idValue,style: TextStyle(fontSize: 40,fontFamily: 'Roboto',color: Colors.white),)),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 30,
                    child: Container(margin: EdgeInsets.only(left: 10), child: Text(usernamesValue,style: TextStyle(fontSize: 20,fontFamily: 'Roboto',color: Colors.white),)),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: idController,
                  onChanged: (String newidvalue) {
                    setState(() {
                      idValue=newidvalue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Card No',
                    errorText: idError,
                    hintText: 'hãy nhập id card của bạn',
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.indigoAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: usernamesController,
                  onChanged: (String value) {
                    setState(() {
                      usernamesValue=value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Fullname',
                    errorText: usernamesError,
                    hintText: 'hãy nhập Username của bạn',
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.indigoAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  //print(usernamesController.text);
                  setState(() {
                    if(idController.text.length>6){
                      onAddItem();
                    }
                    else{
                      idError="id card phải nhiều hơn 6 số";
                    }
                    
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 150),
                  margin: EdgeInsets.all(20),
                  color: Colors.blue,
                  child: Text(
                    'Thêm',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: const Text(
                  "Danh sách thẻ của ",textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  widget.args?.usernameValue ?? "null",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                    height: 120,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        //physics:const NeverScrollableScrollPhysics(),
                        itemCount: listHorizontal.length,
                        itemBuilder: (context, index) {
                        listHorizontal[index].cardNoInvisible =
                        "${listHorizontal[index].idcard.substring(0, 2)}***${listHorizontal[index].idcard.substring(listHorizontal[index].idcard.length - 1)}";
                          return Stack(
                            children: [
                              Positioned(
                                    child:
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 10),
                                          padding: EdgeInsets.all(2),
                                          child: Image.asset(listHorizontal[index].card)),
                              ),
                              Positioned(
                            top: 15,
                            right: 13,
                            child: GestureDetector(
                              child: Icon(
                                listHorizontal[index].cardInvisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onTap: () {
                                setState(() {
                                  listHorizontal[index].cardInvisible =
                                      !listHorizontal[index].cardInvisible;
                                });
                              },
                            ),
                          ),
                              Positioned(
                                bottom: 40,
                                left: 20,
                                child: Text(listHorizontal[index].cardInvisible
                                  ? listHorizontal[index].idcard
                                  : listHorizontal[index].cardNoInvisible,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700)),),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Text(listHorizontal[index].username,style: TextStyle(fontSize: 10,fontFamily: 'Roboto',color: Colors.white),)),
                            ],
                          );
                        }),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenArgument {
  final String usernameValue;

  ScreenArgument({required this.usernameValue});
}
class CardHorizontal {
  String card;
  String username;
  String idcard;
  String cardNoInvisible = "";
  bool cardInvisible;
  CardHorizontal({required this.card, required this.username,required this.idcard,required this.cardInvisible});
}

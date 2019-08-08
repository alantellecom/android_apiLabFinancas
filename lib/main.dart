import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = 'http://192.168.0.11:4000/despesas.json?user_email=alan.tellecom@gmail.com&user_token=KM1x1-4vN2zLpL_HQkQy';

void main() async {
  runApp(new MyApp());
}

Future<List> recebeDados() async {
  http.Response resposta = await http.get(request);

  //print(resposta.body);

  return json.decode(resposta.body);
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(

        hintColor: Colors.amber,
        primaryColor: const Color(0xFF2196f3),

      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final DespesasController = TextEditingController();

  List despesas = null;

  Widget buildItemDespesas(BuildContext context, int index) {
    return ListTile(
      title: Text("${despesas[index]["nome"]}"),
      subtitle: Text("R\$ ${despesas[index]["valor"]}"),
      leading: Icon(
        Icons.payment,
        size: 45.0,
        color: Colors.redAccent,
      ),
    );
  }

  void addItem() {
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Api Rails'),

          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: addItem,
            )
          ],
        ),
        body: FutureBuilder<List>(
            future: recebeDados(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "Carregando Dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:



         if (snapshot.hasData) {
           despesas = snapshot.data;
           print ("entrou");
           return new Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,

               children: <Widget>[

                 new Expanded(
                   child: ListView.builder(
                       padding: EdgeInsets.only(top: 10.0),
                       itemCount: despesas.length,
                       itemBuilder: buildItemDespesas),
                 ),


               ]);
         }
         else{
           return Center(
               child: Text("Erro ao Carregar Dados :(",
                 style: TextStyle(
                     color: Colors.amber,
                     fontSize: 25.0),
                 textAlign: TextAlign.center,)
           );
         }

              }
            }));
  }
}

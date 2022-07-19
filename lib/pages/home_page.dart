// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; //apelido do pacote para utilizar ele nos códigos

//1) importar o pacote do material design (importar os pacotes)

//3) criar uma constante com o nome de request que vai receber o endereco com key api


//5)criar um Stateful
//widget com o nome de Home
// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//comecar a criar o corpo do app
//snapshot é como uma foto da api qdo comeca utilizar
//definir qual será o nosso futuro

class _HomeState extends State<Home> {
  //recuperar o que é digitado nos campos do app
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  late double dolar;
  late double euro;

  final request = "https://api.hgbrasil.com/finance?format=json-&key=6716d950";

//2) comecar uma funcao principal

//4)criar uma função Future com acesso aos mapas das moedas no Json
//essa função vai receber o HTTP
//await é o acesso futuro
//async para formar uma funcao assincrona - buscam algum tipo de recurso em um dispositivo externo
//funcao get em classes em Dart

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
  //print(response.body);
}

  //funcao para apagar campos ao mesmo tempo, apaga um apaga todos
  void _clear() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  //criar funcao para cada campo de texto para recuperar o que está sendo digitado
  // underlaine para que ele seja privado
  void _realChange(String text) {
    if (text.isEmpty) {
      // para funcionar o clear ao mesmo tempo nos três campos
      _clear();
      return;
    }
    double real = double.parse(
        text); //parse e um comando para transformar algo em uma double
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro)
        .toStringAsFixed(2); //conversao com 2 pontos depois da virgula
  }

  void _dolarChange(String text) {
    if (text.isEmpty) {
      _clear();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChange(String text) {
    if (text.isEmpty) {
      _clear();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / euro).toStringAsFixed(2);
  }

  //definir string para o funcionamento do app
  // c para receber controladores
  // f para funcoes
  Widget buildTextField(
      String label, String prefix, TextEditingController c, f) {
    return TextField(
      // text field sao os campos de texto
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black, fontSize: 21.0),
        prefixText: prefix,
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.black, fontSize: 20.0),
      keyboardType: TextInputType
          .number, //para sinalizar no teclado números ao inves de letras
      onChanged: f,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text('Conversor de Moedas FINANCE SIM'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [
                Color.fromARGB(255, 148, 253, 165),
                Color.fromARGB(255, 88, 156, 99),
                Color.fromARGB(255, 36, 83, 44),
                Color.fromARGB(255, 8, 36, 19),
              ],
              stops: const [0.1, 0.4, 0.7, 0.9],
            ),
          ),
          child: Column(
            children: [
              FutureBuilder<Map>(
                future: getData(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    //estado de conexao da api/ativado ou desativado ou esperando
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: Text(
                          "Carregando dados",
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Erro ao carregar dados",
                            style:
                                TextStyle(color: Colors.amber, fontSize: 25.0),
                          ),
                        );
                      }
                      //se nao encontrar o erro ao fazer a verificacao
                      else {
                        dolar = snapshot.data!["results"]["currencies"]["USD"]
                            ["buy"];
                        euro = snapshot.data!["results"]["currencies"]["EUR"]
                            ["buy"]; //processar os Maps da API
                        return SingleChildScrollView(
                          //scroll da tela
                          padding: EdgeInsets.all(10.0), //espacos dos valores
                          child: Column(
                            //filhos do column
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(height: 80),
                              Icon(
                                Icons.monetization_on,
                                size: 180.0,
                                color: Colors.black,
                              ),
                              SizedBox(height: 25),
                              buildTextField("Reais", "R/$mounted ",
                                  realController, _realChange),
                              Divider(), //PARA SEPARAR OS CAMPOS
                              buildTextField("Dolares", "US/$mounted ",
                                  dolarController, _dolarChange),
                              Divider(),
                              buildTextField("Euros", "€/$mounted ", 
                              euroController, _euroChange),

                              SizedBox(
                                height: MediaQuery.of(context).size.height,
                              )
                            ],
                          ),
                        );
                      }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

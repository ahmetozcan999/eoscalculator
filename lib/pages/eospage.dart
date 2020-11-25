import 'package:eoscalculator/providers/AppStateProvider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle, ByteData2;

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

class EOSPage extends StatefulWidget {
  @override
  EOSPageState createState() {
    return EOSPageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class EOSPageState extends State<EOSPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<EOSPageState>.
  final _formKey = GlobalKey<FormState>();
  var multiplyResult;
  var fugasite;
  var fugasitesonuc;

  var sfaktoru;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    final provider = Provider.of<AppStateProvider>(context);
    final multiplyFieldController = TextEditingController();
    final multiplyFieldController2 = TextEditingController();

    count() async {
      ByteData data = await rootBundle.load("assets/preos.xlsx");
      var bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      var excel = Excel.decodeBytes(bytes);

      excel.updateCell('PVT', CellIndex.indexByString("B4"),
          provider.currentCompound.tc.toString());
      excel.updateCell('PVT', CellIndex.indexByString("C4"),
          provider.currentCompound.pc.toString());
      excel.updateCell(
          'PVT', CellIndex.indexByString("B7"), multiplyFieldController.text);
      excel.updateCell(
          'PVT', CellIndex.indexByString("B8"), multiplyFieldController2.text);
      print(multiplyFieldController2.text);

      //print(getApplicationDocumentsDirectory().toString());
      excel.encode();

      var sheet = excel['PVT'];
      print("burdayım");

      var denemeokuma = sheet.cell(CellIndex.indexByString("B4"));
      print(denemeokuma.value.toString());
      var denemeokuma2 = sheet.cell(CellIndex.indexByString("C10"));
      multiplyResult = denemeokuma2.value.value;
      fugasitesonuc = sheet.cell(CellIndex.indexByString("C10"));
      fugasite = fugasitesonuc.value.value;
      print("mresult" + multiplyResult);
      sfaktoru = sheet.cell(CellIndex.indexByString("C10"));
      print("fugasite " + fugasite);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('EOS Hesaplama'),
      ),
      body: Builder(
        builder: (context) => Container(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Seçilen : " + provider.currentCompound?.name ?? "-"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Formül : " +
                        provider.currentCompound?.formula.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Sıcaklık Değeri"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        labelText: "Kelvin cinsinden sıcaklık değeri",
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: multiplyFieldController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Değer Giriniz';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Basınç Değeri"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: new InputDecoration(
                        labelText: "MPa cinsinden basınç değeri",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: multiplyFieldController2,
                      validator: (value2) {
                        if (value2.isEmpty) {
                          return 'Değer Giriniz';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.

                          count();
                        }
                      },
                      child: Text('Hesapla'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

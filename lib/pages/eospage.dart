// Create a Form widget.
import 'package:eoscalculator/providers/AppStateProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

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

  double multiplyResult;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    final provider = Provider.of<AppStateProvider>(context);
    final multiplyFieldController = TextEditingController();
    final multiplyFieldController2 = TextEditingController();

    count() {
      setState(() {
        multiplyResult = double.parse(multiplyFieldController.text) *
            provider.currentCompound.pc;
      });
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
                    child: Text("Seçilen adı: " +
                            provider.currentCompound?.name.toUpperCase() ??
                        "-"),
                  ),
                  //Padding(
                  //  padding: const EdgeInsets.all(8.0),
                  //  child: Text("PC değeri: " +
                  //       provider.currentCompound?.pc.toString()),
                  // ),
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value.isEmpty) {
                  //       return 'Please enter some text';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Sıcaklık Değeri?"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Kelvin cinsinden sıcaklık değeri',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      controller: multiplyFieldController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Sıcaklık Değerini Giriniz';
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
                      decoration: InputDecoration(
                          hintText: 'kPa cinsinden basınç değeri',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      controller: multiplyFieldController2,
                      validator: (value2) {
                        if (value2.isEmpty) {
                          return 'Basınç Değerini Giriniz';
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

                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Hesaplanıyor...')));
                        }
                        exceleGonder(context);
                      },
                      child: Text('Hesapla'),
                    ),
                  ),

                  multiplyResult != null
                      ? Text("Sonuç : " + multiplyResult.toString())
                      : Text(""),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void exceleGonder(BuildContext context) async {
  final veriler = Provider.of<AppStateProvider>(context, listen: false);
  ByteData data = await rootBundle.load("assets/test.xlsx");
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);
  //sayfayı sec
  Sheet sheetObject = excel['PVT'];
  //kritiksicaklik degerini yaz
  var kritiksicaklik = sheetObject.cell(CellIndex.indexByString("B4"));
  kritiksicaklik.value = veriler.currentCompound.tc;
  //kritikbasin degerini yaz
  var kritikbasinc = sheetObject.cell(CellIndex.indexByString("C4"));
  kritikbasinc.value = veriler.currentCompound.pc;
  //omega değerini yaz
  var omega = sheetObject.cell(CellIndex.indexByString("D4"));
  omega.value = veriler.currentCompound.omega;
  //istenilen basınc degerini exele yaz
  var ibasinc = sheetObject.cell(CellIndex.indexByString("B8"));
}

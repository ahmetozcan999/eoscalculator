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
import 'package:rflutter_alert/rflutter_alert.dart';

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
  final multiplyFieldController = TextEditingController();
  final multiplyFieldController2 = TextEditingController();
  var denemetoplama = 2;

  var sfaktoru;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    final provider = Provider.of<AppStateProvider>(context);

    count() async {}

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
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: false),
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
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: false),
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
                        print("sqrt sonucu" + sqrt(4).toString());
                        print("pow sonucu " + pow(2, 2).toString());
                        print("epow sonucu " + pow(e, 7).toString());
                        print("ln hesap sonucu " + log(9).toString());
                        print("toplama denemee sonucu " +
                            (denemetoplama * 2).toString());

                        //num b7 = double.tryParse(multiplyFieldController.text)
                        //.toDouble();
                        num b7 = double.tryParse(multiplyFieldController.text
                            .replaceFirst(",", "."));

                        print("b7 değeri " + b7.toString());

                        num b8 = double.tryParse(multiplyFieldController2.text
                            .replaceFirst(",", "."));
                        print("b8 değeri " + b8.toString());
                        num c4 = double.tryParse(provider.currentCompound.pc
                                .replaceFirst(",", ".")) /
                            10;
                        print("c4 değeri " + c4.toString());
                        num d4 = double.tryParse(provider.currentCompound.omega
                            .replaceFirst(",", "."));
                        print("d4 değeri " + d4.toString());

                        num b4 = double.tryParse(
                            provider.currentCompound.tc.replaceFirst(",", "."));
                        print("b4 değeri " + b4.toString());

                        num h7 = b7 / b4;
                        print("h7 değeri " + h7.toString());
                        num h8 = b8 / c4;
                        print("h8 değeri " + h8.toString());
                        num h9 = 0.37464 + 1.54226 * d4 - 0.26992 * pow(d4, 2);
                        print("h9 değeri " + h9.toString());
                        num h10 = pow((1 + h9 * (1 - sqrt(h7))), 2);
                        print("h10 değeri " + h10.toString());

                        num i6 = 8.314;
                        print("i6 değeri " + i6.toString());

                        num i8 = 0.4572355289 * pow((b4 * i6), 2) * h10 / c4;
                        print("i8 değeri " + i8.toString());
                        num i10 = 0.0777960739 * i6 * b4 / c4;
                        print("i10 değeri " + i10.toString());
                        num j11 = i8 * b8 / pow((i6 * b7), 2);
                        print("j11 değeri " + j11.toString());
                        num j12 = i10 * b8 / i6 / b7;
                        print("j12 değeri " + j12.toString());

                        num c18 = -(j11 * j12 - pow(j12, 2) - pow(j12, 3));
                        print("c18 değeri " + c18.toString());
                        num b18 = j11 - 3 * pow(j12, 2) - 2 * j12;
                        print("b18 değeri " + b18.toString());
                        num a18 = -(1 - j12);
                        print("a18 değeri " + a18.toString());

                        num d18 = (3 * b18 - pow(a18, 2)) / 3;
                        print("d18 degeri " + d18.toString());
                        num a26 = 2 * sqrt((-1 * d18) / 3);
                        print("a26 değeri " + a26.toString());
                        num e18 =
                            (2 * pow(a18, 3) - 9 * a18 * b18 + 27 * c18) / 27;
                        print("e18 değeri " + e18.toString());
                        num b26 = 3 * e18 / d18 / a26;
                        print("b26 değeri " + b26.toString());
                        num c26 = acos(b26);
                        print("c26 değeri " + c26.toString());
                        num d26 = c26 / 3;
                        print("d26 değeri " + d26.toString());
                        num e26 = a26 * cos(d26);
                        print("e26 değeri " + e26.toString());
                        num c9 = e26 - a18 / 3;
                        print("c9 değeri " + c9.toString());
                        num e9 = b8 *
                            pow(
                                e,
                                (c9 -
                                    1 -
                                    log(c9 - j12) -
                                    j11 /
                                        j12 /
                                        2.8284 *
                                        log((c9 + 2.4142 * j12) /
                                            (c9 - 0.4142 * j12))));
                        print("e9 değeri " + e9.toString());

                        num f26 = a26 * cos(d26 + 4 * pi / 3);
                        print("f26 değeri " + f26.toString());
                        num d9 = c9 * i6 * b7 / b8;
                        print("d9 değeri " + d9.toString());
                        num c10 = f26 - a18 / 3;
                        print("c10 değeri " + c10.toString());
                        num d10 = c10 * i6 * b7 / b8;

                        print("d10 değeri " + d10.toString());
                        num g26 = a26 * cos(d26 + 2 * pi / 3);
                        print("g26 değeri " + g26.toString());
                        num c11 = g26 - a18 / 3;
                        print("c11 değeri " + c11.toString());
                        num d11 = c11 * i6 * b7 / b8;
                        print("d11 değeri " + d11.toString());

                        num h16 = pow(e18, 2) / 4 + pow(d18, 3) / 27;
                        print("h16 değeri " + h16.toString());
                        num b22 = pow((-e18 / 2 - sqrt(h16)), 1 / 3);
                        print("b22 değeri " + b22.toString());
                        num a22 = pow(((-1 * e18) / 2 + sqrt(h16)), 1 / 3);
                        print("a22 değeri " + a22.toString());
                        num c22 = a22 + b22;
                        print("c22 değeri " + c22.toString());
                        num c12 = c22 - a18 / 3;
                        print("c12 değeri " + c12.toString());
                        num d12 = c12 * i6 * b7 / b8;
                        print("d12 değeri " + d12.toString());
                        num e12 = (pow(
                                e,
                                (log(c12 -
                                    1 -
                                    log(c12 - j12) -
                                    j11 /
                                        j12 /
                                        2.8284 *
                                        log((c12 + 2.4142 * j12) /
                                            (c12 - 0.4142 * j12)))))) *
                            b8;
                        print("e12 değeri " + e12.toString());
                        num e11 = b8 *
                            (pow(
                                e,
                                (c11 -
                                    1 -
                                    (log(c11 - j12)) -
                                    j11 /
                                        j12 /
                                        2.8284 *
                                        (log((c11 + 2.4142 * j12) /
                                            (c11 - 0.4142 * j12))))));
                        print("e11 değeri " + e11.toString());
                        num h12 = e9 / e11;
                        print("h12 değeri " + h12.toString());
                        print("fugasite : " + e11.toString());

                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          if (h12.toString().contains("NaN")) {
                            fugasitesonuc = "Hesaplanamadı";
                          } else {
                            fugasitesonuc = h12.toString();
                          }
                          Alert(
                            context: context,
                            title: "Sonuç",
                            desc: "Fugasite : " +
                                fugasitesonuc +
                                "\nA: " +
                                j11.toString() +
                                "\nB: " +
                                j12.toString(),
                            image: Image.asset("assets/success.png"),
                          ).show();
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

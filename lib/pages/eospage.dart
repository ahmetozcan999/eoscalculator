// Create a Form widget.
import 'package:eoscalculator/providers/AppStateProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    child: Text(
                        "Seçilen adı: " + provider.currentCompound?.name ??
                            "-"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("PC değeri: " +
                        provider.currentCompound?.pc.toString()),
                  ),
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
                    child: Text("Kaçla çarpılacak?"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: multiplyFieldController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
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

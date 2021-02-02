import 'dart:async';
import 'dart:convert';
import 'package:eoscalculator/constants/constant.dart';
import 'package:eoscalculator/pages/eospage.dart';
import 'package:eoscalculator/providers/AppStateProvider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'models/compound.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Compound> _searchResult = [];
  List<Compound> _compoundList = [];
  final customCp = 0;
  TextEditingController controller = TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map user in responseJson) {
        _compoundList.add(Compound.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    //Remove this method to stop OneSignal Debugging

    super.initState();
    getOnesignal();

    getUserDetails();
  }

  Widget _buildUsersList() {
    final provider = Provider.of<AppStateProvider>(context);

    return ListView.builder(
      itemCount: _compoundList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text(_compoundList[index].name),
            subtitle: Text(_compoundList[index].formula),
            onTap: () {
              Alert(
                context: context,
                title: _compoundList[index].name.toUpperCase(),
                desc: 'Formül:' +
                    _compoundList[index].formula +
                    '\nMolekül Ağırlığı: ' +
                    _compoundList[index].molwt.toString() +
                    '\nKritik Sıcaklık: ' +
                    _compoundList[index].tc.toString() +
                    ' K' +
                    '\nKritik Basınç: ' +
                    _compoundList[index].pc.toString() +
                    ' Bar'
                        '\nKritik Hacim: ' +
                    _compoundList[index].vc.toString() +
                    ' cm3/mol' +
                    '\nOmega: ' +
                    _compoundList[index].omega.toString(),
                buttons: [
                  DialogButton(
                    child: Text(
                      "HESAPLA",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      provider.changeCurrentCompound(_compoundList[index]);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EOSPage()),
                      );
                    },
                    width: 120,
                  )
                ],
              ).show();
            },
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    final provider2 = Provider.of<AppStateProvider>(context);
    return ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, i) {
        return Card(
          child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text(_searchResult[i].name),
            subtitle: Text(_searchResult[i].formula),
            onTap: () {
              Alert(
                context: context,
                title: _searchResult[i].name.toUpperCase(),
                desc: 'Formül:' +
                    _searchResult[i].formula +
                    '\nMolekül Ağırlığı: ' +
                    _searchResult[i].molwt.toString() +
                    '\nKritik Sıcaklık: ' +
                    _searchResult[i].tc.toString() +
                    ' K' +
                    '\nKritik Basınç: ' +
                    _searchResult[i].pc.toString() +
                    ' Bar'
                        '\nKritik Hacim: ' +
                    _searchResult[i].vc.toString() +
                    ' cm3/mol' +
                    '\nOmega: ' +
                    _searchResult[i].omega.toString(),
                buttons: [
                  DialogButton(
                    child: Text(
                      "HESAPLA",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      provider2.changeCurrentCompound(_searchResult[i]);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EOSPage()),
                      );
                    },
                    width: 120,
                  )
                ],
              ).show();
              /*
                  AlertDialog alert = AlertDialog(
                    title: Text(_searchResult[i].name.toUpperCase()),
                    content: Text('Formül: ' +
                        _searchResult[i].formula +
                        '\nTfp: ' +
                        _searchResult[i].tfp.toString() +
                        '\nTb: ' +
                        _searchResult[i].tb.toString() +
                        '\nTc: ' +
                        _searchResult[i].tc.toString() +
                        '\nPc: ' +
                        _searchResult[i].pc.toString() +
                        '\nVc: ' +
                        _searchResult[i].vc.toString() +
                        '\nZc: ' +
                        _searchResult[i].zc.toString() +
                        '\nOmega: ' +
                        _searchResult[i].omega.toString() +
                        '\nDipm: ' +
                        _searchResult[i].dipm.toString() +
                        '\nCpA: ' +
                        _searchResult[i].cpA.toString() +
                        '\nCpB: ' +
                        _searchResult[i].cpB.toString() +
                        '\nCpC: ' +
                        _searchResult[i].cpC.toString() +
                        '\nCpD: ' +
                        _searchResult[i].cpD.toString() +
                        '\ndHf: ' +
                        _searchResult[i].dHf.toString() +
                        '\ndGf: ' +
                        _searchResult[i].dGf.toString() +
                        '\nEq: ' +
                        _searchResult[i].eq.toString()),
                    actions: [],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );*/
            },
          ),
        );
      },
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            controller: controller,
            decoration:
                InputDecoration(hintText: 'Ara', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Container(
            color: Theme.of(context).primaryColor, child: _buildSearchBox()),
        Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? _buildSearchResults()
                : _buildUsersList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equation Of State'),
        elevation: 0.0,
      ),
      body: _buildBody(),
      resizeToAvoidBottomPadding: true,
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _compoundList.forEach((userDetail) {
      if (userDetail.name.toLowerCase().contains(text.toLowerCase()) ||
          userDetail.formula.toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

Future<void> getOnesignal() async {
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init("f390005d-8875-4286-b035-8d096940e039", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
}

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'userDetails.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserDetails> _searchResult = [];
  List<UserDetails> _userDetails = [];
  final customCp = 0;
  TextEditingController controller = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  Widget _buildUsersList() {

    return new ListView.builder(

      itemCount: _userDetails.length,
      itemBuilder: (context, index) {
        return new Card(
          child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text(_userDetails[index].Name),
            subtitle: Text(_userDetails[index].Formula),


          onTap: (){
            AlertDialog alert = AlertDialog(

              title: Text('' + _userDetails[index].Name.toUpperCase()),
              content: Text('Formül: ' + _userDetails[index].Formula + '\nTfp: ' + _userDetails[index].Tfp.toString() +'\nTb: ' + _userDetails[index].Tb.toString() +'\nTc: ' + _userDetails[index].Tc.toString() +'\nPc: ' + _userDetails[index].Pc.toString() +'\nVc: ' + _userDetails[index].Vc.toString() +'\nZc: ' + _userDetails[index].Zc.toString() +'\nΩ: ' + _userDetails[index].Omega.toString() +'\nDipm: ' + _userDetails[index].Dipm.toString() +'\nCpA: ' + _userDetails[index].CpA.toString()+'\nCpB: ' + _userDetails[index].CpB.toString() +'\nCpC: ' + _userDetails[index].CpC.toString() +'\nCpD: ' + _userDetails[index].CpD.toString() +'\ndHf: ' + _userDetails[index].dHf.toString() +'\ndGf: ' + _userDetails[index].dGf.toString() +'\nEq: ' + _userDetails[index].Eq.toString() +'\nLden: ' + _userDetails[index].Lden.toString() +'\nTden: ' + _userDetails[index].Tden.toString()),
              actions: [
              ],
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          },
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return new ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, i) {
        return new Card(
          child: new ListTile(
            leading: FlutterLogo(size: 56.0),

            title: new Text(
                _searchResult[i].Name),
            subtitle: Text(_searchResult[i].Formula),
            onTap: (){
              AlertDialog alert = AlertDialog(
                title: Text(_searchResult[i].Name.toUpperCase()),
                content: Text('Formül: ' + _searchResult[i].Formula + '\nTfp: ' + _searchResult[i].Tfp.toString() +'\nTb: ' + _searchResult[i].Tb.toString() +'\nTc: ' + _searchResult[i].Tc.toString() +'\nPc: ' + _searchResult[i].Pc.toString() +'\nVc: ' + _searchResult[i].Vc.toString() +'\nZc: ' + _searchResult[i].Zc.toString() +'\nOmega: ' + _searchResult[i].Omega.toString() +'\nDipm: ' + _searchResult[i].Dipm.toString() +'\nCpA: ' + _searchResult[i].CpA.toString()+'\nCpB: ' + _searchResult[i].CpB.toString() +'\nCpC: ' + _searchResult[i].CpC.toString() +'\nCpD: ' + _searchResult[i].CpD.toString() +'\ndHf: ' + _searchResult[i].dHf.toString() +'\ndGf: ' + _searchResult[i].dGf.toString() +'\nEq: ' + _searchResult[i].Eq.toString()+'\nLden: ' + _searchResult[i].Lden.toString() +'\nTden: ' + _searchResult[i].Tden.toString()),actions: [
                ],
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            },

          ),

        );
      },
    );
  }

  Widget _buildSearchBox() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'Ara', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
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
    return new Column(
      children: <Widget>[
        new Container(
            color: Theme.of(context).primaryColor, child: _buildSearchBox()),
        new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? _buildSearchResults()
                : _buildUsersList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Equation Of State'),
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

    _userDetails.forEach((userDetail) {
      if (userDetail.Name.toLowerCase().contains(text.toLowerCase()) ||
          userDetail.Formula.toLowerCase().contains(text.toLowerCase())) _searchResult.add(userDetail);
    });

    setState(() {});
  }
}
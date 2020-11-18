import 'package:flutter/material.dart';

final String url = 'http://dogadancozumler.xyz/test1.json';
class UserDetails {

  final String Name, Formula, profileUrl,No;
  final  Molwt,Tfp,Tb,Tc,Pc,Vc,Zc,Omega,Dipm,CpA,CpB,CpC,CpD,dHf,dGf,Eq,Lden,Tden,customCP;



  UserDetails({this.customCP,this.No,this.Tfp, this.Tb,this.Tc,this.Pc,this.Vc,this.Zc,this.Omega,this.Dipm,this.CpA,this.CpB,this.CpC,this.CpD,this.dHf,this.dGf,this.Eq,this.Tden,this.Lden,this.Name, this.Formula,this.Molwt, this.profileUrl = 'https://i.amz.mshcdn.com/3NbrfEiECotKyhcUhgPJHbrL7zM=/950x534/filters:quality(90)/2014%2F06%2F02%2Fc0%2Fzuckheadsho.a33d0.jpg'});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      No: json['No'] ?? '0',
      Name: json['Name']?? '0',
      Formula: json['Formula']?? '0',
      Molwt: json['Molwt']?? '0',
      Tfp: json['Tfp']?? '0',
      Tb:json['Tb']?? '0',
      Tc:json['Tc']?? '0',
      Pc:json['Pc']?? '0',
      Vc:json['Vc']?? '0',
      Zc:json['Zc']?? '0',
      Omega:json['Omega']?? '0',
      Dipm:json['Dipm']?? '0',
      CpA:json['CpA']?? '0',
      CpB:json['CpB']?? '0',
      CpC:json['CpC']?? '0',
      CpD:json['CpD']?? '0',
      dHf:json['dHf']?? '0',
      dGf:json['dGf']?? '0',
      Eq:json['Eq']?? '0',
      Lden:json['Lden']?? '0',
      Tden:json['Tden']?? '0'
    );
  }
}
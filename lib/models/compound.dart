import 'package:flutter/material.dart';

import 'dart:convert';

List<Compound> compoundFromJson(String str) =>
    List<Compound>.from(json.decode(str).map((x) => Compound.fromJson(x)));

String compoundToJson(List<Compound> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Compound {
  Compound({
    this.no,
    this.formula,
    this.name,
    this.molwt,
    this.tfp,
    this.tb,
    this.tc,
    this.pc,
    this.vc,
    this.zc,
    this.omega,
    this.dipm,
    this.cpA,
    this.cpB,
    this.cpC,
    this.cpD,
    this.dHf,
    this.dGf,
    this.eq,
  });

  String no;
  String formula;
  String name;
  String molwt;
  String tfp;
  String tb;
  String tc;
  String pc;
  String vc;
  String zc;
  String omega;
  String dipm;
  String cpA;
  String cpB;
  String cpC;
  String cpD;
  String dHf;
  String dGf;
  String eq;

  factory Compound.fromJson(Map<String, dynamic> json) => Compound(
        no: json["No"] == null ? null : json["No"],
        formula: json["Formula"] == null ? null : json["Formula"],
        name: json["Name"] == null ? null : json["Name"],
        molwt: json["Molwt"] == null ? null : json["Molwt"],
        tfp: json["Tfp"] == null ? null : json["Tfp"],
        tb: json["Tb"] == null ? null : json["Tb"],
        tc: json["Tc"] == null ? null : json["Tc"],
        pc: json["Pc"] == null ? null : json["Pc"],
        vc: json["Vc"] == null ? null : json["Vc"],
        zc: json["Zc"] == null ? null : json["Zc"],
        omega: json["Omega"] == null ? null : json["Omega"],
        dipm: json["Dipm"] == null ? null : json["Dipm"],
        cpA: json["CpA"] == null ? null : json["CpA"],
        cpB: json["CpB"] == null ? null : json["CpB"],
        cpC: json["CpC"] == null ? null : json["CpC"],
        cpD: json["CpD"] == null ? null : json["CpD"],
        dHf: json["dHf"] == null ? null : json["dHf"],
        dGf: json["dGf"] == null ? null : json["dGf"],
        eq: json["Eq"] == null ? null : json["Eq"],
      );

  Map<String, dynamic> toJson() => {
        "No": no == null ? null : no,
        "Formula": formula == null ? null : formula,
        "Name": name == null ? null : name,
        "Molwt": molwt == null ? null : molwt,
        "Tfp": tfp == null ? null : tfp,
        "Tb": tb == null ? null : tb,
        "Tc": tc == null ? null : tc,
        "Pc": pc == null ? null : pc,
        "Vc": vc == null ? null : vc,
        "Zc": zc == null ? null : zc,
        "Omega": omega == null ? null : omega,
        "Dipm": dipm == null ? null : dipm,
        "CpA": cpA == null ? null : cpA,
        "CpB": cpB == null ? null : cpB,
        "CpC": cpC == null ? null : cpC,
        "CpD": cpD == null ? null : cpD,
        "dHf": dHf == null ? null : dHf,
        "dGf": dGf == null ? null : dGf,
        "Eq": eq == null ? null : eq,
      };
}

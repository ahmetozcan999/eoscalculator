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
    this.lden,
    this.tden,
  });

  String no;
  String formula;
  String name;
  double molwt;
  double tfp;
  int tb;
  int tc;
  double pc;
  int vc;
  double zc;
  double omega;
  int dipm;
  double cpA;
  double cpB;
  double cpC;
  double cpD;
  int dHf;
  int dGf;
  int eq;
  double lden;
  int tden;

  factory Compound.fromJson(Map<String, dynamic> json) => Compound(
        no: json["No"] == null ? null : json["No"],
        formula: json["Formula"] == null ? null : json["Formula"],
        name: json["Name"] == null ? null : json["Name"],
        molwt: json["Molwt"] == null ? null : json["Molwt"].toDouble(),
        tfp: json["Tfp"] == null ? null : json["Tfp"].toDouble(),
        tb: json["Tb"] == null ? null : json["Tb"],
        tc: json["Tc"] == null ? null : json["Tc"],
        pc: json["Pc"] == null ? null : json["Pc"].toDouble(),
        vc: json["Vc"] == null ? null : json["Vc"],
        zc: json["Zc"] == null ? null : json["Zc"].toDouble(),
        omega: json["Omega"] == null ? null : json["Omega"].toDouble(),
        dipm: json["Dipm"] == null ? null : json["Dipm"],
        cpA: json["CpA"] == null ? null : json["CpA"].toDouble(),
        cpB: json["CpB"] == null ? null : json["CpB"].toDouble(),
        cpC: json["CpC"] == null ? null : json["CpC"].toDouble(),
        cpD: json["CpD"] == null ? null : json["CpD"].toDouble(),
        dHf: json["dHf"] == null ? null : json["dHf"],
        dGf: json["dGf"] == null ? null : json["dGf"],
        eq: json["Eq"] == null ? null : json["Eq"],
        lden: json["Lden"] == null ? null : json["Lden"].toDouble(),
        tden: json["Tden"] == null ? null : json["Tden"],
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
        "Lden": lden == null ? null : lden,
        "Tden": tden == null ? null : tden,
      };
}



import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil {
  final String? nombre;
  final String? curso;
  final String? asign;
  final String? trim;
  final int? nota;



  Perfil( {
    this.nombre ="",
    this.curso ="",
    this.asign ="",
    this.trim ="",
    this.nota =0,
  });

  factory Perfil.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Perfil(
      nombre: data?['nombre'],
      curso: data?['curso'],
      asign: data?['asign'],
      trim: data?['trim'],
      nota: data?['nota'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      //Estos nombres deben ser iguales a los del firebase
      if (nombre != null) "nombre": nombre,
      if (curso != null) "curso": curso,
      if (asign != null) "asign": asign,
      if (trim != null) "trim": trim,
      if (nota != 0) "nota": nota,
    };
  }

}
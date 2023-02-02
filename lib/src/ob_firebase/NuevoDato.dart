


import 'package:cloud_firestore/cloud_firestore.dart';

class NuevoDato {
  final String? nombre;
  final String? curso;

  NuevoDato( {
    this.nombre ="",
    this.curso ="",
  });

  factory NuevoDato.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return NuevoDato(
      nombre: data?['nombre'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      //Estos nombres deben ser iguales a los del firebase
      if (nombre != null) "nombre": nombre,
    };
  }

}
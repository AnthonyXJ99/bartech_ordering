import 'package:flutter/material.dart';

class Pedido {
  final String id;
  final List<PedidoItem> items;
  final String estado;
  final DateTime fecha;

  Pedido({
    required this.id,
    required this.items,
    required this.estado,
    required this.fecha,
  });
  // ...
}

class PedidoItem {
  final String nroOrden;
  final String cliente;
  final bool paraLlevar; // true: para llevar, false: comer en local
  final String producto;
  final int cantidad;
  final List<String> ingredientes;
  final List<String> acompanamientos;
  final String observacion;
  final Color colorEstado;

  PedidoItem({
    required this.nroOrden,
    required this.cliente,
    required this.paraLlevar,
    required this.producto,
    required this.cantidad,
    required this.ingredientes,
    required this.acompanamientos,
    required this.observacion,
    required this.colorEstado,
  });

  PedidoItem copyWith({Color? colorEstado}) => PedidoItem(
    nroOrden: nroOrden,
    cliente: cliente,
    paraLlevar: paraLlevar,
    producto: producto,
    cantidad: cantidad,
    ingredientes: List.from(ingredientes),
    acompanamientos: List.from(acompanamientos),
    observacion: observacion,
    colorEstado: colorEstado ?? this.colorEstado,
  );
}

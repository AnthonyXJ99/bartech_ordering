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
  final DateTime fechaHoraIngreso;

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
    required this.fechaHoraIngreso,
  });

  /// Retorna el tiempo transcurrido desde que se creó el pedido (como Duration)
  Duration get tiempoTranscurrido =>
      DateTime.now().difference(fechaHoraIngreso);

  /// Formatea la fecha/hora de ingreso (para mostrar en la UI)
  String get fechaHoraIngresoString =>
      "${fechaHoraIngreso.hour.toString().padLeft(2, '0')}:${fechaHoraIngreso.minute.toString().padLeft(2, '0')}";

  /// Formatea el tiempo transcurrido para mostrar tipo "05:23" (mm:ss) o "1h 12m"
  String get tiempoTranscurridoString {
    final d = tiempoTranscurrido;
    if (d.inHours > 0) {
      return "${d.inHours}h ${d.inMinutes % 60}m";
    }
    return "${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  PedidoItem copyWith({Color? colorEstado, DateTime? fechaHoraIngreso}) =>
      PedidoItem(
        nroOrden: nroOrden,
        cliente: cliente,
        paraLlevar: paraLlevar,
        producto: producto,
        cantidad: cantidad,
        ingredientes: List.from(ingredientes),
        acompanamientos: List.from(acompanamientos),
        observacion: observacion,
        colorEstado: colorEstado ?? this.colorEstado,
        fechaHoraIngreso: fechaHoraIngreso ?? this.fechaHoraIngreso,
      );
}

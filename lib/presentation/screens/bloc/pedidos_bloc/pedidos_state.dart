part of 'pedidos_bloc.dart';

class PedidosState extends Equatable {
  final List<PedidoItem> pedidosNuevos;
  final List<PedidoItem> pedidosEnPreparacion;
  final List<PedidoItem> pedidosListos;

  const PedidosState({
    this.pedidosNuevos = const [],
    this.pedidosEnPreparacion = const [],
    this.pedidosListos = const [],
  });

  PedidosState copyWith({
    List<PedidoItem>? pedidosNuevos,
    List<PedidoItem>? pedidosEnPreparacion,
    List<PedidoItem>? pedidosListos,
  }) {
    return PedidosState(
      pedidosNuevos: pedidosNuevos ?? this.pedidosNuevos,
      pedidosEnPreparacion: pedidosEnPreparacion ?? this.pedidosEnPreparacion,
      pedidosListos: pedidosListos ?? this.pedidosListos,
    );
  }

  @override
  List<Object?> get props => [
    pedidosNuevos,
    pedidosEnPreparacion,
    pedidosListos,
  ];
}

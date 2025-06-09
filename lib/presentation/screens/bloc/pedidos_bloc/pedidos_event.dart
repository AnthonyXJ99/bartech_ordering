part of 'pedidos_bloc.dart';

abstract class PedidosEvent extends Equatable {
  const PedidosEvent();

  @override
  List<Object?> get props => [];
}

// Cargar los pedidos iniciales (mock o backend)
class CargarPedidos extends PedidosEvent {}

// Mover un pedido de NUEVO a EN PREPARACIÓN
class MoverAPreparacion extends PedidosEvent {
  final PedidoItem pedido;

  const MoverAPreparacion(this.pedido);

  @override
  List<Object?> get props => [pedido];
}

// Mover un pedido de EN PREPARACIÓN a LISTO
class MoverAListo extends PedidosEvent {
  final PedidoItem pedido;

  const MoverAListo(this.pedido);

  @override
  List<Object?> get props => [pedido];
}

class MoverANuevo extends PedidosEvent {
  final PedidoItem pedido;

  const MoverANuevo(this.pedido);

  @override
  List<Object?> get props => [pedido];
}

// Mover de LISTO a EN PREPARACIÓN (regresar)
class MoverAEnPreparacionDesdeListo extends PedidosEvent {
  final PedidoItem pedido;

  const MoverAEnPreparacionDesdeListo(this.pedido);

  @override
  List<Object?> get props => [pedido];
}

// (Opcional: Agrega aquí más eventos si necesitas, como cancelar o reabrir)

import 'package:bartech_ordering/models/pedido.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'pedidos_event.dart';
part 'pedidos_state.dart';

class PedidosBloc extends Bloc<PedidosEvent, PedidosState> {
  PedidosBloc() : super(const PedidosState()) {
    on<CargarPedidos>(_onCargarPedidos);
    on<MoverAPreparacion>(_onMoverAPreparacion);
    on<MoverAListo>(_onMoverAListo);
    on<MoverANuevo>(_onMoverANuevo);
    on<MoverAEnPreparacionDesdeListo>(_onMoverAEnPreparacionDesdeListo);
  }

  void _onCargarPedidos(CargarPedidos event, Emitter<PedidosState> emit) {
    // Mocks con variedad de pedidos en cada estado
    final pedidosMock = [
      // --- Nuevos ---
      PedidoItem(
        nroOrden: '0010',
        cliente: 'Juan Torres',
        paraLlevar: true,
        producto: 'Pizza Familiar',
        cantidad: 1,
        ingredientes: ['Sin orégano', 'Extra queso', 'Sin ají'],
        acompanamientos: ['Gaseosa 1L', 'Papas'],
        observacion: 'Por favor, cortar en 8 partes',
        colorEstado: Colors.red, // NUEVO
        fechaHoraIngreso: DateTime.now().subtract(
          const Duration(minutes: 5),
        ), // 5 min atrás
      ),
      PedidoItem(
        nroOrden: '0011',
        cliente: 'Ana Díaz',
        paraLlevar: false,
        producto: 'Sandwich de Pollo',
        cantidad: 2,
        ingredientes: ['Extra mayonesa', 'Sin tomate'],
        acompanamientos: ['Chicha morada'],
        observacion: '',
        colorEstado: Colors.red, // NUEVO
        fechaHoraIngreso: DateTime.now().subtract(
          const Duration(minutes: 2),
        ), // 2 min atrás
      ),
      // --- En preparación ---
      PedidoItem(
        nroOrden: '0012',
        cliente: 'Pedro Gómez',
        paraLlevar: false,
        producto: 'Hamburguesa BBQ',
        cantidad: 1,
        ingredientes: ['Sin cebolla', 'Extra tocino'],
        acompanamientos: ['Papas fritas', 'Gaseosa pequeña'],
        observacion: 'Sin ketchup',
        colorEstado: Colors.amber, // EN PREPARACIÓN
        fechaHoraIngreso: DateTime.now().subtract(
          const Duration(minutes: 14),
        ), // 14 min atrás
      ),
      PedidoItem(
        nroOrden: '0013',
        cliente: 'Lucía Castro',
        paraLlevar: true,
        producto: 'Pollo Broaster',
        cantidad: 1,
        ingredientes: ['Con ensalada'],
        acompanamientos: ['Arroz', 'Inka Cola'],
        observacion: '',
        colorEstado: Colors.amber, // EN PREPARACIÓN
        fechaHoraIngreso: DateTime.now().subtract(
          const Duration(minutes: 20),
        ), // 20 min atrás
      ),
      // --- Listos ---
      PedidoItem(
        nroOrden: '0014',
        cliente: 'Mario Ruiz',
        paraLlevar: false,
        producto: 'Salchipapas',
        cantidad: 3,
        ingredientes: ['Sin mostaza', 'Extra salchicha'],
        acompanamientos: ['Gaseosa'],
        observacion: 'Para mesa 8',
        colorEstado: Colors.green, // LISTO
        fechaHoraIngreso: DateTime.now().subtract(
          const Duration(minutes: 35),
        ), // 35 min atrás
      ),
      PedidoItem(
        nroOrden: '0015',
        cliente: 'Sofía León',
        paraLlevar: true,
        producto: 'Hamburguesa Clásica',
        cantidad: 2,
        ingredientes: ['Sin pepinillos', 'Extra queso'],
        acompanamientos: ['Papas', 'Gaseosa'],
        observacion: 'Sin picante',
        colorEstado: Colors.green, // LISTO
        fechaHoraIngreso: DateTime.now().subtract(
          const Duration(minutes: 40, seconds: 50),
        ), // 40 min, 50 s atrás
      ),
    ];

    emit(
      state.copyWith(
        pedidosNuevos: pedidosMock
            .where((p) => p.colorEstado == Colors.red)
            .toList(),
        pedidosEnPreparacion: pedidosMock
            .where((p) => p.colorEstado == Colors.amber)
            .toList(),
        pedidosListos: pedidosMock
            .where((p) => p.colorEstado == Colors.green)
            .toList(),
      ),
    );
  }

  void _onMoverAPreparacion(
    MoverAPreparacion event,
    Emitter<PedidosState> emit,
  ) {
    final pedido = event.pedido.copyWith(colorEstado: Colors.amber);

    // Remueve solo si existe (seguridad)
    final nuevos = List<PedidoItem>.from(state.pedidosNuevos)
      ..removeWhere((p) => p.nroOrden == event.pedido.nroOrden);
    final enPreparacion = List<PedidoItem>.from(state.pedidosEnPreparacion)
      ..add(pedido);

    emit(
      state.copyWith(
        pedidosNuevos: nuevos,
        pedidosEnPreparacion: enPreparacion,
      ),
    );
  }

  void _onMoverAListo(MoverAListo event, Emitter<PedidosState> emit) {
    final pedido = event.pedido.copyWith(colorEstado: Colors.green);

    final enPreparacion = List<PedidoItem>.from(state.pedidosEnPreparacion)
      ..removeWhere((p) => p.nroOrden == event.pedido.nroOrden);
    final listos = List<PedidoItem>.from(state.pedidosListos)..add(pedido);

    emit(
      state.copyWith(
        pedidosEnPreparacion: enPreparacion,
        pedidosListos: listos,
      ),
    );
  }

  void _onMoverANuevo(MoverANuevo event, Emitter<PedidosState> emit) {
    final pedido = event.pedido.copyWith(colorEstado: Colors.red);
    final enPreparacion = List<PedidoItem>.from(state.pedidosEnPreparacion)
      ..removeWhere((p) => p.nroOrden == event.pedido.nroOrden);
    final nuevos = List<PedidoItem>.from(state.pedidosNuevos)..add(pedido);

    emit(
      state.copyWith(
        pedidosNuevos: nuevos,
        pedidosEnPreparacion: enPreparacion,
      ),
    );
  }

  void _onMoverAEnPreparacionDesdeListo(
    MoverAEnPreparacionDesdeListo event,
    Emitter<PedidosState> emit,
  ) {
    final pedido = event.pedido.copyWith(colorEstado: Colors.amber);
    final listos = List<PedidoItem>.from(state.pedidosListos)
      ..removeWhere((p) => p.nroOrden == event.pedido.nroOrden);
    final enPreparacion = List<PedidoItem>.from(state.pedidosEnPreparacion)
      ..add(pedido);

    emit(
      state.copyWith(
        pedidosListos: listos,
        pedidosEnPreparacion: enPreparacion,
      ),
    );
  }
}

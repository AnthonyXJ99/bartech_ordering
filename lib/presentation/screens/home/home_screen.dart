import 'package:bartech_ordering/models/pedido.dart';
import 'package:bartech_ordering/presentation/screens/bloc/pedidos_bloc/pedidos_bloc.dart';
import 'package:bartech_ordering/presentation/widgets/pedido_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos Nuevos"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: BlocBuilder<PedidosBloc, PedidosState>(
        builder: (context, state) {
          return DragTarget<PedidoItem>(
            onWillAcceptWithDetails: (details) =>
                details.data.colorEstado == Colors.amber,
            onAcceptWithDetails: (details) {
              final pedido = details.data;
              context.read<PedidosBloc>().add(MoverANuevo(pedido));
            },
            builder: (context, candidateData, rejectedData) {
              final pedidos = state.pedidosNuevos;
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: pedidos.length,
                itemBuilder: (context, index) {
                  final pedido = pedidos[index];
                  return LongPressDraggable<PedidoItem>(
                    data: pedido,
                    feedback: Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: 320,
                        child: PedidoCard(
                          pedido: pedido,
                          actionLabel: "Preparar",
                          actionIcon: Icons.restaurant,
                          actionColor: Colors.amber,
                          onMarcarListo: () {},
                        ),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: PedidoCard(
                        pedido: pedido,
                        actionLabel: "Preparar",
                        actionIcon: Icons.restaurant,
                        actionColor: Colors.amber,
                        onMarcarListo: () {},
                      ),
                    ),
                    child: PedidoCard(
                      pedido: pedido,
                      actionLabel: "Preparar",
                      actionIcon: Icons.restaurant,
                      actionColor: Colors.amber,
                      onMarcarListo: () {
                        context.read<PedidosBloc>().add(
                          MoverAPreparacion(pedido),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

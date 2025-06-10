import 'package:bartech_ordering/models/pedido.dart';
import 'package:bartech_ordering/presentation/screens/bloc/pedidos_bloc/pedidos_bloc.dart';
import 'package:bartech_ordering/presentation/widgets/pedido_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoingScreen extends StatelessWidget {
  const DoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos en Preparación"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: BlocBuilder<PedidosBloc, PedidosState>(
        builder: (context, state) {
          return DragTarget<PedidoItem>(
            onWillAcceptWithDetails: (details) =>
                details.data.colorEstado == Colors.red ||
                details.data.colorEstado == Colors.green,
            onAcceptWithDetails: (pedido) {
              final bloc = context.read<PedidosBloc>();
              if (pedido.data.colorEstado == Colors.red) {
                // Avanzar: NUEVO → EN PREPARACIÓN
                bloc.add(MoverAPreparacion(pedido.data));
              } else if (pedido.data.colorEstado == Colors.green) {
                // Retroceder: LISTO → EN PREPARACIÓN
                bloc.add(MoverAEnPreparacionDesdeListo(pedido.data));
              }
            },
            builder: (context, candidateData, rejectedData) {
              final pedidos = state.pedidosEnPreparacion;
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
                          actionLabel: "Listo",
                          actionIcon: Icons.check,
                          actionColor: Colors.green,
                          onMarcarListo: () {},
                        ),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: PedidoCard(
                        pedido: pedido,
                        actionLabel: "Listo",
                        actionIcon: Icons.check,
                        actionColor: Colors.green,
                        onMarcarListo: () {},
                      ),
                    ),
                    child: PedidoCard(
                      pedido: pedido,
                      actionLabel: "Listo",
                      actionIcon: Icons.check,
                      actionColor: Colors.green,
                      onMarcarListo: () {
                        context.read<PedidosBloc>().add(MoverAListo(pedido));
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

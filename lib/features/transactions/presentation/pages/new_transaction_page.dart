import 'package:flutter/material.dart';

class NewTransactionPage extends StatelessWidget {
  const NewTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo movimiento'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            '¿Qué quieres registrar?',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          _MovementTypeButton(
            title: 'Venta',
            subtitle: 'Dinero que ingresó al negocio',
            icon: Icons.arrow_upward,
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _MovementTypeButton(
            title: 'Gasto',
            subtitle: 'Pago o compra del negocio',
            icon: Icons.arrow_downward,
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _MovementTypeButton(
            title: 'Retiro personal',
            subtitle: 'Dinero que sacaste para ti',
            icon: Icons.person,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _MovementTypeButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _MovementTypeButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                child: Icon(icon),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
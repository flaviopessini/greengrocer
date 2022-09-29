import 'package:flutter/material.dart';
import 'package:greengrocer/src/configs/custom_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final bool isOverdue;
  final String status;

  final Map<String, int> allStatus = {
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 3,
    'shipping': 4,
    'delivered': 5,
  };

  int get currentStatus => allStatus[status]!;

  OrderStatusWidget({
    Key? key,
    required this.isOverdue,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StatusTile(
          isActive: true,
          title: 'Pedido confirmado',
        ),
        const _CustomDivider(),
        if (currentStatus == 1) ...[
          const _StatusTile(
            isActive: true,
            title: 'Pix falhou',
            backgroundColor: Colors.orange,
          ),
        ] else if (isOverdue) ...[
          const _StatusTile(
            isActive: true,
            title: 'Pix vencido',
            backgroundColor: Colors.red,
          ),
        ] else ...[
          _StatusTile(
            isActive: currentStatus >= 2,
            title: 'Pagamento',
          ),
          const _CustomDivider(),
          _StatusTile(
            isActive: currentStatus >= 3,
            title: 'Preparando',
          ),
          const _CustomDivider(),
          _StatusTile(
            isActive: currentStatus >= 4,
            title: 'Envio',
          ),
          const _CustomDivider(),
          _StatusTile(
            isActive: currentStatus >= 5,
            title: 'Entregue',
          ),
        ],
      ],
    );
  }
}

class _StatusTile extends StatelessWidget {
  final bool isActive;
  final String title;
  final Color? backgroundColor;

  const _StatusTile({
    Key? key,
    this.backgroundColor,
    required this.isActive,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20.0,
          width: 20.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: CustomColors.customSwatchColor,
            ),
            color: isActive
                ? backgroundColor ?? CustomColors.customSwatchColor
                : Colors.transparent,
          ),
          child: isActive
              ? const Icon(
                  Icons.check_rounded,
                  size: 13.0,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(width: 5.0),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
      height: 10.0,
      width: 2.0,
      color: Colors.grey.shade300,
    );
  }
}

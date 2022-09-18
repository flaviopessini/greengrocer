import 'package:flutter/material.dart';
import 'package:greengrocer/src/configs/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/common_widgets/payment_dialog.dart';
import 'package:greengrocer/src/pages/order/components/order_status_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  const OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          //backgroundColor: Colors.yellow,
        ),
        child: ExpansionTile(
          title: Text('Pedido: ${order.id}'),
          subtitle: Text(
            UtilsServices.formatDateTime(order.createdDateTime),
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 170.0,
                      child: ListView.separated(
                        separatorBuilder: (_, index) =>
                            const SizedBox(height: 16.0),
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: order.items.length,
                        itemBuilder: (ctx, index) =>
                            _OrderItemWidget(order.items[index]),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    color: Colors.grey,
                    thickness: 2.0,
                    width: 8.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: OrderStatusWidget(
                      isOverdue: order.overdueDateTime.isBefore(DateTime.now()),
                      status: order.status,
                    ),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                children: [
                  const TextSpan(
                    text: 'Total: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: UtilsServices.priceToCurrency(order.total),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: order.status == 'pending_payment',
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => PaymentDialog(order: order),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                icon: const Icon(Icons.qr_code_rounded),
                label: const Text('Ver QR Code Pix'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  final CartItemModel item;

  const _OrderItemWidget(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${item.quantity}\t',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        Text(
          '${item.item.unit}\t',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        Expanded(
          child: Text(
            '${item.item.itemName}\t',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // const Spacer(),
        Text(
          UtilsServices.priceToCurrency(item.totalPrice()),
          style: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

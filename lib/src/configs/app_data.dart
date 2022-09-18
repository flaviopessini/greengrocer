import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/models/user_model.dart';

ItemModel apple = ItemModel(
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  imgUrl: 'assets/fruits/apple.png',
  itemName: 'Maçã',
  price: 5.5,
  unit: 'kg',
);

ItemModel grape = ItemModel(
  imgUrl: 'assets/fruits/grape.png',
  itemName: 'Uva',
  price: 7.4,
  unit: 'kg',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
  imgUrl: 'assets/fruits/guava.png',
  itemName: 'Goiaba',
  price: 11.5,
  unit: 'kg',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  imgUrl: 'assets/fruits/kiwi.png',
  itemName: 'Kiwi',
  price: 2.5,
  unit: 'un',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  imgUrl: 'assets/fruits/mango.png',
  itemName: 'Manga',
  price: 2.5,
  unit: 'un',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  imgUrl: 'assets/fruits/papaya.png',
  itemName: 'Mamão papaya',
  price: 8,
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

// Lista de produtos
List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];

List<String> categories = [
  'Frutas',
  'Cafés',
  'Cereais',
  'Embutidos',
  'Laticínios',
  'Legumes',
  'Temperos',
  'Verduras',
];

List<CartItemModel> cartItems = [
  CartItemModel(item: apple, quantity: 2),
  CartItemModel(item: mango, quantity: 1),
  CartItemModel(item: guava, quantity: 3),
];

UserModel user = UserModel(
  name: 'Flávio H P',
  phone: '17 9 92019999',
  email: 'email@example.com',
  password: '12345678',
  cpf: '000.111.333-55',
);

List<OrderModel> orders = [
  // Pedido 01
  OrderModel(
    copyAndPaste: 'q1w2e3r4t5y6',
    createdDateTime: DateTime.parse(
      '2022-10-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2022-10-08 11:00:10.458',
    ),
    id: 'asd6a54da6s2d1',
    status: 'refunded',
    total: 11.0,
    items: [
      CartItemModel(
        item: apple,
        quantity: 2,
      ),
      CartItemModel(
        item: mango,
        quantity: 2,
      ),
    ],
  ),

  // Pedido 02
  OrderModel(
    copyAndPaste: 'q1w2e3r4t5y6',
    createdDateTime: DateTime.parse(
      '2022-10-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2022-10-08 11:00:10.458',
    ),
    id: 'a65s4d6a2s1d6a5s',
    status: 'pending_payment',
    total: 11.5,
    items: [
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
    ],
  ),

  // Pedido 03
  OrderModel(
    copyAndPaste: 'a2b2e3r45go9',
    createdDateTime: DateTime.parse(
      '2022-10-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2022-10-08 11:00:10.458',
    ),
    id: 'a65s4d6a2s1d6a5s',
    status: 'paid',
    total: 11.5,
    items: [
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
    ],
  ),

  // Pedido 04
  OrderModel(
    copyAndPaste: 't442e3r4u890',
    createdDateTime: DateTime.parse(
      '2022-10-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2022-10-08 11:00:10.458',
    ),
    id: 'a65s4d6a2s1d6a5s',
    status: 'preparing_purchase',
    total: 11.5,
    items: [
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
    ],
  ),

  // Pedido 04
  OrderModel(
    copyAndPaste: 'j873h4r4u876',
    createdDateTime: DateTime.parse(
      '2022-10-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2022-10-08 11:00:10.458',
    ),
    id: 'a65s4d6a2s1d6a5s',
    status: 'shipping',
    total: 11.5,
    items: [
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
    ],
  ),

  // Pedido 05
  OrderModel(
    copyAndPaste: 'f4k3h8j4u0pl',
    createdDateTime: DateTime.parse(
      '2022-10-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2022-10-08 11:00:10.458',
    ),
    id: 'a65s4d6a2s1d6a5s',
    status: 'delivered',
    total: 11.5,
    items: [
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
    ],
  ),
];

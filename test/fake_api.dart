import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// Igual que [test], pero las peticiones HTTP las responde [_fakeApi].
void testWithFakeApi(String description, Future<void> Function() body) {
  test(description, () => http.runWithClient(body, () => _fakeApi));
}

/// Igual que [testWidgets], pero las peticiones HTTP las responde [_fakeApi].
void testWidgetsWithFakeApi(String description, WidgetTesterCallback body) {
  testWidgets(description, (tester) {
    return http.runWithClient(() => body(tester), () => _fakeApi);
  });
}

/// Responde como Fake Store API con unos pocos datos, para que las pruebas no
/// dependan de internet. Si no conoce la URL responde 404.
final _fakeApi = MockClient((request) async {
  final data = _responses[request.url.toString()];
  if (data == null) return http.Response('Not Found', 404);
  return http.Response(jsonEncode(data), 200);
});

// Datos con la misma forma que las respuestas reales.

const _backpack = {
  'id': 1,
  'title': 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
  'price': 109.95,
  'description': 'Your perfect pack for everyday use and walks in the forest.',
  'category': "men's clothing",
  'image': 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
  'rating': {'rate': 3.9, 'count': 120},
};

const _bracelet = {
  'id': 5,
  'title': "John Hardy Women's Legends Naga Chain Bracelet",
  'price': 695,
  'description': 'From our Legends Collection.',
  'category': 'jewelery',
  'image': 'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_t.png',
  'rating': {'rate': 4.6, 'count': 400},
};

const _hardDrive = {
  'id': 9,
  'title': 'WD 2TB Elements Portable External Hard Drive - USB 3.0 ',
  'price': 64,
  'description': 'USB 3.0 and USB 2.0 Compatibility.',
  'category': 'electronics',
  'image': 'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_t.png',
  'rating': {'rate': 3.3, 'count': 203},
};

const _cart1 = {
  'id': 1,
  'userId': 1,
  'date': '2020-03-02T00:00:00.000Z',
  'products': [
    {'productId': 1, 'quantity': 4},
    {'productId': 2, 'quantity': 1},
    {'productId': 3, 'quantity': 6},
  ],
};

const _cart3 = {
  'id': 3,
  'userId': 2,
  'date': '2020-03-01T00:00:00.000Z',
  'products': [
    {'productId': 1, 'quantity': 2},
    {'productId': 9, 'quantity': 1},
  ],
};

const _david = {
  'id': 2,
  'email': 'morrison@gmail.com',
  'username': 'mor_2314',
  'name': {'firstname': 'david', 'lastname': 'morrison'},
  'address': {
    'city': 'kilcoole',
    'street': 'Lovers Ln',
    'number': 7267,
    'zipcode': '12926-3874',
    'geolocation': {'lat': '-37.3159', 'long': '81.1496'},
  },
  'phone': '1-570-236-7033',
};

const _responses = {
  'https://fakestoreapi.com/products': [_backpack, _bracelet],
  'https://fakestoreapi.com/products/1': _backpack,
  'https://fakestoreapi.com/products/5': _bracelet,
  'https://fakestoreapi.com/products/9': _hardDrive,
  'https://fakestoreapi.com/carts': [_cart1, _cart3],
  'https://fakestoreapi.com/carts/3': _cart3,
  'https://fakestoreapi.com/users/2': _david,
};

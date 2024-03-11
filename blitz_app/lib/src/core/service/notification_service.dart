import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void subscribeTopic(String tituloTopico) {
  // Intenta suscribir al usuario al tópico especificado
  FirebaseMessaging.instance.subscribeToTopic(tituloTopico);
}

Future<void> sendNotificationToTopic(String tituloTopico) async {
  String servidorFCM = 'https://fcm.googleapis.com/fcm/send';
  String tokenServidorFCM =
      'AAAAEZZn7W4:APA91bHRGdwzengbTr9AWkZBjzB0lEWIiw-8-HgeaQotztail18fzxoAZoRvjxyVdQdtcbNV2TnRX05K6Q3ySUr6x2-c5bdL4a0FaoNlRGoNyLBbYmKCzWxJozKg_iCMZi1H638J5xso'; // Puedes obtenerlo desde la consola de Firebase

  final Map<String, dynamic> mensajeFCM = {
    'notification': {
      'title': 'Pedido nuevo',
      'body': 'Un cliente ha creado un nuevo pedido'
    },
    'to': '/topics/$tituloTopico'
  };

  Response resp = await Dio().post(
    servidorFCM,
    options: Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'key=$tokenServidorFCM',
    }),
    data: mensajeFCM,
  );

  if (resp.statusCode == 200) {
    print('Notificación enviada al tópico $tituloTopico');
  } else {
    print(
        'Error al enviar la notificación al tópico $tituloTopico: ${resp.data}');
  }
}

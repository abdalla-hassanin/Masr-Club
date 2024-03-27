import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:masr_club/app/data/models/event_model.dart';

class EventRemoteDataSource {
  final Dio dio;

  EventRemoteDataSource(this.dio);

  Future<List<EventModel>> getEvents() async {
    final response = await dio.get(
        'https://265ead3c-995e-46eb-9e92-35f843eca14f.mock.pstmn.io/events');
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.data);
      return jsonData.map((json) => EventModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}

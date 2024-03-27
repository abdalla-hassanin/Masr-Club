import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../data_sources/event_remote_data_source.dart';
import '../models/event_model.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource remoteDataSource;

  EventRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Event>> getEvents() async {
    final List<EventModel> eventModels = await remoteDataSource.getEvents();
    return eventModels.map((model) => Event(
      id: model.id,
      name: model.name,
      category: model.category,
      location: model.location,
      latitude: model.latitude,
      longitude: model.longitude,
      description: model.description,
      date: model.date,
      time: model.time,
    )).toList();
  }
}

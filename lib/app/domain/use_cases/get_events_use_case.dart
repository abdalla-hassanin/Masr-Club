import '../entities/event.dart';
import '../repositories/event_repository.dart';

class GetEventsUseCase {
  final EventRepository repository;

  GetEventsUseCase(this.repository);

  Future<List<Event>> execute() async {
    return await repository.getEvents();
  }
}

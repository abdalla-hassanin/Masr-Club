import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/event.dart';
import '../../domain/use_cases/get_events_use_case.dart';

part 'event_event.dart';

part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetEventsUseCase getEventsUseCase;

  EventBloc(this.getEventsUseCase) : super(EventInitial()) {
    on<FetchEvents>((event, emit) async {
      emit(EventLoading());
      try {
        final List<Event> result = await getEventsUseCase.execute();
        emit(EventLoaded(result));
      } catch (e) {
        emit(EventError("Failed to fetch events: $e"));
      }
    });
  }
}

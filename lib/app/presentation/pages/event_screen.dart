import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masr_club/app/domain/entities/event.dart';
import 'package:masr_club/app/presentation/manager/event_bloc.dart';
import 'package:masr_club/app/presentation/pages/event_map_screen.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventInitial) {
          return const Center(child: Text('No events yet.'));
        } else if (state is EventLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EventLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final event = state.events[index];
                return EventCart(event);
              },
            ),
          );
        } else if (state is EventError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}

class EventCart extends StatelessWidget {
  final Event event;

  const EventCart(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(event.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              Row(children: [
                const Icon(
                  Icons.directions_boat_outlined,
                  color: Colors.blueGrey,
                ),
                Text(
                  event.category,
                  style: const TextStyle(fontSize: 16),
                ),
              ]),
              const SizedBox(
                height: 6,
              ),
              Row(children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                Text(
                  event.location,
                  style: const TextStyle(fontSize: 16),
                ),
              ]),
              const SizedBox(
                height: 6,
              ),
              Row(children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.blue,
                ),
                Text(
                  "${event.date} | ${event.time}",
                  style: const TextStyle(fontSize: 16),
                ),
              ]),
              const SizedBox(
                height: 8,
              ),
              Text(
                event.description,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventMapScreen(
                        event: event,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'View on Map',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

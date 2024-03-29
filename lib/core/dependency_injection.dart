import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:masr_club/app/data/data_sources/event_remote_data_source.dart';
import 'package:masr_club/app/data/repositories/event_repository_impl.dart';
import 'package:masr_club/app/domain/use_cases/get_events_use_case.dart';
import 'package:masr_club/app/presentation/manager/event_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  // Register dependencies
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<EventRemoteDataSource>(() => EventRemoteDataSource(getIt<Dio>()));
  getIt.registerLazySingleton<EventRepositoryImpl>(() => EventRepositoryImpl(getIt<EventRemoteDataSource>()));
  getIt.registerLazySingleton<GetEventsUseCase>(() => GetEventsUseCase(getIt<EventRepositoryImpl>()));
  getIt.registerFactory<EventBloc>(() => EventBloc(getIt<GetEventsUseCase>()));
}
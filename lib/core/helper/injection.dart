import 'package:connectme_app/data/repositories/auth_repository_impl.dart';
import 'package:connectme_app/domain/repositories/auth_repository.dart';
import 'package:connectme_app/presentation/blocs/auth_cubit.dart';
import 'package:connectme_app/services/auth_service.dart';
import 'package:get_it/get_it.dart';

// Dependency Injection setup using GetIt
// This container manages the lifecycle of all app dependencies
final getIt = GetIt.instance;

void setupDependencies() {
  // Singleton Pattern: AuthService registered as singleton
  // Only one instance exists throughout the app lifecycle
  getIt.registerLazySingleton<AuthService>(() => AuthService());

  // Singleton Pattern: AuthRepository implementation registered as singleton
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthService>()),
  );

  // Factory Pattern: AuthCubit registered as factory
  // A new instance is created each time it's requested
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepository>()));
}

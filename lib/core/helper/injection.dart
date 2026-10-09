import 'package:connectme_app/data/datasources/firestore_post_datasource.dart';
import 'package:connectme_app/data/datasources/local_post_datasource.dart';
import 'package:connectme_app/data/datasources/post_datasource_factory.dart';
import 'package:connectme_app/data/repositories/auth_repository_impl.dart';
import 'package:connectme_app/data/repositories/post_repository_impl.dart';
import 'package:connectme_app/domain/repositories/auth_repository.dart';
import 'package:connectme_app/domain/repositories/post_repository.dart';
import 'package:connectme_app/domain/usecases/create_post.dart';
import 'package:connectme_app/domain/usecases/get_posts.dart';
import 'package:connectme_app/presentation/blocs/auth_cubit.dart';
import 'package:connectme_app/presentation/blocs/post_cubit.dart';
import 'package:connectme_app/services/auth_service.dart';
import 'package:connectme_app/services/firestore_service.dart';
import 'package:get_it/get_it.dart';

// Dependency Injection setup using GetIt
// This container manages the lifecycle of all app dependencies
final getIt = GetIt.instance;

void setupDependencies() {
  // Singleton Pattern: FirestoreService
  // Only one instance exists throughout the app lifecycle
  // The Singleton Pattern is implemented in the class itself with a private constructor
  // and factory constructor, not just through GetIt registration
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());

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

  // Register datasources for posts
  getIt.registerLazySingleton<FirestorePostDataSource>(
    () => FirestorePostDataSource(getIt<FirestoreService>()),
  );

  getIt.registerLazySingleton<LocalPostDataSource>(() => LocalPostDataSource());

  // Factory Pattern: PostDataSourceFactory
  // This factory is responsible for selecting the appropriate datasource
  // (remote Firestore vs local cache) based on application needs
  getIt.registerFactory<PostDataSourceFactory>(
    () => PostDataSourceFactory(
      remoteDataSource: getIt<FirestorePostDataSource>(),
      localDataSource: getIt<LocalPostDataSource>(),
    ),
  );

  // Singleton Pattern: PostRepository implementation registered as singleton
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(getIt<PostDataSourceFactory>()),
  );

  // Register use cases
  getIt.registerFactory<GetPosts>(() => GetPosts(getIt<PostRepository>()));

  getIt.registerFactory<CreatePost>(() => CreatePost(getIt<PostRepository>()));

  // Factory Pattern: PostCubit registered as factory
  // A new instance is created each time it's requested
  getIt.registerFactory<PostCubit>(
    () => PostCubit(getIt<GetPosts>(), getIt<CreatePost>()),
  );
}

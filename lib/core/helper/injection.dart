import 'package:get_it/get_it.dart';
import 'package:connectme_app/data/datasources/biometric_datasource.dart';
import 'package:connectme_app/data/datasources/device_info_datasource.dart';
import 'package:connectme_app/data/datasources/firestore_post_datasource.dart';
import 'package:connectme_app/data/datasources/local_post_datasource.dart';
import 'package:connectme_app/data/datasources/post_datasource_factory.dart';
import 'package:connectme_app/data/datasources/profile_image_data_source.dart';
import 'package:connectme_app/data/repositories/auth_repository_impl.dart';
import 'package:connectme_app/data/repositories/post_repository_impl.dart';
import 'package:connectme_app/domain/repositories/auth_repository.dart';
import 'package:connectme_app/domain/repositories/post_repository.dart';
import 'package:connectme_app/domain/usecases/create_post.dart';
import 'package:connectme_app/domain/usecases/get_posts.dart';
import 'package:connectme_app/presentation/blocs/auth_cubit.dart';
import 'package:connectme_app/presentation/blocs/biometric_cubit.dart';
import 'package:connectme_app/presentation/blocs/device_info_cubit.dart';
import 'package:connectme_app/presentation/blocs/post_cubit.dart';
import 'package:connectme_app/presentation/blocs/profile_cubit.dart';
import 'package:connectme_app/services/auth_service.dart';
import 'package:connectme_app/services/firestore_service.dart';

// Dependency Injection setup
final getIt = GetIt.instance;

void setupDependencies() {
  // Services
  getIt.registerLazySingleton<FirestoreService>(
    () => FirestoreService(),
  );

  getIt.registerLazySingleton<AuthService>(
    () => AuthService(),
  );

  // Authentication
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthService>()),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<AuthRepository>()),
  );

  // Post data sources
  getIt.registerLazySingleton<FirestorePostDataSource>(
    () => FirestorePostDataSource(getIt<FirestoreService>()),
  );

  getIt.registerLazySingleton<LocalPostDataSource>(
    () => LocalPostDataSource(),
  );

  // Factory: selects the appropriate post data source
  getIt.registerFactory<PostDataSourceFactory>(
    () => PostDataSourceFactory(
      remoteDataSource: getIt<FirestorePostDataSource>(),
      localDataSource: getIt<LocalPostDataSource>(),
    ),
  );

  // Post repository
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(getIt<PostDataSourceFactory>()),
  );

  // Post use cases
  getIt.registerFactory<GetPosts>(
    () => GetPosts(getIt<PostRepository>()),
  );

  getIt.registerFactory<CreatePost>(
    () => CreatePost(getIt<PostRepository>()),
  );

  // Post Cubit
  getIt.registerFactory<PostCubit>(
    () => PostCubit(
      getIt<GetPosts>(),
      getIt<CreatePost>(),
    ),
  );

  // Biometric authentication
  getIt.registerLazySingleton<BiometricDataSource>(
    () => BiometricDataSource(),
  );

  getIt.registerFactory<BiometricCubit>(
    () => BiometricCubit(getIt<BiometricDataSource>()),
  );

  // Device information
  getIt.registerLazySingleton<DeviceInfoDataSource>(
    () => DeviceInfoDataSource(),
  );

  getIt.registerFactory<DeviceInfoCubit>(
    () => DeviceInfoCubit(getIt<DeviceInfoDataSource>()),
  );

  // Local profile image storage
  getIt.registerLazySingleton<ProfileImageDataSource>(
    () => ProfileImageDataSource(),
  );

  // Profile
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      getIt<AuthService>(),
      getIt<FirestoreService>(),
      getIt<ProfileImageDataSource>(),
    ),
  );
}

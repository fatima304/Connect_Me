import 'package:connectme_app/data/datasources/firestore_post_datasource.dart';
import 'package:connectme_app/data/datasources/local_post_datasource.dart';

// Factory Pattern: PostDataSourceFactory
// This factory is responsible for selecting and creating the appropriate datasource
// based on the application's needs (remote Firestore vs local cache)
// This is the actual Factory Design Pattern implementation, not GetIt registration
class PostDataSourceFactory {
  PostDataSourceFactory({
    required FirestorePostDataSource remoteDataSource,
    required LocalPostDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final FirestorePostDataSource _remoteDataSource;
  final LocalPostDataSource _localDataSource;

  // Returns the remote Firestore datasource
  // Use this when you need to fetch from or save to Firestore
  FirestorePostDataSource getRemoteDataSource() {
    return _remoteDataSource;
  }

  // Returns the local cache datasource
  // Use this when you need to read from or save to local cache
  LocalPostDataSource getLocalDataSource() {
    return _localDataSource;
  }

  // Example of factory method that could select based on conditions
  // For this assignment, we provide explicit getters for clarity
  // In a more complex scenario, this could use logic like:
  // - Check network connectivity
  // - Check user preferences
  // - Check cache freshness
  // to decide which datasource to return
}

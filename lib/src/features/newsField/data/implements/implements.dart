
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class NewsbarRepositoryImp implements NewsbarRepository{

        final NewsbarRemoteDataSource remoteDataSource;
        NewsbarRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    
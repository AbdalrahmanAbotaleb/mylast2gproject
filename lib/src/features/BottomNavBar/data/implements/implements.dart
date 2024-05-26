
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class HomeviewRepositoryImp implements HomeviewRepository{

        final HomeviewRemoteDataSource remoteDataSource;
        HomeviewRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    
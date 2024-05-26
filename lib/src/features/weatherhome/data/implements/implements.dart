
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class WeatherhomeRepositoryImp implements WeatherhomeRepository{

        final WeatherhomeRemoteDataSource remoteDataSource;
        WeatherhomeRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    
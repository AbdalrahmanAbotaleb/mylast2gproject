
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class ScanninghomeRepositoryImp implements ScanninghomeRepository{

        final ScanninghomeRemoteDataSource remoteDataSource;
        ScanninghomeRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    
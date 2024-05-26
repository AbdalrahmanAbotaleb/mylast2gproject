
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class ChatbotRepositoryImp implements ChatbotRepository{

        final ChatbotRemoteDataSource remoteDataSource;
        ChatbotRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    
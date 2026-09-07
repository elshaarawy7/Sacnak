import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/auth/data/model/user_model.dart';

class GoogleState {} 

class GoogleInitial extends GoogleState {} 

 class GoogleLoading extends GoogleState {} 

  class GoogleSuccess extends GoogleState {
    final UserModel userModel ;

    GoogleSuccess({required this.userModel}); 
  } 

  class GoogleFailure extends GoogleState {
    final Fuiler error ;

    GoogleFailure({required this.error});
    
  } 
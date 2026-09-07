import 'package:sacny/feat/auth/data/model/user_model.dart';

abstract class RegesterState {} 

class RegesterInitial extends RegesterState {} 

class RegesterLoading extends RegesterState {} 

class RegesterSuccess extends RegesterState {
  final UserModel user;

  RegesterSuccess(this.user);
} 

class RegesterFailure extends RegesterState {
  final String errorMessage;

  RegesterFailure(this.errorMessage);
} 
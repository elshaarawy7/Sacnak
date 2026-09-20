class ProfileAdminState {} 
class ProfileAdminInitial extends ProfileAdminState {} 
class ProfileAdminLoading extends ProfileAdminState {} 
class ProfileAdminSuccess extends ProfileAdminState {} 
class ProfileAdminFailure extends ProfileAdminState {
  final String errorMessage;

  ProfileAdminFailure({required this.errorMessage});
}
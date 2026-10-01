class ProfileClientState {} 
class ProfileClientInitial extends ProfileClientState {} 
class ProfileClientLoading extends ProfileClientState {} 
class ProfileClientSuccess extends ProfileClientState {} 
class ProfileClientFailure extends ProfileClientState {
  final String errorMessage;

  ProfileClientFailure({required this.errorMessage});
} 
part of 'all_user_bloc.dart';

sealed class AllUserState extends Equatable {
  const AllUserState();

  @override
  List<Object> get props => [];
}

final class AllUserInitial extends AllUserState {}

final class AllUserLoading extends AllUserState {
}

final class AllUserFailed extends AllUserState {
  final String message;

  const AllUserFailed({required this.message});
  @override
  List<Object> get props => [message];
}

final class AllUserLoaded extends AllUserState {
  final List<UserEntity> data;

  const AllUserLoaded(this.data);
  @override
  List<Object> get props => [data];
}


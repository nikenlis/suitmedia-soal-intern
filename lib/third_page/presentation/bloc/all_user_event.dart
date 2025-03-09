part of 'all_user_bloc.dart';

sealed class AllUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllUserEvent extends AllUserEvent {

}

class LoadMoreUsersEvent extends AllUserEvent {
}





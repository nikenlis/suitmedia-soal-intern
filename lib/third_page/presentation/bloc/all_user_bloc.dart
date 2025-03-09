import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_all_user_usecase.dart';

part 'all_user_event.dart';
part 'all_user_state.dart';

class AllUserBloc extends Bloc<AllUserEvent, AllUserState> {
  final GetAllUserUsecase _useCase;
  int currentPage = 1;
  bool hasMoreData = true;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();

  AllUserBloc(this._useCase) : super(AllUserInitial()) {
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 500 && hasMoreData) {
        add(LoadMoreUsersEvent());
      }
    });

    on<GetAllUserEvent>((event, emit) async {
      emit(AllUserLoading());

      resetPagination();

      final result = await _useCase.execute(currentPage);
      result.fold(
        (failure) {
          emit(AllUserFailed(message: failure.message));
        },
        (data) {
          emit(AllUserLoaded(data));

          if (data.isEmpty) {
            hasMoreData = false;
          } else {
            Future.delayed(Duration(milliseconds: 300), () {
              if (_needsMoreData()) {
                add(LoadMoreUsersEvent());
              }
            });
          }
        },
      );
    });

    on<LoadMoreUsersEvent>((event, emit) async {
      if (isLoadingMore || !hasMoreData) return;

      isLoadingMore = true;
      currentPage++;

      final result = await _useCase.execute(currentPage);
      result.fold(
        (failure) {
          emit(AllUserFailed(message: failure.message));
        },
        (data) {
          if (data.isNotEmpty) {
            final currentState = state as AllUserLoaded;
            emit(AllUserLoaded([...currentState.data, ...data]));

            Future.delayed(Duration(milliseconds: 300), () {
              if (_needsMoreData()) {
                add(LoadMoreUsersEvent());
              }
            });
          } else {
            hasMoreData = false;
          }
        },
      );

      isLoadingMore = false;
    });
  }

  bool _needsMoreData() {
    return scrollController.hasClients &&
        scrollController.position.maxScrollExtent < 500 &&
        hasMoreData;
  }

  void resetPagination() {
    currentPage = 1;
    hasMoreData = true;
    isLoadingMore = false;
  }
}

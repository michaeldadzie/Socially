import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:socially/features/authentication/data/models/failure_model.dart';
import 'package:socially/features/profile/data/models/user_model.dart';
import 'package:socially/features/profile/data/repositories/user/user_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final UserRepository _userRepository;
  SearchCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(SearchState.initial());

  void searchUsers(String query) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final users = await _userRepository.searchUsers(query: query);
      emit(state.copyWith(users: users, status: SearchStatus.loaded));
    } catch (err) {
      state.copyWith(
        status: SearchStatus.error,
        failure:
            const Failure(message: 'Something went wrong. Please try again'),
      );
    }
  }

  void clearSearch() {
    emit(state.copyWith(users: [], status: SearchStatus.initial));
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tea_time/data/model/user.dart';
import 'package:tea_time/domain/entities/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInitial());

  Future<void> getUserInfos() async {
    emit(const UserLoading());
    try {
      final User user = await fetchUser();
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}

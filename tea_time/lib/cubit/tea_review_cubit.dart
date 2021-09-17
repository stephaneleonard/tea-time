import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tea_time/model/tea_review.dart';

part 'tea_review_state.dart';

class TeaReviewCubit extends Cubit<TeaReviewState> {
  TeaReviewCubit() : super(const TeaReviewInitial());

  Future<void> getTeaReviewInfos(String id) async {
    emit(const TeaReviewLoading());
    try {
      final TeaReview teaReview = await fetchTeaReview(id);
      emit(TeaReviewLoaded(teaReview));
    } catch (e) {
      emit(TeaReviewError(e.toString()));
    }
  }
}

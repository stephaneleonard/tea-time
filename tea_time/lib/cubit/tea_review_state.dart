part of 'tea_review_cubit.dart';

@immutable
abstract class TeaReviewState {
  const TeaReviewState();
}

class TeaReviewInitial extends TeaReviewState {
  const TeaReviewInitial();
}

class TeaReviewLoading extends TeaReviewState {
  const TeaReviewLoading();
}

class TeaReviewLoaded extends TeaReviewState {
  const TeaReviewLoaded(this.teaReview);
  final TeaReview teaReview;

  @override
  // ignore: avoid_renaming_method_parameters
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is TeaReviewLoaded && o.teaReview == teaReview;
  }

  @override
  int get hashCode => teaReview.hashCode;
}

class TeaReviewError extends TeaReviewState {
  const TeaReviewError(this.message);
  final String message;
}

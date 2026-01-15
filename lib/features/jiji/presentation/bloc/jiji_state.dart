part of 'jiji_bloc.dart';

sealed class JijiState extends Equatable {
  const JijiState();
}

final class JijiInitial extends JijiState {
  @override
  List<Object> get props => [];
}

final class JijiLoadingState extends JijiState {
  @override
  List<Object?> get props => [];
}

final class JijiLoadedState extends JijiState {
  final String response;

  const JijiLoadedState({required this.response});

  @override
  List<Object> get props => [response];
}

final class JijiErrorState extends JijiState {
  final String errorMessage;
  final int errorTimeStamp;

  const JijiErrorState({required this.errorMessage, required this.errorTimeStamp});

  @override
  List<Object> get props => [errorMessage, errorTimeStamp];
}
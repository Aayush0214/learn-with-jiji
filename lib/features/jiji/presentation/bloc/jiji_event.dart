part of 'jiji_bloc.dart';

sealed class JijiEvent extends Equatable {
  const JijiEvent();
}

class SendQueryEvent extends JijiEvent {
  final String query;
  const SendQueryEvent({required this.query});

  @override
  List<Object> get props => [query];
}
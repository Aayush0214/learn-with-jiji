import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'jiji_event.dart';

part 'jiji_state.dart';

class JijiBloc extends Bloc<JijiEvent, JijiState> {
  JijiBloc() : super(JijiInitial()) {
    on<JijiEvent>((event, emit) {});
    on<SendQueryEvent>(_onSendQuery);
  }

  Future<void> _onSendQuery(SendQueryEvent event, Emitter<JijiState> emit) async {
    debugPrint("event called");
    if (event.query.isEmpty) {
      emit(JijiErrorState(errorMessage: "Please write your query to get answer", errorTimeStamp: DateTime.now().millisecond),);
      return;
    }
    emit(JijiLoadingState());

    // Fake AI processing simulation
    await Future.delayed(const Duration(seconds: 3));

    emit(
      JijiLoadedState(
        response: '''
Retrieval-Augmented Generation (RAG) combines search with large language models to improve accuracy by pulling relevant data from external sources.

• Retrieves data from external sources
• Uses a language model to generate answers
• Enhances the accuracy of responses
        ''',
      ),
    );
  }
}

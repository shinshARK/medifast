
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_event.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_state.dart';
import 'package:rumah_sakit/repositories/transaction_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final SharedPreferences sharedPreferences;
  final TransactionRepository transactionRepository;

  TransactionBloc(this.sharedPreferences, this.transactionRepository) : super(TransactionInitial()) {
    on<TransactionRequested>(_onTransactionRequested);
  }

  Future<void> _onTransactionRequested(TransactionRequested event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    
    try {
      final transactions = await transactionRepository.fetchTransactions(event.userId);
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionFailure(e.toString()));
    }
  }
}
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
    on<PostTransactionRequested>(_onPostTransactionRequested);
    on<TransactionUpdateRequested>(_onTransactionUpdateRequested); // Register the new event handler
  }

  Future<void> _onTransactionRequested(TransactionRequested event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    
    try {
      final transactions = await transactionRepository.fetchTransactions(event.userId);
      emit(TransactionLoaded(transactions));
    } catch (e) {
      print(e.toString());
      emit(TransactionFailure(e.toString()));
    }
  }

  Future<void> _onPostTransactionRequested(PostTransactionRequested event, Emitter<TransactionState> emit) async {
    emit(PostTransactionLoading());
    try {
      await transactionRepository.postTransaction(event.transactionData, event.pasien);
      emit(PostTransactionSuccess());
    } catch (e) {
      emit(PostTransactionFailure(e.toString()));
    }
  }

  Future<void> _onTransactionUpdateRequested(TransactionUpdateRequested event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try {
      await transactionRepository.updateTransaction(event.transactionId, event.updatedData);
      emit(UpdateTransactionSuccess());
    } catch (e) {
      emit(UpdateTransactionFailure(e.toString()));
    }
  }
}



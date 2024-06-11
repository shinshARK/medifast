import 'package:equatable/equatable.dart';
import 'package:rumah_sakit/models/riwayat_transaksi_model.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();
  
  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<RiwayatTransaksiModel> transactions;

  const TransactionLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TransactionFailure extends TransactionState {
  final String error;

  const TransactionFailure(this.error);

  @override
  List<Object> get props => [error];
}

class PostTransactionLoading extends TransactionState {}

class PostTransactionSuccess extends TransactionState {}

class PostTransactionFailure extends TransactionState {
  final String error;

  const PostTransactionFailure(this.error);

  @override
  List<Object> get props => [error];
}

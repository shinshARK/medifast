import 'package:equatable/equatable.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionRequested extends TransactionEvent {
  final int userId;

  TransactionRequested({required this.userId});

  @override
  List<Object> get props => [userId];
}

class PostTransactionRequested extends TransactionEvent {
  final Map<String, dynamic> transactionData;

  PostTransactionRequested({required this.transactionData});

  @override
  List<Object> get props => [transactionData];
}

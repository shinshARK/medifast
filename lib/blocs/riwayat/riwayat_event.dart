import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
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
  final Map<String, dynamic> pasien;

  PostTransactionRequested({required this.transactionData, required this.pasien});

  @override
  List<Object> get props => [transactionData, pasien];
}

class TransactionUpdateRequested extends TransactionEvent {
  final int transactionId;
  final Map<String, dynamic> updatedData;

  TransactionUpdateRequested({required this.transactionId, required this.updatedData});

  @override
  List<Object> get props => [transactionId, updatedData];
}

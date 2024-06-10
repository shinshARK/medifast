import 'package:equatable/equatable.dart';
import 'package:rumah_sakit/models/riwayat_transaksi_model.dart';

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
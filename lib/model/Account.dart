import 'Mutation.dart';

class Account {
  final int balance;
  final int credit;
  final int debit;
  List<Mutation> mutations;

  Account(
      {
        this.balance,
        this.credit,
        this.debit,
        this.mutations, 
      });

  Account.fromMap(Map<String, dynamic> map)
      : balance   = map['balance'] ,
        credit    = map['credit'] ,
        debit     = map['debit']        
         ;
}

part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class ChangeTabEvent extends DashboardEvent {
  const ChangeTabEvent({required this.tab});

  final int tab;

  @override
  List<Object?> get props => [tab];
}

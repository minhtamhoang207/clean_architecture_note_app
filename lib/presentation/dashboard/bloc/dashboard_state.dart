part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  const DashboardInitial({required this.currentTab});

  final int currentTab;

  @override
  List<Object> get props => [currentTab];
}

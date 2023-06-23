import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardInitial(currentTab: 0)) {
    on<ChangeTabEvent>(_onChangeTab);
  }

  FutureOr<void> _onChangeTab(ChangeTabEvent event, Emitter<DashboardState> emit) {
    emit(DashboardInitial(currentTab: event.tab));
  }
}

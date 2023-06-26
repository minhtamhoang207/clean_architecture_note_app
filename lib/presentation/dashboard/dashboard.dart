import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:just_notes/core/util/app_colors.dart';
import 'package:just_notes/presentation/account/account_view.dart';
import 'package:just_notes/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:just_notes/presentation/friend/friend_view.dart';
import 'package:just_notes/presentation/manage_money/manage_money.dart';
import 'package:just_notes/presentation/note/note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  static String routeName = 'dashboard';
  static String routeLocation = '/';
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            state as DashboardInitial;
            return Stack(
              children: [
                IndexedStack(
                  index: state.currentTab,
                  children: const [
                    NoteView(),
                    ManageMoney(),
                    FriendView(),
                    AccountView(),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    margin:
                        const EdgeInsets.only(bottom: 35, left: 50, right: 50),
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.primaryColor,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        _bottomBarItem(
                            context,
                            state,
                            const Icon(Icons.home_filled,
                                color: Color(0xFFEEEEEE)),
                            0),
                        _bottomBarItem(
                            context,
                            state,
                            const Icon(Icons.wallet, color: Color(0xFFEEEEEE)),
                            1),
                        _bottomBarItem(
                            context,
                            state,
                            const Icon(Icons.people_alt_outlined,
                                color: Color(0xFFEEEEEE)),
                            2),
                        _bottomBarItem(
                            context,
                            state,
                            const Icon(Icons.account_circle_outlined,
                                color: Color(0xFFEEEEEE)),
                            3),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 200.ms)
                      .slide(begin: const Offset(0, 0.2)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _bottomBarItem(
      BuildContext context, DashboardInitial state, Icon icon, int index) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        context.read<DashboardBloc>().add(ChangeTabEvent(tab: index));
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.oceanBlue
                  .withOpacity(state.currentTab == index ? 0.6 : 0)),
          child: Center(
            child: icon,
          )),
    ));
  }
}

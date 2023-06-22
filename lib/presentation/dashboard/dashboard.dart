import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:just_notes/presentation/dashboard/bloc/dashboard_bloc.dart';
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
                    ManageMoney(),
                    ManageMoney(),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    margin:
                        const EdgeInsets.only(bottom: 35, left: 50, right: 50),
                    decoration: BoxDecoration(
                        color: const Color(0xFF393E46),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            context
                                .read<DashboardBloc>()
                                .add(const ChangeTabEvent(tab: 0));
                          },
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFEEEEEE).withOpacity(
                                      state.currentTab == 0 ? 0.15 : 0)),
                              child: const Center(
                                child: Icon(Icons.home_filled,
                                    color: Color(0xFFEEEEEE)),
                              )),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            context
                                .read<DashboardBloc>()
                                .add(const ChangeTabEvent(tab: 1));
                          },
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFEEEEEE).withOpacity(
                                      state.currentTab == 1 ? 0.15 : 0)),
                              child: const Center(
                                child: Icon(Icons.home_filled,
                                    color: Color(0xFFEEEEEE)),
                              )),
                        )),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<DashboardBloc>()
                                  .add(const ChangeTabEvent(tab: 1));
                            },
                            icon: const Icon(Icons.monetization_on,
                                color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.home, color: Colors.white),
                          ),
                        ),
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
}

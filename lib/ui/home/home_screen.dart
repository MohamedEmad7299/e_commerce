

import 'package:e_commerce/ui/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/home_states.dart';
import '../../shared/funs.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit,HomeState>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(
                  size: 32,
                  Icons.search,
                  color: cabaret,
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     cubit.changeThemeMode();
              //   },
              //   icon: Icon(
              //       Icons.brightness_4_outlined
              //   ),
              // ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            // backgroundColor: Colors.white,
            selectedItemColor: cabaret,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.category_outlined,
                  ),
                  label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings')
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
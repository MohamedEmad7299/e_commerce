import 'package:e_commerce/cubit/cubit.dart';
import 'package:e_commerce/cubit/home_states.dart';
import 'package:e_commerce/ui/widgets/favourite_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var favourites = cubit.homeModel!.data!.products!.where((element) => cubit.favourites[element.id] == true).toList();
        return cubit.homeModel == null ? Center(child: CircularProgressIndicator()) : ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => FavoriteItem(
              product: favourites[index]
          ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: favourites.length,
        );
      },
      listener: (context, state) {},
    );
  }
}

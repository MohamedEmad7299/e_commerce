import 'package:e_commerce/cubit/cubit.dart';
import 'package:e_commerce/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {

  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {

        var cubit = HomeCubit.get(context);

        return cubit.categoriesModel == null
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image(
                          image: NetworkImage(cubit.categoriesModel!.data!
                              .categories![index].image!),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          cubit.categoriesModel!.data!.categories![index].name!,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: cubit.categoriesModel!.data!.categories!.length);
      },
      listener: (context, state) {},
    );
  }
}

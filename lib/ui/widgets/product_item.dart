

import 'package:e_commerce/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../style/colors.dart';
import 'components.dart';

class ProductItem extends StatelessWidget {

  final product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {

        var cubit = HomeCubit.get(context);

        if (state is FavoritesErrorState && !cubit.errorShown) {
          toast(msg: state.error);
          cubit.setErrorShown(true); // Mark error as shown
        }
      },
      builder: (context, state) {

        var cubit = HomeCubit.get(context);

        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage('${product.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    if (product.discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        color: cabaret,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '${product.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${product.price}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  if (product.discount != 0)
                    Text(
                      '${product.oldPrice}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      cubit.updateFavourites(product.id);
                    },
                    icon: Icon(
                      cubit.favourites[product.id]! ? Icons.favorite : Icons.favorite_border,
                      color: cabaret,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
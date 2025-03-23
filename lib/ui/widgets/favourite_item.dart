import 'package:e_commerce/cubit/cubit.dart';
import 'package:e_commerce/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../style/colors.dart';

class FavoriteItem extends StatelessWidget {

  final product;

  const FavoriteItem({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {

        var cubit = HomeCubit.get(context);

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                        '${product.image}'),
                    width: 150,
                    height: 150,
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
              SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 150,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          '${product.name}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            '${product.price}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(width: 16),
                          if (product.discount != 0)
                            Text(
                              '${product.oldPrice}',
                              style: TextStyle(
                                fontSize: 16,
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
                ),
              )
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

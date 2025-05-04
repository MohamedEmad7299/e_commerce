import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductItem extends StatelessWidget {

  final String imageUrl;
  final String productName;
  final dynamic productReview;
  final dynamic productPrice;
  final VoidCallback onClickFavButton;
  final VoidCallback onClickItem;
  final bool isLoading;
  final bool isFavourite;

  const ProductItem({
    super.key,
    required this.imageUrl,
    this.productName = "No Specified Name",
    this.productReview = "0",
    this.productPrice = 0,
    required this.onClickFavButton,
    required this.onClickItem,
    required this.isLoading,
    required this.isFavourite,
  });

  @override
  Widget build(BuildContext context) {

    final numberFormat = NumberFormat.decimalPattern('en_US');

    return GestureDetector(
      onTap: onClickItem,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(8),
        elevation: 2,
        child: Container(
          height: 240,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      imageUrl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child: Text(
                            "EGP ${numberFormat.format(productPrice)}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 70,
                          child: Text(
                            "EGP ${numberFormat.format(productPrice + (productPrice / 3))}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.deepPurple,
                              decoration: TextDecoration.lineThrough,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          "Review ($productReview)",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const Icon(Icons.star, size: 18, color: Colors.amber),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 8,
                top: 8,
                child: IconButton(
                  icon: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: isFavourite ? Colors.deepPurple : Colors.grey,
                    size: 28,
                  ),
                  onPressed: onClickFavButton,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

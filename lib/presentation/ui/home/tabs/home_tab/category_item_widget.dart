import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';

class CategoryItemWidget extends StatelessWidget {
  Category category;
  CategoryItemWidget({required this.category});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              height: 80,
              width: 90,
              imageUrl: category.image ?? '',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Text(
            category.name ?? '',
            maxLines: 2,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

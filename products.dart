import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_application_1/layout/shop_app/cubit/states.dart';
import 'package:flutter_application_1/models/Shop_app/Home_model.dart';
import 'package:flutter_application_1/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: state is! ShopLoadingHomeDataState,
              builder: (context) =>
                  productsBuilder(ShopCubit.get(context).homeModel!),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        },
        listener: (context, state) {});
  }

  // Widget productsBuilder(ShopHomeModel model) => SingleChildScrollView(
  //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //         CarouselSlider(
  //           items: model.data!.banners
  //               .map((e) => Image(
  //                     image: NetworkImage(e.image),
  //                     fit: BoxFit.cover,
  //                     width: double.infinity,
  //                   ))
  //               .toList(),
  //           options: CarouselOptions(
  //             height: 200,
  //             viewportFraction: 1.0,
  //             enlargeCenterPage: false,
  //             initialPage: 0,
  //             enableInfiniteScroll: true,
  //             reverse: false,
  //             autoPlay: true,
  //             autoPlayInterval: Duration(seconds: 3),
  //             autoPlayAnimationDuration: Duration(seconds: 1),
  //             autoPlayCurve: Curves.fastOutSlowIn,
  //             scrollDirection: Axis.horizontal,
  //           ),
  //         ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.grey,
            child: GridView.count(
              shrinkWrap: true,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 4.0,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1.0 / 1.42,
              crossAxisCount: 2,
              children: List.generate(model.data!.products.length,
                  (index) => buildGrideProduct(model.data!.products[index])),
            ),
          )
        ]),
      );

  Widget buildGrideProduct(ShopProduct model) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                  // fit: BoxFit.cover,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3, fontSize: 12.0),
                  ),
                  Row(
                    children: [
                      Text(
                        'price: ${model.price.round()}',
                        style: TextStyle(
                            height: 1.3, fontSize: 15.0, color: defaultColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 12.0,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_border_outlined,
                            size: 20,
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
}

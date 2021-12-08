import 'package:flutter/material.dart';
import 'package:fruit_shop/data/data.dart';
import 'package:fruit_shop/model/fruits_vegtables.dart';

class FreshFruits extends StatelessWidget {
  const FreshFruits({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(100),
          child: Text(
            'Fresh Fruits',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        //For List Displaying

        ListView.builder(
            padding: const EdgeInsets.only(right: 100.0),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: freshFruitsList.length,
            itemBuilder: (context, index) {
              return _buildFreshFruits(context, index);
            }),
      ],
    );
  }
}

Widget _buildFreshFruits(BuildContext context, int index) {
  Size size = MediaQuery.of(context).size;
  FruitsAndVegs fruitsAndVegs = freshFruitsList[index];
  return Padding(
    padding: const EdgeInsets.only(left: 100),
    child: SizedBox(
      width: size.width * 0.3,
      child: Column(
        children: [
          Image(
            height: size.height * 0.23,
            fit: BoxFit.contain,
            image: AssetImage(
              fruitsAndVegs.imagename,
            ),
          ),
          Text(
            fruitsAndVegs.name,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ),
  );
}

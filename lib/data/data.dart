import 'package:fruit_shop/model/fruits_vegtables.dart';

final _banana =
FruitsAndVegs('assets/banana.jpg', 'Banana', 10.00, 'Fresh Banana Fruit');
final _orange =
FruitsAndVegs('assets/orange.jpg', 'Orange', 7.50, 'Fresh Banana Fruit');
final _strawberry = FruitsAndVegs(
    'assets/Strawberry.jpg', 'Strawberry', 20.00, 'Fresh Strawberry Fruit');
final _pomegranate = FruitsAndVegs(
    'assets/pomegranate.jpg', 'Pomegranate', 15.00, 'Fresh Pomegranate Fruit');
final _tomato = FruitsAndVegs(
    'assets/tomato.jpg', 'Tomato', 8.00, 'Fresh Tomato Vegetable');
final _carrot = FruitsAndVegs(
    'assets/carrots.jpg', 'Carrot', 6.00, 'Fresh carrot Vegetable');
final _cucumber = FruitsAndVegs(
    'assets/cucumber.jpg', 'Cucumber', 5.00, 'Fresh Cucumber Vegetable');
final List<FruitsAndVegs> dailyFreshList = [_tomato, _carrot, _cucumber];
final List<FruitsAndVegs> freshFruitsList = [
  _banana,
  _orange,
  _pomegranate,
  _strawberry
];

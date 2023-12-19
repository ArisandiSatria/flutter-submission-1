class RestaurantCategory {
  String name;
  String imageAsset;

  RestaurantCategory({
    required this.name,
    required this.imageAsset,
  });
}

var restaurantCategoryList = [
  RestaurantCategory(
      name: 'Local', imageAsset: 'assets/images/egg.png'),
  RestaurantCategory(
      name: 'Chinese', imageAsset: 'assets/images/noodles.png'),
  RestaurantCategory(
      name: 'Japanese', imageAsset: 'assets/images/sushi.png'),
  RestaurantCategory(name: 'Western', imageAsset: 'assets/images/pizza.png'),
  RestaurantCategory(
      name: 'Mexican', imageAsset: 'assets/images/taco.png'),
];

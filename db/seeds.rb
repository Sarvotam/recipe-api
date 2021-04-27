# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Category.create(name: "Breakfast");
# Category.create(name: "Lunch");
# Category.create(name: "Appetizers");
# Category.create(name: "Beverages");
# Category.create(name: "Soups");
# Category.create(name: "Salads");
Category.create(name: "Beef");
Category.create(name: "Poultry");
Recipe.create( name: 'burger.', user_id: 1, category_id: 1 );
Recipe.create( name: 'pizza.', user_id: 1, category_id: 2 );
# User.create( username: 'sarvottam', password: 'pppppp' );
# User.create( username: 'sarvottam1', password: 'pppppp' );
# User.create( username: 'sarvottam2', password: 'pppppp' );
# User.create( username: 'sarvottam3', password: 'pppppp' );
Review.create( comment: "hello love", user_id: 3, recipe_id: 7 )
user = User.create(username: "sarvottam", password: "pppppp")

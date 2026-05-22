const recipes = {
    "carbonara": {
        name: "Spaghetti Carbonara",
        img: "pics/carbonara.jpg",
        desc: "A classic Italian pasta dish made with eggs, cheese, pancetta and black pepper.",
        ingredients: [["Spaghetti", "200g"], ["Eggs", "2 large"], ["Pancetta", "100g"], ["Pecorino Romano", "50g"], ["Black pepper", "to taste"]],
        steps: ["Boil pasta in salted water.", "Fry pancetta until crispy.", "Mix eggs and cheese in a bowl.", "Combine pasta with pancetta, then stir in egg mixture."]
    },
    "curry": {
        name: "Curry Chicken",
        img: "pics/curry.jpg",
        desc: "A flavorful chicken curry made with aromatic spices and coconut milk.",
        ingredients: [["Chicken breast", "500g"], ["Coconut milk", "400ml"], ["Curry powder", "2 tbsp"], ["Onion", "1 medium"], ["Garlic", "2 cloves"]],
        steps: ["Heat oil in a pan.", "Cook chopped onion and garlic until soft.", "Add chicken pieces and brown them.", "Pour in coconut milk and spices, then simmer for 15 minutes."]
    },
    "caesar": {
        name: "Caesar Salad",
        img: "pics/caesar.jpg",
        desc: "A fresh and crunchy salad with romaine lettuce, croutons, and creamy dressing.",
        ingredients: [["Romaine lettuce", "1 head"], ["Croutons", "1 cup"], ["Parmesan cheese", "30g"], ["Chicken breast", "200g"], ["Caesar dressing", "4 tbsp"]],
        steps: ["Grill the chicken until cooked through.", "Chop the lettuce and place in a large bowl.", "Add croutons and grated Parmesan.", "Toss with dressing and top with sliced chicken."]
    },
    "guacamole": {
        name: "Authentic Guacamole",
        img: "pics/guacamole.jpeg",
        desc: "A creamy Mexican dip made with ripe avocados, lime, and fresh cilantro.",
        ingredients: [["Avocados", "3 ripe"], ["Lime", "1 pc"], ["Red onion", "1/4 cup"], ["Cilantro", "2 tbsp"], ["Salt", "to taste"]],
        steps: ["Mash the avocados in a bowl.", "Finely chop the onion and cilantro.", "Mix in the lime juice and salt.", "Serve immediately with tortilla chips."]
    },
    "beef-stew": {
        name: "Classic Beef Stew",
        img: "pics/beef-stew.jpg",
        desc: "A hearty and warming stew with tender beef, potatoes, and carrots.",
        ingredients: [["Beef cubes", "600g"], ["Potatoes", "3 large"], ["Carrots", "2 pcs"], ["Beef broth", "500ml"], ["Red wine", "100ml"]],
        steps: ["Sear the beef in a heavy pot.", "Add chopped vegetables and cook for 5 minutes.", "Deglaze with wine and add broth.", "Simmer on low heat for 2 hours until tender."]
    },
    "pancakes": {
        name: "Fluffy American Pancakes",
        img: "pics/pancakes.jpg",
        desc: "Classic thick and soft pancakes, perfect for breakfast with maple syrup.",
        ingredients: [["Flour", "200g"], ["Milk", "250ml"], ["Egg", "1 large"], ["Baking powder", "1 tbsp"], ["Butter", "2 tbsp"]],
        steps: ["Whisk the dry ingredients together.", "Mix in the milk, egg, and melted butter.", "Pour small amounts into a hot pan.", "Flip when bubbles appear and cook until golden."]
    },
    "margarita": {
        name: "Pizza Margherita",
        img: "pics/margarita.jpg",
        desc: "The queen of Italian pizzas with tomato sauce, fresh mozzarella, and basil.",
        ingredients: [["Pizza dough", "250g"], ["Tomato sauce", "1/2 cup"], ["Fresh mozzarella", "125g"], ["Fresh basil", "5 leaves"], ["Olive oil", "1 tbsp"]],
        steps: ["Roll out the dough on a floured surface.", "Spread tomato sauce evenly.", "Add mozzarella slices and olive oil.", "Bake at 250°C for 8-10 minutes, top with basil."]
    },
    "ratatouille": {
        name: "French Ratatouille",
        img: "pics/ratatouille.jpg",
        desc: "A colorful vegetable stew from Provence with eggplant, zucchini, and peppers.",
        ingredients: [["Eggplant", "1 pc"], ["Zucchini", "1 pc"], ["Bell pepper", "2 pcs"], ["Tomatoes", "400g"], ["Herbes de Provence", "1 tbsp"]],
        steps: ["Sauté onions and garlic in olive oil.", "Add diced peppers, eggplant, and zucchini.", "Stir in tomatoes and herbs.", "Cover and simmer for 30 minutes."]
    },
    "shrimp-scampi": {
        name: "Garlic Shrimp Scampi",
        img: "pics/shrimp-scampi.jpg",
        desc: "Delicious shrimp cooked in a buttery garlic and white wine sauce.",
        ingredients: [["Shrimp", "400g"], ["Garlic", "4 cloves"], ["White wine", "1/2 cup"], ["Butter", "50g"], ["Parsley", "1 tbsp"]],
        steps: ["Sauté garlic in butter until fragrant.", "Add shrimp and cook until pink.", "Pour in wine and lemon juice, reduce slightly.", "Garnish with parsley and serve with bread."]
    },
    "apple-pie": {
        name: "Classic Apple Pie",
        img: "pics/apple-pie.jpg",
        desc: "Traditional dessert with a buttery crust and spiced apple filling.",
        ingredients: [["Pie crust", "2 sheets"], ["Apples", "1kg"], ["Cinnamon", "1 tsp"], ["Sugar", "100g"], ["Butter", "20g"]],
        steps: ["Peel and slice the apples.", "Toss apples with sugar and cinnamon.", "Place in the bottom crust, top with butter.", "Cover with the second crust and bake at 180°C for 45 minutes."]
    }
};
-- Create the database
CREATE DATABASE IF NOT EXISTS recipes_db;
USE recipes_db;

-- Create the 'recipes' table to store recipe information
CREATE TABLE IF NOT EXISTS recipes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    instructions TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the 'ingredients' table to store ingredient information
CREATE TABLE IF NOT EXISTS ingredients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    quantity VARCHAR(50),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
);

-- Generate 1000 random recipes
DELIMITER $$

DROP PROCEDURE IF EXISTS insert_random_data$$

CREATE PROCEDURE insert_random_data()
BEGIN
    DECLARE recipe_counter INT DEFAULT 0;
    
    WHILE recipe_counter < 1000 DO
        -- Generate a random recipe name
        SET @recipe_name = CONCAT(
            (SELECT name FROM (
                SELECT 'Pasta' AS name UNION SELECT 'Pizza' UNION SELECT 'Stir-Fry' UNION SELECT 'Burger' UNION SELECT 'Curry'
                UNION SELECT 'Taco' UNION SELECT 'Salad' UNION SELECT 'Soup' UNION SELECT 'Casserole'
            ) t ORDER BY RAND() LIMIT 1),
            ' ',
            (SELECT name FROM (
                SELECT 'Recipe' AS name UNION SELECT 'Delight' UNION SELECT 'Special' UNION SELECT 'Surprise'
            ) t ORDER BY RAND() LIMIT 1)
        );

        -- Generate random instructions
        SET @instructions = CONCAT(
            '1. ',
            (SELECT instruction FROM (
                SELECT 'Heat the pan over medium heat.' AS instruction UNION SELECT 'Chop the vegetables.'
                UNION SELECT 'Cook the meat until browned.' UNION SELECT 'Boil the pasta in salted water.'
                UNION SELECT 'Mix all the ingredients in a bowl.' UNION SELECT 'Bake in the preheated oven.'
                UNION SELECT 'Stir-fry the vegetables.' UNION SELECT 'Season with salt and pepper.' UNION SELECT 'Serve hot.'
            ) t ORDER BY RAND() LIMIT 1),
            '\n2. ',
            (SELECT instruction FROM (
                SELECT 'Heat the pan over medium heat.' AS instruction UNION SELECT 'Chop the vegetables.'
                UNION SELECT 'Cook the meat until browned.' UNION SELECT 'Boil the pasta in salted water.'
                UNION SELECT 'Mix all the ingredients in a bowl.' UNION SELECT 'Bake in the preheated oven.'
                UNION SELECT 'Stir-fry the vegetables.' UNION SELECT 'Season with salt and pepper.' UNION SELECT 'Serve hot.'
            ) t ORDER BY RAND() LIMIT 1)
        );

        -- Insert the random recipe into the 'recipes' table
        INSERT INTO recipes (name, instructions)
        VALUES (@recipe_name, @instructions);

        -- Get the last inserted recipe ID
        SET @recipe_id = LAST_INSERT_ID();

        -- Generate random ingredients
        SET @ingredient_list = '';
        SET @ingredient_counter = 0;
        SET @ingredient_count = FLOOR(RAND() * 6) + 3; -- Random number of ingredients between 3 and 8

        WHILE @ingredient_counter < @ingredient_count DO
            SET @ingredient_name = (
                SELECT name FROM (
                    SELECT 'Chicken' AS name UNION SELECT 'Beef' UNION SELECT 'Pork' UNION SELECT 'Fish'
                    UNION SELECT 'Tofu' UNION SELECT 'Potato' UNION SELECT 'Tomato' UNION SELECT 'Onion'
                    UNION SELECT 'Garlic' UNION SELECT 'Carrot' UNION SELECT 'Bell Pepper' UNION SELECT 'Broccoli'
                    UNION SELECT 'Mushroom' UNION SELECT 'Egg' UNION SELECT 'Cheese' UNION SELECT 'Rice'
                    UNION SELECT 'Pasta' UNION SELECT 'Lettuce' UNION SELECT 'Avocado' UNION SELECT 'Lime'
                    UNION SELECT 'Cilantro' UNION SELECT 'Cumin' UNION SELECT 'Olive Oil' UNION SELECT 'Salt'
                    UNION SELECT 'Pepper' UNION SELECT 'Soy Sauce' UNION SELECT 'Honey' UNION SELECT 'Ginger'
                ) t ORDER BY RAND() LIMIT 1
            );

            SET @ingredient_quantity = CONCAT(FLOOR(RAND() * 1000) + 1, 'g');

            SET @ingredient_list = CONCAT(@ingredient_list, @ingredient_name, ' - ', @ingredient_quantity, '\n');

            INSERT INTO ingredients (recipe_id, name, quantity)
            VALUES (@recipe_id, @ingredient_name, @ingredient_quantity);

            SET @ingredient_counter = @ingredient_counter + 1;
        END WHILE;

        SET recipe_counter = recipe_counter + 1;
    END WHILE;
END$$

DELIMITER ;

-- Call the stored procedure to insert random data
CALL insert_random_data();

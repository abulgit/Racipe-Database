
# Recipe Storage Project


A simple recipe storage system that allows users to store and access their favorite recipes. The project includes a MySQL database to store recipe information, including the recipe name, instructions, and related ingredients.

## Getting Started

### Prerequisites

To run this project, you will need the following:

1. **MySQL Server:** Install and set up a MySQL server on your local machine or a remote server.

### Installation

1. Clone this repository to your local machine:

```bash
git clone [[https://github.com/abulgit/Racipe-Database.git]
cd recipe-Database
```

2. **Update MySQL Credentials:**

   - Open the `DB.sql` file and replace `'your_mysql_host'`, `'your_mysql_username'`, and `'your_mysql_password'` with your actual MySQL server details.

3. **Create the Database and Tables:**

   - Open a MySQL client, such as MySQL Workbench or the MySQL command-line tool.
   - Execute the contents of the `recipe_storage.sql` file to create the necessary database and tables.

4. **Populate the Database with Random Data:**

   - Open a MySQL client and execute the contents of the `insert_random_data.sql` file to insert 1000 random recipes and their ingredients into the database.

5. **Project Structure:**

   - The main SQL code is in the `recipe_storage.sql` file, including the database schema and the stored procedure to insert random data.
   - The sample Python script provided in the `populate_with_python.py` file can also be used to insert random data into the database. Make sure to install the `MySQL-connector-python` package using `pip` before running the script.

## Usage

1. **Accessing the Database:**

   - You can use your preferred MySQL client (e.g., MySQL Workbench, phpMyAdmin) to interact with the `recipes_db` database and its tables.

2. **Storing Recipes:**

   - To add your recipes, you can execute SQL `INSERT` statements on the `recipes` and `ingredients` tables. Each recipe in the `recipes` table will have a unique ID, a name, instructions, and a timestamp for when it was created. Ingredients are related to their corresponding recipes via the `recipe_id` foreign key.

3. **Retrieving Recipes:**

   - To retrieve recipes, you can use SQL `SELECT` queries to fetch the desired information from the `recipes` and `ingredients` tables.

4. **Updating and Deleting Recipes:**

   - You can use SQL `UPDATE` and `DELETE` statements to modify or remove existing recipes from the database.

## Contributing

Contributions are welcome! If you have any suggestions or improvements, please feel free to open an issue or submit a pull request.

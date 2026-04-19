Data: 2025-11-27
[](./README.md)
#Red_Lab/Ex_School/SQL
___

# Sakila
## SELECT statements
Select all columns from the actor table.
 
``` sql
SELECT * 
FROM `actor`;
```

Select only the last_name column from the actor table.
``` sql
SELECT last_name 
FROM actor;
```

Select only the following columns from the film table.
``` sql
SELECT * 
FROM film;
```

Select columns

``` sql
SELECT title, rental_duration, rental_rate
FROM film;
```

## 2. DISTINCT operator
2a. Select all distinct (different) last names from the actor table.
``` sql
SELECT DISTINCT last_name
FROM actor;
```

2b. Select all distinct (different) postal codes from the address table.
``` sql
SELECT DISTINCT postal_code
FROM address;
```

2c. Select all distinct (different) ratings from the film table.
``` sql
SELECT DISTINCT rating
FROM film;
```

## 3. WHERE clause

3a. Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
``` sql
SELECT title, description, rating, length
FROM film
WHERE length > 3;
```

3b. Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.

``` sql
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >05/27/2005;
```

3c. Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
``` sql
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date = 2005-05-27;
```

3d. Select all columns from the customer table for rows that have a last name beginning with "S" and a first name ending with "N".
``` sql
SELECT *
FROM customer
WHERE last_name LIKE 'S%' AND first_name LIKE '%N';
```

3e. Select all columns minus the password column from the staff table for rows that contain a password.
```

```

3f. Select all columns minus the password column from the staff table for rows that do not contain a password.

  

  

 4. IN operator

 4a. Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.

 4b. Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005.

 4c. Select all columns from the film table for films rated G, PG13 or NC17.

  

 5. BETWEEN operator

 5a. Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.

 5b. Select the following columns from the film table for films where the length of the description is between 100 and 120.

 COLUMN NAME Note

 title Exists in film table.

 description Exists in film table.

 release_year Exists in film table.

 total_rental_cost rental_duration * rental_rate

  
  

 6. LIKE operator

 6a. Select the following columns from the film table for rows where the description begins with "A Thoughtful".

 Title, Description, Release Year

 6b. Select the following columns from the film table for rows where the description ends with the word "Boat".

 Title, Description, Rental Duration

 6c. Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.

 Title, Length, Description, Rental Rate

  

 7. LIMIT Operator

 7a. Select all columns from the payment table and only include the first 20 rows.

 7b. Select the payment id, payment date and amount columns from the payment table for rows where the payment amount is greater than 5 and only select rows whose zerobased index in the result set is between 51100.

 7c. Select all columns from the customer table, limiting results to those where the zerobased index is between 101200.

  

 8. ORDER BY statement

 8a. Select all columns from the film table and order rows by the length field in ascending order.

 8b. Select all distinct ratings from the film table ordered by rating in descending order.

 8c. Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.

 8d. Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
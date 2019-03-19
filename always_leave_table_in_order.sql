-- You are creating a website that will help you and your friends keep track of the results of volleyball teams from all around the world. Your website regularly crawls the web searching for new games, and adds the results of these games to the results table stored in your local database. After each update, the table should be sorted in ascending order by the total number of games won. This year's results are quite marvelous - at any given moment there are no two teams that have won the same number of games!

-- The results table contains the following columns:

-- name - the unique name of the team;
-- country - the country of the team;
-- scored - the number of scored goals;
-- missed - the number of missed goals;
-- wins - the total number of games the team has won.
-- Your task is to sort the given results table in ascending order by the number of wins.

CREATE PROCEDURE volleyballResults()
BEGIN
	SELECT * 
  FROM results
  ORDER BY(wins) ASC;
END
-- Mr. Cash wants to keep track of his expenses, so he has prepared a list of all the products he bought this month. Now he is interested in finding the product on which he spent the largest amount of money. If there are products that cost the same amount of money, he'd like to find the one with the lexicographically smallest name.

-- The list of expenses is stored in a table Products which has the following columns:

-- id: unique product id;
-- name: the unique name of the product;
-- price: the price for one item;
-- quantity: the number of items bought.
-- The resulting table should contain one row with a single column: the product with the lexicographically smallest name on which Mr. Cash spent the largest amount of money.

-- The total amount of money spent on a product is calculated as price * quantity.
CREATE PROCEDURE mostExpensive()
BEGIN
	SELECT name
  FROM Products 
  ORDER BY (price*quantity) DESC , name ASC
  LIMIT 1;
END

-- You are working as a recruiter at a big IT company, and you're actively looking for candidates who take the top places in major programming contests. Since the grand finale of the annual City Competition, you've been reaching out to the top participants from the leaderboard, and successfully so.

-- You have already interviewed all the prize winners (the top 3 participants), but that's not enough right now. Your company needs more specialists, so now you would like to connect with the participants who took the next 5 places.

-- The contest leaderboard is stored in a table leaderboard with the following columns:

-- id: unique id of the participant;
-- name: the name of the participant;
-- score: the score the participant achieved in the competition.
-- The resulting table should contain the names of the participants who took the 4th to 8th places inclusive, sorted in descending order of their places. If there are fewer than 8 participants, the results should contain those who ranked lower than 3rd place.

-- It is guaranteed that there are at least 3 prize winners in the leaderboard and that all participants have different scores.
CREATE PROCEDURE contestLeaderboard()
BEGIN
  SELECT name
  FROM leaderboard 
  ORDER BY score desc,
  name asc 
  LIMIT 3,5 ;
END

-- At the end of every semester your professor for "Introduction to Databases" saves the exam results of every student in a simple database system. In the database table Grades, there are five columns:

-- Name: the name of the student;
-- ID: the student's ID number (a 5 byte positive integer);
-- Midterm1: the result of the first midterm out of 100 points;
-- Midterm2: the result of the second midterm out of 100 points;
-- Final: the result of the final exam, this time out of a possible 200 points.
-- According to school policy, there are three possible ways to evaluate a grade:

-- Option 1:
-- Midterm 1: 25% of the grade
-- Midterm 2: 25% of the grade
-- Final exam: 50% of the grade
-- Option 2:
-- Midterm 1: 50% of the grade
-- Midterm 2: 50% of the grade
-- Option 3:
-- Final exam: 100% of the grade.
-- Each student's final grade comes from the option that works the best for that student.

-- As a Teaching Assistant (TA), you need to query the name and id of all the students whose best grade comes from Option 3, sorted based on the first 3 characters of their name. If the first 3 characters of two names are the same, then the student with the lower ID value comes first.

-- Example
CREATE PROCEDURE gradeDistribution()
BEGIN
  SELECT name,id
  FROM Grades 
  WHERE (Midterm1/4 + Midterm2/4 + Final/2) 
  AND (Midterm1/2 + Midterm2/2) < Final 
  ORDER BY substring(name,1,3) asc ,
  id asc;
END

-- Your nephews Huey, Dewey, and Louie are staying with you over the winter holidays. Ever since they arrived, you've hardly had a day go by without some kind of incident - the little rascals do whatever they please! Actually, you're not even mad; the ideas they come up with are pretty amazing, and it looks like there's even a system to their mischief.

-- You decided to track and analyze their behavior, so you created the mischief table in your local database. The table has the following columns:

-- mischief_date: the date of the mischief (of the date type);
-- author: the nephew who caused the mischief ("Huey", "Dewey" or "Louie");
-- title: the title of the mischief.
-- It looks like each of your nephews is active on a specific day of the week. You decide to check your theory by creating another table as follows:
-- The resulting table should contain four columns, weekday, mischief_date, author, and title, where weekday is the weekday of mischief_date (0 for Monday, 1 for Tuesday, and so on, with 6 for Sunday). The table should be sorted by the weekday column, and for each weekday Huey's mischief should go first, Dewey's should go next, and Louie's should go last. In case of a tie, mischief_date should be a tie-breaker. If there's still a tie, the record with the lexicographically smallest title should go first.

-- It is guaranteed that all entries of mischief are unique.
CREATE PROCEDURE mischievousNephews()
BEGIN
	select (WEEKDAY(mischief_date)) as weekday,mischief_date,author,title 
  from mischief
  order by weekday asc, length(author),author, mischief_date, title asc;
END
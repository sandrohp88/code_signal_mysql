-- A large amount of money was stolen today from the main city bank, and as the chief of police it's your duty to find the robber.

-- You store information about your suspects in the table Suspect, which has the structure:

-- id: unique suspect id;
-- name: suspect first name;
-- surname: suspect surname;
-- height: suspect height;
-- weight: suspect weight.
-- You have already gathered some evidence and discovered the following clues:

-- according to the camera records, the robber is not taller than 170cm;
-- the robber left their signature near the crime scene: "B. Gre?n". "B" definitely stands for the first letter of robber's name, and "Gre?n" is their surname. The 4th letter of the surname is smudged by ketchup and is unreadable.
-- To make the list of suspects smaller, you would like to filter out the suspects who can't possibly be guilty according to the information obtained from the clues. For each remaining suspect, you want to save his/her id, name and surname. Please note that the information obtained from the clue should be considered case-insensitive, so for example "bill Green", and "Bill green", and "Bill Green" should all be included in the new table.

-- Given the table Suspect, build the resulting table as follows: the table should have columns id, name and surname and its values should be ordered by the suspects' ids in ascending order.
CREATE PROCEDURE volleyballResults()
BEGIN
	select id, name,surname from Suspect
  where height <= 170 and name like 'b%' and surname like 'Gre_n'
  order by id;
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
	select name 
  from leaderboard
  order by score desc, name asc
  limit 3,5 
  ;
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

CREATE PROCEDURE gradeDistribution()
BEGIN
	select Name,ID 
  from Grades
  where (Midterm1/4 + Midterm2/4 + Final/2) and (Midterm1/2 + Midterm2/2) < Final
  order by substring(name,1,3) asc , id asc;
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
  order by weekday asc, length(author),author, mischief_date, title asc
    ;
END
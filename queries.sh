#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

#pass
echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

#pass
echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

#pass
echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

#pass
echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(avg(winner_goals), 2) FROM games")"

#pass
echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT avg((winner_goals + opponent_goals)) FROM games")"

#pass
echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"

#pass
echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM games right join teams on games.winner_id = teams.team_id
where year=2018 and round='Final'")"

#error
echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "
select distinct name
From games 
inner join teams 
on games.winner_id = teams.team_id where round='Eighth-Final' and year=2014
union
select distinct name
From games 
inner join teams 
on games.opponent_id = teams.team_id where round='Eighth-Final' and year=2014
order by name
")"


#pass
echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT distinct name FROM games left join teams on games.winner_id = teams.team_id
order by name")"

#pass
echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year, name FROM games left join teams on games.winner_id = teams.team_id where
round='Final' order by year asc")"

#pass
echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams where name Like 'Co%'")"

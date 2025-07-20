#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# read games.csv

cat games.csv | while IFS=',' read -r YEAR ROUND WINNER OPPONENT WIN_GOALS OPP_GOALS

# insert game data into the database
do
    if [[ $ROUND != round ]]
    then

      #insert into teams
      WINNER_ID=$($PSQL "select team_id from teams where name='$WINNER'")

      if [[ -z $WINNER_ID ]]; then
        ($PSQL "insert into teams(name) values('$WINNER')")
        WINNER_ID=$($PSQL "select team_id from teams where name='$WINNER'")
      fi

      OPP_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")

      if [[ -z $OPP_ID ]]; then
        ($PSQL "insert into teams(name) values('$OPPONENT')")
        OPP_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")
      fi

      #insert into games
      GAME_ID=$($PSQL "select game_id from games where year=$YEAR and round='$ROUND' 
      and winner_goals=$WIN_GOALS and opponent_goals=$OPP_GOALS 
      and winner_id=$WINNER_ID and opponent_id=$OPP_ID")

      if [[ -z $GAME_ID ]]; then
        ($PSQL "insert into games(year, round, winner_goals, opponent_goals, winner_id, opponent_id)
         values($YEAR, '$ROUND', $WIN_GOALS, $OPP_GOALS, $WINNER_ID, $OPP_ID)")

        GAME_ID=$($PSQL "select game_id from games where year=$YEAR and round='$ROUND' 
        and winner_goals=$WIN_GOALS and opponent_goals=$OPP_GOALS 
        and winner_id=$WINNER_ID and opponent_id=$OPP_ID")
      fi


    fi
done < games.csv
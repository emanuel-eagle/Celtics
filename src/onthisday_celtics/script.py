from nba_api.stats.endpoints import leaguegamefinder
from nba_api.stats.endpoints import boxscoretraditionalv2
from nba_api.stats.static import teams
import pandas as pd
import requests
from time import sleep 
import random
from datetime import datetime

### format of the state map is 
###             the key is the column name from nba_api
###             the value is a list, the first value of the list is the threshold to meet interesting stat
###             the second value of the list is the formatted name for it
###             the formatted name defines what is said in the message, so converts column name, "REB" to rebounds.

PTS_THRESHOLD = 40
REB_THRESHOLD = 15
BLK_THRESHOLD = 12
STL_THRESHOLD = 12
AST_THRESHOLD = 12
IFTTT_WEBHOOK = "https://maker.ifttt.com/trigger/Celtics_OnThisDay/with/key/nCph1jNcGvyI1MGw_z8hWV2pVlofbyjngk4vhNuoliW?value1="

interesting_stat_map= {
        "REB" : [REB_THRESHOLD, "rebounds"],
        "PTS" : [PTS_THRESHOLD, "points"], 
        "BLK" : [BLK_THRESHOLD, "blocks"],
        "STL" : [STL_THRESHOLD, "steals"],
        "AST" : [AST_THRESHOLD, "assists"]
    }

start_year = 1946

today = datetime.today().strftime('%m/%d-%Y')

split_today = today.split("-")

dd_mm_today, end_year = split_today[0], int(split_today[-1])

nba_teams = teams.get_teams()

celtics_id = 0

for team in nba_teams:
    if team["abbreviation"] == "BOS":
        celtics_id = team["id"]
        break

final_string = f"On this day ({dd_mm_today}):\n"

for year in range(start_year, end_year): 
    date = f"{dd_mm_today}/{year}"
    gamefinder = leaguegamefinder.LeagueGameFinder(
            date_from_nullable=date,
            date_to_nullable=date,
            team_id_nullable=celtics_id
        )
    games = gamefinder.get_data_frames()[0]
    if len(games) > 0:
        game_id = games["GAME_ID"][0]
        boxscore = boxscoretraditionalv2.BoxScoreTraditionalV2(game_id = game_id)
        df_box_score = boxscore.get_data_frames()[0]
        df_celtics_only = df_box_score[df_box_score["TEAM_ID"] == celtics_id]
        for stat in interesting_stat_map.keys():
            stat_threshold = interesting_stat_map[stat][0]
            stat_nice_name = interesting_stat_map[stat][1]
            df_stat_specific = df_celtics_only[["PLAYER_NAME", stat]]
            df_stat_specific = df_stat_specific.dropna()
            df_stat_specific[stat] = df_stat_specific[stat].astype(int)
            df_threshold_specific = df_stat_specific[df_stat_specific[stat] > stat_threshold] 
            for index, row in df_threshold_specific.iterrows():
                final_string += f"\nOn this day in {year}, {row['PLAYER_NAME']} had {row[stat]} {stat_nice_name}."
                print(final_string)
    sleep(random.uniform(0.5, 1))
post_response = requests.post(f"{IFTTT_WEBHOOK}{final_string}")
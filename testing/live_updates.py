from nba_api.live.nba.endpoints import scoreboard

games = scoreboard.ScoreBoard()

list_games = games.get_dict()["scoreboard"]["games"]

for game in list_games:
    print("")
    print(game)



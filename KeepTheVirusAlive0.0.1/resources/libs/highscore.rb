require 'yaml'

@high_score = 0

File.write('resources/libs/highscore.yaml', @high_score.to_yaml)

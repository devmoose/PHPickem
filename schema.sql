CREATE TABLE IF NOT EXISTS pickem_week (
  wid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  week_num INT NOT NULL,
  week_start INT NOT NULL,
  week_end INT NOT NULL,
  week_season VARCHAR(4)
);

CREATE TABLE IF NOT EXISTS pickem_game (
  gid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  wid INT NOT NULL,
  start INT NOT NULL,
  end INT NOT NULL,
  home_tid INT NOT NULL,
  away_tid INT NOT NULL,
  home_score INT NOT NULL,
  away_score INT NOT NULL,
  game_winner INT NOT NULL
);

CREATE TABLE IF NOT EXISTS pickem_team (
  tid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  location VARCHAR(200) NOT NULL,
  name VARCHAR(200) NOT NULL,
  abbr VARCHAR(5) NOT NULL
);

CREATE TABLE IF NOT EXISTS pickem_user (
  uid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL,
  password VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS pickem_league (
  lid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  creator_uid INT NOT NULL,
  created INT NOT NULL,
  status TINYINT NOT NULL,
  settings TEXT
);

CREATE TABLE IF NOT EXISTS pickem_league_membership (
  uid INT NOT NULL,
  invited_by INT NOT NULL,
  lid INT NOT NULL,
  status TINYINT NOT NULL,
  time INT NOT NULL
);

CREATE TABLE IF NOT EXISTS pickem_pick (
  pid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  uid INT NOT NULL,
  tid INT NOT NULL,
  lid INT NOT NULL,
  gid INT NOT NULL
);
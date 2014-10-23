<?php
/**
 * NFL Game Score API classes.
 */

class NFLGameList {
  private static $URLGAMESLIST = "http://www.nfl.com/liveupdate/scorestrip/ss.json";
  private static $URLGAMEDETAIL = "http://www.nfl.com/liveupdate/game-center/%/%_gtd.json";

  public static function getGamesList() {
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, NFLGameList::$URLGAMESLIST);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    $result = curl_exec($curl);
    curl_close($curl);
    $games = json_decode($result);
    $gamesList = array();
    foreach($games["gms"] as $game) {
      $gamesList[] = new NFLGame(array("eid" => $game["eid"]));
    }
    return $gamesList;
  }

  public static function getGameDetail($eid) {
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, str_replace("%", $eid, NFLGameList::$URLGAMEDETAIL));
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    $result = curl_exec($curl);
    curl_close($curl);
    return $result;
  }
}

class NFLGame {
  private $eid;
  private $home;
  private $away;
  private $home_score;
  private $away_score;
  private $isDetailed = false;
  private $plays = null;

  public function __construct($options) {
    $this->eid = $options['eid'];
    $this->updateGameData();
  }

  public function setLoadFullDetail($det) {
    $this->isDetailed = $det;
  }

  private function parseGameJson($json) {
    $data = json_decode($json);
    $this->home = $data[$this->eid]['home']['abbr'];
    $this->home_score = $data[$this->eid]['home']['score']['T'];
    $this->away = $data[$this->eid]['away']['abbr'];
    $this->away_score = $data[$this->eid]['away']['score']['T'];
    if ($this->isDetailed) {
      // @TODO: Parse plays and stats.
      $this->plays = array();
    }
  }

  public function updateGameData() {
    $this->parseGameJson(NFLGameList::getGameDetail($this->eid));
  }
}
/**
 * Created by jpontani on 10/21/2014.
 */

var pickem = {};
pickem.methods = {};
pickem.values = {};
pickem.values.getUrl = "pickem_ajax.php";

pickem.methods.getPlayers = function() {
    if (pickem.values.players.length == 0) {
        var players = [];
        $(".player").each(function(index, element) {
            var player = {};
            player.id = element.id;
            player.score = element.attr("score");
            players.push(player);
        });
        pickem.values.players = players;
    }
    return pickem.values.players;
};

pickem.methods.requestPlayerUpdate = function() {
    if (pickem.values.players.length == 0) {
        pickem.methods.getPlayers();
    }
    var players = (function() {
        var str = "";
        pickem.values.players.forEach(function(el, index, arr) {
            str += el.id;
            if (index < pickem.values.players.length - 1) {
                str += ",";
            }
        });
        return str;
    }());
    $.ajax({
        type: "POST",
        url: pickem.values.getUrl,
        dataType: "json",
        data: {players: players},
        success: pickem.methods.updatePlayers
    });
};

pickem.methods.updatePlayers = function(data, status, xhr) {
    data.players.each(function(el, index) {
        pickem.methods.updatePlayer(el);
        pickem.methods.updatePlayerPosition(el);
    });
};

pickem.methods.updatePlayer = function(player) {
    pickem.values.players.each(function(el, index) {
        if (el.id == player.id) {
            pickem.values.players[index] = player;
            return false;
        }
    });
}

pickem.methods.updatePlayerPosition = function(player) {

};
$(function() {
    $( "#bgg-game-search" ).autocomplete({
        source: "/autofill/bgg" //availableTags
    });

    $( "#new-play-location" ).autocomplete({
        source: "/autofill/location" //availableTags
    });

    $( ".search-location" ).autocomplete({
        source: "/autofill/location" //availableTags
    });


});


$(document).on("click", ".play-name", function(e) {
    $( ".play-name" ).autocomplete({
        source: "/autofill/player" //availableTags
    });
});

$(document).on("click", ".expansion-name", function(e) {
    $( this ).autocomplete({
        source: "/autofill/bgg" //availableTags
    });
});
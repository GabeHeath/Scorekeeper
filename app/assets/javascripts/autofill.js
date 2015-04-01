$(function() {
    $( "#bgg-game-search" ).autocomplete({
        source: "/autofill/bgg",
        select: function (e, ui) { //remove this and below to not force users to select from autofill
            $(this).next().val(ui.item.id);
        },
        change: function (ev, ui) {
            if (!ui.item)
                $(this).val("");
        }
    });

    $( "#new-play-location" ).autocomplete({
        source: "/autofill/location" //availableTags
    });

    $( ".search-location" ).autocomplete({
        source: "/autofill/location" //availableTags
    });

    $( "#play-search-bar" ).autocomplete({
        source: "/autofill/game" //availableTags
    })


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
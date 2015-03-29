// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// main supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery-ui/autocomplete
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require_tree .

$(document).ready(function () {
    $('#homepage-learn-more').on('click', function () {
        $('#hotness-thumbnails')[0].scrollIntoView(true);
    });
});

// Hides images if bgg api returns broken link
$(document).ready(function () {
    $("img").error(function () {
        $(this).hide();
    });
});


var playerCount = 1;
var expansionCount = 1;

function remove_player(link) {
    $(link).closest(".fields").remove();
    playerCount--;
    renumberPlayerRows();
    stripePlayerRows()
}

function remove_expansion(link) {
    $(link).closest(".fields").remove();
    expansionCount--;
    renumberExpansionRows();
    stripeExpansionRows()
}

function renumberPlayerRows() {
    $('#players-table tr:visible').each(function (index, el) {
        $(this).children('td:first').first().text(function (i, t) {
            return index++;
        });
    });
}

function stripePlayerRows() {
    $('#players-table tr:visible').each(function (index, el) {
        $(this).toggleClass("stripe", (index + 1) % 2 == 0);
    });
}

function renumberExpansionRows() {
    $('#expansion-table tr:visible').each(function (index, el) {
        $(this).children('td:first').first().text(function (i, t) {
            return index++;
        });
    });
}

function stripeExpansionRows() {
    $('#expansion-table tr:visible').each(function (index, el) {
        $(this).toggleClass("stripe", (index + 1) % 2 == 0);
    });
}

$(document).ready(function () {
    $(".add_player").click(function (event) {
        var regexp, time;
        time = new Date().getTime();
        regexp = new RegExp('blank', 'g');
        $('#players-table tr:last').after($(this).data('fields').replace(regexp, time));
        playerCount++;
        $('#players-table tr:last td:first').text(playerCount);
        stripePlayerRows();
        return event.preventDefault();
    });

    $(".add_expansion").click(function (event) {
        var regexp, time;
        time = new Date().getTime();
        regexp = new RegExp('blank', 'g');
        $('#expansion-table tr:last').after($(this).data('fields').replace(regexp, time));
        expansionCount++;
        $('#expansion-table tr:last td:first').text(expansionCount);
        stripeExpansionRows();
        return event.preventDefault();
    });

    $("#play-table tr[data-link]").click(function() {
        window.location = $(this).data("link")
    })
});



$(document).ready(function() {
    clearAdvancedSearchFields()

    var advancedSearchOpen = false;
    $('#advanced-search-btn').on('click', function() {
        if (!advancedSearchOpen) {
            $('#advanced-search').show();
            $('#advanced-search-btn').attr('class', 'btn btn-default glyphicon glyphicon-chevron-up');
            advancedSearchOpen = true;
        } else {
            $('#advanced-search').hide();
            $('#advanced-search-btn').attr('class', 'btn btn-default glyphicon glyphicon-chevron-down');

            clearAdvancedSearchFields()
            advancedSearchOpen = false;
        }

    });

    $("#searchclear").click(function(){
        $("#play-search-bar").val('');
    });
});


function clearAdvancedSearchFields() {
    $('#start-date').val('')
    $('#end-date').val('')
    $('#location-search-bar').val('')
}

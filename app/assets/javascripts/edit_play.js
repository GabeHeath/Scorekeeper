$(document).ready(function () {
    $('input[name^=existing_win]').each(function() {
        if ($(this).prop('checked')) {
            $(this).prev().prop('disabled', true);
        } else {
            $(this).prev().prop('disabled', false);
        }
    });

    $("#existing-players-table").delegate(":checkbox", "click", function () {
        if ($(this).prop('checked')) {
            $(this).prev().prop('disabled', true);
        } else {
            $(this).prev().prop('disabled', false);
        }
    });

    $("#existing-players-table").delegate(".existing-team-selector", "change", function () {
        var color = $( this ).val()
        var row = $( this ).closest('tr')
        if(color != "none") {
            row.css("background-color", color);
            $('#existing-players-table > tbody > tr > td').css("border-top", "none");
        } else {
            row.removeAttr( "style" );
            $('#existing-players-table > tbody > tr > td').removeAttr( "style" );
        }

        row.insertAfter(findTeamExistingTeam(color, row));

        renumberPlayerRows();
    });
});


function findTeamExistingTeam(color, row) {
    var toReturn;
    $(".existing-team-selector").each(function() {
        if ($(this).val() == color) {
            toReturn = $(this).closest('tr');
            return false;
        }
    });

    return toReturn;
}
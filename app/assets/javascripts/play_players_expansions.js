$(document).ready(function () {
    $("#players-table").delegate(":checkbox", "click", function () {
        if ($(this).prop('checked')) {
            $(this).prev().prop('disabled', true);
        } else {
            $(this).prev().prop('disabled', false);
        }
    });

    $("#players-table").delegate(".team-selector", "change", function () {
        var color = $( this ).val()
        var row = $( this ).closest('tr')
        if(color != "none") {
            row.css("background-color", color);
            $('table > tbody > tr > td').css("border-top", "none");
        } else {
            row.removeAttr( "style" );
            $('table > tbody > tr > td').removeAttr( "style" );
        }

        row.insertAfter(findTeam(color, row));

        renumberPlayerRows();
    });
});


function findTeam(color, row) {
    var toReturn;
    $(".team-selector").each(function() {
        if ($(this).val() == color) {
            toReturn = $(this).closest('tr');
            return false;
        }
    });

    return toReturn;
}
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
    //console.log(color);
    //console.log(row);
    $(".team-selector").each(function() {
        console.log($(this).val());
        if ($(this).val() == color) {
            //console.log($(this).closest('tr'));
            toReturn = $(this).closest('tr');
            return false;
        }
    });

    return toReturn;
}
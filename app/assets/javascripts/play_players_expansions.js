$(document).ready(function () {
    $("#players-table").delegate(":checkbox", "click", function () {
        if ($(this).prop('checked')) {
            $(this).prev().prop('disabled', true);
        } else {
            $(this).prev().prop('disabled', false);
        }
    });
});
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('.datepicker').datepicker(
    format: "yyyy-mm-dd"
    todayHighlight: true
    todayBtn: 'linked'
    autoclose: true
  )

  $('#submit-play').on 'click', ->
    $('#new_play').submit()
    return
  return


#  $('form').on 'click', '.add_fields', (event) ->
#    alert('FUCK')
#    time = new Date().getTime()
#    regex = new RegExp($(this).data('id'), 'g')
#    $(this).before($(this).data('fields').replace(regexp, time))
#    event.preventDefault()
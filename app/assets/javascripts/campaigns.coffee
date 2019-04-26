# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# ok
# M.toast({html: '<i class="tiny material-icons">check_circle</i> I am a toast!', displayLength: '4000', classes:'green' })
# error
# M.toast({html: '<i class="tiny material-icons">cancel</i> Erro!', displayLength: '4000', classes:'red' })
#aviso
# M.toast({html: '<span>Aviso</span><i class="tiny material-icons"  style="margin-left:10px;">error</i>', displayLength: '4000', classes:'orange' })
$(document).on 'turbolinks:load', ->
  $('.update_campaign input').bind 'blur', ->
    $('.update_campaign').submit()

  $('.update_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
      type:'PUT'
      dataType: 'json',
      data: $('.update_campaign').serialize()
      success: (data, text, jqXHR) ->
        M.toast({html: '<span>Campanha atualizada <i class="tiny material-icons">check_circle</i></span>', displayLength: '4000', classes:'green' })
      error: (jqXHR, textStatus, errorThrown) -> 
        M.toast({html: '<span>Problema na atualização da Campanha <i class="tiny material-icons">cancel</i></span>', displayLength: '4000', classes:'red' })
    return false

  $('.remove_campaign').on 'submit', (e) ->
    $.ajax e.target.action, 
      type:'DELETE'
      dataType: 'json',
      data: {}
      
      success: (data, text, jqXHR) ->
        $(location).attr('href','/campaigns');
      error: (jqXHR, textStatus, errorThrown) ->
        M.toast({html: '<span>Problema na remoção da Campanha <i class="tiny material-icons">cancel</i></span>', displayLength: '4000', classes:'red' })
    return false;

  $('.raffle_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
      type: 'POST'
      dataType: 'json',
      data: {}

      success: (data, text, jqXHR) ->
        M.toast({html: '<span>Tudo certo, em breve os participantes receberão um email <i class="tiny material-icons">check_circle</i></span>', displayLength: '4000', classes:'green' })
      error: (jqXHR, textStatus, errorThrown) ->
        M.toast({html: '<span>'+jqXHR.responseText+' <i class="tiny material-icons">error</i></span>', displayLength: '4000', classes:'orange' })
    return false  
$(document).on 'turbolinks:load', ->
  $('#member_email, #member_name').keypress (e) ->
    if e.which == 13 && valid_email($( "#member_email" ).val()) && $( "#member_name" ).val() != ""
      $('.new_member').submit()

  $('#member_email, #member_name').bind 'blur', ->
    if valid_email($( "#member_email" ).val()) && $( "#member_name" ).val() != ""
      $('.new_member').submit()

  $('.member_update').on 'change', (e) ->
    member_id = e.currentTarget.id.replace("member_","")
    $.ajax '/members/' + member_id,
      type: 'PUT',
      dataType: 'json',
      data: { 
        member: {
          name:$("#name_"+member_id).val(),
          email:$("#email_"+member_id).val(),
          campaign_id: $("input[name='member[campaign_id]']").val()
        } 
      }
      success: (data, text, jqXHR) -> 
        M.toast({html: '<span>Membro atualizado com sucesso <i class="tiny material-icons">check_circle</i></span>', displayLength: '4000', classes:'green'})
      error: (jqXHR, textStatus, errorThrown) ->
        M.toast({html: '<span>Problema ao atualizar membro <i class="tiny material-icons">cancel</i></span>', displayLength: '4000', classes:'red' })
    return false

  $('body').on 'click', 'a.remove_member', (e) ->
    $.ajax '/members/'+ e.currentTarget.id,
        type: 'DELETE'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          M.toast({html: '<span>Membro removido <i class="tiny material-icons">check_circle</i></span>', displayLength: '4000', classes:'green' })
          $('#member_' + e.currentTarget.id).remove()
        error: (jqXHR, textStatus, errorThrown) ->
          M.toast({html: '<span>Problema na hora de incluir membro <i class="tiny material-icons">cancel</i></span>', displayLength: '4000', classes:'red' })
    return false

  $('.new_member').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: $(".new_member").serialize()
        success: (data, text, jqXHR) ->
          insert_member(data['id'], data['name'],  data['email'])
          $('#member_name, #member_email').val("")
          $('#member_name').focus()
          M.toast({html: '<span>Membro adicionado <i class="tiny material-icons">check_circle</i></span>', displayLength: '4000', classes:'green' })
          Materialize.toast('Membro adicionado', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          M.toast({html: '<span>Problema na hora de incluir membro <i class="tiny material-icons">cancel</i></span>', displayLength: '4000', classes:'red' })
    return false

valid_email = (email) ->
  /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email)

insert_member = (id, name, email) ->
  html = '<div class="member" id="member_' + id + '">' +
      '<div class="row">' +
        '<div class="col s12 m5 input-field">' +
          '<input id="name" type="text" class="validate" value="' + name + '">' +
          '<label for="name" class="active">Nome</label>' +
        '</div>' +
        '<div class="col s12 m5 input-field">' +
          '<input id="email" type="email" class="validate" value="' + email + '">' +
          '<label for="email" class="active" data-error="Formato incorreto">Email</label>' +
        '</div>' +
        '<div class="col s3 offset-s3 m1 input-field">' +
          '<i class="material-icons icon">visibility</i>' +
        '</div>' +
        '<div class="col s3 m1 input-field">' +
          '<a href="#" class="remove_member" id="' + id + '">' +
            '<i class="material-icons icon">delete</i>' +
          '</a>' +
        '</div>' +
      '</div>' +
    '</div>'

  $('.member_list').append(html)
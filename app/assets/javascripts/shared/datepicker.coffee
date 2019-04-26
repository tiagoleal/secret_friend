$(document).on 'turbolinks:load', ->
  $('.datepicker').datepicker({
      showMonthAfterYear: true,
      showDaysInNextAndPreviousMonths: true,
      today: 'Today',
      clear: 'Clear',
      close: 'Ok',
      autoClose: true,
      format: 'dd/mm/yyyy',
  });
  $('.timepicker').timepicker();
  return

  $(function() {
     $( "#date_from_div" ).datepicker({
      defaultDate: "-1w",
      changeMonth: true,
      changeMonth: false,
      closeText: 'Zamknij',
      prevText: '&#x3c;Poprzedni',
      nextText: 'Następny&#x3e;',
      currentText: 'Dziś',
      monthNames: ['Styczeń','Luty','Marzec','Kwiecień','Maj','Czerwiec',
      'Lipiec','Sierpień','Wrzesień','Październik','Listopad','Grudzień'],
      monthNamesShort: ['Sty','Lu','Mar','Kw','Maj','Cze',
      'Lip','Sie','Wrz','Pa','Lis','Gru'],
      dayNames: ['Niedziela','Poniedziałek','Wtorek','Środa','Czwartek','Piątek','Sobota'],
      dayNamesShort: ['Nie','Pn','Wt','Śr','Czw','Pt','So'],
      dayNamesMin: ['N','Pn','Wt','Śr','Cz','Pt','So'],
      numberOfMonths: 1,
      showAnim: "slide",
      altField: "#search_date_from",
      altFormat: "dd-mm-yy",
    });
    $( "#date_to_div" ).datepicker({
      defaultDate: "today",
      changeMonth: true,
      changeMonth: false,
      closeText: 'Zamknij',
      prevText: '&#x3c;Poprzedni',
      nextText: 'Następny&#x3e;',
      currentText: 'Dziś',
      monthNames: ['Styczeń','Luty','Marzec','Kwiecień','Maj','Czerwiec',
      'Lipiec','Sierpień','Wrzesień','Październik','Listopad','Grudzień'],
      monthNamesShort: ['Sty','Lu','Mar','Kw','Maj','Cze',
      'Lip','Sie','Wrz','Pa','Lis','Gru'],
      dayNames: ['Niedziela','Poniedziałek','Wtorek','Środa','Czwartek','Piątek','Sobota'],
      dayNamesShort: ['Nie','Pn','Wt','Śr','Czw','Pt','So'],
      dayNamesMin: ['N','Pn','Wt','Śr','Cz','Pt','So'],
      numberOfMonths: 1,
      showAnim: "slide",
      altField: "#search_date_to",
      altFormat: "dd-mm-yy",
    });

 $('#cele_ce_data').datepicker( {dateFormat: 'dd-mm-yy',
   defaultDate: "today",
      changeMonth: true,
      changeMonth: false,
      closeText: 'Zamknij',
      prevText: '&#x3c;Poprzedni',
      nextText: 'Następny&#x3e;',
      currentText: 'Dziś',
      monthNames: ['Styczeń','Luty','Marzec','Kwiecień','Maj','Czerwiec',
      'Lipiec','Sierpień','Wrzesień','Październik','Listopad','Grudzień'],
      monthNamesShort: ['Sty','Lu','Mar','Kw','Maj','Cze',
      'Lip','Sie','Wrz','Pa','Lis','Gru'],
      dayNames: ['Niedziela','Poniedziałek','Wtorek','Środa','Czwartek','Piątek','Sobota'],
      dayNamesShort: ['Nie','Pn','Wt','Śr','Czw','Pt','So'],
      dayNamesMin: ['N','Pn','Wt','Śr','Cz','Pt','So']



});
 $('#effectivenes_ef_data').datepicker( {dateFormat: 'dd-mm-yy',
   defaultDate: "today",
      changeMonth: true,
      changeMonth: false,
      closeText: 'Zamknij',
      prevText: '&#x3c;Poprzedni',
      nextText: 'Następny&#x3e;',
      currentText: 'Dziś',
      monthNames: ['Styczeń','Luty','Marzec','Kwiecień','Maj','Czerwiec',
      'Lipiec','Sierpień','Wrzesień','Październik','Listopad','Grudzień'],
      monthNamesShort: ['Sty','Lu','Mar','Kw','Maj','Cze',
      'Lip','Sie','Wrz','Pa','Lis','Gru'],
      dayNames: ['Niedziela','Poniedziałek','Wtorek','Środa','Czwartek','Piątek','Sobota'],
      dayNamesShort: ['Nie','Pn','Wt','Śr','Czw','Pt','So'],
      dayNamesMin: ['N','Pn','Wt','Śr','Cz','Pt','So']



});
 $('#premie_pe_data_od').datepicker( {dateFormat: 'dd-mm-yy',
   defaultDate: "today",
      changeMonth: true,
      changeMonth: false,
      closeText: 'Zamknij',
      prevText: '&#x3c;Poprzedni',
      nextText: 'Następny&#x3e;',
      currentText: 'Dziś',
      monthNames: ['Styczeń','Luty','Marzec','Kwiecień','Maj','Czerwiec',
      'Lipiec','Sierpień','Wrzesień','Październik','Listopad','Grudzień'],
      monthNamesShort: ['Sty','Lu','Mar','Kw','Maj','Cze',
      'Lip','Sie','Wrz','Pa','Lis','Gru'],
      dayNames: ['Niedziela','Poniedziałek','Wtorek','Środa','Czwartek','Piątek','Sobota'],
      dayNamesShort: ['Nie','Pn','Wt','Śr','Czw','Pt','So'],
      dayNamesMin: ['N','Pn','Wt','Śr','Cz','Pt','So']



});
 $('#premie_pe_data_do').datepicker( {dateFormat: 'dd-mm-yy',
   defaultDate: "today",
      changeMonth: true,
      changeMonth: false,
      closeText: 'Zamknij',
      prevText: '&#x3c;Poprzedni',
      nextText: 'Następny&#x3e;',
      currentText: 'Dziś',
      monthNames: ['Styczeń','Luty','Marzec','Kwiecień','Maj','Czerwiec',
      'Lipiec','Sierpień','Wrzesień','Październik','Listopad','Grudzień'],
      monthNamesShort: ['Sty','Lu','Mar','Kw','Maj','Cze',
      'Lip','Sie','Wrz','Pa','Lis','Gru'],
      dayNames: ['Niedziela','Poniedziałek','Wtorek','Środa','Czwartek','Piątek','Sobota'],
      dayNamesShort: ['Nie','Pn','Wt','Śr','Czw','Pt','So'],
      dayNamesMin: ['N','Pn','Wt','Śr','Cz','Pt','So']



});

    $( "#timestamp" ).buttonset();
    $( "#kwartal" ).click(function(){
      var val = $("#search_date_to").val();
      var curr_date = Date.parse(val);
      curr_date = curr_date.setDate(curr_date.getDate() - 90);
      curr_date = moment(curr_date).format("DD-MM-YYYY");
      $("#search_date_from").val(curr_date);
    });

     $( "#miesiac" ).click(function(){
      var val = $("#search_date_to").val();
      var curr_date = Date.parse(val);
      curr_date = curr_date.setDate(curr_date.getDate() - 30);
      curr_date = moment(curr_date).format("DD-MM-YYYY");
      $("#search_date_from").val(curr_date);
    });
      $( "#tydzien" ).click(function(){
      var val = $("#search_date_to").val();
      var curr_date = Date.parse(val);
      curr_date = curr_date.setDate(curr_date.getDate() - 7);
      curr_date = moment(curr_date).format("DD-MM-YYYY");
      $("#search_date_from").val(curr_date);

    });
  });

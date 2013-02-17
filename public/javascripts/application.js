// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(function() {
  jQuery("#task_tcd").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#task_scd").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#task_acd").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });

  jQuery("#test_prog_date_received").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });

  jQuery("#pto_start").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#pto_finish").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#project_dr1").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#project_dr2").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#project_dr3").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#project_dr4").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#project_dr5").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });

  jQuery( "#accordion" ).accordion({ heightStyle: 'content' },{ collapsible: true, active: false });
  jQuery( "#cost_accordian" ).accordion({ heightStyle: 'content' },{ collapsible: true });
  jQuery( "#tabs" ).tabs({event: "mouseover"});

  jQuery( "#sortable" ).sortable();
  jQuery( "#sortable" ).disableSelection();

	});
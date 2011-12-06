// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(function() {
  jQuery("#task_tcd").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#task_scd").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#task_acd").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#pto_start").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#pto_finish").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery( "#accordion" ).accordion({ autoHeight: false },{ collapsible: true });
  jQuery( "#cost_accordian" ).accordion({ autoHeight: false },{ collapsible: true },{ animated: 'bounceslide' });

	});
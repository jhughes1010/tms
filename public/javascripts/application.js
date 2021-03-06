// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(document).ready(function() {
    jQuery("#sample_dateExchange").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
    jQuery("#sample_dateSamples").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
    jQuery("#sample_dateCustApproval").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
    jQuery("#sample_dateQAEnable").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
    jQuery("#sample_target").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
    jQuery("#sample_dateReleaseProduction").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });

  jQuery("#task_tcd").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#task_scd").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
  jQuery("#task_acd").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });

  jQuery("#sa_date").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });

  jQuery("#user_passport").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });

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
  jQuery( "#tabs" ).tabs({event: "mouseover", heightStyle: "fill" });
  jQuery( "#prr" ).dataTable({
            stateSave: true,
            stateDuration: -1,
	        lengthMenu: [[-1, 10, 25, 50],["All", 10, 25, 50]]
        });
        
  jQuery('table.disp').dataTable({
    stateSave: true,
    order: [[ 4, "asc" ]],
	  lengthMenu: [[-1, 10, 25, 50],["All", 10, 25, 50]]
      });
  
  jQuery( "#sortable" ).sortable({
  	axis: 'y',
    update: function(event, ui){
    var itm_arr = jQuery("#sortable").sortable('toArray');
    var pobj = {categories: itm_arr};
    jQuery.post("/priority/reorder", pobj);
        }
      });
	});


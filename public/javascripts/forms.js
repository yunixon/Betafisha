jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

//var $j = jQuery.noConflict();

$(document).ready(function() {

	$('.new_sport, .new_league, .new_country, .edit_sport, .edit_league, .edit_country, .bookmakers_form').submit( function() {
		$.post(this.action, $(this).serialize(), null, "script");
		return false;
	});

	$('#new_sport_item, #new_country_item').click( function() {
		$.ajax({
	   		type: 'POST',
	   		url: this.getAttribute('href'),
	   		dataType:'script'
	   	});
		return false;
	});

	$('#admin_element_id').bind( "change", function() {
  		$.ajax({
	   		type: 'GET',
	   		data: { table_name: $('#admin_table_name').val(),
	   		        bookmaker_name: $('#admin_bookmaker_name').val(),
	   		        element_id: $('#admin_element_id').val(),
	   		        bookmaker_element_id: $('#admin_bookmaker_element_id').val()
	   		       },
	   		url: '/admin/bookmakers_manager',
	   		dataType:'script'
	   	});
	});

		$('#show_relations').bind( "click", function() {
  		$.ajax({
	   		type: 'GET',
	   		data: { table_name: $('#admin_table_name').val(),
	   		        bookmaker_name: $('#admin_bookmaker_name').val(),
	   		        element_id: $('#admin_element_id').val(),
	   		        bookmaker_element_id: $('#admin_bookmaker_element_id').val()
	   		       },
	   		url: '/admin/bookmakers_manager',
	   		dataType:'script'
	   	});
	});

	$('#admin_bookmaker_name, #admin_table_name').change(function() {
  		$.ajax({
	   		type: 'GET',
	   		data: { table_name: $('#admin_table_name').val(),
	   		        bookmaker_name: $('#admin_bookmaker_name').val(),
              },
	   		url: '/admin/bookmakers_manager',
	   		dataType:'script'
	   	});
	});

	$('.delete_relation').click (function() {
  		$.ajax({
	   		type: 'GET',
	   		data: { table_name: $('#admin_table_name').val(),
	   		        bookmaker_name: $('#admin_bookmaker_name').val(),
	   		        element_id: $('#admin_element_id').val(),
	   		        bookmaker_element_id: this.getAttribute('id')
	   		      },
	   		url: '/admin/delete_bookmaker_relation',
	   		dataType:'script'
	   	});

	    return false;
	});

	$('.priority').filter_input({regex:'[0-9]'});

  $('select').selectmenu({
		    style:'dropdown',
		    width: 350,
		    menuWidth: 350,
		    maxHeight: 300,
		    icons: [
			    {find: '.russia'},
			    {find: '.usa'},
		    ]
  });

});


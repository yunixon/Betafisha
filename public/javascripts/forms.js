jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

var $j = jQuery.noConflict();

$j(document).ready(function() {

	$j('.new_sport, .new_league, .new_country, .edit_sport, .edit_league, .edit_country, .bookmakers_form').submit( function() {
		$j.post(this.action, $j(this).serialize(), null, "script");
		return false;
	});

	$j('#new_sport_item, #new_country_item').click( function() {
		$j.ajax({ 
	   		type: 'POST',
	   		url: this.getAttribute('href'), 
	   		dataType:'script' 
	   	});
		return false;
	});	
	
	$j('#admin_element_id').bind( "change", function() {
  		$j.ajax({ 
	   		type: 'GET',
	   		data: { table_name: $j('#admin_table_name').val(), 
	   		        bookmaker_name: $j('#admin_bookmaker_name').val(),
	   		        element_id: $j('#admin_element_id').val(),
	   		        bookmaker_element_id: $j('#admin_bookmaker_element_id').val()
	   		       }, 
	   		url: '/admin/bookmakers_manager', 
	   		dataType:'script' 
	   	});
	});
	
		$j('#show_relations').bind( "click", function() {
  		$j.ajax({ 
	   		type: 'GET',
	   		data: { table_name: $j('#admin_table_name').val(), 
	   		        bookmaker_name: $j('#admin_bookmaker_name').val(),
	   		        element_id: $j('#admin_element_id').val(),
	   		        bookmaker_element_id: $j('#admin_bookmaker_element_id').val()
	   		       }, 
	   		url: '/admin/bookmakers_manager', 
	   		dataType:'script' 
	   	});
	});
		
	$j('#admin_bookmaker_name, #admin_table_name').change(function() {
  		$j.ajax({ 
	   		type: 'GET',
	   		data: { table_name: $j('#admin_table_name').val(), 
	   		        bookmaker_name: $j('#admin_bookmaker_name').val(),
              }, 
	   		url: '/admin/bookmakers_manager', 
	   		dataType:'script' 
	   	});
	});

	$j('.delete_relation').click (function() { 
  		$j.ajax({ 
	   		type: 'GET',
	   		data: { table_name: $j('#admin_table_name').val(), 
	   		        bookmaker_name: $j('#admin_bookmaker_name').val(),
	   		        element_id: $j('#admin_element_id').val(),
	   		        bookmaker_element_id: this.getAttribute('id') 
	   		      }, 
	   		url: '/admin/delete_bookmaker_relation', 
	   		dataType:'script' 
	   	});
	   	
	    return false;
	});

	$j('.priority').filter_input({regex:'[0-9]'});
	
});


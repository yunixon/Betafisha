jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

var $j = jQuery.noConflict();

$j(document).ready(function() {

	$j('.new_sport, .new_league, .new_country').submit( function() {
		$j.post(this.action, $j(this).serialize(), null, "script");
		return false;
	});
	
	$j('.edit_sport, .edit_league, .edit_country').submit( function() {
		$j.post(this.action, $j(this).serialize(), null, "script");
		return false;
	});
	
	
	
	
	$j('#new_sport_item').click( function() {
		$j.ajax({ 
	   		type: 'POST',
	   		url: "sport_new",
	   		dataType:'script' 
	   	});
		return false;
	});	
	
		
	$j('#new_country_item').click( function() {
		$j.ajax({ 
	   		type: 'POST',
	   		url: "country_new",
	   		dataType:'script' 
	   	});
		return false;
	});	
	
	$j('.priority').filter_input({regex:'[0-9]'});
	
});


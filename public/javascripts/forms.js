jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

var $j = jQuery.noConflict();

$j(document).ready(function() {

	$j('.new_sport').submit( function() {
		$j.post(this.action, $j(this).serialize(), null, "script");
		return false;
	});
	
	$j('.edit_sport').submit( function() {
		$j.post(this.action, $j(this).serialize(), null, "script");
		return false;
	});
	
});
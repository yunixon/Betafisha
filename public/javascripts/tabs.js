
jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})
var $j = jQuery.noConflict();

$j(document).ready(function() {

	//When page loads...
	$j(".tab_content").hide(); //Hide all content

	
	$j("ul.tabs li::nth-child(3)").addClass("active").show(); //Activate first tab
	$j(".tab_content:first:nth-child(3)").show(); //Show first tab content
	
	//On Click Event
	$j("ul.tabs li").click(function() {

		$j("ul.tabs li").removeClass("active"); //Remove any "active" class
		$j(this).addClass("active"); //Add "active" class to selected tab
		$j(".tab_content").hide(); //Hide all tab content

		var activeTab = $j(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$j(activeTab).show(); //Fade in the active ID content
		return false;
	});
	
	$j('#new_sport').submit( function() {
		$j.post(this.action, $j(this).serialize(), null, "script");
		return false;
	});
	
});
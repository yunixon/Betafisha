jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

var $j = jQuery.noConflict();

$j(document).ready(function() {

	$j('.add_ligue_item').click( function() {
		$j.ajax({ 
	   		type: 'POST',
	   		url: "ligue_new",
	   		dataType:'script' 
	   	});
		return false;
	});
		

	//When page loads...
	/*$j(".tab_content").hide(); //Hide all content
	$j("ul.tabs li:first").addClass("active").show(); //Activate first tab
	$j(".tab_content:first").show(); //Show first tab content

	//On Click Event
	$j("ul.tabs li").click(function() {

		$j("ul.tabs li").removeClass("active"); //Remove any "active" class
		$j(this).addClass("active"); //Add "active" class to selected tab
		$j(".tab_content").hide(); //Hide all tab content

		var activeTab = $j(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$j(activeTab).fadeIn(); //Fade in the active ID content
		return false;
	});*/
	

	
	/*$j('.pagination a').live('click', function() {
		
		$j.getScript(this.href);//, null, null, 'script');
		return false;
	});
	*/
	//$j('a.delete_user').live('click', function() {
		//alert(this.href);
		//var results = new RegExp('[\\?&]' + 'page'+ '=([^&#]*)').exec(this.href);
		//results = results[1] || 0;
		//alert(results);
		//if(confirm(this.getAttribute("data-confirm"), this.getAttribute("title") )) {
	    //   ('#my_pagination').html('<%= will_paginate @users  %>');
	    //   return false;
	   // } else {
	   //return false;
	  // }
	//})
	


	
});
	
	
	

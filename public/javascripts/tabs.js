jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

//var $j = jQuery.noConflict();

$(document).ready(function() {

	$('.add_league_item').click( function() {
		$.ajax({
	   		type: 'POST',
	   		url: "league_new",
	   		dataType:'script'
	   	});
		return false;
	});


	//When page loads...
	$(".tab_content").hide(); //Hide all content
	$("ul.tabs li:first").addClass("active").show(); //Activate first tab
	$(".tab_content:first").show(); //Show first tab content

	//On Click Event
	$("ul.tabs li").click(function() {

		$("ul.tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content

		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active ID content
		return false;
	});



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


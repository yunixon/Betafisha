var $j = jQuery.noConflict();

$j.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$j(document).ready(function() {

	//When you click on a link with class of poplight and the href starts with a #
	$j('a.poplight[href^=#]').click(function() {
		var popID = $j(this).attr('rel'); //Get Popup Name
		var popURL = $j(this).attr('href'); //Get Popup href to define size

		//Pull Query & Variables from href URL
		var query= popURL.split('?');
		var dim= query[1].split('&');
		var popWidth = dim[0].split('=')[1]; //Gets the first query string value

		//Fade in the Popup and add close button
		$j('#' + popID).fadeIn().css({ 'width': Number( popWidth ) }).prepend('<a href="#" class="close"><img src="../images/close.png" class="btn_close" title="Close Window" alt="Close" /></a>');

		//Define margin for center alignment (vertical   horizontal) - we add 80px to the height/width to accomodate for the padding  and border width defined in the css
		var popMargTop = ($j('#' + popID).height() + 80) / 2;
		var popMargLeft = ($j('#' + popID).width() + 80) / 2;

		//Apply Margin to Popup
		$j('#' + popID).css({
		    'margin-top' : -popMargTop,
		    'margin-left' : -popMargLeft
		});

		//Fade in Background
		$j('body').append('<div id="fade"></div>'); //Add the fade layer to bottom of the body tag.
		$j('#fade').css({'filter' : 'alpha(opacity=80)'}).fadeIn(); //Fade in the fade layer - .css({'filter' : 'alpha(opacity=80)'}) is used to fix the IE Bug on fading transparencies

		return false;
	});

	//Close Popups and Fade Layer
	$j('a.close, #fade').live('click', function() { //When clicking on the close or fade layer...
		$j('#fade , .popup_block').fadeOut(function() {
		    $j('#fade, a.close').remove();  //fade them both out
		});
		return false;
	});

});


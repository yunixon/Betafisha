var $j = jQuery.noConflict();

$j.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$j(document).ready(function() {
  $j('.add_to_coupon').click( function() { alert("sada ");	});

  $j('.odds-data').hide();

	$j('.event a').click( function() {

	/*	$j.ajax({
	   		type: 'GET',
	   		data: { type: "show_event_bets"  },
	   		url: '/coefficients',
	   		dataType:'script'
	   	});
		return false;*/

	});
	//$j('wrapper').css('height', $j('#left_nav').css('height') );
	/*console.log('a');

	setInterval( function() {

		$j.ajax({
	   		type: 'GET',
	   		url: 'api_test',
	   		dataType:'script'
	   	});

		}, 5000 );
		*/





})


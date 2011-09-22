jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {

  $('.add_to_coupon, .remove_to_coupon').click( function() {
	  $.ajax({
	     		type: 'GET',
	     		data: { type: this.getAttribute("class"), sport_id: this.getAttribute("id") },
	     		url: '/coefficients',
	     		dataType:'script'
	     	});
		  return false;
  });

  $('.odds-data').hide();

  $('.event-title').click( function() {
		if( $(this).next().is(':hidden') ) {
			$('.event-title').removeClass('active').next().hide();
			$(this).toggleClass('active').next().show();
		} else {
		  $('.event-title').removeClass('active');
		  $('.odds-data').hide();

		}
		return false;
	});

	//$('.event-title  a').click( function() {});

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


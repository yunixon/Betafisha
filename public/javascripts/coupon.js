 jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() { // add league to coupon
  $('.add_to_coupon, .remove_from_coupon').click( function() {
    $.ajax({
	     		type: 'GET',
	     		data: { type: this.getAttribute("class"), sport_id: this.getAttribute("id") },
	     		url: '/leaguetocoupon',
	     		dataType:'script'
	     	});
		  return false;
  });

});


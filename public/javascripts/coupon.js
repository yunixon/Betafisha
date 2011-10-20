 jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() { // add league to coupon
  $('.add_coupon_manager, .remove_coupon_manager, .remove_coupon_from_list').click( function() {
    alert( this.getAttribute("data") );
    $.ajax({
	     		type: 'GET',
	     		data: { type: this.getAttribute("data"), sport_id: this.getAttribute("id") },
	     		url: '/leaguetocoupon',
	     		dataType:'script'
	     	});
		  return false;
  });

});


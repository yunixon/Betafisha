 jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() { // add league to coupon

  $('a.remove_coupon_from_list').click( function(e) {
    $.ajax({
	     		type: 'GET',
	     		data: { type: this.getAttribute("data"), sport_id: this.getAttribute("id") },
	     		url: '/leaguetocoupon',
	     		dataType:'script'
	     	});
	    e.stopPropagation();
		  return false;
  });

});


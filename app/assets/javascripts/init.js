jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {

  accordionInit();
  accordionFromCookies();

  $('#tools-li a').click(function() { return false; });
  $("#cache-expire-button").click(function(){
    $.ajax({
     		type: 'GET',
     		data: { filter_type: 'cache_expire' },
     		url: '/admin/cache_expire',
     		dataType:'script'
    });
    return false;
  });
  
});

// accordion init
function accordionInit() {
	$('.acc_container').hide();
	$('.leagues').hide();
	$("a.delete_sport_item").hide();
	$("a.edit_sport_item").hide();
}

// gets accordion state from cookie
function accordionFromCookies() {
      if($.cookie('nav_menu_sport') != null) {
      sport_item_id = $.cookie('nav_menu_sport');
       $("#" + sport_item_id).addClass("active").next().show();
      if($.cookie('nav_menu_country') != null) {
         country_item_id = $.cookie('nav_menu_country');
         $("#" + country_item_id).addClass("active").next().show();
      }
    }
}

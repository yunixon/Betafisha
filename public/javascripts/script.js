jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {

  accordionInit();
  accordionFromCookies();

    /**************** ********** ********************/
    /****************  EVENTS    ********************/
    /**************** ********** ********************/

   /* BET TYPE FILTERS */
    $('.allin-filter, .1x2-filter, .1or2-filter, .Outright-filter').click(function(){
    $(this).addClass("active");
	    $.ajax({
	       		type: 'GET',
	       		data: { filter_type: this.getAttribute("class"), sport_id: this.getAttribute("id") },
	       		url: '/coefficients',
	       		dataType:'script'
	       	});
      	return false;
    });

    /**************** ********** ********************/
    /****************  STYLINGS  ********************/
    /**************** ********** ********************/
    $("ul.dropdown li").hover(function(){
        $(this).addClass("hover");
        $('ul:first',this).css('visibility', 'visible');
    }, function(){
        $(this).removeClass("hover");
        $('ul:first',this).css('visibility', 'hidden');
    });

    $("ul.dropdown li ul li:has(ul)").find("a:first").append(" &raquo; ");

    $("a#toggle-coupon-info").click(function() {
      $(this).removeClass("active");
      if($(this).parent().next().is(':hidden')){
        $(this).parent().next().show();
        $(this).parent().next().addClass("active");
      } else {
        $(this).parent().next().hide();
        $(this).removeClass("active");
      }
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


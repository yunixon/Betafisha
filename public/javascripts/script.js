jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {



  $('.add_to_coupon, .remove_from_coupon').click( function() {
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
			$("a.expand").css({backgroundPosition: '0px -50px'});
			$(this).find( "a.expand" ).css({backgroundPosition: '0px -10px'});
			$(this).toggleClass('active').next().show();
		} else {
		  $('.event-title').removeClass('active');
		  $(this).find( "a.expand" ).css({backgroundPosition: '0px -50px'});
		  $('.odds-data').hide();
		}
		return false;
	});

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



})


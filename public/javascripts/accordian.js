$(document).ready(function() {

	$('.acc_container').hide();
	$('.leagues').hide();
	$("a.delete_sport_item").hide();
	$("a.edit_sport_item").hide();
	//$j('.acc_trigger:first').addClass('active').next().show();


	$('.acc_trigger').mouseover( function(){
		$("a.delete_sport_item").hide();
		$(this).find('a.delete_sport_item').show();
		$(this).find('a.edit_sport_item').show();
	});

	$('.acc_trigger').mouseout( function() {
		$("a.delete_sport_item").hide();
		$("a.edit_sport_item").hide();
	});

	$("a.delete_sport_item, a.delete_league_item, a.delete_country_item").click( function() {
        if(confirm(this.getAttribute("data-confirm"), this.getAttribute("title") )) {
            $.post(this.href, {_method:'delete'}, null, "script");
            return false;
        } else {
            return false;
        }
	});

	$("a.edit_sport_item").click( function() {
        $.ajax({
	   		type: 'POST',
	   		url: "sport_edit",
	   		data: { id : this.getAttribute('id') },
	   		dataType:'script'
	   	});
        return false;
	});

	$("a.edit_country_item").click( function() {
        $.ajax({
	   		type: 'POST',
	   		url: "country_edit",
	   		data: { id : this.getAttribute('id') },
	   		dataType:'script'
	   	});
        return false;
	});

	$("a.edit_league_item").click( function() {
        $.ajax({
	   		type: 'POST',
	   		url: "league_edit",
	   		data: { id : this.getAttribute('id') },
	   		dataType:'script'
	   	});
        return false;
	});

	$('.acc_trigger').click( function() {

    $.cookie('nav_menu_sport', $(this).attr("id"), { expires: 7 });
    $.cookie('nav_menu_country', null);

		if( $(this).next().is(':hidden') ) {
			$('.acc_trigger').removeClass('active').next().hide();
			$(this).toggleClass('active').next().show();
		} else {
      $.cookie('nav_menu_sport', null);
		  $('.acc_trigger').removeClass('active');
		  $('.acc_container').hide();

		}

		return false;
	});

	$('.countries li.country a').click( function() {
    $.cookie('nav_menu_country', $(this).parent().attr("id"), { expires: 7 });
		if( $(this).parent().next().is(':hidden') ) {
			$('.countries li.country a').parent().removeClass('active').next().hide();
			$(this).parent().toggleClass('active').next().show();
		}
		return false;
	});

	/*$('.leagues li.league').click( function() {
		$.ajax({
	   		type: 'GET',
	   		data: { sport_id :  this.getAttribute('id'), type: "show_league_events"  },
	   		url: '/coefficients',
	   		dataType:'script'
	   	});
		return false;
	});*/

});


$j(document).ready(function() {

	$j('.acc_container').hide();
	$j('.leagues').hide();
	$j("a.delete_sport_item").hide();
	$j("a.edit_sport_item").hide();
	//$j('.acc_trigger:first').addClass('active').next().show();


	$j('.acc_trigger').mouseover( function(){
		$j("a.delete_sport_item").hide();
		$j(this).find('a.delete_sport_item').show();
		$j(this).find('a.edit_sport_item').show();
	});

	$j('.acc_trigger').mouseout( function() {
		$j("a.delete_sport_item").hide();
		$j("a.edit_sport_item").hide();
	});

	$j("a.delete_sport_item, a.delete_league_item, a.delete_country_item").click( function() {
        if(confirm(this.getAttribute("data-confirm"), this.getAttribute("title") )) {
            $j.post(this.href, {_method:'delete'}, null, "script");
            return false;
        } else {
            return false;
        }
	});

	$j("a.edit_sport_item").click( function() {
        $j.ajax({
	   		type: 'POST',
	   		url: "sport_edit",
	   		data: { id : this.getAttribute('id') },
	   		dataType:'script'
	   	});
        return false;
	});

	$j("a.edit_country_item").click( function() {
        $j.ajax({
	   		type: 'POST',
	   		url: "country_edit",
	   		data: { id : this.getAttribute('id') },
	   		dataType:'script'
	   	});
        return false;
	});

	$j("a.edit_league_item").click( function() {
        $j.ajax({
	   		type: 'POST',
	   		url: "league_edit",
	   		data: { id : this.getAttribute('id') },
	   		dataType:'script'
	   	});
        return false;
	});

	$j('.acc_trigger').click( function() {
		if( $j(this).next().is(':hidden') ) {
			$j('.acc_trigger').removeClass('active').next().hide();
			$j(this).toggleClass('active').next().show();
		} else {
		  $j('.acc_trigger').removeClass('active');
		  $j('.acc_container').hide();

		}

		return false;
	});

	$j('.countries li.country a').click( function() {
		if( $j(this).parent().next().is(':hidden') ) {
			$j('.countries li.country a').parent().removeClass('active').next().hide();
			$j(this).parent().toggleClass('active').next().show();
		}

		return false;
	});

	$j('.leagues li.league').click( function() {
		$j.ajax({
	   		type: 'GET',
	   		data: { sport_id :  this.getAttribute('id'), type: "show_league_events"  },
	   		url: '/coefficients',
	   		dataType:'script'
	   	});
		return false;
	});

});


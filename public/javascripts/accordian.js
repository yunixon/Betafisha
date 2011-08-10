//Set default open/close settings

//var $j = jQuery.noConflict();

$j(document).ready(function() {
	
	$j('.acc_container').hide(); //Hide/close all containers
	$j('.ligues').hide();
	$j("a.delete_item").hide();
	$j("a.edit_item").hide();
	$j('.acc_trigger:first').addClass('active').next().show(); //Add "active" class to first trigger, then show/open the immediate next container
	
	//On Click
	
	$j('.acc_trigger').mouseover( function(){
		$j("a.delete_item").hide();
		$j(this).find('a.delete_item').show();
		$j(this).find('a.edit_item').show();
		return false; 
	});
	
	$j('.acc_trigger').mouseout( function() {
		$j("a.delete_item").hide();
		$j("a.edit_item").hide();
	});
	
	$j("a.delete_item").click( function() {			
        if(confirm(this.getAttribute("data-confirm"), this.getAttribute("title") )) {
            $j.post(this.href, {_method:'delete'}, null, "script");
            return false;
        } else {
            //they clicked no.
            return false;
        }
	});
	

	
	$j('.acc_trigger').click( function() {

		if( $j(this).next().is(':hidden') ) { //If immediate next container is closed...
			if( $j(this).hasClass('last-child') ) {} 
			else {
				
				$j('.acc_trigger').removeClass('active').next().hide(); //Remove all "active" state and slide up the immediate next container
				$j(this).toggleClass('active').next().show(); //Add "active" state to clicked trigger and slide down the immediate next container
			}
		}
	
		return false; //Prevent the browser jump to the link anchor
	});
	
	$j('.countries li.country a').click( function() {
		
		if( $j(this).parent().next().is(':hidden') ) { //If immediate next container is closed...
			$j('.countries li.country a').parent().removeClass('active').next().hide(); //Remove all "active" state and slide up the immediate next container
			$j(this).parent().toggleClass('active').next().show(); //Add "active" state to clicked trigger and slide down the immediate next container
		}
	
		return false; 
	});
	
	$j('.ligues li.ligue a').click( function() {
		return false;
	});
	
	$j('h2.last-child').click( function() {
		$j.get("/admin", null, "script");
		return false;
	});	

});



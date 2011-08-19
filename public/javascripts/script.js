/**
 * @author dxkxzx
 */


var $j = jQuery.noConflict();

$j.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$j(document).ready(function() {
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


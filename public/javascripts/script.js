/**
 * @author dxkxzx
 */

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})


$(document).ready(function() {
	
  $("#refresh").click(function() {
  	
   $.ajax({ 
   		type: 'GET',
   		url: '/api_test', 
   		dataType:'script' 
   	});

  	return false;
  });
   
})


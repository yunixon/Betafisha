jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {

  $('.form_info').hide();
  $('.form_info').html('');
  
	$('.new_sport, .new_league, .new_country, .edit_sport, .edit_league, .edit_country, .bookmakers_form').submit( function() {
		$.post(this.action, $(this).serialize(), null, "script");
		return false;
	});

	$('#new_sport_item, #new_country_item').click( function() {
		$.ajax({
	   		type: 'POST',
	   		url: this.getAttribute('href'),
	   		dataType:'script'
	   	});
		return false;
	});

	$('#admin_common_element_id').bind( "change", function() {
		$.ajax({
   		type: 'GET',
   		data: { table_name: $('#admin_table_name').val(),
   		        bookmaker_name: $('#admin_bookmaker_name').val(),
   		        common_element_id: $('#admin_common_element_id').val(),
   		        bookmaker_element_id: $('#admin_bookmaker_element_id').val()
   		       },
   		url: '/admin/bookmakers_manager',
   		dataType:'script'
   	});
	});

	$('#show_relations').bind( "click", function() {
		$.ajax({
   		type: 'GET',
   		data: { table_name: $('#admin_table_name').val(),
   		        bookmaker_name: $('#admin_bookmaker_name').val(),
   		        common_element_id: $('#admin_common_element_id').val(),
   		        bookmaker_element_id: $('#admin_bookmaker_element_id').val()
   		       },
   		url: '/admin/bookmakers_manager',
   		dataType:'script'
   	});
	});

	$('#admin_bookmaker_name, #admin_table_name').change(function() {
  		$.ajax({
	   		type: 'GET',
	   		data: { table_name: $('#admin_table_name').val(),
	   		        bookmaker_name: $('#admin_bookmaker_name').val(),
	   		        common_element_id: $('#admin_common_element_id').val()
              },
	   		url: '/admin/bookmakers_manager',
	   		dataType:'script'
	   	});
	});

	$('.delete_relation').click (function() {
  		$.ajax({
	   		type: 'GET',
	   		data: { table_name: $('#admin_table_name').val(),
	   		        bookmaker_name: $('#admin_bookmaker_name').val(),
	   		        common_element_id: $('#admin_common_element_id').val(),
	   		        bookmaker_element_id: this.getAttribute('id'),
	   		        bookmaker_element_name: this.getAttribute('data')
	   		      },
	   		url: '/admin/delete_bookmaker_relation',
	   		dataType:'script'
	   	});

	    return false;
	});

	$('.priority').filter_input({regex:'[0-9]'});

  $('select').selectmenu({
		    style:'dropdown',
		    width: 350,
		    menuWidth: 350,
		    maxHeight: 300,
		    icons: [
			    {find: '.russia'},
			    {find: '.usa'},
		    ]
  });

	$( "#admin_common_element_id" ).autocomplete({
      source: function( request, response ) {
				        $.ajax({
					        url: '/admin/bookmakers_manager',
					        dataType: "json",
					        data: {
                          table_name: $('#admin_table_name').val(),
       		                bookmaker_name: $('#admin_bookmaker_name').val(),
       		                common_element_id: $('#admin_common_element_id').val(),
       		                bookmaker_element_id: $('#admin_bookmaker_element_id').val(),
						              term: request.term,
						              filter: "common"
					        },
					        success: function( data ) {
						        response(  $.map( data, function( item ) { return  { id: item[1], value: item[0] }  } ) );					        
					        }
			        }); 
			      }

	}).data( "autocomplete" )._renderItem = function( ul, item ) {
			return $( "<li></li>" )
				.data( "item.autocomplete", item )
				.append( "<a>" + item.value + "</a>" )
				.appendTo( ul ); 		};
				
	$( "#admin_bookmaker_element_id" ).autocomplete({
      source: function( request, response ) {
				        $.ajax({
					        url: '/admin/bookmakers_manager',
					        dataType: "json",
					        data: {
                          table_name: $('#admin_table_name').val(),
       		                bookmaker_name: $('#admin_bookmaker_name').val(),
       		                common_element_id: $('#admin_common_element_id').val(),
       		                bookmaker_element_id: $('#admin_bookmaker_element_id').val(),
						              term: request.term,
						              filter: "common"
					        },
					        success: function( data ) {
						        response(  $.map( data, function( item ) { return  { id: item[1], value: item[0] }  } ) );					        
					        }
			        }); 
			      }

	}).data( "autocomplete" )._renderItem = function( ul, item ) {
			return $( "<li></li>" )
				.data( "item.autocomplete", item )
				.append( "<a>" + item.value + "</a>" )
				.appendTo( ul ); 		};

});


$(document).ready(function(){
	$(".gallery").gallery();
	
	$(".draggable").draggable({
		containment: 'parent'
	});
	
	$('.dataTable').dataTable({
		"bFilter": false,
		"bLengthChange": false
	});
	$('.dataTableDesc').dataTable({
		"bFilter": false,
		"bLengthChange": false,
		"aaSorting": [[0,'desc']]
	});
	
	$('.overlay').overlay();
	
	$('.blind').click(function(){
		if($($(this).attr('rel')).css('display') == 'none'){
			$($(this).attr('rel')).show('blind', {direction: 'vertical'}, 1000);
			window.location.hash = $(this).attr('rel') + '=' + 'visible';
		}else{
			$($(this).attr('rel')).hide('blind', {direction: 'vertical'}, 1000);
			window.location.hash = $(this).attr('rel') + '=' + 'hidden';
		}
	});
})
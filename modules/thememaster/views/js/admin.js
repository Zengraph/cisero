jQuery(function($){
	$('#thememaster .panel').hide(); 
	$('#configuration_fieldset_0').show();
	$('.nav-tabs li:first').addClass('active');
	$('.nav-tabs a').click(function(){
        $(this).parent().addClass('active').siblings().removeClass('active');
        var fieldsetID = $(this).attr('data-fieldset').split(',');	
		$('#thememaster .panel').hide();
        $.each(fieldsetID,function(i,n){
            $('#configuration_fieldset_' + n).show();
        });
    });
	
	if ($('#TM_GFONT_ON_off').is(':checked')) {
		$('#conf_id_TM_GFONT_BODY').hide();
	} 
	
   //jQuery listen for checkbox change
	$("#TM_GFONT_ON_on").change(function() {
		if(this.checked) {
			$('#conf_id_TM_GFONT_BODY').show();
		}
	});
	$("#TM_GFONT_ON_off").change(function() {
		if(this.checked) {
			$('#conf_id_TM_GFONT_BODY').hide();
		}
	});	
});
$(document).ready(function() {
	
	// upload scrap csv js
	$(".label_error").hide();
	$('#file_upload').click(function(){
		$(".label_error").hide();
		if ($("#upload_csv_document").val().trim()=="")
		{
			$("#file_label").show();
			$("#upload_csv_document").val("")
			return false
		}
		else
		{
			if ($("#upload_csv_document").val().split('.').pop()!="csv")
			{	
				$("#file_validate_label").show();
				$("#upload_csv_document").val("")
				return false
			}
		}
	});

});

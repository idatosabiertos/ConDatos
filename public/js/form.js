$(document).ready(function() {  

    $("#form_error").hide();
    $("#scholarship_more_than_once_group").hide();
    $("#colaborator_group").hide();
    $("#proposition_group").hide();

    $("#form").on("submit",function(e){
      if( $('.require-one:checked').length === 0){
        $("#form_error").show();
        location.href = "#parcipate_in"; 
        e.preventDefault();
      }
      else{
         $("#form_error").hide();
      }
    });

    $("input[name=scholarship_before]:radio").change(function() {
        if ($("#scholarship_more_than_once_group").is(":visible")) {
            $("#scholarship_more_than_once_group").hide();
        } else {
            $("#scholarship_more_than_once_group").show();
        }
    });

    $("#thematic").on("change", "input:checkbox", function() {
        if ($("#thematic input:checkbox:checked").length === 3) {
            $('#thematic input:checkbox:not(":checked")').prop('disabled', true);
        } else {
            $("#thematic input:checkbox").prop('disabled', false);
        }
    });

    $("#participate_as_colaborator").change(function() {
        if (this.checked) {
            $("#colaborator_group").show();
        } else {
            $("#colaborator_group").hide();
        }
    });
    $("#has_proposition").change(function() {
        if (this.checked) {
            $("#proposition_group").show();
        } else {
            $("#proposition_group").hide();
        }
    });

});

$(document).ready(function() {  

    $("#parcipate_in_error").hide();
    $("#thematic_error").hide();
    $("#colaborator_group_error").hide();
    $("#organization_tab").hide();
    $("#scholarship_more_than_once_group").hide();
    $("#colaborator_group").hide();
    $("#proposition_group").hide();
    var errorPrefix="_error";

    function checkRequired(e,element,selector,length){
      var errorElem= element + errorPrefix,
          checkedLenght= $(element +' '+ selector + ':checked').length,
          condition= length ===1 ? checkedLenght === 0 : checkedLenght < length;
      if(condition){
        $(errorElem).show();
        location.href = element; 
        e.preventDefault();
      }
      else{
         $(errorElem).hide();
      }
    }

    function showIfCond(elem,cond){
        if (cond) {
            $(elem).show();
        } else {
            $(elem).hide();
        }
    }

    $("#form").on("submit",function(e){
         checkRequired(e,"#parcipate_in",".require-one",1);
         checkRequired(e,"#thematic",".require-three",3);
         if($("#colaborator_group").is(":visible"))
            checkRequired(e,"#colaborator_group",".require-one",1);
    });

    $("input[name=scholarship_before]:radio").change(function(){
        showIfCond("#scholarship_more_than_once_group",!$("#scholarship_more_than_once_group").is(":visible"))
    });

    $("#thematic").on("change", "input:checkbox", function() {
        if ($("#thematic input:checkbox:checked").length === 3) {
            $('#thematic input:checkbox:not(":checked")').prop('disabled', true);
            $("#thematic_error").hide();
        } else {
            $("#thematic input:checkbox").prop('disabled', false);
        }
    });

    $("#participates").on("change", function() {
        if(this.checked){
            $("#organization_tab").show();
            $("#organization").attr("required",true);
            $("#organization_type").attr("required",true);
            $("#organization_role").attr("required",true);
        }
    });

    $("#noparticipates").on("change", function() {
        if(this.checked){
            $("#organization_tab").hide();     
            $("#organization").attr("required",false);
            $("#organization_type").attr("required",false);
            $("#organization_role").attr("required",false);

            $("#organization_tab input").val("");
            $("#organization_tab textarea").val("");
            $("#organization_tab select").val("");
        }
    });

    $("#participate_as_colaborator").change(function(){
        showIfCond("#colaborator_group",this.checked);
    });
    $("#has_proposition").change(function(){
        showIfCond("#proposition_group",this.checked);
        $("#proposition_title").attr("required",this.checked);
        $("#proposition_summary").attr("required",this.checked);
        $("#proposition_why_include").attr("required",this.checked);

        if(!this.checked){            
            $("#proposition_group input").val("");
            $("#proposition_group textarea").val("");
        }
    });

    $('input[value=""]').addClass('empty');
        $('input').keyup(function(){
            if( $(this).val() == ""){
                $(this).addClass("empty");
            }else{
                $(this).removeClass("empty");
            }
        });

});

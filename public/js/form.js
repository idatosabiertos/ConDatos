$(document).ready(function() {  

    $("#parcipate_in_error").hide();
    $("#organization_tab").hide();
    $("#food_preference_tab").hide();   
    $("#recaptcha-err").hide();

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

        var response = grecaptcha.getResponse();
        if(response.length == 0){
            $("#recaptcha-err").show();
            e.preventDefault();
        }
        else{
            $("#recaptcha-err").hide();
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


    $("#lunch_confirmed").on("change", function() {
        $("#food_preference_tab").show();
    });


    $("#lunch_out").on("change", function() {
        $("#food_preference_tab").hide();   
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

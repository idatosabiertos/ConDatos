$(document).ready(function() {  

    $("#food_preference_tab").hide();   

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

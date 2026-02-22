// Main JS - Simplified
$(function() {
    // Gotop button
    $(window).scroll(function() {
        var scrollt = document.documentElement.scrollTop + document.body.scrollTop;
        if (scrollt > 200) {
            $("#gotop").fadeIn(400);
        } else {
            $("#gotop").fadeOut(400);
        }
    });
    
    $("#gotop").click(function() {
        $("html,body").animate({scrollTop: "0px"}, 200);
    });
});

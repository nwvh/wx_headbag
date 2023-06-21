$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "bagOn"){
    $('.headbag').css('display', 'block')
            
        } else if (event.data.type == "bagOff"){
    $('.headbag').css('display', 'none')
        } 
    });
});
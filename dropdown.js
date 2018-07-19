$(document).ready(function() {
  $('.server-name').click(function(){
   $(this).find('span').text(function(_, value){return value=='-'?'+':'-'});
    $(this).nextUntil('tr.server-name').slideToggle(100, function(){
    });
});
});


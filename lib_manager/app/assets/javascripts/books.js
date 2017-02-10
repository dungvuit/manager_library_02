document.addEventListener("turbolinks:load", function() {
  $('.list-categories a').on('click', 'li', function(){
    $('.list-categories a li').removeClass('active');
    $(this).addClass('active')
  });
});

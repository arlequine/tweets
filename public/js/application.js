$(document).ready(function() {
	// Este código corre después de que `document` fue cargado(loaded) 
	// completamente. 
	// Esto garantiza que si amarramos(bind) una función a un elemento 
	// de HTML este exista ya en la página. 
  $('#que_tweet').on("submit", function(evento){

    //first stage: for preventing any default, stop HTML and don't do 'redirect to'
    evento.preventDefault();
    //it gets a url from 'form'
    var url = $(this).attr('action');
    var data = $(this).serialize();
      //to do a Post, it gets a url (url)
      $.post(url,data,function(response_data){
      console.log(response_data);
      $('#show_tweets').append(response_data);
      });

    });


});

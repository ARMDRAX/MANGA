

$(document).ready(function(){
    $('.add-to-cart-form').submit(function(e){
        e.preventDefault();
        const comicId = $(this).data('comic-id');

        $.ajax({
            url: 'cart', // Assicurati che questa sia la URL corretta del tuo servlet o endpoint
            type: 'POST',
            data: { comicId: comicId },
            dataType: 'json',
            success: function(response) {
                if(response.success) {
                    // Aggiorna il numero nel carrello nella navbar
                    $('.cart-count').text(response.cartCount).show();

                    $('#cart-message').text('Manga aggiunto al carrello!').fadeIn();

                    setTimeout(function(){
                        $('#cart-message').fadeOut();
                    }, 3000);
                } else {
                    alert('Errore: ' + response.message);
                }
            },
            error: function() {
                alert('Errore di comunicazione con il server.');
            }
        });
    });
});
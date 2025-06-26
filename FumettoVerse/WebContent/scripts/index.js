

$(document).ready(function(){
    $('.add-to-cart-form').submit(function(e){
        e.preventDefault();
        const form = $(this);
        const comicId = form.data('comic-id');

        $.ajax({
            url: 'cart',
            type: 'POST',
            data: { comicId: comicId },
            success: function(response) {
                if(response.success) {
                    $('.cart-count').text(response.cartCount).show();
                    $('#cart-message').text('Fumetto aggiunto al carrello!').fadeIn();
                    setTimeout(function(){ $('#cart-message').fadeOut(); }, 3000);
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
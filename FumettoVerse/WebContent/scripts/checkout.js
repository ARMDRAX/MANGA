function toggleCardDetails() {
            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
            const cardDetails = document.getElementById('card-details');
            cardDetails.style.display = (paymentMethod === 'Carta di Credito') ? 'block' : 'none';
        }

        document.addEventListener("DOMContentLoaded", function() {
            const form = document.querySelector("form");
            const errorDiv = document.getElementById('error-message');

            form.addEventListener("submit", function(event) {
                errorDiv.innerText = "";

                const paymentMethodElem = document.querySelector('input[name="paymentMethod"]:checked');
                if (!paymentMethodElem) {
                    errorDiv.innerText = "Seleziona un metodo di pagamento.";
                    event.preventDefault();
                    return;
                }
                const paymentMethod = paymentMethodElem.value;

                const address = document.getElementById('address').value.trim();
                const zip = document.getElementById('zip').value.trim();
                const city = document.getElementById('city').value.trim();

                const errors = [];

                // Controlli base indirizzo
                if (!address) errors.push("Inserisci l'indirizzo.");
                if (!zip.match(/^\d{5}$/)) errors.push("Inserisci un CAP valido (5 cifre).");
                if (!city) errors.push("Inserisci la città.");

                if (paymentMethod === "Carta di Credito") {
                    const cardNumber = document.querySelector('input[name="cardNumber"]').value.trim();
                    const expiry = document.querySelector('input[name="expiry"]').value.trim();
                    const cvv = document.querySelector('input[name="cvv"]').value.trim();

                    if (!cardNumber || !expiry || !cvv) {
                        errors.push("Completa tutti i campi della carta di credito.");
                    } else {
                        if (!/^[0-9]{13,19}$/.test(cardNumber)) errors.push("Numero carta non valido.");
                        if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(expiry)) errors.push("Scadenza carta non valida (MM/AA).");
                        if (!/^\d{3,4}$/.test(cvv)) errors.push("CVV non valido.");
                    }
                }

                if (errors.length > 0) {
                    errorDiv.innerHTML = errors.map(e => `<p>${e}</p>`).join('');
                    event.preventDefault();
                }
            });
        });
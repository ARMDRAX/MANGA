document.addEventListener("DOMContentLoaded", function() {
    const form = document.getElementById("registerForm");
    const nameInput = document.getElementById("name");
    const emailInput = document.getElementById("email");
    const passwordInput = document.getElementById("password");
    const errorContainer = document.getElementById("errorMessages");

    function isValidEmail(email) {
        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }

    function isValidPassword(password) {
        const regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
        return regex.test(password);
    }

    function showErrors(errors) {
        errorContainer.innerHTML = "";
        errors.forEach(err => {
            const p = document.createElement("p");
            p.textContent = err;
            p.style.color = "red";
            p.style.textAlign = "center";
            p.style.fontWeight = "bold";
            errorContainer.appendChild(p);
        });
    }

    form.addEventListener("submit", function(event) {
        const errors = [];

        if (nameInput.value.trim() === "") {
            errors.push("Il nome è obbligatorio.");
        }
        if (!isValidEmail(emailInput.value)) {
            errors.push("Inserisci un indirizzo email valido.");
        }
        if (!isValidPassword(passwordInput.value)) {
            errors.push("La password deve essere lunga almeno 8 caratteri e contenere almeno una lettera e un numero.");
        }

        if (errors.length > 0) {
            event.preventDefault();
            showErrors(errors);
        }
    });

    [nameInput, emailInput, passwordInput].forEach(input => {
        input.addEventListener("change", function() {
            const errors = [];

            if (input === nameInput && nameInput.value.trim() === "") {
                errors.push("Il nome è obbligatorio.");
            }
            if (input === emailInput && !isValidEmail(emailInput.value)) {
                errors.push("Inserisci un indirizzo email valido.");
            }
            if (input === passwordInput && !isValidPassword(passwordInput.value)) {
                errors.push("La password deve essere lunga almeno 8 caratteri e contenere almeno una lettera e un numero.");
            }

            if (errors.length > 0) {
                showErrors(errors);
            } else {
                errorContainer.innerHTML = "";
            }
        });
    });
});
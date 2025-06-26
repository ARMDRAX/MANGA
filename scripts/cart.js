document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");
    const errorBox = document.createElement("div");
    errorBox.id = "cartErrors";
    errorBox.style.color = "red";
    errorBox.style.textAlign = "center";
    errorBox.style.fontWeight = "bold";
    form?.prepend(errorBox);

    function showError(msg) {
        errorBox.innerHTML = "";
        const p = document.createElement("p");
        p.textContent = msg;
        errorBox.appendChild(p);
    }

    form?.addEventListener("submit", function (e) {
        const quantityInputs = form.querySelectorAll("input[type='number']");
        for (let input of quantityInputs) {
            const val = parseInt(input.value);
            if (isNaN(val) || val <= 0) {
                e.preventDefault();
                showError("Inserisci una quantità valida (numero maggiore di 0).");
                return;
            }
        }
        errorBox.innerHTML = "";
    });

    form?.querySelectorAll("input[type='number']").forEach(input => {
        input.addEventListener("change", () => {
            const val = parseInt(input.value);
            if (isNaN(val) || val <= 0) {
                showError("Inserisci una quantità valida (numero maggiore di 0).");
            } else {
                errorBox.innerHTML = "";
            }
        });
    });
});
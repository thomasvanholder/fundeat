const rangeInput = document.getElementById("rangeinput");

if (rangeInput) {
  rangeInput.addEventListener("click", (event) => {
    const rangeValue = document.querySelector("#investmentRange").value
    console.log(rangeValue);
    console.log(event.currentTarget);
  });
}


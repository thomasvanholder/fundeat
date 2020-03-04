const rangeInput = document.getElementById("rangeinput").value;

rangeInput.addEventListener("click", (event) => {
  console.log(event);
  console.log(event.currentTarget);
});

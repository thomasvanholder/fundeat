import "bootstrap";
import { setWidth } from '../components/sticky_sidebar';

setWidth();

const rangeInput = document.getElementById("investmentRange");

rangeInput.addEventListener("click", (event) => {
  const rangeValue = document.querySelector("#investmentRange").value
  const investmentAmount = document.querySelector("#investment_amount")
  investmentAmount.value = rangeValue
  console.log(rangeValue);
  console.log(event.currentTarget);
});


test

import "bootstrap";
import { setWidth } from '../components/sticky_sidebar';
import { initCharts } from '../components/init_chart';

initCharts();

setWidth();

const rangeInput = document.getElementById("investmentRange");

if (rangeInput) {
  rangeInput.addEventListener("click", (event) => {
    const rangeValue = document.querySelector("#investmentRange").value
    console.log(rangeValue);
    console.log(event.currentTarget);
  });
}


import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';

import { setWidth } from '../components/sticky_sidebar';
import { initMapbox } from '../plugins/init_mapbox';

initMapbox();
setWidth();

const rangeInput = document.getElementById("investmentRange");

rangeInput.addEventListener("click", (event) => {
  const rangeValue = document.querySelector("#investmentRange").value
  const investmentAmount = document.querySelector("#investment_amount")
  investmentAmount.value = rangeValue
  console.log(rangeValue);
  console.log(event.currentTarget);
});

const rangeInput = document.getElementById("investmentRange");

rangeInput.addEventListener("click", (event) => {
  const rangeValue = document.querySelector("#investmentRange").value
  const investmentAmount = document.querySelector("#investment_amount")
  investmentAmount.value = rangeValue
  console.log(rangeValue);
  console.log(event.currentTarget);
});


// map

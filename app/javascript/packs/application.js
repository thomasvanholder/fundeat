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

const amountInput = document.getElementById("investment_amount");

amountInput.addEventListener("click", (event) => {
  const investmentAmount = document.querySelector("#investment_amount").value
  const rangeValue = document.querySelector("#investmentRange")
  rangeValue.value = investmentAmount
  console.log(investmentAmount);
  console.log(event.currentTarget);
});

flatpickr("#range_start", {
  onChange: function(selectedDates, dateStr, instance) {

    let pricePerDay = document.querySelector('.list-group-item').innerText.split("$")[1]

    let totalPrice = days * pricePerDay

    let span = document.querySelector('#pay_month');
    let inputPrice = document.getElementById('booking_booking_price')
    inputPrice.value = totalPrice
    span.innerText = `${return_p_month}`
  }
});

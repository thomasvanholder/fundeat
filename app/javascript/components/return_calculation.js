const rangeInput = document.getElementById("investmentRange");
const payMonth = document.querySelector("#pay_month");
const roi = Number.parseInt(document.querySelector("#roi").innerText, 10);
const totalRoi = document.querySelector("#total_roi");
const months = document.querySelector("#months");
const amountInput = document.getElementById("investment_amount");

if (rangeInput) {
  rangeInput.addEventListener("click", (event) => {
    const rangeValue = document.querySelector("#investmentRange").value
    const investmentAmount = document.querySelector("#investment_amount")
    investmentAmount.value = rangeValue
    const monthPay = Math.round(rangeValue / 12 * roi / 100, 2)
    payMonth.innerText = monthPay
    totalRoi.innerText = monthPay * months.innerText
  });


  amountInput.addEventListener("click", (event) => {
    const investmentAmount = document.querySelector("#investment_amount").value
    const rangeValue = document.querySelector("#investmentRange")
    rangeValue.value = investmentAmount
    const monthPay = Math.round(rangeValue / 12 * roi / 100, 2)
    payMonth.innerText = monthPay
    totalRoi.innerText = monthPay * months.innerText
  });
}


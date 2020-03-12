const rangeInput = document.getElementById("investmentRange");

if (rangeInput) {
  const payMonth = document.querySelector("#pay_month");
  const roi = Number.parseInt(document.querySelector("#roi").innerText, 10);
  const totalRoi = document.querySelector("#total_roi");
  const months = document.querySelector("#months");
  const amountInput = document.getElementById("investment_amount");
  const investmentReward = document.getElementById("investment_reward");
  const rewards = document.querySelectorAll(".reward")

  rangeInput.addEventListener("click", (event) => {
    document.querySelector("#investment_amount").value = event.target.value
    calculateReturn()
    selectReward(event.target.value)
  });

  if (amountInput) {
    amountInput.addEventListener("change", (event) => {
      document.querySelector("#investmentRange").value = parseInt(event.target.value)
      calculateReturn()
      selectReward(parseInt(event.target.value))
    });
  }

  const calculateReturn = () => {
    const range = document.querySelector("#investmentRange")
    const monthPay = Math.round(range.value / 12 * (roi.innerText, 10) / 100, 2)
    payMonth.innerText = `$ ${monthPay}`
    totalRoi.innerText = `$ ${monthPay * parseInt(months.innerText, 10)}`
  }

  const selectReward = (amount) => {
    const rewardsArray = [].slice.call(rewards, 0).reverse();
    var rewardChecked = false;
    rewardsArray.forEach((reward) => {
      reward.classList.remove("active")
      if ( (parseInt(reward.dataset.amount) <= parseInt(amount)) && !rewardChecked ) {
        reward.classList.add("active")
        rewardChecked = true;
      }
    })
  }

}


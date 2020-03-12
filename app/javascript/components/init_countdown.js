import Countdown from 'countdown.js';

const element = document.getElementById(".countdown");

// const initCountdown = () => {
if (element) {
  const efcc_countdown = new Countdown({
    target: '.countdown',
    dayWord: ' days',
    hourWord: ' hours',
    minWord: ' mins',
    secWord: ' secs'
  });
}

// }

// export { initCountdown }


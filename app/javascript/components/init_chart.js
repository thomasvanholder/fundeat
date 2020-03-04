import Chart from 'chart.js';

const barCanvas = document.getElementById('bar');
const pieCanvas = document.getElementById('pie');

const dataBar = barCanvas.dataset.graph
const dataPie = pieCanvas.dataset.graph

const initCharts = () => {
  if (barCanvas) {
    new Chart(barCanvas, {
      type: 'bar',
      data: JSON.parse(dataBar),
      options: {
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero: true
                  }
              }]
          }
      }
    });
  }

  if (pieCanvas) {
    new Chart(pieCanvas, {
      type: 'bar',
      data: JSON.parse(dataPie),
      options: {
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero: true
                  }
              }]
          }
      }
    });
  }

}

export { initCharts }

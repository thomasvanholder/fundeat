import Chart from 'chart.js';

const barCanvas = document.getElementById('bar');
const pieCanvas = document.getElementById('pie');

// barCanvas.canvas.width = 100;
// barCanvas.canvas.height = 80;

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
// For a pie chart
  if (pieCanvas) {
    new Chart(pieCanvas, {
      type: 'pie',
      data: JSON.parse(dataPie),
      // options: options,
  //     data: JSON.parse(dataPie),
    });
  }

}

export { initCharts }

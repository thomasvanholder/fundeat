import "bootstrap";
import { initMapbox } from '../plugins/init_mapbox';
import { setWidth } from '../components/sticky_sidebar';
import '../components/return_calculation';
import { initCharts } from '../components/init_chart';

initMapbox();
setWidth();
initCharts();

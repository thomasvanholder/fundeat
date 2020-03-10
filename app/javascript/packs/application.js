import "bootstrap";
import { initMapbox } from '../plugins/init_mapbox';
import { setWidth } from '../components/sticky_sidebar';
import '../components/return_calculation';
import { initCharts } from '../components/init_chart';
import { initAutocomplete } from '../plugins/init_autocomplete';
import "../plugins/flatpickr";



initMapbox();
setWidth();
initCharts();
initAutocomplete();

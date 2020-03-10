import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
// import "flatpickr/dist/themes/airbnb.css"

flatpickr(".datepicker", {
  // mode: "multiple",
  // dateFormat: "Y-m-d"
  // altInput: true
  inline: true,
  enableTime: true,
  dateFormat: "Y-m-d H:i",
  minTime: "09:00",
  maxTime: "18:30"
})

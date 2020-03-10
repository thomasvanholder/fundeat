import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css" // Note this is important!

flatpickr(".datepicker", {
  // mode: "multiple",
  // dateFormat: "Y-m-d"
  // altInput: true
  inline: true,
  enableTime: true,
  dateFormat: "Y-m-d H:i",
  minDate: "today",
  minTime: "09:00",
  maxTime: "18:30"
})

// import "flatpickr/dist/themes/airbnb.css"

import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import "flatpickr/dist/themes/material_green.css";

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

const datePickerElement = document.getElementById("datepicker2")

flatpickr("#datepicker2", {
  // mode: "multiple",
  // dateFormat: "Y-m-d"
  // altInput: true
  inline: true,
  enableTime: false,
  dateFormat: "Y-m-d",
  minDate: "today",
  defaultDate: datePickerElement.dataset.endDate,
})


// import "flatpickr/dist/themes/airbnb.css"

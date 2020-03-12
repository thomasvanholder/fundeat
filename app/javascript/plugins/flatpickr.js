import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import "flatpickr/dist/themes/material_green.css";

const datePickerElement1 = document.querySelector(".datepicker")

if (datePickerElement1) {
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
}


const datePickerElement2 = document.getElementById("datepicker2")

if (datePickerElement2) {
  flatpickr("#datepicker2", {
    // mode: "multiple",
    // dateFormat: "Y-m-d"
    // altInput: true
    inline: true,
    enableTime: false,
    dateFormat: "Y-m-d",
    minDate: "today",
    defaultDate: datePickerElement2.dataset.endDate,
  })
}


// import "flatpickr/dist/themes/airbnb.css"

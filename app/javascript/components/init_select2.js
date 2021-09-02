import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({
    width: "200px",
    theme: "bootstrap",

    // placeholder: 'Select an option'
    templateSelection: function (data) {
      console.log(data.id)
      if (data.id === 'Adelaide') {
        return "Ex. Florence"
      } else if (data.id === 'Barcelona') {
        return "Ex. Paris"
      } else {
        return data.id
      }
    }
  });
  $('.trip_nb_people').select2({
    width: "30px",
    theme: "bootstrap",
  });
};

export { initSelect2 };

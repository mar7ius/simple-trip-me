import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({
    width: "177.3px",
    theme: "bootstrap"

  });
};

export { initSelect2 };

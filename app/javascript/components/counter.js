const counter = () => {
  var max = 10;
  var min = 0;
  var initialValue = 0;
  var step = 1;

  var number = document.getElementById("number");
  var plus = document.getElementById("plus");
  var minus = document.getElementById("minus");

  if (initialValue > max || initialValue < min) initialValue = min;
  number.innerHTML = initialValue;

  function cursorMinus() {
    if (parseInt(number.innerHTML) > min)
      number.innerHTML = parseInt(number.innerHTML) - step;
    if (parseInt(number.innerHTML) <= min) minus.style.opacity = 0.3;
    plus.style.opacity = 1;
  }

  function cursorPlus() {
    if (parseInt(number.innerHTML) < max)
      number.innerHTML = parseInt(number.innerHTML) + step;
    if (parseInt(number.innerHTML) >= max) plus.style.opacity = 0.3;
    minus.style.opacity = 1;
  }

  minus.addEventListener("click", cursorMinus);
  plus.addEventListener("click", cursorPlus);

};

export { counter };

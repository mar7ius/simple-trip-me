const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-lewagon');
  const banner = document.querySelector('.banner');
  // const loginID = document.getElementById('btn-login');
  // const linkAddNew = document.getElementById('link-add-new');
  // const btnClear = document.querySelectorAll('.btn-clear');

  if (navbar) {
    let bannerMidHeight;
    if (banner) {
      bannerMidHeight = banner.getBoundingClientRect().height / 2;
    } else {
      bannerMidHeight = navbar.getBoundingClientRect().height;
    }

    window.addEventListener('scroll', () => {
      if (window.scrollY >= bannerMidHeight) {
        navbar.classList.add('navbar-white');
        navbar.classList.remove('navbar-transparent');
      }
       else {
        navbar.classList.remove('navbar-white');
        navbar.classList.add('navbar-transparent');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };

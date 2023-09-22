import toastr from 'toastr';

toastr.options = {
  closeButton: true,
  showDuration: '300',
  hideDuration: '1000',
  timeOut: '5000',
  showEasing: 'swing',
  hideEasing: 'linear',
  showMethod: 'fadeIn', // Use slideDown for animation
  hideMethod: 'fadeOut', // Use slideUp for animation
  // Other options...
};
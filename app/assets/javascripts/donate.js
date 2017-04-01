$(document).ready(function() {
  var item = localStorage.getItem('donateModal');
  var today = new Date().getTime();
  var yesterday = new Date(today - 86400000).getTime();
  if (!item || JSON.parse(item).seenAt < yesterday) {
    $(".modal-donate").modal({ show: true });
    localStorage.setItem('donateModal', JSON.stringify({ seenAt: today }));
  }
});

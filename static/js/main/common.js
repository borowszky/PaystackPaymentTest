var getCookies = function() {
  var pairs = document.cookie.split(";");
  var cookies = {};
  for (var index = 0; index < pairs.length; index++) {
    var pair = pairs[index].split("=");
    cookies[(pair[0] + "").trim()] = unescape(pair[1]);
  }
  return cookies;
};
document.addEventListener("DOMContentLoaded", function() {
  IdleTimeout.init();
});
$(document).ready(function() {
  var cookies = getCookies();

  $(".dropdown-item." + cookies["lang"]).addClass("active");
  $(".navbar-nav-link." + cookies["lang"])
    .parent()
    .addClass("active");

  // Change language in dropdown
  $(".language-switch")
    .children(".dropdown-toggle")
    .html(
      $(".language-switch")
        .find("." + cookies["lang"])
        .html()
    )
    .children("img")
    .addClass("mr-2");

  swalInit = swal.mixin({
    buttonsStyling: false,
    confirmButtonClass: "btn btn-primary",
    cancelButtonClass: "btn btn-light",
    width: '50%'
  });
});

var setLanguage = function(selectedLang, itemId) {
  document.cookie =
    encodeURIComponent("lang") +
    "=" +
    encodeURIComponent(selectedLang) +
    ";path=/";

  // Change lang in dropdown
  $(".language-switch")
    .children(".dropdown-toggle")
    .html($(selectedLang).html())
    .children("img")
    .addClass("mr-2");

  // Set active class
  $(".dropdown-item" + selectedLang).addClass("active");
  $(".navbar-nav-link" + selectedLang)
    .parent()
    .addClass("active");

  location.reload();
};

var swalInit;
var authToken;
var light_4 = $(this).closest(".card");

function makeHttpPost(
  url,
  data,
  successTitle,
  successMessage,
  erroTitle,
  errorMessage
) {  
    $.ajax({
      type: "POST",
      url: baseUrl + url,
      processData: false,
      data: JSON.stringify(data),
      beforeSend: function(request) {
        request.setRequestHeader("Content-Type", "application/json");
      },
      success: function() {
        $(light_4).unblock();
        swalInit({
          title: successTitle,
          text: successMessage,
          type: "success"
        });
        window.setTimeout(function() {
          document.location.reload();
        }, 1000);
      },
      error: function(res) {
        $(light_4).unblock();
        swalInit({
          title: erroTitle,
          text: res.responseJSON.Message,
          type: "error"
        });
      }
    });
}


function makeHttpGet(url) {
  $.ajax({
    type: "GET",
    url: baseUrl + url,
    success: function(res) {
      console.log(res);
      return res
    },
    error: function(res) {
      console.log(res);
      return null
    }
  });
}


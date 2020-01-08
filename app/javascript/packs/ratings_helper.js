document.getElementById('ratings').addEventListener('ajax:success',function(event) {
  alert("rating is set");
});

document.getElementById('ratings').addEventListener('ajax:error',function(event) {
  alert("some error occurred unable to set rating");
});

$(function() {
    console.log(document.cookie);
  $.get('/schools.json', function(data) {
    schools = _.map(data, function(school) {
      return school['name'];
    })
    $("#schools").autocomplete({
      source: schools
    });
  })
});

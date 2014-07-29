$(function(){

  $("form.mission input[type='file']").each(function(i, item) {
    var $field = $(item);
    var $button = $("<button type='button'>Select an SVG</button>");
    var $valueLabel = $("<span class='value'></span>");

    $field.hide();
    $button.insertBefore($field);
    $valueLabel.insertAfter($button);

    $button.on('click', function(e){
      e.preventDefault;
      $field.click();
    })

    $field.on('change', function(){
      var filePath = $field.val().replace(/.+[\\\/]/, "");
      $valueLabel.text(filePath);
    })
  });

  var $stateField = $("#mission_state");
  var $completedOnWrapper = $('#mission_completed_on_input');

  var showCompletedOnIfInCompletedState = function(){
    state = $stateField.val();
    if (state == "completed") {
      $completedOnWrapper.show();
    } else {
      $completedOnWrapper.hide();
    }
  }
  showCompletedOnIfInCompletedState();
  $stateField.on('change', showCompletedOnIfInCompletedState);


});

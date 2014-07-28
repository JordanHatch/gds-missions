$(function(){

  $("form.mission input[type='file']").each(function(i, item) {
    var $field = $(item);
    var $button = $("<button type='button'>Select image</button>");
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
  })

});

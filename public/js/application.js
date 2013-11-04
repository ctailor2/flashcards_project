$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
});

// jQuery to add rows to table when creating a deck.
$(document).ready(function(){
  $("#add").click(function(){
    var q_input = $("#QAtable tr:last #question");
    var a_input = $("#QAtable tr:last #answer");
    if($.trim(q_input.val()).length > 0 && $.trim(a_input.val()).length > 0)
      { 
        $("#QAtable tr:last").clone(true).insertAfter("#QAtable tr:last");
        $("#QAtable tr:last #question").val('');
        $("#QAtable tr:last #answer").val('');
        return false;
      }
    else
      {
        alert("Q or A fields cannot be empty.");
        return false;
      }
  });

  $("#remove").click(function(){
    $(this).closest("tr").remove();
  });

  $("#submit").click(function(){
    var title_input = $("#title");
    if($.trim(title_input.val()).length == 0)
    {
      alert("Title field cannot be empty.");
      return false;
    }
  });
});

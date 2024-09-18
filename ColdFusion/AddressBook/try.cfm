<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Multiselect Example with jQuery and CFML</title>
  <!-- Bootstrap CSS for styling -->
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <!-- Bootstrap JS -->
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <style>
    /* Optional: Custom CSS for additional styling */
    .container {
      max-width: 600px;
    }
  </style>
</head>
<body>
  <div class="container mt-5">
    <h1>Select Your Favorite Fruits</h1>
    <form id="fruitForm" action="your-cfml-endpoint.cfm" method="POST">
      <div class="form-group">
        <label for="fruits">Choose your favorite fruits:</label>
        <select id="fruits" name="fruits[]" class="form-control" multiple>
          <option value="1">Apple</option>
          <option value="2">Banana</option>
          <option value="3">Orange</option>
          <option value="4">Grape</option>
          <option value="5">Strawberry</option>
        </select>
      </div>
      <button type="button" id="submitBtn" class="btn btn-primary">Submit</button>
    </form>
    <div id="result" class="mt-3"></div>
  </div>

  <!-- jQuery Script to Handle Form Submission -->
  <script>
    $(document).ready(function() {
      $('#submitBtn').on('click', function() {
        // Get selected values from the multiselect
        var selectedFruits = $('#fruits').val();
        
        // Display the selected values
        if (selectedFruits.length > 0) {
          $('#result').text('Selected Fruit IDs: ' + selectedFruits.join(', '));
        } else {
          $('#result').text('No fruit selected.');
        }
        
        // Optional: Submit the form via AJAX
        /*$.ajax({
          type: 'POST',
          url: $('#fruitForm').attr('action'),
          data: $('#fruitForm').serialize(),
          success: function(response) {
            $('#result').html(response);
          },
          error: function() {
            $('#result').text('An error occurred while processing your request.');
          }
        });*/
      });
    });
  </script>
  
  <!-- CFML for processing the form (for local development) -->
  <cfif structKeyExists(form, "fruits")>
    <cfset selectedFruits = form.fruits>
    <cfoutput>
      <h2>Selected Fruits:</h2>
      <ul>
        <cfloop array="#selectedFruits#" index="fruitID">
          <li>Fruit ID: #fruitID#</li>
        </cfloop>
      </ul>
    </cfoutput>
  <cfelse>
    <cfoutput>No fruits selected.</cfoutput>
  </cfif>
</body>
</html>
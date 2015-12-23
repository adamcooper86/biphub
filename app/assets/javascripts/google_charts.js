$( document ).ready(function() {
  if($('.graph').length){
    // Load the Visualization API and the piechart package.
    google.charts.load('current', {packages: ['corechart']});

    // Set a callback to run when the Google Visualization API is loaded.
    google.charts.setOnLoadCallback(drawChart);

    // Callback that creates and populates a data table,
    // instantiates the pie chart, passes in the data and
    // draws it.
    function drawChart() {

      // Create the data table.
      var input_data = $('#chart_div').data("school");
      var title = $('#chart_div').data("title");

      var data = google.visualization.arrayToDataTable(input_data);

      // Set chart options
      var options = {'title': title,
                     'width':400,
                     'height':300};

      // Instantiate and draw our chart, passing in some options.
      var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
      chart.draw(data, options);
    }
  }
});
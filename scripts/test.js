
// Load the Visualization API and the piechart package.
google.load('visualization', '1.0', {'packages':['corechart', 'sankey', 'table']});
var tableId = '1SCk-z3Px3D6atvUwB7pSiSgPze8cjtfoZbBh1DFr';

getData = function(config, context) {
  YUI().use('io-base', 'json-parse', 'node', 'querystring-parse', function(Y) {
    var handleComplete = function(callback) {
      return function(io, a, args) {
        if (!Y.Lang.isFunction(callback)) {
          return null;
        }
        var response = Y.JSON.parse(a.responseText);
        callback(response);
      };
    };


    Y.io(config.url, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      },
      data: Y.QueryString.stringify(config.data),
      on: {
        success: handleComplete(config.success),
        failure: handleComplete(config.failure)
      },
      context: context
    });
  });
};



loadData = function() {
  getData({
    url: 'http://localhost:3000/api/graphs/sankey/fod-occp',
    success: function(response) {
      var data = google.visualization.arrayToDataTable(response);
      drawChart(data);
    }
  });
};

// Callback that creates and populates a data table, 
// instantiates the pie chart, passes in the data and
// draws it.
drawChart = function(data) {

  // // Create the data table.
  // var data = new google.visualization.DataTable();
  // data.addColumn('string', 'Topping');
  // data.addColumn('number', 'Slices');
  // data.addRows([
  //   ['Mushrooms', 3],
  //   ['Onions', 1],
  //   ['Olives', 1],
  //   ['Zucchini', 1],
  //   ['Pepperoni', 2]
  // ]);
  

  // var data = response.getDataTable();
  // debugger;
  // Set chart options
  // var options = {'title':'How Much Pizza I Ate Last Night',
                 // is3D: true};

  var options = {};

  // Instantiate and draw our chart, passing in some options.
  var chart = new google.visualization.Sankey(document.getElementById('chart_div'));
  chart.draw(data, options);

};

// Set a callback to run when the Google Visualization API is loaded.
google.setOnLoadCallback(loadData);
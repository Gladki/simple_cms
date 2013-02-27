function drawVisualization() {
// Some raw data (not necessarily accurate)


 var formatter = new google.visualization.ColorFormat();
  formatter.addRange(-20000, 0, 'white', 'orange');
  formatter.addRange(20000, null, 'red', '#33ff33');
  formatter.format(dataTable, 2); 



var table = new google.visualization.Table(document.getElementById('table'));
  table.draw(dataTable, {allowHtml: true, showRowNumber: true});
var options = {
  title : 'Efektywność pracowników', width: 900, height: 700,
  vAxis: {title: "Efektywność"},
  hAxis: {title: "Pracownik"},
  seriesType: "bars",
  backgroundColor: 'transparent',
  // bar.groupWidth: {20%},
  series: {0 : {type: "bars" }, 1 : {type: "line"}, 2: {type: "line"} },
  isStacked: true
  //series: {0: {type: "line"}}
};

var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
chart.draw(dataTable, options);
}
 google.setOnLoadCallback(drawVisualization);
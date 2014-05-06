function showGraph() {
  $('body').on('ajax:success', '.show-graph', function(e, data, status, xhr) {
    console.log("This is the response")
    console.log(data.negative)

    $('.show-graph').remove();

    var dataSet = data.slice();

    var width = 1200;
    var height = 500;
    var radius = Math.min(width, height) / 2;


    var arc = d3.svg.arc()
    .outerRadius(radius - 10)
    .innerRadius(150);

    var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return d.negative.length; });

    var svg = d3.select(".d3").append("svg")
    .attr("width", width)
    .attr("height", height)
    .append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

    var g = svg.selectAll(".arc")
      .data(pie(dataSet))
      .enter().append("g")
      .attr("class", "arc");

    g.append("path")
    .attr("d", arc)
    .style("fill", function(d) { 

      if(d.sentiment_score == 0) {
        return "#2C8E47";
      } else if(d.sentiment_score > 0.5) {
        return "#B9F345";
      } else if(d.sentiment_score < -0.5) {
        return "#11435B";
      } else if(d.sentiment_score > 0) {
        return "#45BD42";
      } else {
        return "#0F93A1";
      };

     });

  });
}

$(document).ready(function() {
  showGraph();
});


$(document).on('page:load', function() {
  showGraph();
});
 
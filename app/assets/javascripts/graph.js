function showGraph() {
  $('body').on('ajax:success', '.show-graph', function(e, data, status, xhr) {
    $('.show-graph').remove();

    var dataSet = data.slice();

    var w = 1200;
    var h = 200;
    var xPadding = 60;
    var yPadding = 10;
    var circlePadding = 5;
    var minRadius = 15;
    var maxRadius = 50;

    var svg = d3.select(".d3")
              .append("svg")
              .attr("width", w)
              .attr("height", h);

    var circles = svg.selectAll('circle')
                  .data(dataSet)
                  .enter()
                  .append('circle')
                  .on("mouseenter", function(d,i) {
                    d3.select('#journal-info').text(d.name+", relevance: "+d.relevance+", sentiment_score: "+d.sentiment_score)
                  });

    var labels = svg.selectAll('text')
                 .data(dataSet)
                 .enter()
                 .append('text')

    var xScale = d3.scale.linear()
                 .domain([0, (maxRadius+circlePadding) * dataSet.length])
                 .range([xPadding, w - xPadding])


    circles.transition().duration(500)
    .attr('cx', function(d, i) {
      return i * maxRadius * 2 + xPadding;
    }).attr('cy', 100)
    .attr('r', function(d) {
      return d.relevance * 50;
    }).attr('fill', function(d) {
        if(d.children) {
          return "#FFFFFF";
        } else if(d.sentiment_score == 0) {
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
      })

    labels.transition().duration(500)
    .attr('x', function(d, i) {
      return i * maxRadius * 2 + xPadding;
    }).attr('y', 100)
    .text(function(d) {
      return d.name;
    }).attr('text-anchor', 'middle')
    .attr('font-size', function(d) {
      return d.relevance * 15;
    })
    .attr('fill', "#000000")
  });
}

$(document).ready(function() {
  showGraph();
});


$(document).on('page:load', function() {
  showGraph();
});

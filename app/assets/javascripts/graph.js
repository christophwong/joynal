$(document).ready(function() {

  $('.show-graph').on('ajax:success', function(e, data, status, xhr) {
    var dataSet = data.slice();

    var w = 1200;
    var h = 200;
    var xPadding = 60;
    var yPadding = 10;
    var circlePadding = 5;
    var minRadius = 15;
    var maxRadius = 50;


    var svg = d3.select("body")
              .append("svg")
              .attr("width", w)
              .attr("height", h);

    var circles = svg.selectAll('circle')
                  .data(dataSet)
                  .enter()
                  .append('circle')
                  .on("mouseenter", function(d,i) {
                    d3.select('#journal-info').text(d.name+", relevance: "+d.relevance.toFixed(2)+", sentiment_score: "+d.sentiment_score.toFixed(2))
                  });

    var labels = svg.selectAll('text')
                 .data(dataSet)
                 .enter()
                 .append('text')

    var xScale = d3.scale.linear()
                 .domain([0, (maxRadius+circlePadding) * dataSet.length])
                 .range([xPadding, w - xPadding])


    var color = d3.scale.category20b()

    circles.transition().duration(500)
    .attr('cx', function(d, i) {
      return i * maxRadius * 2 + xPadding;
    }).attr('cy', 100)
    .attr('r', function(d) {
      return d.relevance * 50;
    }).attr('fill', function(d) {
      if (d.sentiment_score > 0) {
        return "rgb(0," + (d.sentiment_score * 255) + ", 0)"
      } else if (d.sentiment_score < 0) {
        return "rgb(" + (-d.sentiment_score * 255) + ",0, 0)"
      } else {
        return "#FFFFFF"
      }
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
    .attr('fill', function(d) {
      console.log("this is sentiment_score")
      console.log(d.sentiment_score)
      if (d.sentiment_score < 0) {
        return "#FFFFFF"
      } else {
        return "#000000"
      }
    })
  });
});


$(document).on('page:load', function() {

  $('.show-graph').on('ajax:success', function(e, data, status, xhr) {
    var dataSet = data.slice();

    var w = 1200;
    var h = 200;
    var xPadding = 60;
    var yPadding = 10;
    var circlePadding = 5;
    var minRadius = 15;
    var maxRadius = 50;


    var svg = d3.select("body")
              .append("svg")
              .attr("width", w)
              .attr("height", h);

    var circles = svg.selectAll('circle')
                  .data(dataSet)
                  .enter()
                  .append('circle')
                  .on("mouseenter", function(d,i) {
                    d3.select('#journal-info').text(d.name+", relevance: "+d.relevance.toFixed(2)+", sentiment_score: "+d.sentiment_score.toFixed(2))
                  });

    var labels = svg.selectAll('text')
                 .data(dataSet)
                 .enter()
                 .append('text')

    var xScale = d3.scale.linear()
                 .domain([0, (maxRadius+circlePadding) * dataSet.length])
                 .range([xPadding, w - xPadding])


    var color = d3.scale.category20b()

    circles.transition().duration(500)
    .attr('cx', function(d, i) {
      return i * maxRadius * 2 + xPadding;
    }).attr('cy', 100)
    .attr('r', function(d) {
      return d.relevance * 50;
    }).attr('fill', function(d) {
      if (d.sentiment_score > 0) {
        return "rgb(0," + (d.sentiment_score * 255) + ", 0)"
      } else if (d.sentiment_score < 0) {
        return "rgb(" + (-d.sentiment_score * 255) + ",0, 0)"
      } else {
        return "#FFFFFF"
      }
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
    .attr('fill', function(d) {
      console.log("this is sentiment_score")
      console.log(d.sentiment_score)
      if (d.sentiment_score < 0) {
        return "#FFFFFF"
      } else {
        return "#000000"
      }
    })

    // $('svg circle').on('mouseenter', function(e) {
    //   console.log("This is this")
    //   console.log(this)
    //   d3.select(this).transition().duration(100)
    //   .attr('r', maxRadius)
    // })




  });
});

$(document).ready(function() {
  // d3.selectAll('h1').style("color", function() {
  //   return "hsl("+ Math.random() * 360 +", 100%, 50%)";
  // });

  // d3.selectAll('h2')
  //   .data([19, 70, 12, 16])
  //   .style('font-size', function(d) {
  //     return d + 'px'
  //   })
  //   .enter().append('h2')
  //   .text(function(d) {
  //     return "I'm h2 number" + d +"!";
  //   });

  // var String = "Fucktarts"

  // var h2 = d3.select("body").selectAll("p")
  //   .data([4, 8, 15, 16, 23, 42])
  //   .text(String);

  // entering
  // h2.enter().append('h2').text(String);


  // exiting
  // h2.exit().remove();


  // d3.select('body')
  //   .transition()
  //   .duration(750)
  //   .delay(1000)
  //   .style('background-color', 'black');

  // var svg = d3.select('body').selectAll('svg')
  // var circle = svg.selectAll("circle");

  // $('#circle').on('click', function(e) {
  //   circle.transition().duration(500).delay(0).style('fill', 'black');
  //   circle.transition().duration(750).delay(500).attr('r',30);
  //   circle.transition().duration(1200).delay(1250).attr('cy', 120);
  // })

  // var dataset = [];
  // for (var i=0; i<2; i++) {
  //   var newNum = Math.random() * 30;
  //   dataset.push(newNum);
  // }

  // d3.select('.d3').selectAll('rect')
  //   .data(dataset).enter()
  //   .append('svg')
  //   .attr('class', 'rect')
  //   .attr("width", "20")
  //   .attr("height", '100')
  //   .attr("fill", 'teal');

  // var bars = d3.select('.d3').selectAll('.bar-chart')

  // var durationTime = 500;
  // var delayTime = 0

  // $('#rectangle').on('click', function(e) {
  //   bars.data(dataset).enter()
  //   .append('div')
  //   .attr('class', 'bar-chart').transition().duration(500).style('height', function(d) {
  //     return d * 5 + 'px';
  //   });
  // });

  var w = '750'
  var h = '400'
  var xPadding = 50
  var yPadding = 20

  var dataset = [ 5, 10, 15, 20, 25, 20, 14, 11, 10, 20, 23, 25, 30, 10, 5, 10, 14, 9, 30, 32, 19, 5, 10, 15, 20, 25, 20, 14, 11, 10, 20, 23, 25, 30, 10, 5, 10, 14, 9, 30, 32, 19 ];

  var dataset2 = [
                [5, 20], [480, 90], [250, 50], [100, 33], [330, 95],
                [410, 12], [475, 44], [25, 67], [85, 21], [220, 88]
              ];

  var svg = d3.select(".d3")
            .append("svg")
            .attr("width", w)   // <-- Here
            .attr("height", h); // <-- and here!

  var circles = svg.selectAll('circle')
                .data(dataset2)
                .enter()
                .append('circle')

  var rects = svg.selectAll('rect')
                .data(dataset)
                .enter()
                .append('rect')
                .attr('fill', 'teal')

  var labels = svg.selectAll('text')
                .data(dataset2)
                .enter()
                .append('text')

  var xScale = d3.scale.linear()
                 .domain([0, d3.max(dataset2, function(d) { return d[0] })])
                 .range([xPadding, w - xPadding])

  var yScale = d3.scale.linear()
                 .domain([0, d3.max(dataset2, function(d) { return d[1] })])
                 .range([h - yPadding, yPadding])

  var xAxis = d3.svg.axis();
  xAxis.scale(xScale);
  // specify where labels appear
  xAxis.orient('bottom').ticks(5);

  var yAxis = d3.svg.axis();
  yAxis.scale(yScale);
  yAxis.orient('left').ticks(5);

  svg.append('g').attr('class', 'axis')
  .attr('transform', "translate(0,"+ (h - yPadding) +")").call(xAxis);

  svg.append('g').attr('class', 'axis')
  .attr('transform', "translate("+(xPadding) + ", 0)" ).call(yAxis);


  $('#circle').on('click', function(e) {
    circles.transition().duration(500)
    .attr('cx', function(d) {
      return xScale(d[0]);
    }).attr('cy', function(d) {
      return yScale(d[1]);
    }).attr('r', 5).attr('fill', 'teal')

    labels.transition().duration(500)
    .attr('x', function(d) {
      return xScale(d[0] + 4);
    }).attr('y', function(d) {
      return yScale(d[1] - 4);
    }).text(function(d) {
      return d[0] + ", "  + d[1];
    })

  });

  $('#rectangle').on('click', function(e) {
    rects.transition().duration(500)
    .attr('x', function(d, i) {
      return i * (w / dataset.length);
    })
    .attr('y', function(d) {
      return (h - d * 3);
    })
    .attr('width', w/dataset.length - 1)
    .attr('height', function(d) {
      return d * 3;
    }).attr('fill', function(d) {
      // return "rgb(" + d * 5 + ",0, 0)"
      // return "rgb(0," + d * 5 + ", 0)"
      // return "rgb(0, 0, " + d * 5 + ")"
      return "rgb(" + d * 5 + "," + d * 8 + "," + d * 10 + ")"
    });

    labels.transition().duration(500)
    .attr('x', function(d, i) {
      return i * (w / dataset.length) + (w / dataset.length - 1)/2;
    }).attr('y', function(d) {
      return (h - d * 3) + 13
    }).text(function(d) {
      return d;
    }).attr('text-anchor', 'middle')
      .attr('fill', function(d) {
        return "rgb(" + (255 - d * 5) + "," + (255 - d * 8) + "," + (255 - d * 10) + ")"
      });

  });

});

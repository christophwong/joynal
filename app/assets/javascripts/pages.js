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

  var svg = d3.select('body').selectAll('svg')
  var circle = svg.selectAll("circle");

  $('button').on('click', function(e) {
    circle.transition().duration(500).delay(0).style('fill', 'black');
    circle.transition().duration(750).delay(500).attr('r',30);
    circle.transition().duration(1200).delay(1250).attr('cy', 120);
  })

  var dataset = [ 5, 10, 15, 20, 25 ];

  // d3.select('.d3').selectAll('rect')
  //   .data(dataset).enter()
  //   .append('svg')
  //   .attr('class', 'rect')
  //   .attr("width", "20")
  //   .attr("height", '100')
  //   .attr("fill", 'teal');

  d3.select('.d3').selectAll('.bar-chart')
    .data(dataset).enter()
    .append('div')
    .attr('class', 'bar-chart')

  $('#rectangle').on('click', function(e) {
  });

});

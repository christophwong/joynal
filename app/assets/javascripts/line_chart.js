function lineChart(){

  $('.get-line-chart').on('ajax:success', function(e, data, status, xhr) {

    var dataSet = data
    var parseDate = d3.time.format("%Y-%m-%dT%X.%LZ").parse;
    var margin = {top: 20, right: 20, bottom: 30, left: 50}
    var width = $('.container').width() - margin.left - margin.right;
    var height = $('.container').height() - margin.top - margin.bottom;

    var x = d3.time.scale()
    .range([0, width]);

    var y = d3.scale.linear()
      .range([height, 0]);

    var xAxis = d3.svg.axis()
                .scale(x)
                .orient('bottom')

    var yAxis = d3.svg.axis()
                .scale(y)
                .orient('left');

    var line = d3.svg.line()
            .x(function(d){ return x(parseDate(d.created_at)); })
            .y(function(d){ return y(d.sentiment_score); });

    var svg = d3.select('.line-chart').append('svg')
        .attr('width', width + margin.left + margin.right)
        .attr('height', height + margin.top + margin.bottom)
        .append('g')
        .attr('transform', "translate("+margin.left+"," + margin.top + ")");

    var circles = svg.selectAll('circle')
                  .data(dataSet)
                  .enter()
                  .append('circle')


    var captionDiv = d3.select('.line-chart')
                       .append('div')
                       .attr('class', 'tooltip')
                       .style('opacity', 0);

    x.domain(d3.extent(dataSet, function(d) { return parseDate(d.created_at) }));
    y.domain(d3.extent(dataSet, function(d) { return d.sentiment_score}));

    svg.append('g')
       .attr('class', 'x axis')
       .attr('transform', "translate(0," + (height-1) + ")")
       .call(xAxis);

    svg.append('g')
       .attr('class', 'y axis')
       .attr('transform', "translate(-1,0)")
       .call(yAxis)
       .append("text")
       .attr('transform', 'rotate(-90)')
       .attr('y', 6)
       .attr('dy', '.71em')
       .style('text-anchor', 'end')
       .text('Positivity')

    svg.append('path')
        .datum(dataSet)
        .attr('class', 'line')
        .attr('d', line)
        .attr('stroke', 'steelblue')
        .attr('stroke-width', '1.5px')
        .attr('fill', 'none');

    circles.attr('cx', function(d) {
      return x(parseDate(d.created_at))
    }).attr('cy', function(d) {
      return y(d.sentiment_score)
    }).attr('r', 5).attr('fill', 'red')
    .on('mouseover', function(d) {
      captionDiv.transition()
      .duration(500)
      .style('opacity', 0);
      captionDiv.transition()
                .duration(200)
                .style('opacity', .9);
      captionDiv.html("<a href='/journal_entries/"+d.id+"'>"+ d.content.substring(0,50) +"...</a>")
      .style('left', (d3.event.pageX) + "px")
      .style('top', ((d3.event.pageY) - 20) + "px")
      .style('position', 'absolute')
    });
  });
}



$(document).ready(function(){
  lineChart();
})

$(document).on('page:load', function(){
  lineChart();
})

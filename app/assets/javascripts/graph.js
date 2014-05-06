function showGraph() {
  $('body').on('ajax:success', '.show-graph', function(e, data, status, xhr) {
    
    $('.show-graph').remove();
    $('.chart-description').show();
    var dataSet = data.slice();

    var width = 450;
    var height = 450;
    var radius = Math.min(width, height) / 2;
    var color = d3.scale.ordinal()
                .range(["#11435B","#2C8E47","#B9F345"])

    var arc = d3.svg.arc()
    .outerRadius(radius - 60)
    .innerRadius(90);

    var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return d.keywords.length; });

    var svg = d3.select(".d3").append("svg")
    .attr("width", width)
    .attr("height", height)
    .append("g")
    .attr("transform", "translate(" + width / 5 * 3 + "," + height / 2 + ")")
    // .on('click', function(d) {
    //   console.log(this)
    //   d3.select(this)
    //   .transition().duration(500)
    //   .attr("transform", "translate(" + width / 4 + "," + height / 2 + ")")
    // })
    ;

    var g = svg.selectAll(".arc")
      .data(pie(dataSet))
      .enter().append("g")
      .attr("class", "arc");


    var displayText = svg.append('text')
       .attr('transform', "translate(-9, 9)")
       .attr('font-size', '2em')

    g.append("path")
    .attr("d", arc)
    .style("fill", function(d) { return color(d.data.sentiment_type); })
    .on('mouseenter', function(d) {
      d3.select(this).attr('stroke', '#3C72F4').attr('stroke-width', '5')
      displayText.text(d.data.keywords.length)
    })
    .on('mouseleave', function(d) {
      d3.select(this).attr('stroke', 'none')
      displayText.text('')
    })
    .on('click', function(d) {
      d3.select('#keyword-name').text('');
      svg.transition().duration(750)
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")
      for(var i=0;i<d.data.keywords.length;i++) {
        if (d.data.keywords[i].sentiment_score < 0 || d.data.keywords[i].sentiment_score > 0){
          d3.select('#keyword-name').append('p')
          .transition().duration(750).delay(750)
          .text(d.data.keywords[i].name + ", " + d.data.keywords[i].sentiment_score.toFixed(2));
        } else {
           d3.select('#keyword-name').append('p')
          .transition().duration(750).delay(750)
          .text(d.data.keywords[i].name + ", " + d.data.keywords[i].sentiment_score.toFixed(0));
        }
      }
    });

    g.append("text")
      .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
      .attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text(function(d) { return d.data.sentiment_type; })
      .attr('fill', function(d) {
        if (d.data.sentiment_type === 'positive') {
          return "#0B326B"
        } else if (d.data.sentiment_type === 'neutral') {
          return "#ECE93B"
        } else {
          return "#F4EC6F"
        }
      });

  });
}

$(document).ready(function() {
  showGraph();
});


$(document).on('page:load', function() {
  showGraph();
});


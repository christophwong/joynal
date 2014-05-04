function showCloud() {

  $('.show-cloud').on('ajax:success', function(e, data, status, xhr) {
    var dataSet = {
      "name": "root",
      "value": 1,
      "children": data
      }

    var diameter = data.length * 20,
        format = d3.format(",d"),
        color = d3.scale.category20c();

    var bubble = d3.layout.pack()
        .size([diameter, diameter])
        .padding(1.5);

    var svg = d3.select(".cloud").append("svg")
        .attr("width", diameter)
        .attr("height", diameter)
        .attr("class", "bubble");


    var nodes = bubble.nodes(dataSet);

    var node = svg.selectAll(".node")
              .data(nodes)
              .enter()
              .append("g")
                .attr("class", "node")
                .attr("transform", function(d){ return "translate(" + d.x + "," + d.y + ")";})
                .on('click', function(d) {
                  d3.select('#cloud-info').text("Keyword: " + d.name + ", Frequency: " + d.value + ", Average Sentiment Score: " + d.sentiment_score)
                }).on('mouseenter', function(d) {
                  d3.select(this).attr('fill', 'red')
                  .attr('font-size', '2em')
                }).on('mouseleave', function(d) {
                  d3.select(this).attr('fill', '')
                  .attr('font-size', '')
                })


    node.append("circle")
      .attr("r", function(d) { return d.r; })
      .attr("fill", function(d) {
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
      .attr("stroke", function(d) { return d.children ? "#FFFFFF" : "#5F5556"})
      .attr("stroke-width", 2)

    node.append("text")
      .text(function(d){ return d.children ? "" : d.name ;} )
      .attr('text-anchor', 'middle');
  });
};

$(document).ready(function() {
  showCloud();
});

$(document).on('page:load', function() {
  showCloud();
})

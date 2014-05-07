function showCloud(json_array) {

  $('.show-cloud').remove();
  $('.chart-description.cloud').show();

  var chartWidth = 680;

  var chartData = [
                    {'type': 'Very Negative', 'color': '#11435B', 'textColor': '#FEF990'},
                    {'type': 'Negative', 'color': '#0F93A1', 'textColor': '#FEF76D'},
                    {'type': 'Neutral', 'color': '#2C8E47', 'textColor': '#F0EA3D'},
                    {'type': 'Positive', 'color': '#45BD42', 'textColor': '#09447E'},
                    {'type': 'Very Positive', 'color': '#B9F345', 'textColor': '#0D50E7'}
                  ]

  var chartScale = d3.scale.linear()
                   .domain([0, 1])
                   .range([0, chartWidth])

  var chart = d3.select("#chart-legend").append('svg')
              .attr('width', chartWidth)
              .attr('height', 35)

  var chartElement = chart.selectAll('.chart-element')
                     .data(chartData)
                     .enter().append('g')
                     .attr('class', 'chart-element')

  var chartBars = chartElement.append('rect')
                    .attr('width', 0)
                    .transition()
                    .duration(1000)
                    .attr('width', 130)
                    .attr('height', 35)
                    .attr('fill', function(d) {
                      return d.color
                    })
                    .attr('x', function(d, i) {
                      return (i * 130 + 30)
                    })

  chartElement.append("text")
              .transition()
              .delay(900)
              .attr('width', 130)
              .attr('height', 300)
              .attr('x', function(d, i) {
                return (i * 130) + 50
              }).attr('y', 25)
              .text(function(d) {
                return d.type;
              }).attr('fill', function(d) {
                return d.textColor;
              })


  var dataSet = {
    "name": "root",
    "value": 1,
    "children": json_array
    }

  var diameter = 650,
      format = d3.format(",d");

  var bubble = d3.layout.pack()
      .size([diameter, diameter])
      .padding(7.5);

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
              .on('mouseenter', function(d) {
                if (d.children){
                  return ""
                }else{
                  d3.select('#cloud-info').text(d.name + " " + d.sentiment_score)
                }
              });

  node.append("circle")
    .attr('fill', 'white')
    .attr('stroke', '#FFFFFF')
    .attr("r", function(d) { return d.r; })
    .transition()
    .duration(1500)
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
    .attr('text-anchor', 'middle')
    .style('fill', 'white')
    .transition()
    .duration(1500)
    .style('fill','black')
    .each(function(d) {
      var rect,
          r2 = d.r * d.r,
          s = d.r * 2,
          t = d3.select(this);
      do {
        t.style("font-size", s-- + "px");
        rect = this.getBBox();
      } while (norm2(rect.x, rect.y) > r2
        || norm2(rect.x + rect.width, rect.y) > r2
        || norm2(rect.x + rect.width, rect.y + rect.height) > r2
        || norm2(rect.x, rect.y + rect.height) > r2);
      });
    function norm2(x, y) {
      return x * x + y * y;
    }

};

function showWordCloud() {
  $('.show-cloud').on('ajax:success', function(e, data, status, xhr) {
    showCloud(data);
  })
}


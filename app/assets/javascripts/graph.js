// function showGraph() {
//   $('.show-graph').on('ajax:success', function(e, data, status, xhr) {
//     var dataSet = data.slice();

//     var w = 1200;
//     var h = 200;
//     var xPadding = 60;
//     var yPadding = 10;
//     var circlePadding = 5;
//     var minRadius = 15;
//     var maxRadius = 50;


//     var svg = d3.select("body")
//               .append("svg")
//               .attr("width", w)
//               .attr("height", h);

//     var circles = svg.selectAll('circle')
//                   .data(dataSet)
//                   .enter()
//                   .append('circle')
//                   .on("mouseenter", function(d,i) {
//                     d3.select('#journal-info').text(d.name+", relevance: "+d.relevance+", sentiment_score: "+d.sentiment_score)
//                   });

//     var labels = svg.selectAll('text')
//                  .data(dataSet)
//                  .enter()
//                  .append('text')

//     var xScale = d3.scale.linear()
//                  .domain([0, (maxRadius+circlePadding) * dataSet.length])
//                  .range([xPadding, w - xPadding])


//     var color = d3.scale.category20b()

//     circles.transition().duration(500)
//     .attr('cx', function(d, i) {
//       return i * maxRadius * 2 + xPadding;
//     }).attr('cy', 100)
//     .attr('r', function(d) {
//       return d.relevance * 50;
//     }).attr('fill', function(d) {
//       if (d.sentiment_score > 0) {
//         return "rgb(0," + (d.sentiment_score * 255) + ", 0)"
//       } else if (d.sentiment_score < 0) {
//         return "rgb(" + (-d.sentiment_score * 255) + ",0, 0)"
//       } else {
//         return "#FFFFFF"
//       }
//     })

//     labels.transition().duration(500)
//     .attr('x', function(d, i) {
//       return i * maxRadius * 2 + xPadding;
//     }).attr('y', 100)
//     .text(function(d) {
//       return d.name;
//     }).attr('text-anchor', 'middle')
//     .attr('font-size', function(d) {
//       return d.relevance * 15;
//     })
//     .attr('fill', function(d) {
//       console.log("this is sentiment_score")
//       console.log(d.sentiment_score)
//       if (d.sentiment_score < 0) {
//         return "#FFFFFF"
//       } else {
//         return "#000000"
//       }
//     })
//   });
// }

function showGraph() {

  // $('.show-graph').on('ajax:success', function(e, data, status, xhr) {
    var dataSet = {
      "name": "Max",
      "value": 100,
      "children":[
        {"name": "Hello", "value": 26 },
        {"name": "hello", "value": 65 },
        {"name": "bye", "value": 100 }
        ]
      }

    var diameter = 390,
        format = d3.format(",d"),
        color = d3.scale.category20c();

    var bubble = d3.layout.pack()
        // .sort(null)
        .size([diameter, diameter])
        .padding(1.5);

    var svg = d3.select(".d3").append("svg")
        .attr("width", diameter)
        .attr("height", diameter)
        .attr("class", "bubble");

    // d3.json(dataSet, function(error, root) {
    //   var node = svg.selectAll(".node")
    //       .data(bubble.nodes(classes(root))
    //       .filter(function(d) { return !d.children; }))
    //     .enter().append("g")
    //       .attr("class", "node")
    //       .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });

    //   node.append("title")
    //       .text(function(d) { return d.className + ": " + format(d.value); });

    //   node.append("circle")
    //       .attr("r", function(d) { return d.r; })
    //       .style("fill", function(d) { return color(d.packageName); });

    //   node.append("text")
    //       .attr("dy", ".3em")
    //       .style("text-anchor", "middle")
    //       .text(function(d) { return d.className.substring(0, d.r / 3); });
    // });

    var nodes = bubble.nodes(dataSet);

    var node = svg.selectAll(".node")
              .data(nodes)
              .enter()
              .append("g")
                .attr("class", "node")
                .attr("transform", function(d){ return "translate(" + d.x + "," + d.y + ")";});

        node.append("circle")
          .attr("r", function(d){ return d.r; })
          .attr("fill", function(d){ return "#" + "00" + d.value + "55"})
          .attr("opacity", 0.25)
          .attr("stroke", "black")
          .attr("stroke-width", 2)

        node.append("text")
          .text(function(d){ return d.name ;} )

    // var node = svg.selectAll('.node')
    //            .data(bubble.nodes(classes(root)))
    //            .filter(function(d) { return !d.children; })
    //            .enter().append('g')
    //            .attr('class', 'node')
    //            .attr('transform', function(d) { return "translate(" + d.x + "," + d.y + ")" });

    //     node.append("title")
    //         .text(function(d) { return d.name });

    //     node.append("circle")
    //         .attr("r", function(d) { return d.r })
    //         .style("fill", function(d) { return color(d.name); });

    //     node.append("text")
    //         .attr("dy", ".3em")
    //         .style("text-anchor", "middle")
    //         .text(function(d) { return d.name; });

  // });

};

$(document).ready(function() {
  showGraph();
  // $('.show-graph').on('ajax:success', function(e, data, status, xhr) {
  //   console.log("I'm here!!")
  //   console.log(data)
  // });
});


$(document).on('page:load', function() {
  showGraph();
  // $('.show-graph').on('ajax:success', function(e, data, status, xhr) {
  //   console.log("I'm here!!")
  //   console.log(data)
  // });
});

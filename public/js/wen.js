function refresh() {
  $('.picker').each(function() {
    var id = this.id
    var s = id.split('-')
    $.getJSON('/colours/' + s[0] + '/' + s[1], function (data) {
      if(s[1] == 'face') {
        $('#' + id).attr('stroke', 'rgb(' + (data['colour'].join(', ')) + ')')
      } else {
        $('#' + id).attr('fill', 'rgb(' + (data['colour'].join(', ')) + ')')
      }
      $('#' + id).spectrum({
        color: 'rgb(' + (data['colour'].join(', ')) + ')',
        showPalette: true,
        palette: [
          colours
        ],
        showPaletteOnly: true,
        togglePaletteOnly: true,
        togglePaletteMoreText: 'expert mode',
        togglePaletteLessText: 'easy mode',
        hideAfterPaletteSelect:true,
      //  showInitial: true,
        preferredFormat: "rgb"
      })
    })
  })
}

function makeClockPicker() {
  var w = 320             // Width of SVG element
  var h = 320             // Height of SVG element

  var cx = w / 2          // Center x
  var cy = h / 2          // Center y
  var margin = 20
  var r = w / 2 - margin  // Radius of clock face
  var innerRadius = 72
  var outerRadius = 128
  var sw = 32 // stroke width
  var blobSize = 24

  var svg = d3.select("#clock").append("svg")
    .attr("width", w)
    .attr("height", h)

  makeClockFace()

  function makeClockFace() {
    var now = new Date()

    makeWheel(svg, 'minutes-face', cx, cy, outerRadius, sw)
    makeWheel(svg, 'hours-face', cx, cy, innerRadius, sw)

    makeBlob(svg, 'minutes-hands', cx, cy, outerRadius, blobSize, now)
    makeBlob(svg, 'hours-hands', cx, cy, innerRadius, blobSize, now)
  }
}

function makeWheel(svg, id, x, y, radius, sw) {
  svg.append('a').attr("xlink:href", '#')
      .append('svg:circle')
      .attr('id', id)
      .attr('class', 'picker')
      .attr('r', radius)
      .attr('cx', x)
      .attr('cy', y)
      .attr('fill', 'none')
      .attr('stroke', '#000')
      .attr('stroke-width', sw)
      .attr('shape-rendering', 'auto')
      .attr('opacity', 0.5)
}

function makeBlob(svg, id, cx, cy, radius, blobSize, now) {
  var x = cx
  var y = cy - radius

  var blob = svg.append('a')
    .attr("xlink:href", '#')
    .append("svg:circle").attr({
      cx: x,
      cy: y,
      opacity: 1,
      r: blobSize,
      fill: "#000",
      opacity: 0.9,
      stroke: '#777'
    });

  var mins = now.getMinutes()
  var angle = mins * 6
  if(id.includes('hours')) {
    var hours = now.getHours()
    angle = hours * 30
  }

  blob.attr('transform', 'rotate(' + angle + ', ' + cx + ', ' + cy + ')')
      .attr("xlink:href", '#')
      .attr('id', id)
      .attr('class', 'picker')
}

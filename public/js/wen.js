function degreesToRadians(degrees) {
  return degrees * (Math.PI / 180)
}

function minutesToDegrees(mins) {
  return (mins * 6).toFixed(2) / 1
}

function hoursToDegrees(hours, mins) {
  var wholeHours = (hours % 12) * 30
  var fraction
  if (mins == 0) {
    fraction = 0
  } else {
    fraction = 30 * (mins / 60.0)
  }

  return (wholeHours + fraction).toFixed(2) / 1
}

function hourEnds(angle) {
  var start = 0 - (360 - angle)
  return {
    start: start,
    end: angle
  }
}

function refresh() {
  $('.picker').each(function() {
    var id = this.id
    var s = id.split('-')
    $.getJSON('/colours/' + s[0] + '/' + s[1], function (data) {
      $('#' + id).attr('fill', 'rgb(' + (data['colour'].join(', ')) + ')')
      $('#' + id).spectrum({
        color: 'rgb(' + (data['colour'].join(', ')) + ')',
        showPalette: true,
        palette: [
          colours
        ],
        showPaletteOnly: true,
        //togglePaletteOnly: true,
        togglePaletteMoreText: 'expert mode',
        togglePaletteLessText: 'easy mode',
        hideAfterPaletteSelect:true,
      //  showInitial: true,
        preferredFormat: "rgb",
        containerClassName: 'wen-picker'
      })
    })
  })
}

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

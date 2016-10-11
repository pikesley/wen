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

function minuteEnds(minutes, buffer, mode) {
  if(mode === undefined) {
    mode = 'range'
  }

  var shim = 1 / 1000

  hs = 0
  if (mode == 'strict') {
    hs = (minutes * 6).toFixed(2) / 1
  }

  if (mode == 'vague') {
    hs = (minutes * 6) - 6
  }

  if (mode == 'range') {
    if (minutes > 55) {
      minutes = 55
    }
  }

  he = ((minutes + shim) * 6).toFixed(2) / 1
  if (mode == 'range') {
    if (he > 327) {
      he = he - 2
    }
  }

  if (mode == 'vague') {
    he = (minutes * 6) + 6
  }

  fs = (minutes * 6) + buffer
  if (mode == 'range') {
    if (fs > 343) {
      fs = (fs - shim) - 2
    }
  }

  if (mode == 'vague') {
    fs = he + buffer
  }

  fe = 360 - buffer
  if (mode == 'strict') {
    fe = 360 + (minutes * 6) - buffer
  }

  if (mode == 'vague') {
    fe = hs - buffer + 360
  }

  return {
    'hands': {
      'start': hs,
      'end': he
    },
    'face': {
      'start': fs,
      'end': fe
    }
  }
}

function hourEnds(hours, minutes, buffer) {
  var shim = 1 / 1000
  var hs = hoursToDegrees(hours, minutes)
  var he = hs + shim

  return {
    'hands': {
      'start': hs,
      'end': he
    },
    'face': {
      'start': hs + 28,
      'end': hs + 332
    }
  }
}

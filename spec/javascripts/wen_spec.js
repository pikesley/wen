describe('Wen', function() {
  describe('degreesToRadians', function() {
    it('converts 0 degrees', function() {
      expect(degreesToRadians(0)).toEqual(0)
    })

    it('converts 180 degrees', function() {
      expect(degreesToRadians(180)).toEqual(Math.PI)
    })
  })

  describe('minutesToDegrees', function() {
    it('converts 0 minutes', function() {
      expect(minutesToDegrees(0)).toEqual(0)
    })

    it('converts 30 minutes', function() {
      expect(minutesToDegrees(30)).toEqual(180)
    })

    it('converts 45 minutes', function() {
      expect(minutesToDegrees(45)).toEqual(270)
    })
  })

  describe('hoursToDegrees', function() {
    it('converts 0 hours and 0 minutes', function() {
      expect(hoursToDegrees(0, 0)).toEqual(0)
    })

    it('converts 6 hours and 0 minutes', function() {
      expect(hoursToDegrees(6, 0)).toEqual(180)
    })

    it('converts 7 hours', function() {
      expect(hoursToDegrees(7, 0)).toEqual(210)
    })

    it('converts 6 hours 30 minutes', function() {
      expect(hoursToDegrees(6, 30)).toEqual(195)
    })

    it('modulates for 24-hour time', function() {
      expect(hoursToDegrees(18, 30)).toEqual(195)
    })
  })

  describe('hourEnds', function() {
    it('gets the ends for 90', function() {
      expect(hourEnds(90)).toEqual(
        {
          start: -270,
          end: 90
        }
      )
    })

    it('gets the ends for 180', function() {
      expect(hourEnds(180)).toEqual(
        {
          start: -180,
          end: 180
        }
      )
    })
  })
})

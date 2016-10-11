describe('Wen', function() {
  describe('minuteEnds', function() {
    it('gets the ends for 0 minutes', function() {
      expect(minuteEnds(0, 16)).toEqual(
        {
          "hands":{
            "start":0,
            "end":0.01
          },
          "face":{
            "start":16,
            "end":344
          }
        }
      )
    })

    it('gets the ends for 1 minutes', function() {
      expect(minuteEnds(1, 16)).toEqual(
        {
          "hands":{
            "start":0,
            "end":6.01
          },
          "face":{
            "start":22,
            "end":344
          }
        }
      )
    })

    it('gets the ends for 25 minutes', function() {
      expect(minuteEnds(25, 16)).toEqual(
        {
          "hands":{
            "start":0,
            "end":150.01
          },
          "face":{
            "start":166,
            "end":344
          }
        }
      )
    })

    it('gets the ends for 39 minutes', function() {
      expect(minuteEnds(39, 16)).toEqual(
        {
          "hands":{
            "start":0,
            "end":234.01
          },
          "face":{
            "start":250,
            "end":344
          }
        }
      )
    })

    it('gets the ends for 54 minutes', function() {
      expect(minuteEnds(54, 16)).toEqual(
        {
          "hands":{
            "start":0,
            "end":324.01
          },
          "face":{
            "start":340,
            "end":344
          }
        }
      )
    })

    it('gets the ends for 55 minutes', function() {
      expect(minuteEnds(55, 16)).toEqual(
        {
          "hands":{
            "start":0,
            "end":328.01
          },
          "face":{
            "start":343.999,
            "end":344
          }
        }
      )
    })

    it('gets the ends for 57 minutes', function() {
      expect(minuteEnds(57, 16)).toEqual(
        {
          "hands":{
            "start":0,
            "end":328.01
          },
          "face":{
            "start":343.999,
            "end":344
          }
        }
      )
    })

    describe('different modes', function() {
      describe('strict mode', function() {
        it('gets the ends for 0 minutes', function() {
          expect(minuteEnds(0, 16, 'strict')).toEqual(
            {
              "hands":{
                "start":0,
                "end":0.01
              },
              "face":{
                "start":16,
                "end":344
              }
            }
          )
        })

        it('gets the ends for 1 minutes', function() {
          expect(minuteEnds(1, 16, 'strict')).toEqual(
            {
              "hands":{
                "start":6,
                "end":6.01
              },
              "face":{
                "start":22,
                "end":350
              }
            }
          )
        })

        it('gets the ends for 54 minutes', function() {
          expect(minuteEnds(54, 16, 'strict')).toEqual(
            {
              "hands":{
                "start":324,
                "end":324.01
              },
              "face":{
                "start":340,
                "end":668
              }
            }
          )
        })

        it('gets the ends for 55 minutes', function() {
          expect(minuteEnds(55, 16, 'strict')).toEqual(
            {
              "hands":{
                "start":330,
                "end":330.01
              },
              "face":{
                "start":346,
                "end":674
              }
            }
          )
        })
      })

      describe('vague mode', function() {
        it('gets the ends for 0 minutes', function() {
          expect(minuteEnds(0, 16, 'vague')).toEqual(
            {
              "hands":{
                "start":-6,
                "end":6
              },
              "face":{
                "start":22,
                "end":338
              }
            }
          )
        })

        it('gets the ends for 30 minutes', function() {
          expect(minuteEnds(30, 16, 'vague')).toEqual(
            {
              "hands":{
                "start":174,
                "end":186
              },
              "face":{
                "start":202,
                "end":518
              }
            }
          )
        })
      })
    })
  })

  describe('hourEnds', function() {
    it('gets the ends for 0 hours', function() {
      expect(hourEnds(0, 0, 16)).toEqual(
        {
          "hands":{
            "start":0,
            "end":0.001
          },
          "face":{
            "start":28,
            "end":332
          }
        }
      )
    })

    it('gets the ends for 1 hour', function() {
      expect(hourEnds(1, 0, 16)).toEqual(
        {
          "hands":{
            "start":30,
            "end":30.001
          },
          "face":{
            "start":58,
            "end":362
          }
        }
      )
    })

    it('gets the ends for 16:30', function() {
      expect(hourEnds(16, 30)).toEqual(
        {
          "hands":{
            "start":135,
            "end":135.001
          },
          "face":{
            "start":163,
            "end":467
          }
        }
      )
    })
  })
})

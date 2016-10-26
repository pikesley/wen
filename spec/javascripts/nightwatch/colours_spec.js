const timeout = 2000

module.exports = {
  'Single colour change': function(browser) {
    browser
      .url('http://localhost:9292/colours')
      .waitForElementVisible('body', timeout)
      .assert.containsText('h1', 'colours')

      .click('a[id=reset]')
      .pause(timeout)

      .click('#hours-hand')
      .waitForElementVisible('.hours-hand-picker', timeout)
      .click('.hours-hand-picker div div div span[title="rgb(255, 0, 127)"] span')
      .pause(timeout)
      .assert.attributeContains('#hours-hand', 'fill', 'rgb(255, 0, 127)')

      .end()
/*  },

  'Multiple colour change': function(browser) {
    browser
      .url('http://localhost:9292/colours')
      .waitForElementVisible('body', timeout)

      .click('a[id=reset]')
      .pause(timeout)

      .click('#minutes-hand')
      .waitForElementVisible('.minutes-hand-picker', timeout)
      .click('.minutes-hand-picker div div div span[title="rgb(255, 0, 255)"] span')
      .pause(timeout)


      .click('#hours-hand')
      .waitForElementVisible('.hours-hand-picker', timeout)
      .click('.hours-hand-picker div div div span[title="rgb(255, 255, 255)"] span')
      .pause(timeout)

      .assert.attributeContains('#minutes-hand', 'fill', 'rgb(255, 0, 255)')
      .assert.attributeContains('#hours-hand', 'fill', 'rgb(255, 255, 255)')

      .end()*/
  }
}

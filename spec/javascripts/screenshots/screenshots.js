module.exports = {
  'Colours screenshot': function(browser) {
    browser
      .url('http://localhost:9292/colours')
      .waitForElementVisible('body', 1000)
      .resizeWindow(400, 700)
      .click('a[id=reset]')
      .click('#hours-hand')
      .waitForElementVisible('.hours-hand-picker', 1000)
      .saveScreenshot('./screenshot/colours.png')
      .end()
  },

  'Modes screenshot': function(browser) {
    browser
      .url('http://localhost:9292/modes')
      .waitForElementVisible('body', 1000)
      .resizeWindow(400, 700)
      .click('#range-mode-picker')
      .saveScreenshot('./screenshot/modes.png')
      .end()
  },

  'Tricks screenshot': function(browser) {
    browser
      .url('http://localhost:9292/tricks')
      .waitForElementVisible('body', 1000)
      .resizeWindow(400, 700)
      .saveScreenshot('./screenshot/tricks.png')
      .end()
  }
}

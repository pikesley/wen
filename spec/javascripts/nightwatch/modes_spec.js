const timeout = 100

module.exports = {
  'Mode change': function(browser) {
    browser
      .url('http://localhost:9292/modes')
      .waitForElementVisible('body', timeout)
      .assert.containsText('h1', 'modes')
      .click('button[id=vague-mode]')
      .click('button[id=about-vague-mode]')
      .waitForElementVisible('#vague-modal', timeout)
      .assert.cssClassPresent('#about-vague-mode', 'btn-active')
      .assert.containsText('#vague-is-current', 'this mode is currently selected')
      .assert.hidden('#range-is-current')
      .assert.hidden('#strict-is-current')
      .end()
  }
}

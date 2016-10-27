const timeout = 100

module.exports = {
  'Mode change': function(browser) {
    browser
      .url('http://localhost:9292/modes')
      .waitForElementVisible('body', timeout)
      .assert.containsText('h1', 'modes')

      // select vague mode
      .click('#vague-mode-picker')

      // button becomes active
      .assert.cssClassPresent('#about-vague-mode', 'btn-active')

      // open vague modal
      .click('#about-vague-mode')
      .waitForElementVisible('#vague-modal', timeout)

      // only this one has the text
      .assert.containsText('#vague-is-current', 'this mode is currently selected')
      .assert.hidden('#range-is-current')
      .assert.hidden('#strict-is-current')

      // and we should not see this button
      .assert.hidden('#vague-mode-modal-picker')

      .end()
  }
}

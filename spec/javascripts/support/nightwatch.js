const TRAVIS_JOB_NUMBER = process.env.TRAVIS_JOB_NUMBER;

module.exports = {
  src_folders: ["spec/javascripts/nightwatch/"],
  output_folder: "spec/javascripts/nightwatch/reports",
  custom_commands_path: "",
  custom_assertions_path: "",
  page_objects_path: "",
  globals_path: "",
  test_settings: {
    default: {
      launch_url: "http://ondemand.saucelabs.com:80",
      selenium_port: 80,
      selenium_host: "ondemand.saucelabs.com",
      silent: true,
      username: process.env.SAUCE_USERNAME,
      access_key: process.env.SAUCE_ACCESS_KEY,
      screenshots: {
        enabled: false,
        path: "",
      },
      desiredCapabilities: {
        browserName: "chrome",
        build: `build-${TRAVIS_JOB_NUMBER}`,
       "tunnel-identifier": TRAVIS_JOB_NUMBER,
     },
      globals: {
        waitForConditionTimeout: 10000,
      }
    },
    local: {
      launch_url: "http://localhost:9292",
      selenium_port: 4444,
      selenium_host: "localhost",
      silent: true,
      screenshots: {
        enabled: false,
        path: ""
      },
      desiredCapabilities: {
        browserName: "chrome"
      }
    }
  }
}

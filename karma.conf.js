module.exports = function (config) {
  config.set({
    files: [
    'js/vendor.js',
    'js/angular-app.js',
      'js/angular-app.test.js'
    ],
    exclude: [
    ],

    browsers: ['Chrome'],
    // Chrome, ChromeCanary, Firefox, IE (only Windows), Opera, PhantomJS, Safari (only Mac)

    reporters: [
      'dots',
      // 'coverage',
    ],
    preprocessors: {
      'js/**/*test.js': 'coverage',
      //'src/angular/**/*test.coffee': 'coffee'
    },
    // Optionally, configure the reporter:
    //
    // coverageReporter: {
    //   type: 'html',
    //   dir: 'coverage/',
    // },

    basePath: './builds/development/',
    captureTimeout: 60000,
    colors: true,
    frameworks: ['jasmine'],
    logLevel: config.LOG_DEBUG,
    port: 9876,
    reportSlowerThan: 500,
    runnerPort: 9100,
  });
};
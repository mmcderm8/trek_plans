
var path = require('path');

module.exports = function(config) {
  config.set({
    // use the PhantomJS browser
    browsers: ['PhantomJS'],

    // use the Jasmine testing framework
    frameworks: ['jasmine'],

    // files that Karma will server to the browser
    files: [
      // load fixtures
      'test/fixtures/**/*.json',
      // use Babel polyfill to emulate a full ES6 environment in PhantomJS
      '../node_modules/babel-polyfill/dist/polyfill.js',
      // entry file for Webpack
      'test/testHelper.js',
      // use whatwg-fetch polyfill
      '../node_modules/whatwg-fetch/fetch.js'
    ],

    // before serving test/testHelper.js to the browser
    preprocessors: {
      // process json files with karma-json-fixtures-preprocessor
      'test/fixtures/**/*.json': ['json_fixtures'],
      'test/testHelper.js': [
        // use karma-webpack to preprocess the file via webpack
        'webpack',
        // use karma-sourcemap-loader to utilize sourcemaps generated by webpack
        'sourcemap'
      ]
    },

    // webpack configuration used by karma-webpack
    webpack: {
      // generate sourcemaps
      devtool: 'inline-source-map',
      // enzyme-specific setup
      externals: {
        'cheerio': 'window',
        'react/addons': true,
        'react/lib/ExecutionEnvironment': true,
        'react/lib/ReactContext': true
      },
      module: {
        loaders: [
          {
            include: /\.json$/,
            loader: 'json-loader'
          },
          // use babel-loader to transpile the test and src folders
          {
            test: /\.jsx?$/,
            exclude: /node_modules/,
            loader: 'babel'
          }
        ]
      },

      // relative path starts out at the src folder when importing modules
      resolve: {
        root: path.resolve(__dirname, './src')
      }
    },

    webpackMiddleware: {
      // do not output webpack build information to the browser's console
      noInfo: true
    },

    // test reporters that Karma should use
    reporters: [
      // use karma-spec-reporter to report results to the browser's console
      'progress',
      'spec'
    ],

    jsonFixturesPreprocessor: {
      stripPrefix: 'test/fixtures/'
    },

    // karma-spec-reporter configuration
    specReporter: {
      suppressErrorSummary: true,  // do not print error summary

      // remove meaningless stack trace when tests do not pass
      maxLogLines: 2,

      // do not print information about tests that are passing
      suppressPassed: true,
      suppressSkipped: true

    }
  })
}

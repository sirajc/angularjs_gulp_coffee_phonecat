var gulp = require('gulp'),
	jade = require('gulp-jade'),
	//browserify = require('gulp-browserify'),
	uglify = require('gulp-uglify'),
	gulpif = require('gulp-if'),
	sass = require('gulp-sass'),
	connect = require('gulp-connect'),
	coffee = require('gulp-coffee'),
	ngClassify = require('gulp-ng-classify'),
	ngmin = require('gulp-ngmin'),
    ngAnnotate = require('gulp-ng-annotate'),
	clean = require('gulp-clean'),
	concat = require('gulp-concat'),
	clean = require('gulp-clean'),
	runSequence = require('run-sequence'),
	plumber = require('gulp-plumber'),
	gutil = require('gulp-util'),
	minifyCSS = require('gulp-minify-css'),
	prefix = require('gulp-autoprefixer'),
	karma = require('gulp-karma'),
    sourcemaps = require('gulp-sourcemaps')
    ;

/********* ENVIRONMENT SETUP *****************/
var env = process.env.NODE_ENV || 'development' ;
var isDevelopment = (env === 'development');
var isProduction = (env === 'production');

/********* Bower Libs (TODO create a task to automate this) *****************/
var bowerLibs = [	
					'bower_components/jquery/dist/jquery.js',
					'bower_components/angular/angular.js',
					'bower_components/angular-route/angular-route.js',
					'bower_components/angular-resource/angular-resource.js',
					'bower_components/angular-animate/angular-animate.js',
					'bower_components/angular-mocks/angular-mocks.js'
				];

if(isProduction){
	bowerLibs = [	
					'bower_components/jquery/dist/jquery.min.js',
					'bower_components/angular/angular.min.js',
					'bower_components/angular-route/angular-route.min.js',
					'bower_components/angular-resource/angular-resource.min.js',
					'bower_components/angular-animate/angular-animate.min.js'
				];
}

/********* DIRECTORIES SOURCE AND BUILD *****************/
var srcDir = 'src';
var src = {
	jadeFiles: srcDir + '/angular/**/*.jade',
	coffeeFiles: [srcDir + '/angular/**/*.coffee', '!' + srcDir + '/angular/**/*test.coffee'],
	coffeeTestFiles: srcDir + '/angular/**/*test.coffee',
	sassFiles: [srcDir + '/sass/**/*.scss', srcDir + '/sass/**/*.sass'],
	mainSassFile: srcDir + '/sass/apps.sass',
	cssLibFiles: 'css-libs/**/*.css'
};

var assetDir = 'assets';
var assets = {
	jsonFiles: assetDir + '/**/*.json',
	imageFiles: [assetDir + '/**/*.png', assetDir + '/**/*.jpg']
}

var outputDir = 'builds/development';
if(isProduction){
	outputDir = 'builds/production';
}
var output = {
	dir: {
		html: outputDir,
		css: outputDir + '/css',
		js: outputDir + '/js',
		assets: outputDir
	},
	file: {
		vendorjs: 'vendor.js',
		angularjs: 'angular-app.js', 
		karmaTestJs: 'angular-app.test.js',
		vendorcss: 'vendor.css',
		css: 'apps.css',
		htmlIndex: 'index.html'

	}
}
var stagingDir = 'builds/angular';
var stage ={
	dir: {
		ngClassify: stagingDir + '/ng_classified',
		angularjs: stagingDir + '/angularjs'
	}
}

/********* CONFIGURATIONS *****************/
var serverPort = 8000;
var livereloadPort = 35777;
var outputSourceMapForJS = true;
if(isProduction){
	outputSourceMapForJS=false;
}

/********* UTIL FUNCTIONS FOR THIS GULPFILE.js *****************/
function logError(error) {
	gutil.log(gutil.colors.red(error.message));
	gutil.beep();
	this.emit('end');
};

/*################### TASKS #################################*/

gulp.task('clean', function(){
	return gulp.src([outputDir, stagingDir])
		.pipe(clean({force: true, read: false}));
});

gulp.task('jade' , function() {
	return gulp.src(src.jadeFiles)
		.pipe(plumber(logError))
		.pipe(jade({pretty : isDevelopment}))
		.pipe(gulp.dest(output.dir.html))
		.pipe(connect.reload());
});

gulp.task('coffee', function () {
	var options = {
		// controller: {
		// 	format: '*',
		// 	suffix: ''
		// }
	};

	return gulp
		.src(src.coffeeFiles)
		.pipe(plumber(logError))
        .pipe(coffee({bare: false}))
        .pipe(ngAnnotate({remove: true,add: true,single_quotes: true}))
		.pipe(gulp.dest(stage.dir.angularjs))
		.pipe(gulpif(isProduction , uglify({outSourceMap: outputSourceMapForJS})))
		.pipe(concat(output.file.angularjs))
		.pipe(gulp.dest(output.dir.js))
		.pipe(connect.reload());
});

gulp.task('coffee-test', function () {
	return gulp
		.src(src.coffeeTestFiles)
		.pipe(plumber(logError))
        .pipe(sourcemaps.init())
		.pipe(coffee({bare: false}))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(stage.dir.angularjs))
		.pipe(concat(output.file.karmaTestJs))
		.pipe(gulp.dest(output.dir.js))
});

gulp.task('sass', function(){
	var config = {};

	if(isDevelopment){
		// Getting runtime error, hence commenting this now
		// config.sourceComments = 'map'
	}
	if(isProduction){
		config.outputStyle = 'compressed'
	}

	return gulp.src(src.mainSassFile)
		.pipe(plumber(logError))
		.pipe(sass(config))
		.pipe(prefix(["last 2 version", "> 1%", "ie 8"], { cascade: true }))
		.pipe(gulp.dest(output.dir.css))
		.pipe(connect.reload());
});

gulp.task('assets-json' , function() {
	return gulp.src(assets.jsonFiles)
		.pipe(plumber(logError))
		.pipe(gulp.dest(output.dir.assets))
		.pipe(connect.reload());
});

gulp.task('assets-image' , function() {
	return gulp.src(assets.imageFiles)
		.pipe(plumber(logError))
		.pipe(gulp.dest(output.dir.assets))
		.pipe(connect.reload());
});

gulp.task('css-libs', function() {
	return gulp.src(src.cssLibFiles)
		.pipe(plumber(logError))
		.pipe(concat(output.file.vendorcss))
		.pipe(gulp.dest(output.dir.css));
});

gulp.task('bower', function(){
	return gulp.src(bowerLibs)
		.pipe(plumber(logError))
		.pipe(concat(output.file.vendorjs))
		.pipe(gulp.dest(output.dir.js));
});

gulp.task('watch', function(){
	gulp.watch(src.jadeFiles, ['jade']);
	gulp.watch(src.sassFiles, ['sass']);
	gulp.watch(src.coffeeFiles,  ['coffee'] );
	gulp.watch(src.coffeeTestFiles,  ['coffee-test'] );
	gulp.watch(assets.jsonFiles,  ['assets-json'] );
	gulp.watch(assets.imageFiles,  ['assets-image'] );
});

gulp.task('connect', function() {
  connect.server({
    root: [outputDir],
    livereload: true,
    port: serverPort,
    fallback: output.dir.html + '/' +output.file.htmlIndex,
    livereload : { port: livereloadPort }
  });
});

gulp.task('build', function(callback) {
	gutil.log(gutil.colors.green('Building for '+ env.toUpperCase() + ' environment'));
  	runSequence('clean',
              ['jade', 'coffee', 'coffee-test' ,'sass', 'css-libs', 'bower', 'assets-json', 'assets-image'],
              callback);
});

gulp.task('default', function(callback) {
  	runSequence('build',
              	'watch',
              	'connect',
              	callback);
});

// Karma
gulp.task('karma', function () {
  return gulp.src(['no need to supply files because everything is in config file'])
    .pipe(karma({
      configFile: 'karma.conf.js',
      action: 'watch'
    }).on('error', logError));
});


// The protractor task
var protractor = require('gulp-protractor').protractor;

// Start a standalone server
var webdriver_standalone = require('gulp-protractor').webdriver_standalone;

// Download and update the selenium driver
var webdriver_update = require('gulp-protractor').webdriver_update;

// Downloads the selenium webdriver
gulp.task('webdriver_update', webdriver_update);

// Start the standalone selenium server
// NOTE: This is not needed if you reference the
// seleniumServerJar in your protractor.conf.js
gulp.task('webdriver_standalone', webdriver_standalone);


// Setting up the test task
gulp.task('e2e', function(cb) {
    gulp.src(['./src/test-e2e/*.js']).pipe(protractor({
        configFile: './src/test-e2e/protractor.config.js'
    })).on('error', function(e) {
        console.log(e)
    }).on('end', cb);
});
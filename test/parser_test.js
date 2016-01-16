var assert = require('chai').assert;
var PEG = require('pegjs');
var fs = require('fs');

describe('Parser', function() {
  var parser;
  before(function() {
    var grammar = fs.readFileSync('src/grammar.pegjs', 'utf-8');
    parser = PEG.buildParser(grammar);
  });

  describe('Basic Parsing', function() {
    it('should parse a blank string', function() {
      parser.parse("");
    });

    it('should parse a simple comment', function() {
      console.log(parser.parse("10 REM This is a comment\n"));
    });

    it('should parse a simple statement', function() {
      console.log(parser.parse("10 REM This is a comment\n"));
    });
  });

  describe('Constants', function() {
    // "Hello"
    // "$25,000.00"
    // "Number of Employees"
    it('should parse string constants');

    // -32768
    // +32767
    it('should parse integer constants');

    // 21.12
    it('should parse fixed-point constants');

    // 235.988E-7 (= .0000235988)
    // 2359E6 (= 2359000000)
    it('should parse floating-point constants');

  });

});

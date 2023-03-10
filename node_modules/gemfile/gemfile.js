'use strict';

let fs = require('fs');
let path = require('path');
let assert = require('assert');
let util = require('util');

const GEMFILE_DEFAULT_LOCATION = path.resolve(process.cwd(), 'Gemfile.lock');
const WHITESPACE = /^(\s*)/;
const GEMFILE_KEY_VALUE = /^\s*([^:(]*)\s*\:*\s*(.*)/;

module.exports = {
  interpret,
  parse,
  parseSync
};

function interpret(string) {
  assert(
    typeof string === 'string',
    'gemfile.interpret expects a UTF-8 Gemfile.lock string source.'
  );

  let line;
  let level;
  let index = 0;
  let previousWhitespace = -1;
  let gemfile = level = {};
  let lines = string.split('\n');
  let stack = [];

  while((line = lines[index++]) !== undefined) {

    // Handle depth stack changes

    let whitespace = WHITESPACE.exec(line)[1].length;

    if (whitespace <= previousWhitespace) {
      let stackIndex = stack.length - 1;

      while(stack[stackIndex] && (whitespace <= stack[stackIndex].depth)) {
        stack.pop();
        stackIndex--;
      }
    }

    // Make note of line's whitespace depth

    previousWhitespace = whitespace;

    // Handle new key/value leaf

    let parts = GEMFILE_KEY_VALUE.exec(line);
    let key = parts[1].trim();
    let value = parts[2] || '';

    if (key) {

      // Handle path traversal

      let level = gemfile;

      for (let stackIndex = 0; stackIndex < stack.length; stackIndex++) {
        if (level[stack[stackIndex].key]) {
          level = level[stack[stackIndex].key];
        }
      }

      // Handle data type inference

      let data = {};

      if (value.indexOf('/') > -1)  {
        data.path = value;
      } else if (value.indexOf('(') > -1) {
        if (value[value.length - 1] === '!') {
          value = value.substring(0, value.length - 1);
          data.outsourced = true;
        }

        if (value[1] !== ')') {
          data.version = value.substring(1, value.length - 1);
        }
      } else if (/\b[0-9a-f]{7,40}\b/.test(value)) {
        data.sha = value;
      }

      // Set key at current level

      level[key] = data;

      // Push key on stack

      stack.push({key, depth: whitespace});
    }
  }

  let keys = Object.keys(gemfile);

  let hasGemKey = keys.indexOf('GEM') > -1;
  let hasDependenciesKey = keys.indexOf('DEPENDENCIES') > -1;
  let hasPlatformsKey = keys.indexOf('PLATFORMS') > -1;

  if (!hasGemKey || !hasDependenciesKey || !hasPlatformsKey) {
    console.warn([
      'Are you sure this a Gemfile.lock?',
      'If it is, please file an issue on Github: https://github.com/treycordova/gemfile/issues.',
      'Regardless, gemfile parsed whatever you gave it.'
    ].join('\n'));
  }


  if (gemfile['BUNDLED WITH']) {
    gemfile['BUNDLED WITH'] = Object.keys(gemfile['BUNDLED WITH'])[0];
  }

  return gemfile;
}

function parse(path) {
  path = typeof path === 'string' ?
    path :
    GEMFILE_DEFAULT_LOCATION;

  return new Promise(function(resolve, reject) {
    let file = fs.readFile(path, {encoding: 'utf8'}, function(error, gemfile) {
      if (error) {
        return reject(`Couldn't find a Gemfile at the specified location: ${path}.`);
      } else {
        return resolve(interpret(gemfile));
      }
    });
  });
}

function parseSync(path) {
  path = typeof path === 'string' ?
    path :
    GEMFILE_DEFAULT_LOCATION;

  return interpret(fs.readFileSync(path, 'utf8'));
}

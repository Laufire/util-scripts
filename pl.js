#!/usr/bin/env node

// A script to help with processing inputs from stdin.

const reducers = {
	sum: (t, x) => Number(t) + Number(x),
	stitch: (t, x) => t + x,
};

const commands = {
	// Call builtin reducers.
	reduce: (input) => (lines, args) => (args.length
		? lines.reduce(reducers[input], args[0])
		: lines.reduce(reducers[input])),

	// Call the given function with lines array as the only parameter.
	eval: (input) => (lines, args) => eval(input)(lines, args),

	// Return the lines as-is.
	undefined: () => (lines) => lines.join('\n'),
};

// eslint-disable-next-line no-magic-numbers
const [command, input, ...rest] = process.argv.slice(2);

const fn = commands[command](input);
const lines = [];
let lingeringLine = '';

process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', (chunk) => {
	const chunkLines = chunk.split('\n');

	chunkLines[0] = lingeringLine + chunkLines[0];
	lingeringLine = chunkLines.pop();

	chunkLines.forEach((line) => lines.push(line));
});

process.stdin.on('end', () => {
	// eslint-disable-next-line no-console
	console.log(fn(lines, rest));
});

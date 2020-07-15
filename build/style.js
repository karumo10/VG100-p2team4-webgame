(function(scope){
'use strict';

function F(arity, fun, wrapper) {
  wrapper.a = arity;
  wrapper.f = fun;
  return wrapper;
}

function F2(fun) {
  return F(2, fun, function(a) { return function(b) { return fun(a,b); }; })
}
function F3(fun) {
  return F(3, fun, function(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  });
}
function F4(fun) {
  return F(4, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  });
}
function F5(fun) {
  return F(5, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  });
}
function F6(fun) {
  return F(6, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  });
}
function F7(fun) {
  return F(7, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  });
}
function F8(fun) {
  return F(8, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  });
}
function F9(fun) {
  return F(9, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  });
}

function A2(fun, a, b) {
  return fun.a === 2 ? fun.f(a, b) : fun(a)(b);
}
function A3(fun, a, b, c) {
  return fun.a === 3 ? fun.f(a, b, c) : fun(a)(b)(c);
}
function A4(fun, a, b, c, d) {
  return fun.a === 4 ? fun.f(a, b, c, d) : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e) {
  return fun.a === 5 ? fun.f(a, b, c, d, e) : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f) {
  return fun.a === 6 ? fun.f(a, b, c, d, e, f) : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g) {
  return fun.a === 7 ? fun.f(a, b, c, d, e, f, g) : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h) {
  return fun.a === 8 ? fun.f(a, b, c, d, e, f, g, h) : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i) {
  return fun.a === 9 ? fun.f(a, b, c, d, e, f, g, h, i) : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}

console.warn('Compiled in DEV mode. Follow the advice at https://elm-lang.org/0.19.1/optimize for better performance and smaller assets.');


var _List_Nil_UNUSED = { $: 0 };
var _List_Nil = { $: '[]' };

function _List_Cons_UNUSED(hd, tl) { return { $: 1, a: hd, b: tl }; }
function _List_Cons(hd, tl) { return { $: '::', a: hd, b: tl }; }


var _List_cons = F2(_List_Cons);

function _List_fromArray(arr)
{
	var out = _List_Nil;
	for (var i = arr.length; i--; )
	{
		out = _List_Cons(arr[i], out);
	}
	return out;
}

function _List_toArray(xs)
{
	for (var out = []; xs.b; xs = xs.b) // WHILE_CONS
	{
		out.push(xs.a);
	}
	return out;
}

var _List_map2 = F3(function(f, xs, ys)
{
	for (var arr = []; xs.b && ys.b; xs = xs.b, ys = ys.b) // WHILE_CONSES
	{
		arr.push(A2(f, xs.a, ys.a));
	}
	return _List_fromArray(arr);
});

var _List_map3 = F4(function(f, xs, ys, zs)
{
	for (var arr = []; xs.b && ys.b && zs.b; xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A3(f, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map4 = F5(function(f, ws, xs, ys, zs)
{
	for (var arr = []; ws.b && xs.b && ys.b && zs.b; ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A4(f, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map5 = F6(function(f, vs, ws, xs, ys, zs)
{
	for (var arr = []; vs.b && ws.b && xs.b && ys.b && zs.b; vs = vs.b, ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A5(f, vs.a, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_sortBy = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		return _Utils_cmp(f(a), f(b));
	}));
});

var _List_sortWith = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		var ord = A2(f, a, b);
		return ord === $elm$core$Basics$EQ ? 0 : ord === $elm$core$Basics$LT ? -1 : 1;
	}));
});



var _JsArray_empty = [];

function _JsArray_singleton(value)
{
    return [value];
}

function _JsArray_length(array)
{
    return array.length;
}

var _JsArray_initialize = F3(function(size, offset, func)
{
    var result = new Array(size);

    for (var i = 0; i < size; i++)
    {
        result[i] = func(offset + i);
    }

    return result;
});

var _JsArray_initializeFromList = F2(function (max, ls)
{
    var result = new Array(max);

    for (var i = 0; i < max && ls.b; i++)
    {
        result[i] = ls.a;
        ls = ls.b;
    }

    result.length = i;
    return _Utils_Tuple2(result, ls);
});

var _JsArray_unsafeGet = F2(function(index, array)
{
    return array[index];
});

var _JsArray_unsafeSet = F3(function(index, value, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[index] = value;
    return result;
});

var _JsArray_push = F2(function(value, array)
{
    var length = array.length;
    var result = new Array(length + 1);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[length] = value;
    return result;
});

var _JsArray_foldl = F3(function(func, acc, array)
{
    var length = array.length;

    for (var i = 0; i < length; i++)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_foldr = F3(function(func, acc, array)
{
    for (var i = array.length - 1; i >= 0; i--)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_map = F2(function(func, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = func(array[i]);
    }

    return result;
});

var _JsArray_indexedMap = F3(function(func, offset, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = A2(func, offset + i, array[i]);
    }

    return result;
});

var _JsArray_slice = F3(function(from, to, array)
{
    return array.slice(from, to);
});

var _JsArray_appendN = F3(function(n, dest, source)
{
    var destLen = dest.length;
    var itemsToCopy = n - destLen;

    if (itemsToCopy > source.length)
    {
        itemsToCopy = source.length;
    }

    var size = destLen + itemsToCopy;
    var result = new Array(size);

    for (var i = 0; i < destLen; i++)
    {
        result[i] = dest[i];
    }

    for (var i = 0; i < itemsToCopy; i++)
    {
        result[i + destLen] = source[i];
    }

    return result;
});



// LOG

var _Debug_log_UNUSED = F2(function(tag, value)
{
	return value;
});

var _Debug_log = F2(function(tag, value)
{
	console.log(tag + ': ' + _Debug_toString(value));
	return value;
});


// TODOS

function _Debug_todo(moduleName, region)
{
	return function(message) {
		_Debug_crash(8, moduleName, region, message);
	};
}

function _Debug_todoCase(moduleName, region, value)
{
	return function(message) {
		_Debug_crash(9, moduleName, region, value, message);
	};
}


// TO STRING

function _Debug_toString_UNUSED(value)
{
	return '<internals>';
}

function _Debug_toString(value)
{
	return _Debug_toAnsiString(false, value);
}

function _Debug_toAnsiString(ansi, value)
{
	if (typeof value === 'function')
	{
		return _Debug_internalColor(ansi, '<function>');
	}

	if (typeof value === 'boolean')
	{
		return _Debug_ctorColor(ansi, value ? 'True' : 'False');
	}

	if (typeof value === 'number')
	{
		return _Debug_numberColor(ansi, value + '');
	}

	if (value instanceof String)
	{
		return _Debug_charColor(ansi, "'" + _Debug_addSlashes(value, true) + "'");
	}

	if (typeof value === 'string')
	{
		return _Debug_stringColor(ansi, '"' + _Debug_addSlashes(value, false) + '"');
	}

	if (typeof value === 'object' && '$' in value)
	{
		var tag = value.$;

		if (typeof tag === 'number')
		{
			return _Debug_internalColor(ansi, '<internals>');
		}

		if (tag[0] === '#')
		{
			var output = [];
			for (var k in value)
			{
				if (k === '$') continue;
				output.push(_Debug_toAnsiString(ansi, value[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (tag === 'Set_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Set')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Set$toList(value));
		}

		if (tag === 'RBNode_elm_builtin' || tag === 'RBEmpty_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Dict')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Dict$toList(value));
		}

		if (tag === 'Array_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Array')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Array$toList(value));
		}

		if (tag === '::' || tag === '[]')
		{
			var output = '[';

			value.b && (output += _Debug_toAnsiString(ansi, value.a), value = value.b)

			for (; value.b; value = value.b) // WHILE_CONS
			{
				output += ',' + _Debug_toAnsiString(ansi, value.a);
			}
			return output + ']';
		}

		var output = '';
		for (var i in value)
		{
			if (i === '$') continue;
			var str = _Debug_toAnsiString(ansi, value[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '[' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return _Debug_ctorColor(ansi, tag) + output;
	}

	if (typeof DataView === 'function' && value instanceof DataView)
	{
		return _Debug_stringColor(ansi, '<' + value.byteLength + ' bytes>');
	}

	if (typeof File !== 'undefined' && value instanceof File)
	{
		return _Debug_internalColor(ansi, '<' + value.name + '>');
	}

	if (typeof value === 'object')
	{
		var output = [];
		for (var key in value)
		{
			var field = key[0] === '_' ? key.slice(1) : key;
			output.push(_Debug_fadeColor(ansi, field) + ' = ' + _Debug_toAnsiString(ansi, value[key]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return _Debug_internalColor(ansi, '<internals>');
}

function _Debug_addSlashes(str, isChar)
{
	var s = str
		.replace(/\\/g, '\\\\')
		.replace(/\n/g, '\\n')
		.replace(/\t/g, '\\t')
		.replace(/\r/g, '\\r')
		.replace(/\v/g, '\\v')
		.replace(/\0/g, '\\0');

	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}

function _Debug_ctorColor(ansi, string)
{
	return ansi ? '\x1b[96m' + string + '\x1b[0m' : string;
}

function _Debug_numberColor(ansi, string)
{
	return ansi ? '\x1b[95m' + string + '\x1b[0m' : string;
}

function _Debug_stringColor(ansi, string)
{
	return ansi ? '\x1b[93m' + string + '\x1b[0m' : string;
}

function _Debug_charColor(ansi, string)
{
	return ansi ? '\x1b[92m' + string + '\x1b[0m' : string;
}

function _Debug_fadeColor(ansi, string)
{
	return ansi ? '\x1b[37m' + string + '\x1b[0m' : string;
}

function _Debug_internalColor(ansi, string)
{
	return ansi ? '\x1b[36m' + string + '\x1b[0m' : string;
}

function _Debug_toHexDigit(n)
{
	return String.fromCharCode(n < 10 ? 48 + n : 55 + n);
}


// CRASH


function _Debug_crash_UNUSED(identifier)
{
	throw new Error('https://github.com/elm/core/blob/1.0.0/hints/' + identifier + '.md');
}


function _Debug_crash(identifier, fact1, fact2, fact3, fact4)
{
	switch(identifier)
	{
		case 0:
			throw new Error('What node should I take over? In JavaScript I need something like:\n\n    Elm.Main.init({\n        node: document.getElementById("elm-node")\n    })\n\nYou need to do this with any Browser.sandbox or Browser.element program.');

		case 1:
			throw new Error('Browser.application programs cannot handle URLs like this:\n\n    ' + document.location.href + '\n\nWhat is the root? The root of your file system? Try looking at this program with `elm reactor` or some other server.');

		case 2:
			var jsonErrorString = fact1;
			throw new Error('Problem with the flags given to your Elm program on initialization.\n\n' + jsonErrorString);

		case 3:
			var portName = fact1;
			throw new Error('There can only be one port named `' + portName + '`, but your program has multiple.');

		case 4:
			var portName = fact1;
			var problem = fact2;
			throw new Error('Trying to send an unexpected type of value through port `' + portName + '`:\n' + problem);

		case 5:
			throw new Error('Trying to use `(==)` on functions.\nThere is no way to know if functions are "the same" in the Elm sense.\nRead more about this at https://package.elm-lang.org/packages/elm/core/latest/Basics#== which describes why it is this way and what the better version will look like.');

		case 6:
			var moduleName = fact1;
			throw new Error('Your page is loading multiple Elm scripts with a module named ' + moduleName + '. Maybe a duplicate script is getting loaded accidentally? If not, rename one of them so I know which is which!');

		case 8:
			var moduleName = fact1;
			var region = fact2;
			var message = fact3;
			throw new Error('TODO in module `' + moduleName + '` ' + _Debug_regionToString(region) + '\n\n' + message);

		case 9:
			var moduleName = fact1;
			var region = fact2;
			var value = fact3;
			var message = fact4;
			throw new Error(
				'TODO in module `' + moduleName + '` from the `case` expression '
				+ _Debug_regionToString(region) + '\n\nIt received the following value:\n\n    '
				+ _Debug_toString(value).replace('\n', '\n    ')
				+ '\n\nBut the branch that handles it says:\n\n    ' + message.replace('\n', '\n    ')
			);

		case 10:
			throw new Error('Bug in https://github.com/elm/virtual-dom/issues');

		case 11:
			throw new Error('Cannot perform mod 0. Division by zero error.');
	}
}

function _Debug_regionToString(region)
{
	if (region.start.line === region.end.line)
	{
		return 'on line ' + region.start.line;
	}
	return 'on lines ' + region.start.line + ' through ' + region.end.line;
}



// EQUALITY

function _Utils_eq(x, y)
{
	for (
		var pair, stack = [], isEqual = _Utils_eqHelp(x, y, 0, stack);
		isEqual && (pair = stack.pop());
		isEqual = _Utils_eqHelp(pair.a, pair.b, 0, stack)
		)
	{}

	return isEqual;
}

function _Utils_eqHelp(x, y, depth, stack)
{
	if (x === y)
	{
		return true;
	}

	if (typeof x !== 'object' || x === null || y === null)
	{
		typeof x === 'function' && _Debug_crash(5);
		return false;
	}

	if (depth > 100)
	{
		stack.push(_Utils_Tuple2(x,y));
		return true;
	}

	/**/
	if (x.$ === 'Set_elm_builtin')
	{
		x = $elm$core$Set$toList(x);
		y = $elm$core$Set$toList(y);
	}
	if (x.$ === 'RBNode_elm_builtin' || x.$ === 'RBEmpty_elm_builtin')
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	/**_UNUSED/
	if (x.$ < 0)
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	for (var key in x)
	{
		if (!_Utils_eqHelp(x[key], y[key], depth + 1, stack))
		{
			return false;
		}
	}
	return true;
}

var _Utils_equal = F2(_Utils_eq);
var _Utils_notEqual = F2(function(a, b) { return !_Utils_eq(a,b); });



// COMPARISONS

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

function _Utils_cmp(x, y, ord)
{
	if (typeof x !== 'object')
	{
		return x === y ? /*EQ*/ 0 : x < y ? /*LT*/ -1 : /*GT*/ 1;
	}

	/**/
	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? 0 : a < b ? -1 : 1;
	}
	//*/

	/**_UNUSED/
	if (typeof x.$ === 'undefined')
	//*/
	/**/
	if (x.$[0] === '#')
	//*/
	{
		return (ord = _Utils_cmp(x.a, y.a))
			? ord
			: (ord = _Utils_cmp(x.b, y.b))
				? ord
				: _Utils_cmp(x.c, y.c);
	}

	// traverse conses until end of a list or a mismatch
	for (; x.b && y.b && !(ord = _Utils_cmp(x.a, y.a)); x = x.b, y = y.b) {} // WHILE_CONSES
	return ord || (x.b ? /*GT*/ 1 : y.b ? /*LT*/ -1 : /*EQ*/ 0);
}

var _Utils_lt = F2(function(a, b) { return _Utils_cmp(a, b) < 0; });
var _Utils_le = F2(function(a, b) { return _Utils_cmp(a, b) < 1; });
var _Utils_gt = F2(function(a, b) { return _Utils_cmp(a, b) > 0; });
var _Utils_ge = F2(function(a, b) { return _Utils_cmp(a, b) >= 0; });

var _Utils_compare = F2(function(x, y)
{
	var n = _Utils_cmp(x, y);
	return n < 0 ? $elm$core$Basics$LT : n ? $elm$core$Basics$GT : $elm$core$Basics$EQ;
});


// COMMON VALUES

var _Utils_Tuple0_UNUSED = 0;
var _Utils_Tuple0 = { $: '#0' };

function _Utils_Tuple2_UNUSED(a, b) { return { a: a, b: b }; }
function _Utils_Tuple2(a, b) { return { $: '#2', a: a, b: b }; }

function _Utils_Tuple3_UNUSED(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }

function _Utils_chr_UNUSED(c) { return c; }
function _Utils_chr(c) { return new String(c); }


// RECORDS

function _Utils_update(oldRecord, updatedFields)
{
	var newRecord = {};

	for (var key in oldRecord)
	{
		newRecord[key] = oldRecord[key];
	}

	for (var key in updatedFields)
	{
		newRecord[key] = updatedFields[key];
	}

	return newRecord;
}


// APPEND

var _Utils_append = F2(_Utils_ap);

function _Utils_ap(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (!xs.b)
	{
		return ys;
	}
	var root = _List_Cons(xs.a, ys);
	xs = xs.b
	for (var curr = root; xs.b; xs = xs.b) // WHILE_CONS
	{
		curr = curr.b = _List_Cons(xs.a, ys);
	}
	return root;
}



// MATH

var _Basics_add = F2(function(a, b) { return a + b; });
var _Basics_sub = F2(function(a, b) { return a - b; });
var _Basics_mul = F2(function(a, b) { return a * b; });
var _Basics_fdiv = F2(function(a, b) { return a / b; });
var _Basics_idiv = F2(function(a, b) { return (a / b) | 0; });
var _Basics_pow = F2(Math.pow);

var _Basics_remainderBy = F2(function(b, a) { return a % b; });

// https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf
var _Basics_modBy = F2(function(modulus, x)
{
	var answer = x % modulus;
	return modulus === 0
		? _Debug_crash(11)
		:
	((answer > 0 && modulus < 0) || (answer < 0 && modulus > 0))
		? answer + modulus
		: answer;
});


// TRIGONOMETRY

var _Basics_pi = Math.PI;
var _Basics_e = Math.E;
var _Basics_cos = Math.cos;
var _Basics_sin = Math.sin;
var _Basics_tan = Math.tan;
var _Basics_acos = Math.acos;
var _Basics_asin = Math.asin;
var _Basics_atan = Math.atan;
var _Basics_atan2 = F2(Math.atan2);


// MORE MATH

function _Basics_toFloat(x) { return x; }
function _Basics_truncate(n) { return n | 0; }
function _Basics_isInfinite(n) { return n === Infinity || n === -Infinity; }

var _Basics_ceiling = Math.ceil;
var _Basics_floor = Math.floor;
var _Basics_round = Math.round;
var _Basics_sqrt = Math.sqrt;
var _Basics_log = Math.log;
var _Basics_isNaN = isNaN;


// BOOLEANS

function _Basics_not(bool) { return !bool; }
var _Basics_and = F2(function(a, b) { return a && b; });
var _Basics_or  = F2(function(a, b) { return a || b; });
var _Basics_xor = F2(function(a, b) { return a !== b; });



var _String_cons = F2(function(chr, str)
{
	return chr + str;
});

function _String_uncons(string)
{
	var word = string.charCodeAt(0);
	return !isNaN(word)
		? $elm$core$Maybe$Just(
			0xD800 <= word && word <= 0xDBFF
				? _Utils_Tuple2(_Utils_chr(string[0] + string[1]), string.slice(2))
				: _Utils_Tuple2(_Utils_chr(string[0]), string.slice(1))
		)
		: $elm$core$Maybe$Nothing;
}

var _String_append = F2(function(a, b)
{
	return a + b;
});

function _String_length(str)
{
	return str.length;
}

var _String_map = F2(function(func, string)
{
	var len = string.length;
	var array = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = string.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			array[i] = func(_Utils_chr(string[i] + string[i+1]));
			i += 2;
			continue;
		}
		array[i] = func(_Utils_chr(string[i]));
		i++;
	}
	return array.join('');
});

var _String_filter = F2(function(isGood, str)
{
	var arr = [];
	var len = str.length;
	var i = 0;
	while (i < len)
	{
		var char = str[i];
		var word = str.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += str[i];
			i++;
		}

		if (isGood(_Utils_chr(char)))
		{
			arr.push(char);
		}
	}
	return arr.join('');
});

function _String_reverse(str)
{
	var len = str.length;
	var arr = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = str.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			arr[len - i] = str[i + 1];
			i++;
			arr[len - i] = str[i - 1];
			i++;
		}
		else
		{
			arr[len - i] = str[i];
			i++;
		}
	}
	return arr.join('');
}

var _String_foldl = F3(function(func, state, string)
{
	var len = string.length;
	var i = 0;
	while (i < len)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += string[i];
			i++;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_foldr = F3(function(func, state, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_split = F2(function(sep, str)
{
	return str.split(sep);
});

var _String_join = F2(function(sep, strs)
{
	return strs.join(sep);
});

var _String_slice = F3(function(start, end, str) {
	return str.slice(start, end);
});

function _String_trim(str)
{
	return str.trim();
}

function _String_trimLeft(str)
{
	return str.replace(/^\s+/, '');
}

function _String_trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function _String_words(str)
{
	return _List_fromArray(str.trim().split(/\s+/g));
}

function _String_lines(str)
{
	return _List_fromArray(str.split(/\r\n|\r|\n/g));
}

function _String_toUpper(str)
{
	return str.toUpperCase();
}

function _String_toLower(str)
{
	return str.toLowerCase();
}

var _String_any = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (isGood(_Utils_chr(char)))
		{
			return true;
		}
	}
	return false;
});

var _String_all = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (!isGood(_Utils_chr(char)))
		{
			return false;
		}
	}
	return true;
});

var _String_contains = F2(function(sub, str)
{
	return str.indexOf(sub) > -1;
});

var _String_startsWith = F2(function(sub, str)
{
	return str.indexOf(sub) === 0;
});

var _String_endsWith = F2(function(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
});

var _String_indexes = F2(function(sub, str)
{
	var subLen = sub.length;

	if (subLen < 1)
	{
		return _List_Nil;
	}

	var i = 0;
	var is = [];

	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}

	return _List_fromArray(is);
});


// TO STRING

function _String_fromNumber(number)
{
	return number + '';
}


// INT CONVERSIONS

function _String_toInt(str)
{
	var total = 0;
	var code0 = str.charCodeAt(0);
	var start = code0 == 0x2B /* + */ || code0 == 0x2D /* - */ ? 1 : 0;

	for (var i = start; i < str.length; ++i)
	{
		var code = str.charCodeAt(i);
		if (code < 0x30 || 0x39 < code)
		{
			return $elm$core$Maybe$Nothing;
		}
		total = 10 * total + code - 0x30;
	}

	return i == start
		? $elm$core$Maybe$Nothing
		: $elm$core$Maybe$Just(code0 == 0x2D ? -total : total);
}


// FLOAT CONVERSIONS

function _String_toFloat(s)
{
	// check if it is a hex, octal, or binary number
	if (s.length === 0 || /[\sxbo]/.test(s))
	{
		return $elm$core$Maybe$Nothing;
	}
	var n = +s;
	// faster isNaN check
	return n === n ? $elm$core$Maybe$Just(n) : $elm$core$Maybe$Nothing;
}

function _String_fromList(chars)
{
	return _List_toArray(chars).join('');
}




function _Char_toCode(char)
{
	var code = char.charCodeAt(0);
	if (0xD800 <= code && code <= 0xDBFF)
	{
		return (code - 0xD800) * 0x400 + char.charCodeAt(1) - 0xDC00 + 0x10000
	}
	return code;
}

function _Char_fromCode(code)
{
	return _Utils_chr(
		(code < 0 || 0x10FFFF < code)
			? '\uFFFD'
			:
		(code <= 0xFFFF)
			? String.fromCharCode(code)
			:
		(code -= 0x10000,
			String.fromCharCode(Math.floor(code / 0x400) + 0xD800, code % 0x400 + 0xDC00)
		)
	);
}

function _Char_toUpper(char)
{
	return _Utils_chr(char.toUpperCase());
}

function _Char_toLower(char)
{
	return _Utils_chr(char.toLowerCase());
}

function _Char_toLocaleUpper(char)
{
	return _Utils_chr(char.toLocaleUpperCase());
}

function _Char_toLocaleLower(char)
{
	return _Utils_chr(char.toLocaleLowerCase());
}



/**/
function _Json_errorToString(error)
{
	return $elm$json$Json$Decode$errorToString(error);
}
//*/


// CORE DECODERS

function _Json_succeed(msg)
{
	return {
		$: 0,
		a: msg
	};
}

function _Json_fail(msg)
{
	return {
		$: 1,
		a: msg
	};
}

function _Json_decodePrim(decoder)
{
	return { $: 2, b: decoder };
}

var _Json_decodeInt = _Json_decodePrim(function(value) {
	return (typeof value !== 'number')
		? _Json_expecting('an INT', value)
		:
	(-2147483647 < value && value < 2147483647 && (value | 0) === value)
		? $elm$core$Result$Ok(value)
		:
	(isFinite(value) && !(value % 1))
		? $elm$core$Result$Ok(value)
		: _Json_expecting('an INT', value);
});

var _Json_decodeBool = _Json_decodePrim(function(value) {
	return (typeof value === 'boolean')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a BOOL', value);
});

var _Json_decodeFloat = _Json_decodePrim(function(value) {
	return (typeof value === 'number')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a FLOAT', value);
});

var _Json_decodeValue = _Json_decodePrim(function(value) {
	return $elm$core$Result$Ok(_Json_wrap(value));
});

var _Json_decodeString = _Json_decodePrim(function(value) {
	return (typeof value === 'string')
		? $elm$core$Result$Ok(value)
		: (value instanceof String)
			? $elm$core$Result$Ok(value + '')
			: _Json_expecting('a STRING', value);
});

function _Json_decodeList(decoder) { return { $: 3, b: decoder }; }
function _Json_decodeArray(decoder) { return { $: 4, b: decoder }; }

function _Json_decodeNull(value) { return { $: 5, c: value }; }

var _Json_decodeField = F2(function(field, decoder)
{
	return {
		$: 6,
		d: field,
		b: decoder
	};
});

var _Json_decodeIndex = F2(function(index, decoder)
{
	return {
		$: 7,
		e: index,
		b: decoder
	};
});

function _Json_decodeKeyValuePairs(decoder)
{
	return {
		$: 8,
		b: decoder
	};
}

function _Json_mapMany(f, decoders)
{
	return {
		$: 9,
		f: f,
		g: decoders
	};
}

var _Json_andThen = F2(function(callback, decoder)
{
	return {
		$: 10,
		b: decoder,
		h: callback
	};
});

function _Json_oneOf(decoders)
{
	return {
		$: 11,
		g: decoders
	};
}


// DECODING OBJECTS

var _Json_map1 = F2(function(f, d1)
{
	return _Json_mapMany(f, [d1]);
});

var _Json_map2 = F3(function(f, d1, d2)
{
	return _Json_mapMany(f, [d1, d2]);
});

var _Json_map3 = F4(function(f, d1, d2, d3)
{
	return _Json_mapMany(f, [d1, d2, d3]);
});

var _Json_map4 = F5(function(f, d1, d2, d3, d4)
{
	return _Json_mapMany(f, [d1, d2, d3, d4]);
});

var _Json_map5 = F6(function(f, d1, d2, d3, d4, d5)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5]);
});

var _Json_map6 = F7(function(f, d1, d2, d3, d4, d5, d6)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6]);
});

var _Json_map7 = F8(function(f, d1, d2, d3, d4, d5, d6, d7)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
});

var _Json_map8 = F9(function(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
});


// DECODE

var _Json_runOnString = F2(function(decoder, string)
{
	try
	{
		var value = JSON.parse(string);
		return _Json_runHelp(decoder, value);
	}
	catch (e)
	{
		return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'This is not valid JSON! ' + e.message, _Json_wrap(string)));
	}
});

var _Json_run = F2(function(decoder, value)
{
	return _Json_runHelp(decoder, _Json_unwrap(value));
});

function _Json_runHelp(decoder, value)
{
	switch (decoder.$)
	{
		case 2:
			return decoder.b(value);

		case 5:
			return (value === null)
				? $elm$core$Result$Ok(decoder.c)
				: _Json_expecting('null', value);

		case 3:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('a LIST', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _List_fromArray);

		case 4:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _Json_toElmArray);

		case 6:
			var field = decoder.d;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return _Json_expecting('an OBJECT with a field named `' + field + '`', value);
			}
			var result = _Json_runHelp(decoder.b, value[field]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, field, result.a));

		case 7:
			var index = decoder.e;
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			if (index >= value.length)
			{
				return _Json_expecting('a LONGER array. Need index ' + index + ' but only see ' + value.length + ' entries', value);
			}
			var result = _Json_runHelp(decoder.b, value[index]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, index, result.a));

		case 8:
			if (typeof value !== 'object' || value === null || _Json_isArray(value))
			{
				return _Json_expecting('an OBJECT', value);
			}

			var keyValuePairs = _List_Nil;
			// TODO test perf of Object.keys and switch when support is good enough
			for (var key in value)
			{
				if (value.hasOwnProperty(key))
				{
					var result = _Json_runHelp(decoder.b, value[key]);
					if (!$elm$core$Result$isOk(result))
					{
						return $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, key, result.a));
					}
					keyValuePairs = _List_Cons(_Utils_Tuple2(key, result.a), keyValuePairs);
				}
			}
			return $elm$core$Result$Ok($elm$core$List$reverse(keyValuePairs));

		case 9:
			var answer = decoder.f;
			var decoders = decoder.g;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = _Json_runHelp(decoders[i], value);
				if (!$elm$core$Result$isOk(result))
				{
					return result;
				}
				answer = answer(result.a);
			}
			return $elm$core$Result$Ok(answer);

		case 10:
			var result = _Json_runHelp(decoder.b, value);
			return (!$elm$core$Result$isOk(result))
				? result
				: _Json_runHelp(decoder.h(result.a), value);

		case 11:
			var errors = _List_Nil;
			for (var temp = decoder.g; temp.b; temp = temp.b) // WHILE_CONS
			{
				var result = _Json_runHelp(temp.a, value);
				if ($elm$core$Result$isOk(result))
				{
					return result;
				}
				errors = _List_Cons(result.a, errors);
			}
			return $elm$core$Result$Err($elm$json$Json$Decode$OneOf($elm$core$List$reverse(errors)));

		case 1:
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, decoder.a, _Json_wrap(value)));

		case 0:
			return $elm$core$Result$Ok(decoder.a);
	}
}

function _Json_runArrayDecoder(decoder, value, toElmValue)
{
	var len = value.length;
	var array = new Array(len);
	for (var i = 0; i < len; i++)
	{
		var result = _Json_runHelp(decoder, value[i]);
		if (!$elm$core$Result$isOk(result))
		{
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, i, result.a));
		}
		array[i] = result.a;
	}
	return $elm$core$Result$Ok(toElmValue(array));
}

function _Json_isArray(value)
{
	return Array.isArray(value) || (typeof FileList !== 'undefined' && value instanceof FileList);
}

function _Json_toElmArray(array)
{
	return A2($elm$core$Array$initialize, array.length, function(i) { return array[i]; });
}

function _Json_expecting(type, value)
{
	return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'Expecting ' + type, _Json_wrap(value)));
}


// EQUALITY

function _Json_equality(x, y)
{
	if (x === y)
	{
		return true;
	}

	if (x.$ !== y.$)
	{
		return false;
	}

	switch (x.$)
	{
		case 0:
		case 1:
			return x.a === y.a;

		case 2:
			return x.b === y.b;

		case 5:
			return x.c === y.c;

		case 3:
		case 4:
		case 8:
			return _Json_equality(x.b, y.b);

		case 6:
			return x.d === y.d && _Json_equality(x.b, y.b);

		case 7:
			return x.e === y.e && _Json_equality(x.b, y.b);

		case 9:
			return x.f === y.f && _Json_listEquality(x.g, y.g);

		case 10:
			return x.h === y.h && _Json_equality(x.b, y.b);

		case 11:
			return _Json_listEquality(x.g, y.g);
	}
}

function _Json_listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!_Json_equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

var _Json_encode = F2(function(indentLevel, value)
{
	return JSON.stringify(_Json_unwrap(value), null, indentLevel) + '';
});

function _Json_wrap(value) { return { $: 0, a: value }; }
function _Json_unwrap(value) { return value.a; }

function _Json_wrap_UNUSED(value) { return value; }
function _Json_unwrap_UNUSED(value) { return value; }

function _Json_emptyArray() { return []; }
function _Json_emptyObject() { return {}; }

var _Json_addField = F3(function(key, value, object)
{
	object[key] = _Json_unwrap(value);
	return object;
});

function _Json_addEntry(func)
{
	return F2(function(entry, array)
	{
		array.push(_Json_unwrap(func(entry)));
		return array;
	});
}

var _Json_encodeNull = _Json_wrap(null);




// STRINGS


var _Parser_isSubString = F5(function(smallString, offset, row, col, bigString)
{
	var smallLength = smallString.length;
	var isGood = offset + smallLength <= bigString.length;

	for (var i = 0; isGood && i < smallLength; )
	{
		var code = bigString.charCodeAt(offset);
		isGood =
			smallString[i++] === bigString[offset++]
			&& (
				code === 0x000A /* \n */
					? ( row++, col=1 )
					: ( col++, (code & 0xF800) === 0xD800 ? smallString[i++] === bigString[offset++] : 1 )
			)
	}

	return _Utils_Tuple3(isGood ? offset : -1, row, col);
});



// CHARS


var _Parser_isSubChar = F3(function(predicate, offset, string)
{
	return (
		string.length <= offset
			? -1
			:
		(string.charCodeAt(offset) & 0xF800) === 0xD800
			? (predicate(_Utils_chr(string.substr(offset, 2))) ? offset + 2 : -1)
			:
		(predicate(_Utils_chr(string[offset]))
			? ((string[offset] === '\n') ? -2 : (offset + 1))
			: -1
		)
	);
});


var _Parser_isAsciiCode = F3(function(code, offset, string)
{
	return string.charCodeAt(offset) === code;
});



// NUMBERS


var _Parser_chompBase10 = F2(function(offset, string)
{
	for (; offset < string.length; offset++)
	{
		var code = string.charCodeAt(offset);
		if (code < 0x30 || 0x39 < code)
		{
			return offset;
		}
	}
	return offset;
});


var _Parser_consumeBase = F3(function(base, offset, string)
{
	for (var total = 0; offset < string.length; offset++)
	{
		var digit = string.charCodeAt(offset) - 0x30;
		if (digit < 0 || base <= digit) break;
		total = base * total + digit;
	}
	return _Utils_Tuple2(offset, total);
});


var _Parser_consumeBase16 = F2(function(offset, string)
{
	for (var total = 0; offset < string.length; offset++)
	{
		var code = string.charCodeAt(offset);
		if (0x30 <= code && code <= 0x39)
		{
			total = 16 * total + code - 0x30;
		}
		else if (0x41 <= code && code <= 0x46)
		{
			total = 16 * total + code - 55;
		}
		else if (0x61 <= code && code <= 0x66)
		{
			total = 16 * total + code - 87;
		}
		else
		{
			break;
		}
	}
	return _Utils_Tuple2(offset, total);
});



// FIND STRING


var _Parser_findSubString = F5(function(smallString, offset, row, col, bigString)
{
	var newOffset = bigString.indexOf(smallString, offset);
	var target = newOffset < 0 ? bigString.length : newOffset + smallString.length;

	while (offset < target)
	{
		var code = bigString.charCodeAt(offset++);
		code === 0x000A /* \n */
			? ( col=1, row++ )
			: ( col++, (code & 0xF800) === 0xD800 && offset++ )
	}

	return _Utils_Tuple3(newOffset, row, col);
});



var _Bitwise_and = F2(function(a, b)
{
	return a & b;
});

var _Bitwise_or = F2(function(a, b)
{
	return a | b;
});

var _Bitwise_xor = F2(function(a, b)
{
	return a ^ b;
});

function _Bitwise_complement(a)
{
	return ~a;
};

var _Bitwise_shiftLeftBy = F2(function(offset, a)
{
	return a << offset;
});

var _Bitwise_shiftRightBy = F2(function(offset, a)
{
	return a >> offset;
});

var _Bitwise_shiftRightZfBy = F2(function(offset, a)
{
	return a >>> offset;
});



// TASKS

function _Scheduler_succeed(value)
{
	return {
		$: 0,
		a: value
	};
}

function _Scheduler_fail(error)
{
	return {
		$: 1,
		a: error
	};
}

function _Scheduler_binding(callback)
{
	return {
		$: 2,
		b: callback,
		c: null
	};
}

var _Scheduler_andThen = F2(function(callback, task)
{
	return {
		$: 3,
		b: callback,
		d: task
	};
});

var _Scheduler_onError = F2(function(callback, task)
{
	return {
		$: 4,
		b: callback,
		d: task
	};
});

function _Scheduler_receive(callback)
{
	return {
		$: 5,
		b: callback
	};
}


// PROCESSES

var _Scheduler_guid = 0;

function _Scheduler_rawSpawn(task)
{
	var proc = {
		$: 0,
		e: _Scheduler_guid++,
		f: task,
		g: null,
		h: []
	};

	_Scheduler_enqueue(proc);

	return proc;
}

function _Scheduler_spawn(task)
{
	return _Scheduler_binding(function(callback) {
		callback(_Scheduler_succeed(_Scheduler_rawSpawn(task)));
	});
}

function _Scheduler_rawSend(proc, msg)
{
	proc.h.push(msg);
	_Scheduler_enqueue(proc);
}

var _Scheduler_send = F2(function(proc, msg)
{
	return _Scheduler_binding(function(callback) {
		_Scheduler_rawSend(proc, msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});

function _Scheduler_kill(proc)
{
	return _Scheduler_binding(function(callback) {
		var task = proc.f;
		if (task.$ === 2 && task.c)
		{
			task.c();
		}

		proc.f = null;

		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}


/* STEP PROCESSES

type alias Process =
  { $ : tag
  , id : unique_id
  , root : Task
  , stack : null | { $: SUCCEED | FAIL, a: callback, b: stack }
  , mailbox : [msg]
  }

*/


var _Scheduler_working = false;
var _Scheduler_queue = [];


function _Scheduler_enqueue(proc)
{
	_Scheduler_queue.push(proc);
	if (_Scheduler_working)
	{
		return;
	}
	_Scheduler_working = true;
	while (proc = _Scheduler_queue.shift())
	{
		_Scheduler_step(proc);
	}
	_Scheduler_working = false;
}


function _Scheduler_step(proc)
{
	while (proc.f)
	{
		var rootTag = proc.f.$;
		if (rootTag === 0 || rootTag === 1)
		{
			while (proc.g && proc.g.$ !== rootTag)
			{
				proc.g = proc.g.i;
			}
			if (!proc.g)
			{
				return;
			}
			proc.f = proc.g.b(proc.f.a);
			proc.g = proc.g.i;
		}
		else if (rootTag === 2)
		{
			proc.f.c = proc.f.b(function(newRoot) {
				proc.f = newRoot;
				_Scheduler_enqueue(proc);
			});
			return;
		}
		else if (rootTag === 5)
		{
			if (proc.h.length === 0)
			{
				return;
			}
			proc.f = proc.f.b(proc.h.shift());
		}
		else // if (rootTag === 3 || rootTag === 4)
		{
			proc.g = {
				$: rootTag === 3 ? 0 : 1,
				b: proc.f.b,
				i: proc.g
			};
			proc.f = proc.f.d;
		}
	}
}



function _Process_sleep(time)
{
	return _Scheduler_binding(function(callback) {
		var id = setTimeout(function() {
			callback(_Scheduler_succeed(_Utils_Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}




// PROGRAMS


var _Platform_worker = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function() { return function() {} }
	);
});



// INITIALIZE A PROGRAM


function _Platform_initialize(flagDecoder, args, init, update, subscriptions, stepperBuilder)
{
	var result = A2(_Json_run, flagDecoder, _Json_wrap(args ? args['flags'] : undefined));
	$elm$core$Result$isOk(result) || _Debug_crash(2 /**/, _Json_errorToString(result.a) /**/);
	var managers = {};
	var initPair = init(result.a);
	var model = initPair.a;
	var stepper = stepperBuilder(sendToApp, model);
	var ports = _Platform_setupEffects(managers, sendToApp);

	function sendToApp(msg, viewMetadata)
	{
		var pair = A2(update, msg, model);
		stepper(model = pair.a, viewMetadata);
		_Platform_enqueueEffects(managers, pair.b, subscriptions(model));
	}

	_Platform_enqueueEffects(managers, initPair.b, subscriptions(model));

	return ports ? { ports: ports } : {};
}



// TRACK PRELOADS
//
// This is used by code in elm/browser and elm/http
// to register any HTTP requests that are triggered by init.
//


var _Platform_preload;


function _Platform_registerPreload(url)
{
	_Platform_preload.add(url);
}



// EFFECT MANAGERS


var _Platform_effectManagers = {};


function _Platform_setupEffects(managers, sendToApp)
{
	var ports;

	// setup all necessary effect managers
	for (var key in _Platform_effectManagers)
	{
		var manager = _Platform_effectManagers[key];

		if (manager.a)
		{
			ports = ports || {};
			ports[key] = manager.a(key, sendToApp);
		}

		managers[key] = _Platform_instantiateManager(manager, sendToApp);
	}

	return ports;
}


function _Platform_createManager(init, onEffects, onSelfMsg, cmdMap, subMap)
{
	return {
		b: init,
		c: onEffects,
		d: onSelfMsg,
		e: cmdMap,
		f: subMap
	};
}


function _Platform_instantiateManager(info, sendToApp)
{
	var router = {
		g: sendToApp,
		h: undefined
	};

	var onEffects = info.c;
	var onSelfMsg = info.d;
	var cmdMap = info.e;
	var subMap = info.f;

	function loop(state)
	{
		return A2(_Scheduler_andThen, loop, _Scheduler_receive(function(msg)
		{
			var value = msg.a;

			if (msg.$ === 0)
			{
				return A3(onSelfMsg, router, value, state);
			}

			return cmdMap && subMap
				? A4(onEffects, router, value.i, value.j, state)
				: A3(onEffects, router, cmdMap ? value.i : value.j, state);
		}));
	}

	return router.h = _Scheduler_rawSpawn(A2(_Scheduler_andThen, loop, info.b));
}



// ROUTING


var _Platform_sendToApp = F2(function(router, msg)
{
	return _Scheduler_binding(function(callback)
	{
		router.g(msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});


var _Platform_sendToSelf = F2(function(router, msg)
{
	return A2(_Scheduler_send, router.h, {
		$: 0,
		a: msg
	});
});



// BAGS


function _Platform_leaf(home)
{
	return function(value)
	{
		return {
			$: 1,
			k: home,
			l: value
		};
	};
}


function _Platform_batch(list)
{
	return {
		$: 2,
		m: list
	};
}


var _Platform_map = F2(function(tagger, bag)
{
	return {
		$: 3,
		n: tagger,
		o: bag
	}
});



// PIPE BAGS INTO EFFECT MANAGERS
//
// Effects must be queued!
//
// Say your init contains a synchronous command, like Time.now or Time.here
//
//   - This will produce a batch of effects (FX_1)
//   - The synchronous task triggers the subsequent `update` call
//   - This will produce a batch of effects (FX_2)
//
// If we just start dispatching FX_2, subscriptions from FX_2 can be processed
// before subscriptions from FX_1. No good! Earlier versions of this code had
// this problem, leading to these reports:
//
//   https://github.com/elm/core/issues/980
//   https://github.com/elm/core/pull/981
//   https://github.com/elm/compiler/issues/1776
//
// The queue is necessary to avoid ordering issues for synchronous commands.


// Why use true/false here? Why not just check the length of the queue?
// The goal is to detect "are we currently dispatching effects?" If we
// are, we need to bail and let the ongoing while loop handle things.
//
// Now say the queue has 1 element. When we dequeue the final element,
// the queue will be empty, but we are still actively dispatching effects.
// So you could get queue jumping in a really tricky category of cases.
//
var _Platform_effectsQueue = [];
var _Platform_effectsActive = false;


function _Platform_enqueueEffects(managers, cmdBag, subBag)
{
	_Platform_effectsQueue.push({ p: managers, q: cmdBag, r: subBag });

	if (_Platform_effectsActive) return;

	_Platform_effectsActive = true;
	for (var fx; fx = _Platform_effectsQueue.shift(); )
	{
		_Platform_dispatchEffects(fx.p, fx.q, fx.r);
	}
	_Platform_effectsActive = false;
}


function _Platform_dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	_Platform_gatherEffects(true, cmdBag, effectsDict, null);
	_Platform_gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		_Scheduler_rawSend(managers[home], {
			$: 'fx',
			a: effectsDict[home] || { i: _List_Nil, j: _List_Nil }
		});
	}
}


function _Platform_gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.$)
	{
		case 1:
			var home = bag.k;
			var effect = _Platform_toEffect(isCmd, home, taggers, bag.l);
			effectsDict[home] = _Platform_insert(isCmd, effect, effectsDict[home]);
			return;

		case 2:
			for (var list = bag.m; list.b; list = list.b) // WHILE_CONS
			{
				_Platform_gatherEffects(isCmd, list.a, effectsDict, taggers);
			}
			return;

		case 3:
			_Platform_gatherEffects(isCmd, bag.o, effectsDict, {
				s: bag.n,
				t: taggers
			});
			return;
	}
}


function _Platform_toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		for (var temp = taggers; temp; temp = temp.t)
		{
			x = temp.s(x);
		}
		return x;
	}

	var map = isCmd
		? _Platform_effectManagers[home].e
		: _Platform_effectManagers[home].f;

	return A2(map, applyTaggers, value)
}


function _Platform_insert(isCmd, newEffect, effects)
{
	effects = effects || { i: _List_Nil, j: _List_Nil };

	isCmd
		? (effects.i = _List_Cons(newEffect, effects.i))
		: (effects.j = _List_Cons(newEffect, effects.j));

	return effects;
}



// PORTS


function _Platform_checkPortName(name)
{
	if (_Platform_effectManagers[name])
	{
		_Debug_crash(3, name)
	}
}



// OUTGOING PORTS


function _Platform_outgoingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		e: _Platform_outgoingPortMap,
		u: converter,
		a: _Platform_setupOutgoingPort
	};
	return _Platform_leaf(name);
}


var _Platform_outgoingPortMap = F2(function(tagger, value) { return value; });


function _Platform_setupOutgoingPort(name)
{
	var subs = [];
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Process_sleep(0);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, cmdList, state)
	{
		for ( ; cmdList.b; cmdList = cmdList.b) // WHILE_CONS
		{
			// grab a separate reference to subs in case unsubscribe is called
			var currentSubs = subs;
			var value = _Json_unwrap(converter(cmdList.a));
			for (var i = 0; i < currentSubs.length; i++)
			{
				currentSubs[i](value);
			}
		}
		return init;
	});

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		// copy subs into a new array in case unsubscribe is called within a
		// subscribed callback
		subs = subs.slice();
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}



// INCOMING PORTS


function _Platform_incomingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		f: _Platform_incomingPortMap,
		u: converter,
		a: _Platform_setupIncomingPort
	};
	return _Platform_leaf(name);
}


var _Platform_incomingPortMap = F2(function(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});


function _Platform_setupIncomingPort(name, sendToApp)
{
	var subs = _List_Nil;
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Scheduler_succeed(null);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, subList, state)
	{
		subs = subList;
		return init;
	});

	// PUBLIC API

	function send(incomingValue)
	{
		var result = A2(_Json_run, converter, _Json_wrap(incomingValue));

		$elm$core$Result$isOk(result) || _Debug_crash(4, name, result.a);

		var value = result.a;
		for (var temp = subs; temp.b; temp = temp.b) // WHILE_CONS
		{
			sendToApp(temp.a(value));
		}
	}

	return { send: send };
}



// EXPORT ELM MODULES
//
// Have DEBUG and PROD versions so that we can (1) give nicer errors in
// debug mode and (2) not pay for the bits needed for that in prod mode.
//


function _Platform_export_UNUSED(exports)
{
	scope['Elm']
		? _Platform_mergeExportsProd(scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsProd(obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6)
				: _Platform_mergeExportsProd(obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}


function _Platform_export(exports)
{
	scope['Elm']
		? _Platform_mergeExportsDebug('Elm', scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsDebug(moduleName, obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6, moduleName)
				: _Platform_mergeExportsDebug(moduleName + '.' + name, obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}




// HELPERS


var _VirtualDom_divertHrefToApp;

var _VirtualDom_doc = typeof document !== 'undefined' ? document : {};


function _VirtualDom_appendChild(parent, child)
{
	parent.appendChild(child);
}

var _VirtualDom_init = F4(function(virtualNode, flagDecoder, debugMetadata, args)
{
	// NOTE: this function needs _Platform_export available to work

	/**_UNUSED/
	var node = args['node'];
	//*/
	/**/
	var node = args && args['node'] ? args['node'] : _Debug_crash(0);
	//*/

	node.parentNode.replaceChild(
		_VirtualDom_render(virtualNode, function() {}),
		node
	);

	return {};
});



// TEXT


function _VirtualDom_text(string)
{
	return {
		$: 0,
		a: string
	};
}



// NODE


var _VirtualDom_nodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 1,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_node = _VirtualDom_nodeNS(undefined);



// KEYED NODE


var _VirtualDom_keyedNodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 2,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_keyedNode = _VirtualDom_keyedNodeNS(undefined);



// CUSTOM


function _VirtualDom_custom(factList, model, render, diff)
{
	return {
		$: 3,
		d: _VirtualDom_organizeFacts(factList),
		g: model,
		h: render,
		i: diff
	};
}



// MAP


var _VirtualDom_map = F2(function(tagger, node)
{
	return {
		$: 4,
		j: tagger,
		k: node,
		b: 1 + (node.b || 0)
	};
});



// LAZY


function _VirtualDom_thunk(refs, thunk)
{
	return {
		$: 5,
		l: refs,
		m: thunk,
		k: undefined
	};
}

var _VirtualDom_lazy = F2(function(func, a)
{
	return _VirtualDom_thunk([func, a], function() {
		return func(a);
	});
});

var _VirtualDom_lazy2 = F3(function(func, a, b)
{
	return _VirtualDom_thunk([func, a, b], function() {
		return A2(func, a, b);
	});
});

var _VirtualDom_lazy3 = F4(function(func, a, b, c)
{
	return _VirtualDom_thunk([func, a, b, c], function() {
		return A3(func, a, b, c);
	});
});

var _VirtualDom_lazy4 = F5(function(func, a, b, c, d)
{
	return _VirtualDom_thunk([func, a, b, c, d], function() {
		return A4(func, a, b, c, d);
	});
});

var _VirtualDom_lazy5 = F6(function(func, a, b, c, d, e)
{
	return _VirtualDom_thunk([func, a, b, c, d, e], function() {
		return A5(func, a, b, c, d, e);
	});
});

var _VirtualDom_lazy6 = F7(function(func, a, b, c, d, e, f)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f], function() {
		return A6(func, a, b, c, d, e, f);
	});
});

var _VirtualDom_lazy7 = F8(function(func, a, b, c, d, e, f, g)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g], function() {
		return A7(func, a, b, c, d, e, f, g);
	});
});

var _VirtualDom_lazy8 = F9(function(func, a, b, c, d, e, f, g, h)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g, h], function() {
		return A8(func, a, b, c, d, e, f, g, h);
	});
});



// FACTS


var _VirtualDom_on = F2(function(key, handler)
{
	return {
		$: 'a0',
		n: key,
		o: handler
	};
});
var _VirtualDom_style = F2(function(key, value)
{
	return {
		$: 'a1',
		n: key,
		o: value
	};
});
var _VirtualDom_property = F2(function(key, value)
{
	return {
		$: 'a2',
		n: key,
		o: value
	};
});
var _VirtualDom_attribute = F2(function(key, value)
{
	return {
		$: 'a3',
		n: key,
		o: value
	};
});
var _VirtualDom_attributeNS = F3(function(namespace, key, value)
{
	return {
		$: 'a4',
		n: key,
		o: { f: namespace, o: value }
	};
});



// XSS ATTACK VECTOR CHECKS


function _VirtualDom_noScript(tag)
{
	return tag == 'script' ? 'p' : tag;
}

function _VirtualDom_noOnOrFormAction(key)
{
	return /^(on|formAction$)/i.test(key) ? 'data-' + key : key;
}

function _VirtualDom_noInnerHtmlOrFormAction(key)
{
	return key == 'innerHTML' || key == 'formAction' ? 'data-' + key : key;
}

function _VirtualDom_noJavaScriptUri_UNUSED(value)
{
	return /^javascript:/i.test(value.replace(/\s/g,'')) ? '' : value;
}

function _VirtualDom_noJavaScriptUri(value)
{
	return /^javascript:/i.test(value.replace(/\s/g,''))
		? 'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'
		: value;
}

function _VirtualDom_noJavaScriptOrHtmlUri_UNUSED(value)
{
	return /^\s*(javascript:|data:text\/html)/i.test(value) ? '' : value;
}

function _VirtualDom_noJavaScriptOrHtmlUri(value)
{
	return /^\s*(javascript:|data:text\/html)/i.test(value)
		? 'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'
		: value;
}



// MAP FACTS


var _VirtualDom_mapAttribute = F2(function(func, attr)
{
	return (attr.$ === 'a0')
		? A2(_VirtualDom_on, attr.n, _VirtualDom_mapHandler(func, attr.o))
		: attr;
});

function _VirtualDom_mapHandler(func, handler)
{
	var tag = $elm$virtual_dom$VirtualDom$toHandlerInt(handler);

	// 0 = Normal
	// 1 = MayStopPropagation
	// 2 = MayPreventDefault
	// 3 = Custom

	return {
		$: handler.$,
		a:
			!tag
				? A2($elm$json$Json$Decode$map, func, handler.a)
				:
			A3($elm$json$Json$Decode$map2,
				tag < 3
					? _VirtualDom_mapEventTuple
					: _VirtualDom_mapEventRecord,
				$elm$json$Json$Decode$succeed(func),
				handler.a
			)
	};
}

var _VirtualDom_mapEventTuple = F2(function(func, tuple)
{
	return _Utils_Tuple2(func(tuple.a), tuple.b);
});

var _VirtualDom_mapEventRecord = F2(function(func, record)
{
	return {
		message: func(record.message),
		stopPropagation: record.stopPropagation,
		preventDefault: record.preventDefault
	}
});



// ORGANIZE FACTS


function _VirtualDom_organizeFacts(factList)
{
	for (var facts = {}; factList.b; factList = factList.b) // WHILE_CONS
	{
		var entry = factList.a;

		var tag = entry.$;
		var key = entry.n;
		var value = entry.o;

		if (tag === 'a2')
		{
			(key === 'className')
				? _VirtualDom_addClass(facts, key, _Json_unwrap(value))
				: facts[key] = _Json_unwrap(value);

			continue;
		}

		var subFacts = facts[tag] || (facts[tag] = {});
		(tag === 'a3' && key === 'class')
			? _VirtualDom_addClass(subFacts, key, value)
			: subFacts[key] = value;
	}

	return facts;
}

function _VirtualDom_addClass(object, key, newClass)
{
	var classes = object[key];
	object[key] = classes ? classes + ' ' + newClass : newClass;
}



// RENDER


function _VirtualDom_render(vNode, eventNode)
{
	var tag = vNode.$;

	if (tag === 5)
	{
		return _VirtualDom_render(vNode.k || (vNode.k = vNode.m()), eventNode);
	}

	if (tag === 0)
	{
		return _VirtualDom_doc.createTextNode(vNode.a);
	}

	if (tag === 4)
	{
		var subNode = vNode.k;
		var tagger = vNode.j;

		while (subNode.$ === 4)
		{
			typeof tagger !== 'object'
				? tagger = [tagger, subNode.j]
				: tagger.push(subNode.j);

			subNode = subNode.k;
		}

		var subEventRoot = { j: tagger, p: eventNode };
		var domNode = _VirtualDom_render(subNode, subEventRoot);
		domNode.elm_event_node_ref = subEventRoot;
		return domNode;
	}

	if (tag === 3)
	{
		var domNode = vNode.h(vNode.g);
		_VirtualDom_applyFacts(domNode, eventNode, vNode.d);
		return domNode;
	}

	// at this point `tag` must be 1 or 2

	var domNode = vNode.f
		? _VirtualDom_doc.createElementNS(vNode.f, vNode.c)
		: _VirtualDom_doc.createElement(vNode.c);

	if (_VirtualDom_divertHrefToApp && vNode.c == 'a')
	{
		domNode.addEventListener('click', _VirtualDom_divertHrefToApp(domNode));
	}

	_VirtualDom_applyFacts(domNode, eventNode, vNode.d);

	for (var kids = vNode.e, i = 0; i < kids.length; i++)
	{
		_VirtualDom_appendChild(domNode, _VirtualDom_render(tag === 1 ? kids[i] : kids[i].b, eventNode));
	}

	return domNode;
}



// APPLY FACTS


function _VirtualDom_applyFacts(domNode, eventNode, facts)
{
	for (var key in facts)
	{
		var value = facts[key];

		key === 'a1'
			? _VirtualDom_applyStyles(domNode, value)
			:
		key === 'a0'
			? _VirtualDom_applyEvents(domNode, eventNode, value)
			:
		key === 'a3'
			? _VirtualDom_applyAttrs(domNode, value)
			:
		key === 'a4'
			? _VirtualDom_applyAttrsNS(domNode, value)
			:
		((key !== 'value' && key !== 'checked') || domNode[key] !== value) && (domNode[key] = value);
	}
}



// APPLY STYLES


function _VirtualDom_applyStyles(domNode, styles)
{
	var domNodeStyle = domNode.style;

	for (var key in styles)
	{
		domNodeStyle[key] = styles[key];
	}
}



// APPLY ATTRS


function _VirtualDom_applyAttrs(domNode, attrs)
{
	for (var key in attrs)
	{
		var value = attrs[key];
		typeof value !== 'undefined'
			? domNode.setAttribute(key, value)
			: domNode.removeAttribute(key);
	}
}



// APPLY NAMESPACED ATTRS


function _VirtualDom_applyAttrsNS(domNode, nsAttrs)
{
	for (var key in nsAttrs)
	{
		var pair = nsAttrs[key];
		var namespace = pair.f;
		var value = pair.o;

		typeof value !== 'undefined'
			? domNode.setAttributeNS(namespace, key, value)
			: domNode.removeAttributeNS(namespace, key);
	}
}



// APPLY EVENTS


function _VirtualDom_applyEvents(domNode, eventNode, events)
{
	var allCallbacks = domNode.elmFs || (domNode.elmFs = {});

	for (var key in events)
	{
		var newHandler = events[key];
		var oldCallback = allCallbacks[key];

		if (!newHandler)
		{
			domNode.removeEventListener(key, oldCallback);
			allCallbacks[key] = undefined;
			continue;
		}

		if (oldCallback)
		{
			var oldHandler = oldCallback.q;
			if (oldHandler.$ === newHandler.$)
			{
				oldCallback.q = newHandler;
				continue;
			}
			domNode.removeEventListener(key, oldCallback);
		}

		oldCallback = _VirtualDom_makeCallback(eventNode, newHandler);
		domNode.addEventListener(key, oldCallback,
			_VirtualDom_passiveSupported
			&& { passive: $elm$virtual_dom$VirtualDom$toHandlerInt(newHandler) < 2 }
		);
		allCallbacks[key] = oldCallback;
	}
}



// PASSIVE EVENTS


var _VirtualDom_passiveSupported;

try
{
	window.addEventListener('t', null, Object.defineProperty({}, 'passive', {
		get: function() { _VirtualDom_passiveSupported = true; }
	}));
}
catch(e) {}



// EVENT HANDLERS


function _VirtualDom_makeCallback(eventNode, initialHandler)
{
	function callback(event)
	{
		var handler = callback.q;
		var result = _Json_runHelp(handler.a, event);

		if (!$elm$core$Result$isOk(result))
		{
			return;
		}

		var tag = $elm$virtual_dom$VirtualDom$toHandlerInt(handler);

		// 0 = Normal
		// 1 = MayStopPropagation
		// 2 = MayPreventDefault
		// 3 = Custom

		var value = result.a;
		var message = !tag ? value : tag < 3 ? value.a : value.message;
		var stopPropagation = tag == 1 ? value.b : tag == 3 && value.stopPropagation;
		var currentEventNode = (
			stopPropagation && event.stopPropagation(),
			(tag == 2 ? value.b : tag == 3 && value.preventDefault) && event.preventDefault(),
			eventNode
		);
		var tagger;
		var i;
		while (tagger = currentEventNode.j)
		{
			if (typeof tagger == 'function')
			{
				message = tagger(message);
			}
			else
			{
				for (var i = tagger.length; i--; )
				{
					message = tagger[i](message);
				}
			}
			currentEventNode = currentEventNode.p;
		}
		currentEventNode(message, stopPropagation); // stopPropagation implies isSync
	}

	callback.q = initialHandler;

	return callback;
}

function _VirtualDom_equalEvents(x, y)
{
	return x.$ == y.$ && _Json_equality(x.a, y.a);
}



// DIFF


// TODO: Should we do patches like in iOS?
//
// type Patch
//   = At Int Patch
//   | Batch (List Patch)
//   | Change ...
//
// How could it not be better?
//
function _VirtualDom_diff(x, y)
{
	var patches = [];
	_VirtualDom_diffHelp(x, y, patches, 0);
	return patches;
}


function _VirtualDom_pushPatch(patches, type, index, data)
{
	var patch = {
		$: type,
		r: index,
		s: data,
		t: undefined,
		u: undefined
	};
	patches.push(patch);
	return patch;
}


function _VirtualDom_diffHelp(x, y, patches, index)
{
	if (x === y)
	{
		return;
	}

	var xType = x.$;
	var yType = y.$;

	// Bail if you run into different types of nodes. Implies that the
	// structure has changed significantly and it's not worth a diff.
	if (xType !== yType)
	{
		if (xType === 1 && yType === 2)
		{
			y = _VirtualDom_dekey(y);
			yType = 1;
		}
		else
		{
			_VirtualDom_pushPatch(patches, 0, index, y);
			return;
		}
	}

	// Now we know that both nodes are the same $.
	switch (yType)
	{
		case 5:
			var xRefs = x.l;
			var yRefs = y.l;
			var i = xRefs.length;
			var same = i === yRefs.length;
			while (same && i--)
			{
				same = xRefs[i] === yRefs[i];
			}
			if (same)
			{
				y.k = x.k;
				return;
			}
			y.k = y.m();
			var subPatches = [];
			_VirtualDom_diffHelp(x.k, y.k, subPatches, 0);
			subPatches.length > 0 && _VirtualDom_pushPatch(patches, 1, index, subPatches);
			return;

		case 4:
			// gather nested taggers
			var xTaggers = x.j;
			var yTaggers = y.j;
			var nesting = false;

			var xSubNode = x.k;
			while (xSubNode.$ === 4)
			{
				nesting = true;

				typeof xTaggers !== 'object'
					? xTaggers = [xTaggers, xSubNode.j]
					: xTaggers.push(xSubNode.j);

				xSubNode = xSubNode.k;
			}

			var ySubNode = y.k;
			while (ySubNode.$ === 4)
			{
				nesting = true;

				typeof yTaggers !== 'object'
					? yTaggers = [yTaggers, ySubNode.j]
					: yTaggers.push(ySubNode.j);

				ySubNode = ySubNode.k;
			}

			// Just bail if different numbers of taggers. This implies the
			// structure of the virtual DOM has changed.
			if (nesting && xTaggers.length !== yTaggers.length)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			// check if taggers are "the same"
			if (nesting ? !_VirtualDom_pairwiseRefEqual(xTaggers, yTaggers) : xTaggers !== yTaggers)
			{
				_VirtualDom_pushPatch(patches, 2, index, yTaggers);
			}

			// diff everything below the taggers
			_VirtualDom_diffHelp(xSubNode, ySubNode, patches, index + 1);
			return;

		case 0:
			if (x.a !== y.a)
			{
				_VirtualDom_pushPatch(patches, 3, index, y.a);
			}
			return;

		case 1:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKids);
			return;

		case 2:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKeyedKids);
			return;

		case 3:
			if (x.h !== y.h)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
			factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

			var patch = y.i(x.g, y.g);
			patch && _VirtualDom_pushPatch(patches, 5, index, patch);

			return;
	}
}

// assumes the incoming arrays are the same length
function _VirtualDom_pairwiseRefEqual(as, bs)
{
	for (var i = 0; i < as.length; i++)
	{
		if (as[i] !== bs[i])
		{
			return false;
		}
	}

	return true;
}

function _VirtualDom_diffNodes(x, y, patches, index, diffKids)
{
	// Bail if obvious indicators have changed. Implies more serious
	// structural changes such that it's not worth it to diff.
	if (x.c !== y.c || x.f !== y.f)
	{
		_VirtualDom_pushPatch(patches, 0, index, y);
		return;
	}

	var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
	factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

	diffKids(x, y, patches, index);
}



// DIFF FACTS


// TODO Instead of creating a new diff object, it's possible to just test if
// there *is* a diff. During the actual patch, do the diff again and make the
// modifications directly. This way, there's no new allocations. Worth it?
function _VirtualDom_diffFacts(x, y, category)
{
	var diff;

	// look for changes and removals
	for (var xKey in x)
	{
		if (xKey === 'a1' || xKey === 'a0' || xKey === 'a3' || xKey === 'a4')
		{
			var subDiff = _VirtualDom_diffFacts(x[xKey], y[xKey] || {}, xKey);
			if (subDiff)
			{
				diff = diff || {};
				diff[xKey] = subDiff;
			}
			continue;
		}

		// remove if not in the new facts
		if (!(xKey in y))
		{
			diff = diff || {};
			diff[xKey] =
				!category
					? (typeof x[xKey] === 'string' ? '' : null)
					:
				(category === 'a1')
					? ''
					:
				(category === 'a0' || category === 'a3')
					? undefined
					:
				{ f: x[xKey].f, o: undefined };

			continue;
		}

		var xValue = x[xKey];
		var yValue = y[xKey];

		// reference equal, so don't worry about it
		if (xValue === yValue && xKey !== 'value' && xKey !== 'checked'
			|| category === 'a0' && _VirtualDom_equalEvents(xValue, yValue))
		{
			continue;
		}

		diff = diff || {};
		diff[xKey] = yValue;
	}

	// add new stuff
	for (var yKey in y)
	{
		if (!(yKey in x))
		{
			diff = diff || {};
			diff[yKey] = y[yKey];
		}
	}

	return diff;
}



// DIFF KIDS


function _VirtualDom_diffKids(xParent, yParent, patches, index)
{
	var xKids = xParent.e;
	var yKids = yParent.e;

	var xLen = xKids.length;
	var yLen = yKids.length;

	// FIGURE OUT IF THERE ARE INSERTS OR REMOVALS

	if (xLen > yLen)
	{
		_VirtualDom_pushPatch(patches, 6, index, {
			v: yLen,
			i: xLen - yLen
		});
	}
	else if (xLen < yLen)
	{
		_VirtualDom_pushPatch(patches, 7, index, {
			v: xLen,
			e: yKids
		});
	}

	// PAIRWISE DIFF EVERYTHING ELSE

	for (var minLen = xLen < yLen ? xLen : yLen, i = 0; i < minLen; i++)
	{
		var xKid = xKids[i];
		_VirtualDom_diffHelp(xKid, yKids[i], patches, ++index);
		index += xKid.b || 0;
	}
}



// KEYED DIFF


function _VirtualDom_diffKeyedKids(xParent, yParent, patches, rootIndex)
{
	var localPatches = [];

	var changes = {}; // Dict String Entry
	var inserts = []; // Array { index : Int, entry : Entry }
	// type Entry = { tag : String, vnode : VNode, index : Int, data : _ }

	var xKids = xParent.e;
	var yKids = yParent.e;
	var xLen = xKids.length;
	var yLen = yKids.length;
	var xIndex = 0;
	var yIndex = 0;

	var index = rootIndex;

	while (xIndex < xLen && yIndex < yLen)
	{
		var x = xKids[xIndex];
		var y = yKids[yIndex];

		var xKey = x.a;
		var yKey = y.a;
		var xNode = x.b;
		var yNode = y.b;

		var newMatch = undefined;
		var oldMatch = undefined;

		// check if keys match

		if (xKey === yKey)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNode, localPatches, index);
			index += xNode.b || 0;

			xIndex++;
			yIndex++;
			continue;
		}

		// look ahead 1 to detect insertions and removals.

		var xNext = xKids[xIndex + 1];
		var yNext = yKids[yIndex + 1];

		if (xNext)
		{
			var xNextKey = xNext.a;
			var xNextNode = xNext.b;
			oldMatch = yKey === xNextKey;
		}

		if (yNext)
		{
			var yNextKey = yNext.a;
			var yNextNode = yNext.b;
			newMatch = xKey === yNextKey;
		}


		// swap x and y
		if (newMatch && oldMatch)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			_VirtualDom_insertNode(changes, localPatches, xKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNextNode, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		// insert y
		if (newMatch)
		{
			index++;
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			index += xNode.b || 0;

			xIndex += 1;
			yIndex += 2;
			continue;
		}

		// remove x
		if (oldMatch)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 1;
			continue;
		}

		// remove x, insert y
		if (xNext && xNextKey === yNextKey)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNextNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		break;
	}

	// eat up any remaining nodes with removeNode and insertNode

	while (xIndex < xLen)
	{
		index++;
		var x = xKids[xIndex];
		var xNode = x.b;
		_VirtualDom_removeNode(changes, localPatches, x.a, xNode, index);
		index += xNode.b || 0;
		xIndex++;
	}

	while (yIndex < yLen)
	{
		var endInserts = endInserts || [];
		var y = yKids[yIndex];
		_VirtualDom_insertNode(changes, localPatches, y.a, y.b, undefined, endInserts);
		yIndex++;
	}

	if (localPatches.length > 0 || inserts.length > 0 || endInserts)
	{
		_VirtualDom_pushPatch(patches, 8, rootIndex, {
			w: localPatches,
			x: inserts,
			y: endInserts
		});
	}
}



// CHANGES FROM KEYED DIFF


var _VirtualDom_POSTFIX = '_elmW6BL';


function _VirtualDom_insertNode(changes, localPatches, key, vnode, yIndex, inserts)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		entry = {
			c: 0,
			z: vnode,
			r: yIndex,
			s: undefined
		};

		inserts.push({ r: yIndex, A: entry });
		changes[key] = entry;

		return;
	}

	// this key was removed earlier, a match!
	if (entry.c === 1)
	{
		inserts.push({ r: yIndex, A: entry });

		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(entry.z, vnode, subPatches, entry.r);
		entry.r = yIndex;
		entry.s.s = {
			w: subPatches,
			A: entry
		};

		return;
	}

	// this key has already been inserted or moved, a duplicate!
	_VirtualDom_insertNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, yIndex, inserts);
}


function _VirtualDom_removeNode(changes, localPatches, key, vnode, index)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		var patch = _VirtualDom_pushPatch(localPatches, 9, index, undefined);

		changes[key] = {
			c: 1,
			z: vnode,
			r: index,
			s: patch
		};

		return;
	}

	// this key was inserted earlier, a match!
	if (entry.c === 0)
	{
		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(vnode, entry.z, subPatches, index);

		_VirtualDom_pushPatch(localPatches, 9, index, {
			w: subPatches,
			A: entry
		});

		return;
	}

	// this key has already been removed or moved, a duplicate!
	_VirtualDom_removeNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, index);
}



// ADD DOM NODES
//
// Each DOM node has an "index" assigned in order of traversal. It is important
// to minimize our crawl over the actual DOM, so these indexes (along with the
// descendantsCount of virtual nodes) let us skip touching entire subtrees of
// the DOM if we know there are no patches there.


function _VirtualDom_addDomNodes(domNode, vNode, patches, eventNode)
{
	_VirtualDom_addDomNodesHelp(domNode, vNode, patches, 0, 0, vNode.b, eventNode);
}


// assumes `patches` is non-empty and indexes increase monotonically.
function _VirtualDom_addDomNodesHelp(domNode, vNode, patches, i, low, high, eventNode)
{
	var patch = patches[i];
	var index = patch.r;

	while (index === low)
	{
		var patchType = patch.$;

		if (patchType === 1)
		{
			_VirtualDom_addDomNodes(domNode, vNode.k, patch.s, eventNode);
		}
		else if (patchType === 8)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var subPatches = patch.s.w;
			if (subPatches.length > 0)
			{
				_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
			}
		}
		else if (patchType === 9)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var data = patch.s;
			if (data)
			{
				data.A.s = domNode;
				var subPatches = data.w;
				if (subPatches.length > 0)
				{
					_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
				}
			}
		}
		else
		{
			patch.t = domNode;
			patch.u = eventNode;
		}

		i++;

		if (!(patch = patches[i]) || (index = patch.r) > high)
		{
			return i;
		}
	}

	var tag = vNode.$;

	if (tag === 4)
	{
		var subNode = vNode.k;

		while (subNode.$ === 4)
		{
			subNode = subNode.k;
		}

		return _VirtualDom_addDomNodesHelp(domNode, subNode, patches, i, low + 1, high, domNode.elm_event_node_ref);
	}

	// tag must be 1 or 2 at this point

	var vKids = vNode.e;
	var childNodes = domNode.childNodes;
	for (var j = 0; j < vKids.length; j++)
	{
		low++;
		var vKid = tag === 1 ? vKids[j] : vKids[j].b;
		var nextLow = low + (vKid.b || 0);
		if (low <= index && index <= nextLow)
		{
			i = _VirtualDom_addDomNodesHelp(childNodes[j], vKid, patches, i, low, nextLow, eventNode);
			if (!(patch = patches[i]) || (index = patch.r) > high)
			{
				return i;
			}
		}
		low = nextLow;
	}
	return i;
}



// APPLY PATCHES


function _VirtualDom_applyPatches(rootDomNode, oldVirtualNode, patches, eventNode)
{
	if (patches.length === 0)
	{
		return rootDomNode;
	}

	_VirtualDom_addDomNodes(rootDomNode, oldVirtualNode, patches, eventNode);
	return _VirtualDom_applyPatchesHelp(rootDomNode, patches);
}

function _VirtualDom_applyPatchesHelp(rootDomNode, patches)
{
	for (var i = 0; i < patches.length; i++)
	{
		var patch = patches[i];
		var localDomNode = patch.t
		var newNode = _VirtualDom_applyPatch(localDomNode, patch);
		if (localDomNode === rootDomNode)
		{
			rootDomNode = newNode;
		}
	}
	return rootDomNode;
}

function _VirtualDom_applyPatch(domNode, patch)
{
	switch (patch.$)
	{
		case 0:
			return _VirtualDom_applyPatchRedraw(domNode, patch.s, patch.u);

		case 4:
			_VirtualDom_applyFacts(domNode, patch.u, patch.s);
			return domNode;

		case 3:
			domNode.replaceData(0, domNode.length, patch.s);
			return domNode;

		case 1:
			return _VirtualDom_applyPatchesHelp(domNode, patch.s);

		case 2:
			if (domNode.elm_event_node_ref)
			{
				domNode.elm_event_node_ref.j = patch.s;
			}
			else
			{
				domNode.elm_event_node_ref = { j: patch.s, p: patch.u };
			}
			return domNode;

		case 6:
			var data = patch.s;
			for (var i = 0; i < data.i; i++)
			{
				domNode.removeChild(domNode.childNodes[data.v]);
			}
			return domNode;

		case 7:
			var data = patch.s;
			var kids = data.e;
			var i = data.v;
			var theEnd = domNode.childNodes[i];
			for (; i < kids.length; i++)
			{
				domNode.insertBefore(_VirtualDom_render(kids[i], patch.u), theEnd);
			}
			return domNode;

		case 9:
			var data = patch.s;
			if (!data)
			{
				domNode.parentNode.removeChild(domNode);
				return domNode;
			}
			var entry = data.A;
			if (typeof entry.r !== 'undefined')
			{
				domNode.parentNode.removeChild(domNode);
			}
			entry.s = _VirtualDom_applyPatchesHelp(domNode, data.w);
			return domNode;

		case 8:
			return _VirtualDom_applyPatchReorder(domNode, patch);

		case 5:
			return patch.s(domNode);

		default:
			_Debug_crash(10); // 'Ran into an unknown patch!'
	}
}


function _VirtualDom_applyPatchRedraw(domNode, vNode, eventNode)
{
	var parentNode = domNode.parentNode;
	var newNode = _VirtualDom_render(vNode, eventNode);

	if (!newNode.elm_event_node_ref)
	{
		newNode.elm_event_node_ref = domNode.elm_event_node_ref;
	}

	if (parentNode && newNode !== domNode)
	{
		parentNode.replaceChild(newNode, domNode);
	}
	return newNode;
}


function _VirtualDom_applyPatchReorder(domNode, patch)
{
	var data = patch.s;

	// remove end inserts
	var frag = _VirtualDom_applyPatchReorderEndInsertsHelp(data.y, patch);

	// removals
	domNode = _VirtualDom_applyPatchesHelp(domNode, data.w);

	// inserts
	var inserts = data.x;
	for (var i = 0; i < inserts.length; i++)
	{
		var insert = inserts[i];
		var entry = insert.A;
		var node = entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u);
		domNode.insertBefore(node, domNode.childNodes[insert.r]);
	}

	// add end inserts
	if (frag)
	{
		_VirtualDom_appendChild(domNode, frag);
	}

	return domNode;
}


function _VirtualDom_applyPatchReorderEndInsertsHelp(endInserts, patch)
{
	if (!endInserts)
	{
		return;
	}

	var frag = _VirtualDom_doc.createDocumentFragment();
	for (var i = 0; i < endInserts.length; i++)
	{
		var insert = endInserts[i];
		var entry = insert.A;
		_VirtualDom_appendChild(frag, entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u)
		);
	}
	return frag;
}


function _VirtualDom_virtualize(node)
{
	// TEXT NODES

	if (node.nodeType === 3)
	{
		return _VirtualDom_text(node.textContent);
	}


	// WEIRD NODES

	if (node.nodeType !== 1)
	{
		return _VirtualDom_text('');
	}


	// ELEMENT NODES

	var attrList = _List_Nil;
	var attrs = node.attributes;
	for (var i = attrs.length; i--; )
	{
		var attr = attrs[i];
		var name = attr.name;
		var value = attr.value;
		attrList = _List_Cons( A2(_VirtualDom_attribute, name, value), attrList );
	}

	var tag = node.tagName.toLowerCase();
	var kidList = _List_Nil;
	var kids = node.childNodes;

	for (var i = kids.length; i--; )
	{
		kidList = _List_Cons(_VirtualDom_virtualize(kids[i]), kidList);
	}
	return A3(_VirtualDom_node, tag, attrList, kidList);
}

function _VirtualDom_dekey(keyedNode)
{
	var keyedKids = keyedNode.e;
	var len = keyedKids.length;
	var kids = new Array(len);
	for (var i = 0; i < len; i++)
	{
		kids[i] = keyedKids[i].b;
	}

	return {
		$: 1,
		c: keyedNode.c,
		d: keyedNode.d,
		e: kids,
		f: keyedNode.f,
		b: keyedNode.b
	};
}




// ELEMENT


var _Debugger_element;

var _Browser_element = _Debugger_element || F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function(sendToApp, initialModel) {
			var view = impl.view;
			/**_UNUSED/
			var domNode = args['node'];
			//*/
			/**/
			var domNode = args && args['node'] ? args['node'] : _Debug_crash(0);
			//*/
			var currNode = _VirtualDom_virtualize(domNode);

			return _Browser_makeAnimator(initialModel, function(model)
			{
				var nextNode = view(model);
				var patches = _VirtualDom_diff(currNode, nextNode);
				domNode = _VirtualDom_applyPatches(domNode, currNode, patches, sendToApp);
				currNode = nextNode;
			});
		}
	);
});



// DOCUMENT


var _Debugger_document;

var _Browser_document = _Debugger_document || F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function(sendToApp, initialModel) {
			var divertHrefToApp = impl.setup && impl.setup(sendToApp)
			var view = impl.view;
			var title = _VirtualDom_doc.title;
			var bodyNode = _VirtualDom_doc.body;
			var currNode = _VirtualDom_virtualize(bodyNode);
			return _Browser_makeAnimator(initialModel, function(model)
			{
				_VirtualDom_divertHrefToApp = divertHrefToApp;
				var doc = view(model);
				var nextNode = _VirtualDom_node('body')(_List_Nil)(doc.body);
				var patches = _VirtualDom_diff(currNode, nextNode);
				bodyNode = _VirtualDom_applyPatches(bodyNode, currNode, patches, sendToApp);
				currNode = nextNode;
				_VirtualDom_divertHrefToApp = 0;
				(title !== doc.title) && (_VirtualDom_doc.title = title = doc.title);
			});
		}
	);
});



// ANIMATION


var _Browser_cancelAnimationFrame =
	typeof cancelAnimationFrame !== 'undefined'
		? cancelAnimationFrame
		: function(id) { clearTimeout(id); };

var _Browser_requestAnimationFrame =
	typeof requestAnimationFrame !== 'undefined'
		? requestAnimationFrame
		: function(callback) { return setTimeout(callback, 1000 / 60); };


function _Browser_makeAnimator(model, draw)
{
	draw(model);

	var state = 0;

	function updateIfNeeded()
	{
		state = state === 1
			? 0
			: ( _Browser_requestAnimationFrame(updateIfNeeded), draw(model), 1 );
	}

	return function(nextModel, isSync)
	{
		model = nextModel;

		isSync
			? ( draw(model),
				state === 2 && (state = 1)
				)
			: ( state === 0 && _Browser_requestAnimationFrame(updateIfNeeded),
				state = 2
				);
	};
}



// APPLICATION


function _Browser_application(impl)
{
	var onUrlChange = impl.onUrlChange;
	var onUrlRequest = impl.onUrlRequest;
	var key = function() { key.a(onUrlChange(_Browser_getUrl())); };

	return _Browser_document({
		setup: function(sendToApp)
		{
			key.a = sendToApp;
			_Browser_window.addEventListener('popstate', key);
			_Browser_window.navigator.userAgent.indexOf('Trident') < 0 || _Browser_window.addEventListener('hashchange', key);

			return F2(function(domNode, event)
			{
				if (!event.ctrlKey && !event.metaKey && !event.shiftKey && event.button < 1 && !domNode.target && !domNode.hasAttribute('download'))
				{
					event.preventDefault();
					var href = domNode.href;
					var curr = _Browser_getUrl();
					var next = $elm$url$Url$fromString(href).a;
					sendToApp(onUrlRequest(
						(next
							&& curr.protocol === next.protocol
							&& curr.host === next.host
							&& curr.port_.a === next.port_.a
						)
							? $elm$browser$Browser$Internal(next)
							: $elm$browser$Browser$External(href)
					));
				}
			});
		},
		init: function(flags)
		{
			return A3(impl.init, flags, _Browser_getUrl(), key);
		},
		view: impl.view,
		update: impl.update,
		subscriptions: impl.subscriptions
	});
}

function _Browser_getUrl()
{
	return $elm$url$Url$fromString(_VirtualDom_doc.location.href).a || _Debug_crash(1);
}

var _Browser_go = F2(function(key, n)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		n && history.go(n);
		key();
	}));
});

var _Browser_pushUrl = F2(function(key, url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		history.pushState({}, '', url);
		key();
	}));
});

var _Browser_replaceUrl = F2(function(key, url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		history.replaceState({}, '', url);
		key();
	}));
});



// GLOBAL EVENTS


var _Browser_fakeNode = { addEventListener: function() {}, removeEventListener: function() {} };
var _Browser_doc = typeof document !== 'undefined' ? document : _Browser_fakeNode;
var _Browser_window = typeof window !== 'undefined' ? window : _Browser_fakeNode;

var _Browser_on = F3(function(node, eventName, sendToSelf)
{
	return _Scheduler_spawn(_Scheduler_binding(function(callback)
	{
		function handler(event)	{ _Scheduler_rawSpawn(sendToSelf(event)); }
		node.addEventListener(eventName, handler, _VirtualDom_passiveSupported && { passive: true });
		return function() { node.removeEventListener(eventName, handler); };
	}));
});

var _Browser_decodeEvent = F2(function(decoder, event)
{
	var result = _Json_runHelp(decoder, event);
	return $elm$core$Result$isOk(result) ? $elm$core$Maybe$Just(result.a) : $elm$core$Maybe$Nothing;
});



// PAGE VISIBILITY


function _Browser_visibilityInfo()
{
	return (typeof _VirtualDom_doc.hidden !== 'undefined')
		? { hidden: 'hidden', change: 'visibilitychange' }
		:
	(typeof _VirtualDom_doc.mozHidden !== 'undefined')
		? { hidden: 'mozHidden', change: 'mozvisibilitychange' }
		:
	(typeof _VirtualDom_doc.msHidden !== 'undefined')
		? { hidden: 'msHidden', change: 'msvisibilitychange' }
		:
	(typeof _VirtualDom_doc.webkitHidden !== 'undefined')
		? { hidden: 'webkitHidden', change: 'webkitvisibilitychange' }
		: { hidden: 'hidden', change: 'visibilitychange' };
}



// ANIMATION FRAMES


function _Browser_rAF()
{
	return _Scheduler_binding(function(callback)
	{
		var id = _Browser_requestAnimationFrame(function() {
			callback(_Scheduler_succeed(Date.now()));
		});

		return function() {
			_Browser_cancelAnimationFrame(id);
		};
	});
}


function _Browser_now()
{
	return _Scheduler_binding(function(callback)
	{
		callback(_Scheduler_succeed(Date.now()));
	});
}



// DOM STUFF


function _Browser_withNode(id, doStuff)
{
	return _Scheduler_binding(function(callback)
	{
		_Browser_requestAnimationFrame(function() {
			var node = document.getElementById(id);
			callback(node
				? _Scheduler_succeed(doStuff(node))
				: _Scheduler_fail($elm$browser$Browser$Dom$NotFound(id))
			);
		});
	});
}


function _Browser_withWindow(doStuff)
{
	return _Scheduler_binding(function(callback)
	{
		_Browser_requestAnimationFrame(function() {
			callback(_Scheduler_succeed(doStuff()));
		});
	});
}


// FOCUS and BLUR


var _Browser_call = F2(function(functionName, id)
{
	return _Browser_withNode(id, function(node) {
		node[functionName]();
		return _Utils_Tuple0;
	});
});



// WINDOW VIEWPORT


function _Browser_getViewport()
{
	return {
		scene: _Browser_getScene(),
		viewport: {
			x: _Browser_window.pageXOffset,
			y: _Browser_window.pageYOffset,
			width: _Browser_doc.documentElement.clientWidth,
			height: _Browser_doc.documentElement.clientHeight
		}
	};
}

function _Browser_getScene()
{
	var body = _Browser_doc.body;
	var elem = _Browser_doc.documentElement;
	return {
		width: Math.max(body.scrollWidth, body.offsetWidth, elem.scrollWidth, elem.offsetWidth, elem.clientWidth),
		height: Math.max(body.scrollHeight, body.offsetHeight, elem.scrollHeight, elem.offsetHeight, elem.clientHeight)
	};
}

var _Browser_setViewport = F2(function(x, y)
{
	return _Browser_withWindow(function()
	{
		_Browser_window.scroll(x, y);
		return _Utils_Tuple0;
	});
});



// ELEMENT VIEWPORT


function _Browser_getViewportOf(id)
{
	return _Browser_withNode(id, function(node)
	{
		return {
			scene: {
				width: node.scrollWidth,
				height: node.scrollHeight
			},
			viewport: {
				x: node.scrollLeft,
				y: node.scrollTop,
				width: node.clientWidth,
				height: node.clientHeight
			}
		};
	});
}


var _Browser_setViewportOf = F3(function(id, x, y)
{
	return _Browser_withNode(id, function(node)
	{
		node.scrollLeft = x;
		node.scrollTop = y;
		return _Utils_Tuple0;
	});
});



// ELEMENT


function _Browser_getElement(id)
{
	return _Browser_withNode(id, function(node)
	{
		var rect = node.getBoundingClientRect();
		var x = _Browser_window.pageXOffset;
		var y = _Browser_window.pageYOffset;
		return {
			scene: _Browser_getScene(),
			viewport: {
				x: x,
				y: y,
				width: _Browser_doc.documentElement.clientWidth,
				height: _Browser_doc.documentElement.clientHeight
			},
			element: {
				x: x + rect.left,
				y: y + rect.top,
				width: rect.width,
				height: rect.height
			}
		};
	});
}



// LOAD and RELOAD


function _Browser_reload(skipCache)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function(callback)
	{
		_VirtualDom_doc.location.reload(skipCache);
	}));
}

function _Browser_load(url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function(callback)
	{
		try
		{
			_Browser_window.location = url;
		}
		catch(err)
		{
			// Only Firefox can throw a NS_ERROR_MALFORMED_URI exception here.
			// Other browsers reload the page, so let's be consistent about that.
			_VirtualDom_doc.location.reload(false);
		}
	}));
}
var $elm$core$Basics$EQ = {$: 'EQ'};
var $elm$core$Basics$LT = {$: 'LT'};
var $elm$core$List$cons = _List_cons;
var $elm$core$Elm$JsArray$foldr = _JsArray_foldr;
var $elm$core$Array$foldr = F3(
	function (func, baseCase, _v0) {
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = F2(
			function (node, acc) {
				if (node.$ === 'SubTree') {
					var subTree = node.a;
					return A3($elm$core$Elm$JsArray$foldr, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3($elm$core$Elm$JsArray$foldr, func, acc, values);
				}
			});
		return A3(
			$elm$core$Elm$JsArray$foldr,
			helper,
			A3($elm$core$Elm$JsArray$foldr, func, baseCase, tail),
			tree);
	});
var $elm$core$Array$toList = function (array) {
	return A3($elm$core$Array$foldr, $elm$core$List$cons, _List_Nil, array);
};
var $elm$core$Dict$foldr = F3(
	function (func, acc, t) {
		foldr:
		while (true) {
			if (t.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = t.b;
				var value = t.c;
				var left = t.d;
				var right = t.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldr, func, acc, right)),
					$temp$t = left;
				func = $temp$func;
				acc = $temp$acc;
				t = $temp$t;
				continue foldr;
			}
		}
	});
var $elm$core$Dict$toList = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return A2(
					$elm$core$List$cons,
					_Utils_Tuple2(key, value),
					list);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Dict$keys = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return A2($elm$core$List$cons, key, keyList);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Set$toList = function (_v0) {
	var dict = _v0.a;
	return $elm$core$Dict$keys(dict);
};
var $elm$core$Basics$GT = {$: 'GT'};
var $author$project$Message$GetViewport = function (a) {
	return {$: 'GetViewport', a: a};
};
var $elm$core$Basics$apR = F2(
	function (x, f) {
		return f(x);
	});
var $author$project$Model$Paused = {$: 'Paused'};
var $author$project$Model$Playing = {$: 'Playing'};
var $author$project$Model$Stopped = {$: 'Stopped'};
var $author$project$Model$decodeState = function (string) {
	switch (string) {
		case 'paused':
			return $author$project$Model$Paused;
		case 'playing':
			return $author$project$Model$Playing;
		default:
			return $author$project$Model$Stopped;
	}
};
var $elm$core$Result$Err = function (a) {
	return {$: 'Err', a: a};
};
var $elm$json$Json$Decode$Failure = F2(
	function (a, b) {
		return {$: 'Failure', a: a, b: b};
	});
var $elm$json$Json$Decode$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var $elm$json$Json$Decode$Index = F2(
	function (a, b) {
		return {$: 'Index', a: a, b: b};
	});
var $elm$core$Result$Ok = function (a) {
	return {$: 'Ok', a: a};
};
var $elm$json$Json$Decode$OneOf = function (a) {
	return {$: 'OneOf', a: a};
};
var $elm$core$Basics$False = {$: 'False'};
var $elm$core$Basics$add = _Basics_add;
var $elm$core$Maybe$Just = function (a) {
	return {$: 'Just', a: a};
};
var $elm$core$Maybe$Nothing = {$: 'Nothing'};
var $elm$core$String$all = _String_all;
var $elm$core$Basics$and = _Basics_and;
var $elm$core$Basics$append = _Utils_append;
var $elm$json$Json$Encode$encode = _Json_encode;
var $elm$core$String$fromInt = _String_fromNumber;
var $elm$core$String$join = F2(
	function (sep, chunks) {
		return A2(
			_String_join,
			sep,
			_List_toArray(chunks));
	});
var $elm$core$String$split = F2(
	function (sep, string) {
		return _List_fromArray(
			A2(_String_split, sep, string));
	});
var $elm$json$Json$Decode$indent = function (str) {
	return A2(
		$elm$core$String$join,
		'\n    ',
		A2($elm$core$String$split, '\n', str));
};
var $elm$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			if (!list.b) {
				return acc;
			} else {
				var x = list.a;
				var xs = list.b;
				var $temp$func = func,
					$temp$acc = A2(func, x, acc),
					$temp$list = xs;
				func = $temp$func;
				acc = $temp$acc;
				list = $temp$list;
				continue foldl;
			}
		}
	});
var $elm$core$List$length = function (xs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, i) {
				return i + 1;
			}),
		0,
		xs);
};
var $elm$core$List$map2 = _List_map2;
var $elm$core$Basics$le = _Utils_le;
var $elm$core$Basics$sub = _Basics_sub;
var $elm$core$List$rangeHelp = F3(
	function (lo, hi, list) {
		rangeHelp:
		while (true) {
			if (_Utils_cmp(lo, hi) < 1) {
				var $temp$lo = lo,
					$temp$hi = hi - 1,
					$temp$list = A2($elm$core$List$cons, hi, list);
				lo = $temp$lo;
				hi = $temp$hi;
				list = $temp$list;
				continue rangeHelp;
			} else {
				return list;
			}
		}
	});
var $elm$core$List$range = F2(
	function (lo, hi) {
		return A3($elm$core$List$rangeHelp, lo, hi, _List_Nil);
	});
var $elm$core$List$indexedMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$map2,
			f,
			A2(
				$elm$core$List$range,
				0,
				$elm$core$List$length(xs) - 1),
			xs);
	});
var $elm$core$Char$toCode = _Char_toCode;
var $elm$core$Char$isLower = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (97 <= code) && (code <= 122);
};
var $elm$core$Char$isUpper = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 90) && (65 <= code);
};
var $elm$core$Basics$or = _Basics_or;
var $elm$core$Char$isAlpha = function (_char) {
	return $elm$core$Char$isLower(_char) || $elm$core$Char$isUpper(_char);
};
var $elm$core$Char$isDigit = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 57) && (48 <= code);
};
var $elm$core$Char$isAlphaNum = function (_char) {
	return $elm$core$Char$isLower(_char) || ($elm$core$Char$isUpper(_char) || $elm$core$Char$isDigit(_char));
};
var $elm$core$List$reverse = function (list) {
	return A3($elm$core$List$foldl, $elm$core$List$cons, _List_Nil, list);
};
var $elm$core$String$uncons = _String_uncons;
var $elm$json$Json$Decode$errorOneOf = F2(
	function (i, error) {
		return '\n\n(' + ($elm$core$String$fromInt(i + 1) + (') ' + $elm$json$Json$Decode$indent(
			$elm$json$Json$Decode$errorToString(error))));
	});
var $elm$json$Json$Decode$errorToString = function (error) {
	return A2($elm$json$Json$Decode$errorToStringHelp, error, _List_Nil);
};
var $elm$json$Json$Decode$errorToStringHelp = F2(
	function (error, context) {
		errorToStringHelp:
		while (true) {
			switch (error.$) {
				case 'Field':
					var f = error.a;
					var err = error.b;
					var isSimple = function () {
						var _v1 = $elm$core$String$uncons(f);
						if (_v1.$ === 'Nothing') {
							return false;
						} else {
							var _v2 = _v1.a;
							var _char = _v2.a;
							var rest = _v2.b;
							return $elm$core$Char$isAlpha(_char) && A2($elm$core$String$all, $elm$core$Char$isAlphaNum, rest);
						}
					}();
					var fieldName = isSimple ? ('.' + f) : ('[\'' + (f + '\']'));
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, fieldName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'Index':
					var i = error.a;
					var err = error.b;
					var indexName = '[' + ($elm$core$String$fromInt(i) + ']');
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, indexName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'OneOf':
					var errors = error.a;
					if (!errors.b) {
						return 'Ran into a Json.Decode.oneOf with no possibilities' + function () {
							if (!context.b) {
								return '!';
							} else {
								return ' at json' + A2(
									$elm$core$String$join,
									'',
									$elm$core$List$reverse(context));
							}
						}();
					} else {
						if (!errors.b.b) {
							var err = errors.a;
							var $temp$error = err,
								$temp$context = context;
							error = $temp$error;
							context = $temp$context;
							continue errorToStringHelp;
						} else {
							var starter = function () {
								if (!context.b) {
									return 'Json.Decode.oneOf';
								} else {
									return 'The Json.Decode.oneOf at json' + A2(
										$elm$core$String$join,
										'',
										$elm$core$List$reverse(context));
								}
							}();
							var introduction = starter + (' failed in the following ' + ($elm$core$String$fromInt(
								$elm$core$List$length(errors)) + ' ways:'));
							return A2(
								$elm$core$String$join,
								'\n\n',
								A2(
									$elm$core$List$cons,
									introduction,
									A2($elm$core$List$indexedMap, $elm$json$Json$Decode$errorOneOf, errors)));
						}
					}
				default:
					var msg = error.a;
					var json = error.b;
					var introduction = function () {
						if (!context.b) {
							return 'Problem with the given value:\n\n';
						} else {
							return 'Problem with the value at json' + (A2(
								$elm$core$String$join,
								'',
								$elm$core$List$reverse(context)) + ':\n\n    ');
						}
					}();
					return introduction + ($elm$json$Json$Decode$indent(
						A2($elm$json$Json$Encode$encode, 4, json)) + ('\n\n' + msg));
			}
		}
	});
var $elm$core$Array$branchFactor = 32;
var $elm$core$Array$Array_elm_builtin = F4(
	function (a, b, c, d) {
		return {$: 'Array_elm_builtin', a: a, b: b, c: c, d: d};
	});
var $elm$core$Elm$JsArray$empty = _JsArray_empty;
var $elm$core$Basics$ceiling = _Basics_ceiling;
var $elm$core$Basics$fdiv = _Basics_fdiv;
var $elm$core$Basics$logBase = F2(
	function (base, number) {
		return _Basics_log(number) / _Basics_log(base);
	});
var $elm$core$Basics$toFloat = _Basics_toFloat;
var $elm$core$Array$shiftStep = $elm$core$Basics$ceiling(
	A2($elm$core$Basics$logBase, 2, $elm$core$Array$branchFactor));
var $elm$core$Array$empty = A4($elm$core$Array$Array_elm_builtin, 0, $elm$core$Array$shiftStep, $elm$core$Elm$JsArray$empty, $elm$core$Elm$JsArray$empty);
var $elm$core$Elm$JsArray$initialize = _JsArray_initialize;
var $elm$core$Array$Leaf = function (a) {
	return {$: 'Leaf', a: a};
};
var $elm$core$Basics$apL = F2(
	function (f, x) {
		return f(x);
	});
var $elm$core$Basics$eq = _Utils_equal;
var $elm$core$Basics$floor = _Basics_floor;
var $elm$core$Elm$JsArray$length = _JsArray_length;
var $elm$core$Basics$gt = _Utils_gt;
var $elm$core$Basics$max = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) > 0) ? x : y;
	});
var $elm$core$Basics$mul = _Basics_mul;
var $elm$core$Array$SubTree = function (a) {
	return {$: 'SubTree', a: a};
};
var $elm$core$Elm$JsArray$initializeFromList = _JsArray_initializeFromList;
var $elm$core$Array$compressNodes = F2(
	function (nodes, acc) {
		compressNodes:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodes);
			var node = _v0.a;
			var remainingNodes = _v0.b;
			var newAcc = A2(
				$elm$core$List$cons,
				$elm$core$Array$SubTree(node),
				acc);
			if (!remainingNodes.b) {
				return $elm$core$List$reverse(newAcc);
			} else {
				var $temp$nodes = remainingNodes,
					$temp$acc = newAcc;
				nodes = $temp$nodes;
				acc = $temp$acc;
				continue compressNodes;
			}
		}
	});
var $elm$core$Tuple$first = function (_v0) {
	var x = _v0.a;
	return x;
};
var $elm$core$Array$treeFromBuilder = F2(
	function (nodeList, nodeListSize) {
		treeFromBuilder:
		while (true) {
			var newNodeSize = $elm$core$Basics$ceiling(nodeListSize / $elm$core$Array$branchFactor);
			if (newNodeSize === 1) {
				return A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodeList).a;
			} else {
				var $temp$nodeList = A2($elm$core$Array$compressNodes, nodeList, _List_Nil),
					$temp$nodeListSize = newNodeSize;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue treeFromBuilder;
			}
		}
	});
var $elm$core$Array$builderToArray = F2(
	function (reverseNodeList, builder) {
		if (!builder.nodeListSize) {
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail),
				$elm$core$Array$shiftStep,
				$elm$core$Elm$JsArray$empty,
				builder.tail);
		} else {
			var treeLen = builder.nodeListSize * $elm$core$Array$branchFactor;
			var depth = $elm$core$Basics$floor(
				A2($elm$core$Basics$logBase, $elm$core$Array$branchFactor, treeLen - 1));
			var correctNodeList = reverseNodeList ? $elm$core$List$reverse(builder.nodeList) : builder.nodeList;
			var tree = A2($elm$core$Array$treeFromBuilder, correctNodeList, builder.nodeListSize);
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail) + treeLen,
				A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep),
				tree,
				builder.tail);
		}
	});
var $elm$core$Basics$idiv = _Basics_idiv;
var $elm$core$Basics$lt = _Utils_lt;
var $elm$core$Array$initializeHelp = F5(
	function (fn, fromIndex, len, nodeList, tail) {
		initializeHelp:
		while (true) {
			if (fromIndex < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					false,
					{nodeList: nodeList, nodeListSize: (len / $elm$core$Array$branchFactor) | 0, tail: tail});
			} else {
				var leaf = $elm$core$Array$Leaf(
					A3($elm$core$Elm$JsArray$initialize, $elm$core$Array$branchFactor, fromIndex, fn));
				var $temp$fn = fn,
					$temp$fromIndex = fromIndex - $elm$core$Array$branchFactor,
					$temp$len = len,
					$temp$nodeList = A2($elm$core$List$cons, leaf, nodeList),
					$temp$tail = tail;
				fn = $temp$fn;
				fromIndex = $temp$fromIndex;
				len = $temp$len;
				nodeList = $temp$nodeList;
				tail = $temp$tail;
				continue initializeHelp;
			}
		}
	});
var $elm$core$Basics$remainderBy = _Basics_remainderBy;
var $elm$core$Array$initialize = F2(
	function (len, fn) {
		if (len <= 0) {
			return $elm$core$Array$empty;
		} else {
			var tailLen = len % $elm$core$Array$branchFactor;
			var tail = A3($elm$core$Elm$JsArray$initialize, tailLen, len - tailLen, fn);
			var initialFromIndex = (len - tailLen) - $elm$core$Array$branchFactor;
			return A5($elm$core$Array$initializeHelp, fn, initialFromIndex, len, _List_Nil, tail);
		}
	});
var $elm$core$Basics$True = {$: 'True'};
var $elm$core$Result$isOk = function (result) {
	if (result.$ === 'Ok') {
		return true;
	} else {
		return false;
	}
};
var $elm$json$Json$Decode$field = _Json_decodeField;
var $author$project$Model$NoQuest = {$: 'NoQuest'};
var $author$project$Items$PoliceOffice = {$: 'PoliceOffice'};
var $author$project$Items$Empty = {$: 'Empty'};
var $author$project$Items$Park = {$: 'Park'};
var $author$project$Items$emptyIni = {isHeld: false, isPick: false, isWear: false, itemType: $author$project$Items$Empty, number: 1, scene: $author$project$Items$Park, x: 0, y: 0};
var $author$project$Items$bagIni = {grid1: $author$project$Items$emptyIni, grid10: $author$project$Items$emptyIni, grid2: $author$project$Items$emptyIni, grid3: $author$project$Items$emptyIni, grid4: $author$project$Items$emptyIni, grid5: $author$project$Items$emptyIni, grid6: $author$project$Items$emptyIni, grid7: $author$project$Items$emptyIni, grid8: $author$project$Items$emptyIni, grid9: $author$project$Items$emptyIni};
var $author$project$Items$BulletProof = {$: 'BulletProof'};
var $author$project$Items$bulletProofIni = {isHeld: false, isPick: false, isWear: false, itemType: $author$project$Items$BulletProof, number: 1, scene: $author$project$Items$Park, x: 700, y: 530};
var $author$project$Model$Allen = {$: 'Allen'};
var $author$project$Model$cAllen = {
	area: {hei: 60, wid: 20, x: 600, y: 270},
	description: 'ALLENPOLICEOFFICE.npc.day=1',
	interacttrue: false,
	itemType: $author$project$Model$Allen
};
var $author$project$Model$Bob = {$: 'Bob'};
var $author$project$Model$cBob = {
	area: {hei: 60, wid: 20, x: 450, y: 520},
	description: 'BOBPOLICEOFFICE.npc.day=1',
	interacttrue: false,
	itemType: $author$project$Model$Bob
};
var $author$project$Model$Lee = {$: 'Lee'};
var $author$project$Model$cLee = {
	area: {hei: 60, wid: 20, x: 400, y: 270},
	description: 'LEEPOLICEOFFICE.npc.day=1',
	interacttrue: false,
	itemType: $author$project$Model$Lee
};
var $elm$core$Dict$RBEmpty_elm_builtin = {$: 'RBEmpty_elm_builtin'};
var $elm$core$Dict$empty = $elm$core$Dict$RBEmpty_elm_builtin;
var $author$project$Items$Gun = {$: 'Gun'};
var $author$project$Items$gunIni = {isHeld: false, isPick: false, isWear: false, itemType: $author$project$Items$Gun, number: 1, scene: $author$project$Items$PoliceOffice, x: 400, y: 530};
var $author$project$Model$heroIni = {height: 60, width: 20, x: 300, y: 520};
var $elm$core$Basics$identity = function (x) {
	return x;
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Debug$State = function (a) {
	return {$: 'State', a: a};
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Debug$init = $jschomay$elm_narrative_engine$NarrativeEngine$Debug$State(
	{lastInteractionId: 'Start', lastMatchedRuleId: 'Begin', searchText: ''});
var $author$project$Rules$entity = F3(
	function (entityString, name, description) {
		return _Utils_Tuple2(
			entityString,
			{description: description, name: name});
	});
var $author$project$Rules$initialWorldModelSpec = _List_fromArray(
	[
		A3($author$project$Rules$entity, 'PLAYER.current_location=POLICEOFFICE.day1', 'The player', ''),
		A3($author$project$Rules$entity, 'LEEPOLICEOFFICE.npc.day=1.trigger=0', 'Lee', 'Well, Allen seems to have something assigned to you. Let\'s go and solve the case.'),
		A3($author$project$Rules$entity, 'BOBPOLICEOFFICE.npc.day=1.trigger=0', 'Bob', 'Don\'t disturb me. I\'m reading something critical.'),
		A3($author$project$Rules$entity, 'ALLENPOLICEOFFICE.npc.day=1.trigger=0', 'Allen', 'A man who loves reading novels.'),
		A3($author$project$Rules$entity, 'ALLENPARK.npc.day=1.trigger=0', 'Allen', 'Go to ask them about this case. Lee has told me that Brennan died about 9 p.m. yesterday.'),
		A3($author$project$Rules$entity, 'LEEPARK.npc.day=1.trigger=0', 'Lee', 'Do you find anything? Allen is over there and you can talk with him.'),
		A3($author$project$Rules$entity, 'CATHERINE.npc.day=1.trigger=0.suspect=0', 'Catherine', 'Please do find out the truth... I can\'t take it. We were about to get engaged and then he died suddenly...'),
		A3($author$project$Rules$entity, 'ADKINS.npc.day=1.trigger=0.suspect=0', 'Adkins', 'Our dream hasn\'t come true yet... You are so talented, but why is fate so unfair?'),
		A3($author$project$Rules$entity, 'BODYPARKSHOES.choices=0', 'The shoes of Brennan.', 'A very clean pair of designer shoes. Carefully maintained, even the shoe sole.'),
		A3($author$project$Rules$entity, 'SCARONNECK.choices=0', 'The scar of Brennan on his neck.', 'There are obvious signs of strangulation.'),
		A3($author$project$Rules$entity, 'BELONGINGS.choices=0', 'The belongings of Brennan.', 'Nothing is left.'),
		A3($author$project$Rules$entity, 'YES.bobtalk.choices=0', 'Yes', ''),
		A3($author$project$Rules$entity, 'NO.bobtalk.choices=0', 'No', ''),
		A3($author$project$Rules$entity, 'DOESNTMATTER.leetalk.choices=0', 'It doesn\'t matter. \'Almost\' late is not late.', ''),
		A3($author$project$Rules$entity, 'PAYATTENTION.leetalk.choices=0', 'Oh, I\'ll pay attention to that next time.', ''),
		A3($author$project$Rules$entity, 'NOTHING.allentalkpark.choices=0', 'Nothing.', ''),
		A3($author$project$Rules$entity, 'SHOE.allentalkpark.choices=0', 'The shoes look strange.', ''),
		A3($author$project$Rules$entity, 'WEAPON.allentalkpark.choices=0', 'What the murderer used to strangle him is strange.', ''),
		A3($author$project$Rules$entity, 'ADKINSALIBI.choices=0', 'Where were you last night, Adkins? Was there anyone with you?', ''),
		A3($author$project$Rules$entity, 'CATHERINEALIBI.choices=0', 'Where were you last night, Catherine? Was there anyone with you?', ''),
		A3($author$project$Rules$entity, 'ADKINSASK.choices=0', 'When did you see Brennan last time? Do you know why he came here last night?', ''),
		A3($author$project$Rules$entity, 'CATHERINEASK.choices=0', 'When did you see Brennan last time? Do you know why he came here last night?', '')
	]);
var $elm$core$Result$map = F2(
	function (func, ra) {
		if (ra.$ === 'Ok') {
			var a = ra.a;
			return $elm$core$Result$Ok(
				func(a));
		} else {
			var e = ra.a;
			return $elm$core$Result$Err(e);
		}
	});
var $elm$core$Result$map3 = F4(
	function (func, ra, rb, rc) {
		if (ra.$ === 'Err') {
			var x = ra.a;
			return $elm$core$Result$Err(x);
		} else {
			var a = ra.a;
			if (rb.$ === 'Err') {
				var x = rb.a;
				return $elm$core$Result$Err(x);
			} else {
				var b = rb.a;
				if (rc.$ === 'Err') {
					var x = rc.a;
					return $elm$core$Result$Err(x);
				} else {
					var c = rc.a;
					return $elm$core$Result$Ok(
						A3(func, a, b, c));
				}
			}
		}
	});
var $elm$core$Dict$Black = {$: 'Black'};
var $elm$core$Dict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {$: 'RBNode_elm_builtin', a: a, b: b, c: c, d: d, e: e};
	});
var $elm$core$Dict$Red = {$: 'Red'};
var $elm$core$Dict$balance = F5(
	function (color, key, value, left, right) {
		if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Red')) {
			var _v1 = right.a;
			var rK = right.b;
			var rV = right.c;
			var rLeft = right.d;
			var rRight = right.e;
			if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
				var _v3 = left.a;
				var lK = left.b;
				var lV = left.c;
				var lLeft = left.d;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Red,
					key,
					value,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					rK,
					rV,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, left, rLeft),
					rRight);
			}
		} else {
			if ((((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) && (left.d.$ === 'RBNode_elm_builtin')) && (left.d.a.$ === 'Red')) {
				var _v5 = left.a;
				var lK = left.b;
				var lV = left.c;
				var _v6 = left.d;
				var _v7 = _v6.a;
				var llK = _v6.b;
				var llV = _v6.c;
				var llLeft = _v6.d;
				var llRight = _v6.e;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Red,
					lK,
					lV,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, llK, llV, llLeft, llRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, key, value, lRight, right));
			} else {
				return A5($elm$core$Dict$RBNode_elm_builtin, color, key, value, left, right);
			}
		}
	});
var $elm$core$Basics$compare = _Utils_compare;
var $elm$core$Dict$insertHelp = F3(
	function (key, value, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, $elm$core$Dict$RBEmpty_elm_builtin, $elm$core$Dict$RBEmpty_elm_builtin);
		} else {
			var nColor = dict.a;
			var nKey = dict.b;
			var nValue = dict.c;
			var nLeft = dict.d;
			var nRight = dict.e;
			var _v1 = A2($elm$core$Basics$compare, key, nKey);
			switch (_v1.$) {
				case 'LT':
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						A3($elm$core$Dict$insertHelp, key, value, nLeft),
						nRight);
				case 'EQ':
					return A5($elm$core$Dict$RBNode_elm_builtin, nColor, nKey, value, nLeft, nRight);
				default:
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						nLeft,
						A3($elm$core$Dict$insertHelp, key, value, nRight));
			}
		}
	});
var $elm$core$Dict$insert = F3(
	function (key, value, dict) {
		var _v0 = A3($elm$core$Dict$insertHelp, key, value, dict);
		if ((_v0.$ === 'RBNode_elm_builtin') && (_v0.a.$ === 'Red')) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $author$project$Rules$content__________________________________ = $elm$core$Dict$insert;
var $author$project$Rules$narrative_content = A3(
	$author$project$Rules$content__________________________________,
	'ask adkins alibi2',
	'Actually... Please don\'t tell Catherine this; I\'m afraid she can\'t take it. Brennan told me he wanted to propose to her today, and he asked me how to give her a surprise. I met him at my office at 8 p.m. last night, and talked for...about 20 minutes? I suggested him to propose to her in this park because here is a peaceful place. Then he left my office... Maybe he wanted to find a good place here, but...',
	A3(
		$author$project$Rules$content__________________________________,
		'ask catherine alibi2',
		'Yesterday we had lunch together and then watched a movie. I haven\'t seen him since we parted at 3 p.m. yesterday. We didn\'t live together because we haven\'t got married yet. I don\'t know why he must go such a stark place at night. He never told me that.',
		A3(
			$author$project$Rules$content__________________________________,
			'talk with allen park 2',
			'Do you think there\'s anything questionable about them? Let me know if you come to a conclusion on this case, and we trust your judgment, Kay.(Click the \'Conclusion\' button to solve the case.)',
			A3(
				$author$project$Rules$content__________________________________,
				'ask catherine alibi',
				'I was reading at home last night, but I ordered a night snack at 9:30.',
				A3(
					$author$project$Rules$content__________________________________,
					'talk with catherine',
					'Yes, I found his body... I received his message last night at 10 p.m., and he asked me to meet here this morning. When I arrived, I only saw his body... That\'s so strange! He never had any enemies!',
					A3(
						$author$project$Rules$content__________________________________,
						'ask adkins alibi',
						'I\'m a lawyer and yesterday I work overtime with my colleagues at my own firm. I didn\'t leave my firm until 11 p.m.',
						A3(
							$author$project$Rules$content__________________________________,
							'talk with adkins',
							'Morning, officer. Yes, I\'m Adkins. I grew up with him together and we are like brothers... He has few friends but we\'ve always had a good relationship. Who would have thought such a thing could happen!',
							A3(
								$author$project$Rules$content__________________________________,
								'invest belongings',
								'Nothing is left.',
								A3(
									$author$project$Rules$content__________________________________,
									'invest scar',
									'There are obvious signs of strangulation.',
									A3(
										$author$project$Rules$content__________________________________,
										'invest shoes',
										'A very clean pair of designer shoes. Carefully maintained, even the shoe sole.',
										A3(
											$author$project$Rules$content__________________________________,
											'talk with lee park',
											'{LEEPARK.trigger=1? Do you find anything? Allen is over there and you can talk with him.| I\'ll assist the medical examiner in obtaining autopsy results. Can you investigate the body first?}',
											A3(
												$author$project$Rules$content__________________________________,
												'weapon',
												'The weapon? It\'s just an ordinary rope. Nothing strange. Maybe it\'s just a simple robbery, but let\'s ask Catherine and Adkins for their alibi from last night.',
												A3(
													$author$project$Rules$content__________________________________,
													'shoes',
													'You mean that his shoe sole is too clean, but it\'s almost impossible to keep it clean when walking on the messy grassland. So he is likely to be dumped here. Go to ask Catherine and Adkins! They are criminal suspects.',
													A3(
														$author$project$Rules$content__________________________________,
														'nothing',
														'Em, you think that this is a simple robbery? Fair enough, but let\'s ask Catherine and Adkins for their alibi from last night.',
														A3(
															$author$project$Rules$content__________________________________,
															'talk with allen park',
															'{ALLENPARK.trigger=1? Go to ask them about this case. Lee has told me that Brennan died about 9 p.m. yesterday. | What do you think about this? What looks suspicious?}',
															A3(
																$author$project$Rules$content__________________________________,
																'talk with allen 1',
																'{ALLENPOLICEOFFICE.trigger=1? What are you waiting for? Go to the park!(Go to the gate to go to other places.)| Kay, you are almost late! Now go with me at once, a body is found in the park.}',
																A3(
																	$author$project$Rules$content__________________________________,
																	'pay attention next time',
																	'Kay? That\'s not like you.',
																	A3(
																		$author$project$Rules$content__________________________________,
																		'that doesn\'t matter',
																		'That\'s what you will say. But beware of Allen scolding you.',
																		A3(
																			$author$project$Rules$content__________________________________,
																			'talk with lee',
																			'{LEEPOLICEOFFICE.trigger=1? Well, Allen seems to have something assigned to you.| Hey, Kay. You are almost late at work.}',
																			A3(
																				$author$project$Rules$content__________________________________,
																				'no',
																				'You\'ll be late, Kay.',
																				A3(
																					$author$project$Rules$content__________________________________,
																					'yes',
																					'Don\'t kid me, Kay.',
																					A3($author$project$Rules$content__________________________________, 'talk with bob', '{BOBPOLICEOFFICE.trigger=1? Don\'t disturb me.| Good morning. What can I do for you?}', $elm$core$Dict$empty))))))))))))))))))))));
var $elm$core$String$concat = function (strings) {
	return A2($elm$core$String$join, '', strings);
};
var $elm$core$List$foldrHelper = F4(
	function (fn, acc, ctr, ls) {
		if (!ls.b) {
			return acc;
		} else {
			var a = ls.a;
			var r1 = ls.b;
			if (!r1.b) {
				return A2(fn, a, acc);
			} else {
				var b = r1.a;
				var r2 = r1.b;
				if (!r2.b) {
					return A2(
						fn,
						a,
						A2(fn, b, acc));
				} else {
					var c = r2.a;
					var r3 = r2.b;
					if (!r3.b) {
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(fn, c, acc)));
					} else {
						var d = r3.a;
						var r4 = r3.b;
						var res = (ctr > 500) ? A3(
							$elm$core$List$foldl,
							fn,
							acc,
							$elm$core$List$reverse(r4)) : A4($elm$core$List$foldrHelper, fn, acc, ctr + 1, r4);
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(
									fn,
									c,
									A2(fn, d, res))));
					}
				}
			}
		}
	});
var $elm$core$List$foldr = F3(
	function (fn, acc, ls) {
		return A4($elm$core$List$foldrHelper, fn, acc, 0, ls);
	});
var $elm$core$List$intersperse = F2(
	function (sep, xs) {
		if (!xs.b) {
			return _List_Nil;
		} else {
			var hd = xs.a;
			var tl = xs.b;
			var step = F2(
				function (x, rest) {
					return A2(
						$elm$core$List$cons,
						sep,
						A2($elm$core$List$cons, x, rest));
				});
			var spersed = A3($elm$core$List$foldr, step, _List_Nil, tl);
			return A2($elm$core$List$cons, hd, spersed);
		}
	});
var $elm$core$List$map = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, acc) {
					return A2(
						$elm$core$List$cons,
						f(x),
						acc);
				}),
			_List_Nil,
			xs);
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$deadEndsToString = function (deadEnds) {
	var problemToString = function (p) {
		switch (p.$) {
			case 'Expecting':
				var s = p.a;
				return 'expecting \'' + (s + '\'');
			case 'ExpectingInt':
				return 'expecting int';
			case 'ExpectingHex':
				return 'expecting hex';
			case 'ExpectingOctal':
				return 'expecting octal';
			case 'ExpectingBinary':
				return 'expecting binary';
			case 'ExpectingFloat':
				return 'expecting float';
			case 'ExpectingNumber':
				return 'expecting number';
			case 'ExpectingVariable':
				return 'expecting variable';
			case 'ExpectingSymbol':
				var s = p.a;
				return 'expecting symbol \'' + (s + '\'');
			case 'ExpectingKeyword':
				var s = p.a;
				return 'expecting keyword \'' + (s + '\'');
			case 'ExpectingEnd':
				return 'expecting end';
			case 'UnexpectedChar':
				return 'unexpected char';
			case 'Problem':
				var s = p.a;
				return 'problem ' + s;
			default:
				return 'bad repeat';
		}
	};
	var deadEndToString = function (deadend) {
		return problemToString(deadend.problem) + (' at row ' + ($elm$core$String$fromInt(deadend.row) + (', col ' + $elm$core$String$fromInt(deadend.col))));
	};
	return $elm$core$String$concat(
		A2(
			$elm$core$List$intersperse,
			'; ',
			A2($elm$core$List$map, deadEndToString, deadEnds)));
};
var $elm$parser$Parser$ExpectingEnd = {$: 'ExpectingEnd'};
var $elm$parser$Parser$Advanced$Bad = F2(
	function (a, b) {
		return {$: 'Bad', a: a, b: b};
	});
var $elm$parser$Parser$Advanced$Good = F3(
	function (a, b, c) {
		return {$: 'Good', a: a, b: b, c: c};
	});
var $elm$parser$Parser$Advanced$Parser = function (a) {
	return {$: 'Parser', a: a};
};
var $elm$parser$Parser$Advanced$AddRight = F2(
	function (a, b) {
		return {$: 'AddRight', a: a, b: b};
	});
var $elm$parser$Parser$Advanced$DeadEnd = F4(
	function (row, col, problem, contextStack) {
		return {col: col, contextStack: contextStack, problem: problem, row: row};
	});
var $elm$parser$Parser$Advanced$Empty = {$: 'Empty'};
var $elm$parser$Parser$Advanced$fromState = F2(
	function (s, x) {
		return A2(
			$elm$parser$Parser$Advanced$AddRight,
			$elm$parser$Parser$Advanced$Empty,
			A4($elm$parser$Parser$Advanced$DeadEnd, s.row, s.col, x, s.context));
	});
var $elm$core$String$length = _String_length;
var $elm$parser$Parser$Advanced$end = function (x) {
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			return _Utils_eq(
				$elm$core$String$length(s.src),
				s.offset) ? A3($elm$parser$Parser$Advanced$Good, false, _Utils_Tuple0, s) : A2(
				$elm$parser$Parser$Advanced$Bad,
				false,
				A2($elm$parser$Parser$Advanced$fromState, s, x));
		});
};
var $elm$parser$Parser$end = $elm$parser$Parser$Advanced$end($elm$parser$Parser$ExpectingEnd);
var $elm$parser$Parser$Advanced$andThen = F2(
	function (callback, _v0) {
		var parseA = _v0.a;
		return $elm$parser$Parser$Advanced$Parser(
			function (s0) {
				var _v1 = parseA(s0);
				if (_v1.$ === 'Bad') {
					var p = _v1.a;
					var x = _v1.b;
					return A2($elm$parser$Parser$Advanced$Bad, p, x);
				} else {
					var p1 = _v1.a;
					var a = _v1.b;
					var s1 = _v1.c;
					var _v2 = callback(a);
					var parseB = _v2.a;
					var _v3 = parseB(s1);
					if (_v3.$ === 'Bad') {
						var p2 = _v3.a;
						var x = _v3.b;
						return A2($elm$parser$Parser$Advanced$Bad, p1 || p2, x);
					} else {
						var p2 = _v3.a;
						var b = _v3.b;
						var s2 = _v3.c;
						return A3($elm$parser$Parser$Advanced$Good, p1 || p2, b, s2);
					}
				}
			});
	});
var $elm$parser$Parser$andThen = $elm$parser$Parser$Advanced$andThen;
var $elm$parser$Parser$UnexpectedChar = {$: 'UnexpectedChar'};
var $elm$parser$Parser$Advanced$isSubChar = _Parser_isSubChar;
var $elm$core$Basics$negate = function (n) {
	return -n;
};
var $elm$parser$Parser$Advanced$chompIf = F2(
	function (isGood, expecting) {
		return $elm$parser$Parser$Advanced$Parser(
			function (s) {
				var newOffset = A3($elm$parser$Parser$Advanced$isSubChar, isGood, s.offset, s.src);
				return _Utils_eq(newOffset, -1) ? A2(
					$elm$parser$Parser$Advanced$Bad,
					false,
					A2($elm$parser$Parser$Advanced$fromState, s, expecting)) : (_Utils_eq(newOffset, -2) ? A3(
					$elm$parser$Parser$Advanced$Good,
					true,
					_Utils_Tuple0,
					{col: 1, context: s.context, indent: s.indent, offset: s.offset + 1, row: s.row + 1, src: s.src}) : A3(
					$elm$parser$Parser$Advanced$Good,
					true,
					_Utils_Tuple0,
					{col: s.col + 1, context: s.context, indent: s.indent, offset: newOffset, row: s.row, src: s.src}));
			});
	});
var $elm$parser$Parser$chompIf = function (isGood) {
	return A2($elm$parser$Parser$Advanced$chompIf, isGood, $elm$parser$Parser$UnexpectedChar);
};
var $elm$parser$Parser$Advanced$chompWhileHelp = F5(
	function (isGood, offset, row, col, s0) {
		chompWhileHelp:
		while (true) {
			var newOffset = A3($elm$parser$Parser$Advanced$isSubChar, isGood, offset, s0.src);
			if (_Utils_eq(newOffset, -1)) {
				return A3(
					$elm$parser$Parser$Advanced$Good,
					_Utils_cmp(s0.offset, offset) < 0,
					_Utils_Tuple0,
					{col: col, context: s0.context, indent: s0.indent, offset: offset, row: row, src: s0.src});
			} else {
				if (_Utils_eq(newOffset, -2)) {
					var $temp$isGood = isGood,
						$temp$offset = offset + 1,
						$temp$row = row + 1,
						$temp$col = 1,
						$temp$s0 = s0;
					isGood = $temp$isGood;
					offset = $temp$offset;
					row = $temp$row;
					col = $temp$col;
					s0 = $temp$s0;
					continue chompWhileHelp;
				} else {
					var $temp$isGood = isGood,
						$temp$offset = newOffset,
						$temp$row = row,
						$temp$col = col + 1,
						$temp$s0 = s0;
					isGood = $temp$isGood;
					offset = $temp$offset;
					row = $temp$row;
					col = $temp$col;
					s0 = $temp$s0;
					continue chompWhileHelp;
				}
			}
		}
	});
var $elm$parser$Parser$Advanced$chompWhile = function (isGood) {
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			return A5($elm$parser$Parser$Advanced$chompWhileHelp, isGood, s.offset, s.row, s.col, s);
		});
};
var $elm$parser$Parser$chompWhile = $elm$parser$Parser$Advanced$chompWhile;
var $elm$core$Basics$always = F2(
	function (a, _v0) {
		return a;
	});
var $elm$core$String$slice = _String_slice;
var $elm$parser$Parser$Advanced$mapChompedString = F2(
	function (func, _v0) {
		var parse = _v0.a;
		return $elm$parser$Parser$Advanced$Parser(
			function (s0) {
				var _v1 = parse(s0);
				if (_v1.$ === 'Bad') {
					var p = _v1.a;
					var x = _v1.b;
					return A2($elm$parser$Parser$Advanced$Bad, p, x);
				} else {
					var p = _v1.a;
					var a = _v1.b;
					var s1 = _v1.c;
					return A3(
						$elm$parser$Parser$Advanced$Good,
						p,
						A2(
							func,
							A3($elm$core$String$slice, s0.offset, s1.offset, s0.src),
							a),
						s1);
				}
			});
	});
var $elm$parser$Parser$Advanced$getChompedString = function (parser) {
	return A2($elm$parser$Parser$Advanced$mapChompedString, $elm$core$Basics$always, parser);
};
var $elm$parser$Parser$getChompedString = $elm$parser$Parser$Advanced$getChompedString;
var $elm$parser$Parser$Advanced$map2 = F3(
	function (func, _v0, _v1) {
		var parseA = _v0.a;
		var parseB = _v1.a;
		return $elm$parser$Parser$Advanced$Parser(
			function (s0) {
				var _v2 = parseA(s0);
				if (_v2.$ === 'Bad') {
					var p = _v2.a;
					var x = _v2.b;
					return A2($elm$parser$Parser$Advanced$Bad, p, x);
				} else {
					var p1 = _v2.a;
					var a = _v2.b;
					var s1 = _v2.c;
					var _v3 = parseB(s1);
					if (_v3.$ === 'Bad') {
						var p2 = _v3.a;
						var x = _v3.b;
						return A2($elm$parser$Parser$Advanced$Bad, p1 || p2, x);
					} else {
						var p2 = _v3.a;
						var b = _v3.b;
						var s2 = _v3.c;
						return A3(
							$elm$parser$Parser$Advanced$Good,
							p1 || p2,
							A2(func, a, b),
							s2);
					}
				}
			});
	});
var $elm$parser$Parser$Advanced$ignorer = F2(
	function (keepParser, ignoreParser) {
		return A3($elm$parser$Parser$Advanced$map2, $elm$core$Basics$always, keepParser, ignoreParser);
	});
var $elm$parser$Parser$ignorer = $elm$parser$Parser$Advanced$ignorer;
var $elm$core$List$any = F2(
	function (isOkay, list) {
		any:
		while (true) {
			if (!list.b) {
				return false;
			} else {
				var x = list.a;
				var xs = list.b;
				if (isOkay(x)) {
					return true;
				} else {
					var $temp$isOkay = isOkay,
						$temp$list = xs;
					isOkay = $temp$isOkay;
					list = $temp$list;
					continue any;
				}
			}
		}
	});
var $elm$core$List$member = F2(
	function (x, xs) {
		return A2(
			$elm$core$List$any,
			function (a) {
				return _Utils_eq(a, x);
			},
			xs);
	});
var $elm$core$String$isEmpty = function (string) {
	return string === '';
};
var $elm$parser$Parser$Problem = function (a) {
	return {$: 'Problem', a: a};
};
var $elm$parser$Parser$Advanced$problem = function (x) {
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			return A2(
				$elm$parser$Parser$Advanced$Bad,
				false,
				A2($elm$parser$Parser$Advanced$fromState, s, x));
		});
};
var $elm$parser$Parser$problem = function (msg) {
	return $elm$parser$Parser$Advanced$problem(
		$elm$parser$Parser$Problem(msg));
};
var $elm$parser$Parser$Advanced$succeed = function (a) {
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			return A3($elm$parser$Parser$Advanced$Good, false, a, s);
		});
};
var $elm$parser$Parser$succeed = $elm$parser$Parser$Advanced$succeed;
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$notEmpty = function (s) {
	return $elm$core$String$isEmpty(s) ? $elm$parser$Parser$problem('cannot be empty') : $elm$parser$Parser$succeed(s);
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$idParser = function () {
	var valid = function (c) {
		return $elm$core$Char$isAlphaNum(c) || A2(
			$elm$core$List$member,
			c,
			_List_fromArray(
				[
					_Utils_chr('_'),
					_Utils_chr('-'),
					_Utils_chr(':'),
					_Utils_chr('#'),
					_Utils_chr('+')
				]));
	};
	return A2(
		$elm$parser$Parser$andThen,
		$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$notEmpty,
		$elm$parser$Parser$getChompedString(
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed(_Utils_Tuple0),
					$elm$parser$Parser$chompIf($elm$core$Char$isAlpha)),
				$elm$parser$Parser$chompWhile(valid))));
}();
var $elm$parser$Parser$Advanced$keeper = F2(
	function (parseFunc, parseArg) {
		return A3($elm$parser$Parser$Advanced$map2, $elm$core$Basics$apL, parseFunc, parseArg);
	});
var $elm$parser$Parser$keeper = $elm$parser$Parser$Advanced$keeper;
var $elm$parser$Parser$Done = function (a) {
	return {$: 'Done', a: a};
};
var $elm$parser$Parser$Loop = function (a) {
	return {$: 'Loop', a: a};
};
var $elm$core$Set$Set_elm_builtin = function (a) {
	return {$: 'Set_elm_builtin', a: a};
};
var $elm$core$Set$insert = F2(
	function (key, _v0) {
		var dict = _v0.a;
		return $elm$core$Set$Set_elm_builtin(
			A3($elm$core$Dict$insert, key, _Utils_Tuple0, dict));
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$addTag = F2(
	function (value, entity) {
		return _Utils_update(
			entity,
			{
				tags: A2($elm$core$Set$insert, value, entity.tags)
			});
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$emptyLinks = $elm$core$Dict$empty;
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$emptyStats = $elm$core$Dict$empty;
var $elm$core$Set$empty = $elm$core$Set$Set_elm_builtin($elm$core$Dict$empty);
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$emptyTags = $elm$core$Set$empty;
var $elm$parser$Parser$Advanced$loopHelp = F4(
	function (p, state, callback, s0) {
		loopHelp:
		while (true) {
			var _v0 = callback(state);
			var parse = _v0.a;
			var _v1 = parse(s0);
			if (_v1.$ === 'Good') {
				var p1 = _v1.a;
				var step = _v1.b;
				var s1 = _v1.c;
				if (step.$ === 'Loop') {
					var newState = step.a;
					var $temp$p = p || p1,
						$temp$state = newState,
						$temp$callback = callback,
						$temp$s0 = s1;
					p = $temp$p;
					state = $temp$state;
					callback = $temp$callback;
					s0 = $temp$s0;
					continue loopHelp;
				} else {
					var result = step.a;
					return A3($elm$parser$Parser$Advanced$Good, p || p1, result, s1);
				}
			} else {
				var p1 = _v1.a;
				var x = _v1.b;
				return A2($elm$parser$Parser$Advanced$Bad, p || p1, x);
			}
		}
	});
var $elm$parser$Parser$Advanced$loop = F2(
	function (state, callback) {
		return $elm$parser$Parser$Advanced$Parser(
			function (s) {
				return A4($elm$parser$Parser$Advanced$loopHelp, false, state, callback, s);
			});
	});
var $elm$parser$Parser$Advanced$map = F2(
	function (func, _v0) {
		var parse = _v0.a;
		return $elm$parser$Parser$Advanced$Parser(
			function (s0) {
				var _v1 = parse(s0);
				if (_v1.$ === 'Good') {
					var p = _v1.a;
					var a = _v1.b;
					var s1 = _v1.c;
					return A3(
						$elm$parser$Parser$Advanced$Good,
						p,
						func(a),
						s1);
				} else {
					var p = _v1.a;
					var x = _v1.b;
					return A2($elm$parser$Parser$Advanced$Bad, p, x);
				}
			});
	});
var $elm$parser$Parser$map = $elm$parser$Parser$Advanced$map;
var $elm$parser$Parser$Advanced$Done = function (a) {
	return {$: 'Done', a: a};
};
var $elm$parser$Parser$Advanced$Loop = function (a) {
	return {$: 'Loop', a: a};
};
var $elm$parser$Parser$toAdvancedStep = function (step) {
	if (step.$ === 'Loop') {
		var s = step.a;
		return $elm$parser$Parser$Advanced$Loop(s);
	} else {
		var a = step.a;
		return $elm$parser$Parser$Advanced$Done(a);
	}
};
var $elm$parser$Parser$loop = F2(
	function (state, callback) {
		return A2(
			$elm$parser$Parser$Advanced$loop,
			state,
			function (s) {
				return A2(
					$elm$parser$Parser$map,
					$elm$parser$Parser$toAdvancedStep,
					callback(s));
			});
	});
var $elm$core$Basics$composeR = F3(
	function (f, g, x) {
		return g(
			f(x));
	});
var $elm$core$Maybe$map = F2(
	function (f, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return $elm$core$Maybe$Just(
				f(value));
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $elm$parser$Parser$Advanced$Append = F2(
	function (a, b) {
		return {$: 'Append', a: a, b: b};
	});
var $elm$parser$Parser$Advanced$oneOfHelp = F3(
	function (s0, bag, parsers) {
		oneOfHelp:
		while (true) {
			if (!parsers.b) {
				return A2($elm$parser$Parser$Advanced$Bad, false, bag);
			} else {
				var parse = parsers.a.a;
				var remainingParsers = parsers.b;
				var _v1 = parse(s0);
				if (_v1.$ === 'Good') {
					var step = _v1;
					return step;
				} else {
					var step = _v1;
					var p = step.a;
					var x = step.b;
					if (p) {
						return step;
					} else {
						var $temp$s0 = s0,
							$temp$bag = A2($elm$parser$Parser$Advanced$Append, bag, x),
							$temp$parsers = remainingParsers;
						s0 = $temp$s0;
						bag = $temp$bag;
						parsers = $temp$parsers;
						continue oneOfHelp;
					}
				}
			}
		}
	});
var $elm$parser$Parser$Advanced$oneOf = function (parsers) {
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			return A3($elm$parser$Parser$Advanced$oneOfHelp, s, $elm$parser$Parser$Advanced$Empty, parsers);
		});
};
var $elm$parser$Parser$oneOf = $elm$parser$Parser$Advanced$oneOf;
var $elm$parser$Parser$ExpectingSymbol = function (a) {
	return {$: 'ExpectingSymbol', a: a};
};
var $elm$parser$Parser$Advanced$Token = F2(
	function (a, b) {
		return {$: 'Token', a: a, b: b};
	});
var $elm$parser$Parser$Advanced$isSubString = _Parser_isSubString;
var $elm$core$Basics$not = _Basics_not;
var $elm$parser$Parser$Advanced$token = function (_v0) {
	var str = _v0.a;
	var expecting = _v0.b;
	var progress = !$elm$core$String$isEmpty(str);
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			var _v1 = A5($elm$parser$Parser$Advanced$isSubString, str, s.offset, s.row, s.col, s.src);
			var newOffset = _v1.a;
			var newRow = _v1.b;
			var newCol = _v1.c;
			return _Utils_eq(newOffset, -1) ? A2(
				$elm$parser$Parser$Advanced$Bad,
				false,
				A2($elm$parser$Parser$Advanced$fromState, s, expecting)) : A3(
				$elm$parser$Parser$Advanced$Good,
				progress,
				_Utils_Tuple0,
				{col: newCol, context: s.context, indent: s.indent, offset: newOffset, row: newRow, src: s.src});
		});
};
var $elm$parser$Parser$Advanced$symbol = $elm$parser$Parser$Advanced$token;
var $elm$parser$Parser$symbol = function (str) {
	return $elm$parser$Parser$Advanced$symbol(
		A2(
			$elm$parser$Parser$Advanced$Token,
			str,
			$elm$parser$Parser$ExpectingSymbol(str)));
};
var $elm$core$String$toInt = _String_toInt;
var $elm$core$Maybe$withDefault = F2(
	function (_default, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return value;
		} else {
			return _default;
		}
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$numberParser = function () {
	var int_ = A2(
		$elm$parser$Parser$andThen,
		A2(
			$elm$core$Basics$composeR,
			$elm$core$String$toInt,
			A2(
				$elm$core$Basics$composeR,
				$elm$core$Maybe$map($elm$parser$Parser$succeed),
				$elm$core$Maybe$withDefault(
					$elm$parser$Parser$problem('not an int')))),
		$elm$parser$Parser$getChompedString(
			$elm$parser$Parser$chompWhile($elm$core$Char$isDigit)));
	return $elm$parser$Parser$oneOf(
		_List_fromArray(
			[
				A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed($elm$core$Basics$negate),
					$elm$parser$Parser$symbol('-')),
				int_),
				int_
			]));
}();
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$propertyNameParser = function () {
	var valid = function (c) {
		return $elm$core$Char$isAlphaNum(c) || A2(
			$elm$core$List$member,
			c,
			_List_fromArray(
				[
					_Utils_chr('_'),
					_Utils_chr(':'),
					_Utils_chr('#')
				]));
	};
	return A2(
		$elm$parser$Parser$andThen,
		$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$notEmpty,
		$elm$parser$Parser$getChompedString(
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$succeed(_Utils_Tuple0),
				$elm$parser$Parser$chompWhile(valid))));
}();
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$setLink = F3(
	function (key, value, entity) {
		return _Utils_update(
			entity,
			{
				links: A3($elm$core$Dict$insert, key, value, entity.links)
			});
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$setStat = F3(
	function (key, value, entity) {
		return _Utils_update(
			entity,
			{
				stats: A3($elm$core$Dict$insert, key, value, entity.stats)
			});
	});
var $elm$parser$Parser$Advanced$spaces = $elm$parser$Parser$Advanced$chompWhile(
	function (c) {
		return _Utils_eq(
			c,
			_Utils_chr(' ')) || (_Utils_eq(
			c,
			_Utils_chr('\n')) || _Utils_eq(
			c,
			_Utils_chr('\r')));
	});
var $elm$parser$Parser$spaces = $elm$parser$Parser$Advanced$spaces;
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$propsParser = function () {
	var toComponent = F2(
		function (key, fn) {
			return fn(key);
		});
	var helper = function (acc) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$keeper,
					A2(
						$elm$parser$Parser$keeper,
						A2(
							$elm$parser$Parser$ignorer,
							A2(
								$elm$parser$Parser$ignorer,
								$elm$parser$Parser$succeed(toComponent),
								$elm$parser$Parser$spaces),
							$elm$parser$Parser$symbol('.')),
						$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$propertyNameParser),
					$elm$parser$Parser$oneOf(
						_List_fromArray(
							[
								A2(
								$elm$parser$Parser$keeper,
								A2(
									$elm$parser$Parser$ignorer,
									$elm$parser$Parser$succeed($elm$core$Basics$identity),
									$elm$parser$Parser$symbol('=')),
								$elm$parser$Parser$oneOf(
									_List_fromArray(
										[
											A2(
											$elm$parser$Parser$map,
											function (v) {
												return function (k) {
													return $elm$parser$Parser$Loop(
														A3($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$setLink, k, v, acc));
												};
											},
											$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$idParser),
											A2(
											$elm$parser$Parser$map,
											function (v) {
												return function (k) {
													return $elm$parser$Parser$Loop(
														A3($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$setStat, k, v, acc));
												};
											},
											$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$numberParser)
										]))),
								$elm$parser$Parser$succeed(
								function (t) {
									return $elm$parser$Parser$Loop(
										A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$addTag, t, acc));
								})
							]))),
					$elm$parser$Parser$succeed(
					$elm$parser$Parser$Done(acc))
				]));
	};
	var emptyNarrativeComponent = {links: $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$emptyLinks, stats: $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$emptyStats, tags: $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$emptyTags};
	return A2($elm$parser$Parser$loop, emptyNarrativeComponent, helper);
}();
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$entityParser = function () {
	var toEntity = F2(
		function (id, narrativeComponent) {
			return _Utils_Tuple2(id, narrativeComponent);
		});
	return A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			$elm$parser$Parser$succeed(toEntity),
			$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$idParser),
		A2($elm$parser$Parser$ignorer, $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$propsParser, $elm$parser$Parser$end));
}();
var $elm$core$Result$mapError = F2(
	function (f, result) {
		if (result.$ === 'Ok') {
			var v = result.a;
			return $elm$core$Result$Ok(v);
		} else {
			var e = result.a;
			return $elm$core$Result$Err(
				f(e));
		}
	});
var $elm$core$Tuple$mapSecond = F2(
	function (func, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			x,
			func(y));
	});
var $elm$parser$Parser$DeadEnd = F3(
	function (row, col, problem) {
		return {col: col, problem: problem, row: row};
	});
var $elm$parser$Parser$problemToDeadEnd = function (p) {
	return A3($elm$parser$Parser$DeadEnd, p.row, p.col, p.problem);
};
var $elm$parser$Parser$Advanced$bagToList = F2(
	function (bag, list) {
		bagToList:
		while (true) {
			switch (bag.$) {
				case 'Empty':
					return list;
				case 'AddRight':
					var bag1 = bag.a;
					var x = bag.b;
					var $temp$bag = bag1,
						$temp$list = A2($elm$core$List$cons, x, list);
					bag = $temp$bag;
					list = $temp$list;
					continue bagToList;
				default:
					var bag1 = bag.a;
					var bag2 = bag.b;
					var $temp$bag = bag1,
						$temp$list = A2($elm$parser$Parser$Advanced$bagToList, bag2, list);
					bag = $temp$bag;
					list = $temp$list;
					continue bagToList;
			}
		}
	});
var $elm$parser$Parser$Advanced$run = F2(
	function (_v0, src) {
		var parse = _v0.a;
		var _v1 = parse(
			{col: 1, context: _List_Nil, indent: 1, offset: 0, row: 1, src: src});
		if (_v1.$ === 'Good') {
			var value = _v1.b;
			return $elm$core$Result$Ok(value);
		} else {
			var bag = _v1.b;
			return $elm$core$Result$Err(
				A2($elm$parser$Parser$Advanced$bagToList, bag, _List_Nil));
		}
	});
var $elm$parser$Parser$run = F2(
	function (parser, source) {
		var _v0 = A2($elm$parser$Parser$Advanced$run, parser, source);
		if (_v0.$ === 'Ok') {
			var a = _v0.a;
			return $elm$core$Result$Ok(a);
		} else {
			var problems = _v0.a;
			return $elm$core$Result$Err(
				A2($elm$core$List$map, $elm$parser$Parser$problemToDeadEnd, problems));
		}
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$parseEntity = F2(
	function (extendFn, _v0) {
		var text = _v0.a;
		var extraFields = _v0.b;
		return A2(
			$elm$core$Result$mapError,
			$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$deadEndsToString,
			A2(
				$elm$core$Result$map,
				$elm$core$Tuple$mapSecond(
					extendFn(extraFields)),
				A2($elm$parser$Parser$run, $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$entityParser, text)));
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$parseMany = F2(
	function (extendFn, entities) {
		var displayError = F2(
			function (source, e) {
				return _Utils_Tuple2('Entity def: ' + source, e);
			});
		var addParsedEntity = F2(
			function (entity, acc) {
				var source = entity.a;
				var extraFields = entity.b;
				var _v0 = A2($jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$parseEntity, extendFn, entity);
				if (_v0.$ === 'Ok') {
					var _v1 = _v0.a;
					var id = _v1.a;
					var parsedEntity = _v1.b;
					return A2(
						$elm$core$Result$map,
						A2($elm$core$Dict$insert, id, parsedEntity),
						acc);
				} else {
					var err = _v0.a;
					if (acc.$ === 'Ok') {
						return $elm$core$Result$Err(
							_List_fromArray(
								[
									A2(displayError, source, err)
								]));
					} else {
						var errors = acc.a;
						return $elm$core$Result$Err(
							A2(
								$elm$core$List$cons,
								A2(displayError, source, err),
								errors));
					}
				}
			});
		return A3(
			$elm$core$List$foldl,
			addParsedEntity,
			$elm$core$Result$Ok($elm$core$Dict$empty),
			entities);
	});
var $elm$core$Dict$foldl = F3(
	function (func, acc, dict) {
		foldl:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldl, func, acc, left)),
					$temp$dict = right;
				func = $temp$func;
				acc = $temp$acc;
				dict = $temp$dict;
				continue foldl;
			}
		}
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$Looping = {$: 'Looping'};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$Randomly = {$: 'Randomly'};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$Sticking = {$: 'Sticking'};
var $elm$core$Basics$composeL = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
var $elm$core$List$all = F2(
	function (isOkay, list) {
		return !A2(
			$elm$core$List$any,
			A2($elm$core$Basics$composeL, $elm$core$Basics$not, isOkay),
			list);
	});
var $elm$parser$Parser$Advanced$backtrackable = function (_v0) {
	var parse = _v0.a;
	return $elm$parser$Parser$Advanced$Parser(
		function (s0) {
			var _v1 = parse(s0);
			if (_v1.$ === 'Bad') {
				var x = _v1.b;
				return A2($elm$parser$Parser$Advanced$Bad, false, x);
			} else {
				var a = _v1.b;
				var s1 = _v1.c;
				return A3($elm$parser$Parser$Advanced$Good, false, a, s1);
			}
		});
};
var $elm$parser$Parser$backtrackable = $elm$parser$Parser$Advanced$backtrackable;
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$break = $elm$parser$Parser$symbol('|');
var $elm$parser$Parser$Advanced$findSubString = _Parser_findSubString;
var $elm$parser$Parser$Advanced$fromInfo = F4(
	function (row, col, x, context) {
		return A2(
			$elm$parser$Parser$Advanced$AddRight,
			$elm$parser$Parser$Advanced$Empty,
			A4($elm$parser$Parser$Advanced$DeadEnd, row, col, x, context));
	});
var $elm$parser$Parser$Advanced$chompUntil = function (_v0) {
	var str = _v0.a;
	var expecting = _v0.b;
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			var _v1 = A5($elm$parser$Parser$Advanced$findSubString, str, s.offset, s.row, s.col, s.src);
			var newOffset = _v1.a;
			var newRow = _v1.b;
			var newCol = _v1.c;
			return _Utils_eq(newOffset, -1) ? A2(
				$elm$parser$Parser$Advanced$Bad,
				false,
				A4($elm$parser$Parser$Advanced$fromInfo, newRow, newCol, expecting, s.context)) : A3(
				$elm$parser$Parser$Advanced$Good,
				_Utils_cmp(s.offset, newOffset) < 0,
				_Utils_Tuple0,
				{col: newCol, context: s.context, indent: s.indent, offset: newOffset, row: newRow, src: s.src});
		});
};
var $elm$parser$Parser$Expecting = function (a) {
	return {$: 'Expecting', a: a};
};
var $elm$parser$Parser$toToken = function (str) {
	return A2(
		$elm$parser$Parser$Advanced$Token,
		str,
		$elm$parser$Parser$Expecting(str));
};
var $elm$parser$Parser$chompUntil = function (str) {
	return $elm$parser$Parser$Advanced$chompUntil(
		$elm$parser$Parser$toToken(str));
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$close = $elm$parser$Parser$symbol('}');
var $elm$parser$Parser$Advanced$commit = function (a) {
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			return A3($elm$parser$Parser$Advanced$Good, true, a, s);
		});
};
var $elm$parser$Parser$commit = $elm$parser$Parser$Advanced$commit;
var $elm$core$Array$fromListHelp = F3(
	function (list, nodeList, nodeListSize) {
		fromListHelp:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, list);
			var jsArray = _v0.a;
			var remainingItems = _v0.b;
			if (_Utils_cmp(
				$elm$core$Elm$JsArray$length(jsArray),
				$elm$core$Array$branchFactor) < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					true,
					{nodeList: nodeList, nodeListSize: nodeListSize, tail: jsArray});
			} else {
				var $temp$list = remainingItems,
					$temp$nodeList = A2(
					$elm$core$List$cons,
					$elm$core$Array$Leaf(jsArray),
					nodeList),
					$temp$nodeListSize = nodeListSize + 1;
				list = $temp$list;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue fromListHelp;
			}
		}
	});
var $elm$core$Array$fromList = function (list) {
	if (!list.b) {
		return $elm$core$Array$empty;
	} else {
		return A3($elm$core$Array$fromListHelp, list, _List_Nil, 0);
	}
};
var $elm$core$Bitwise$and = _Bitwise_and;
var $elm$core$Bitwise$shiftRightZfBy = _Bitwise_shiftRightZfBy;
var $elm$core$Array$bitMask = 4294967295 >>> (32 - $elm$core$Array$shiftStep);
var $elm$core$Basics$ge = _Utils_ge;
var $elm$core$Elm$JsArray$unsafeGet = _JsArray_unsafeGet;
var $elm$core$Array$getHelp = F3(
	function (shift, index, tree) {
		getHelp:
		while (true) {
			var pos = $elm$core$Array$bitMask & (index >>> shift);
			var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (_v0.$ === 'SubTree') {
				var subTree = _v0.a;
				var $temp$shift = shift - $elm$core$Array$shiftStep,
					$temp$index = index,
					$temp$tree = subTree;
				shift = $temp$shift;
				index = $temp$index;
				tree = $temp$tree;
				continue getHelp;
			} else {
				var values = _v0.a;
				return A2($elm$core$Elm$JsArray$unsafeGet, $elm$core$Array$bitMask & index, values);
			}
		}
	});
var $elm$core$Bitwise$shiftLeftBy = _Bitwise_shiftLeftBy;
var $elm$core$Array$tailIndex = function (len) {
	return (len >>> 5) << 5;
};
var $elm$core$Array$get = F2(
	function (index, _v0) {
		var len = _v0.a;
		var startShift = _v0.b;
		var tree = _v0.c;
		var tail = _v0.d;
		return ((index < 0) || (_Utils_cmp(index, len) > -1)) ? $elm$core$Maybe$Nothing : ((_Utils_cmp(
			index,
			$elm$core$Array$tailIndex(len)) > -1) ? $elm$core$Maybe$Just(
			A2($elm$core$Elm$JsArray$unsafeGet, $elm$core$Array$bitMask & index, tail)) : $elm$core$Maybe$Just(
			A3($elm$core$Array$getHelp, startShift, index, tree)));
	});
var $elm$random$Random$Seed = F2(
	function (a, b) {
		return {$: 'Seed', a: a, b: b};
	});
var $elm$random$Random$next = function (_v0) {
	var state0 = _v0.a;
	var incr = _v0.b;
	return A2($elm$random$Random$Seed, ((state0 * 1664525) + incr) >>> 0, incr);
};
var $elm$random$Random$initialSeed = function (x) {
	var _v0 = $elm$random$Random$next(
		A2($elm$random$Random$Seed, 0, 1013904223));
	var state1 = _v0.a;
	var incr = _v0.b;
	var state2 = (state1 + x) >>> 0;
	return $elm$random$Random$next(
		A2($elm$random$Random$Seed, state2, incr));
};
var $elm$random$Random$Generator = function (a) {
	return {$: 'Generator', a: a};
};
var $elm$core$Bitwise$xor = _Bitwise_xor;
var $elm$random$Random$peel = function (_v0) {
	var state = _v0.a;
	var word = (state ^ (state >>> ((state >>> 28) + 4))) * 277803737;
	return ((word >>> 22) ^ word) >>> 0;
};
var $elm$random$Random$int = F2(
	function (a, b) {
		return $elm$random$Random$Generator(
			function (seed0) {
				var _v0 = (_Utils_cmp(a, b) < 0) ? _Utils_Tuple2(a, b) : _Utils_Tuple2(b, a);
				var lo = _v0.a;
				var hi = _v0.b;
				var range = (hi - lo) + 1;
				if (!((range - 1) & range)) {
					return _Utils_Tuple2(
						(((range - 1) & $elm$random$Random$peel(seed0)) >>> 0) + lo,
						$elm$random$Random$next(seed0));
				} else {
					var threshhold = (((-range) >>> 0) % range) >>> 0;
					var accountForBias = function (seed) {
						accountForBias:
						while (true) {
							var x = $elm$random$Random$peel(seed);
							var seedN = $elm$random$Random$next(seed);
							if (_Utils_cmp(x, threshhold) < 0) {
								var $temp$seed = seedN;
								seed = $temp$seed;
								continue accountForBias;
							} else {
								return _Utils_Tuple2((x % range) + lo, seedN);
							}
						}
					};
					return accountForBias(seed0);
				}
			});
	});
var $elm$core$List$isEmpty = function (xs) {
	if (!xs.b) {
		return true;
	} else {
		return false;
	}
};
var $elm$parser$Parser$Advanced$lazy = function (thunk) {
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			var _v0 = thunk(_Utils_Tuple0);
			var parse = _v0.a;
			return parse(s);
		});
};
var $elm$parser$Parser$lazy = $elm$parser$Parser$Advanced$lazy;
var $elm$core$Basics$min = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) < 0) ? x : y;
	});
var $elm$core$Basics$modBy = _Basics_modBy;
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$open = $elm$parser$Parser$symbol('{');
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$CompareLink = F2(
	function (a, b) {
		return {$: 'CompareLink', a: a, b: b};
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$CompareStat = F2(
	function (a, b) {
		return {$: 'CompareStat', a: a, b: b};
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasLink = F2(
	function (a, b) {
		return {$: 'HasLink', a: a, b: b};
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasStat = F3(
	function (a, b, c) {
		return {$: 'HasStat', a: a, b: b, c: c};
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasTag = function (a) {
	return {$: 'HasTag', a: a};
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Match = F2(
	function (a, b) {
		return {$: 'Match', a: a, b: b};
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Not = function (a) {
	return {$: 'Not', a: a};
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SpecificLink = function (a) {
	return {$: 'SpecificLink', a: a};
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SpecificStat = function (a) {
	return {$: 'SpecificStat', a: a};
};
var $elm$parser$Parser$ExpectingKeyword = function (a) {
	return {$: 'ExpectingKeyword', a: a};
};
var $elm$parser$Parser$Advanced$keyword = function (_v0) {
	var kwd = _v0.a;
	var expecting = _v0.b;
	var progress = !$elm$core$String$isEmpty(kwd);
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			var _v1 = A5($elm$parser$Parser$Advanced$isSubString, kwd, s.offset, s.row, s.col, s.src);
			var newOffset = _v1.a;
			var newRow = _v1.b;
			var newCol = _v1.c;
			return (_Utils_eq(newOffset, -1) || (0 <= A3(
				$elm$parser$Parser$Advanced$isSubChar,
				function (c) {
					return $elm$core$Char$isAlphaNum(c) || _Utils_eq(
						c,
						_Utils_chr('_'));
				},
				newOffset,
				s.src))) ? A2(
				$elm$parser$Parser$Advanced$Bad,
				false,
				A2($elm$parser$Parser$Advanced$fromState, s, expecting)) : A3(
				$elm$parser$Parser$Advanced$Good,
				progress,
				_Utils_Tuple0,
				{col: newCol, context: s.context, indent: s.indent, offset: newOffset, row: newRow, src: s.src});
		});
};
var $elm$parser$Parser$keyword = function (kwd) {
	return $elm$parser$Parser$Advanced$keyword(
		A2(
			$elm$parser$Parser$Advanced$Token,
			kwd,
			$elm$parser$Parser$ExpectingKeyword(kwd)));
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$MatchAny = function (a) {
	return {$: 'MatchAny', a: a};
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$selectorParser = $elm$parser$Parser$oneOf(
	_List_fromArray(
		[
			A2(
			$elm$parser$Parser$map,
			$elm$core$Basics$always($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$MatchAny),
			$elm$parser$Parser$symbol('*')),
			A2(
			$elm$parser$Parser$map,
			$elm$core$Basics$always(
				$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Match('$')),
			$elm$parser$Parser$symbol('$')),
			A2($elm$parser$Parser$map, $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Match, $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$idParser)
		]));
var $elm$parser$Parser$token = function (str) {
	return $elm$parser$Parser$Advanced$token(
		$elm$parser$Parser$toToken(str));
};
function $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$cyclic$matcherParser() {
	var toMatcher = F2(
		function (selector, queries) {
			return selector(queries);
		});
	return A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			$elm$parser$Parser$succeed(toMatcher),
			$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$selectorParser),
		$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$cyclic$queriesParser());
}
function $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$cyclic$queriesParser() {
	var toQuery = F4(
		function (acc, negate, propName, queryConstructor) {
			return negate ? $elm$parser$Parser$Loop(
				A2(
					$elm$core$List$cons,
					$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Not(
						queryConstructor(propName)),
					acc)) : $elm$parser$Parser$Loop(
				A2(
					$elm$core$List$cons,
					queryConstructor(propName),
					acc));
		});
	var compareParser = F2(
		function (kind, mapper) {
			return A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$keeper,
					A2(
						$elm$parser$Parser$ignorer,
						A2(
							$elm$parser$Parser$ignorer,
							$elm$parser$Parser$succeed(mapper),
							$elm$parser$Parser$keyword('(' + kind)),
						$elm$parser$Parser$chompWhile(
							$elm$core$Basics$eq(
								_Utils_chr(' ')))),
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$oneOf(
							_List_fromArray(
								[
									A2(
									$elm$parser$Parser$map,
									$elm$core$Basics$always('$'),
									$elm$parser$Parser$token('$')),
									$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$idParser
								])),
						$elm$parser$Parser$symbol('.'))),
				A2(
					$elm$parser$Parser$ignorer,
					$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$propertyNameParser,
					$elm$parser$Parser$symbol(')')));
		});
	var helper = function (acc) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$keeper,
					A2(
						$elm$parser$Parser$keeper,
						A2(
							$elm$parser$Parser$keeper,
							A2(
								$elm$parser$Parser$ignorer,
								$elm$parser$Parser$succeed(
									toQuery(acc)),
								$elm$parser$Parser$symbol('.')),
							$elm$parser$Parser$oneOf(
								_List_fromArray(
									[
										A2(
										$elm$parser$Parser$map,
										$elm$core$Basics$always(true),
										$elm$parser$Parser$symbol('!')),
										$elm$parser$Parser$succeed(false)
									]))),
						$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$propertyNameParser),
					$elm$parser$Parser$oneOf(
						_List_fromArray(
							[
								A2(
								$elm$parser$Parser$keeper,
								A2(
									$elm$parser$Parser$ignorer,
									$elm$parser$Parser$succeed($elm$core$Basics$identity),
									$elm$parser$Parser$symbol('>')),
								$elm$parser$Parser$oneOf(
									_List_fromArray(
										[
											A2(
											compareParser,
											'stat',
											F3(
												function (compareID, compareKey, key) {
													return A3(
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasStat,
														key,
														$elm$core$Basics$GT,
														A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$CompareStat, compareID, compareKey));
												})),
											A2(
											$elm$parser$Parser$map,
											function (n) {
												return function (key) {
													return A3(
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasStat,
														key,
														$elm$core$Basics$GT,
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SpecificStat(n));
												};
											},
											$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$numberParser)
										]))),
								A2(
								$elm$parser$Parser$keeper,
								A2(
									$elm$parser$Parser$ignorer,
									$elm$parser$Parser$succeed($elm$core$Basics$identity),
									$elm$parser$Parser$symbol('<')),
								$elm$parser$Parser$oneOf(
									_List_fromArray(
										[
											A2(
											compareParser,
											'stat',
											F3(
												function (compareID, compareKey, key) {
													return A3(
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasStat,
														key,
														$elm$core$Basics$LT,
														A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$CompareStat, compareID, compareKey));
												})),
											A2(
											$elm$parser$Parser$map,
											function (n) {
												return function (key) {
													return A3(
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasStat,
														key,
														$elm$core$Basics$LT,
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SpecificStat(n));
												};
											},
											$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$numberParser)
										]))),
								A2(
								$elm$parser$Parser$keeper,
								A2(
									$elm$parser$Parser$ignorer,
									$elm$parser$Parser$succeed($elm$core$Basics$identity),
									$elm$parser$Parser$symbol('=')),
								$elm$parser$Parser$oneOf(
									_List_fromArray(
										[
											A2(
											$elm$parser$Parser$map,
											function (n) {
												return function (key) {
													return A3(
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasStat,
														key,
														$elm$core$Basics$EQ,
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SpecificStat(n));
												};
											},
											$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$numberParser),
											A2(
											$elm$parser$Parser$map,
											function (_v0) {
												return function (key) {
													return A2(
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasLink,
														key,
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SpecificLink(
															A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Match, '$', _List_Nil)));
												};
											},
											$elm$parser$Parser$symbol('$')),
											A2(
											$elm$parser$Parser$map,
											function (id) {
												return function (key) {
													return A2(
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasLink,
														key,
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SpecificLink(
															A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Match, id, _List_Nil)));
												};
											},
											$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$idParser),
											A2(
											compareParser,
											'stat',
											F3(
												function (compareID, compareKey, key) {
													return A3(
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasStat,
														key,
														$elm$core$Basics$EQ,
														A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$CompareStat, compareID, compareKey));
												})),
											A2(
											compareParser,
											'link',
											F3(
												function (compareID, compareKey, key) {
													return A2(
														$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasLink,
														key,
														A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$CompareLink, compareID, compareKey));
												})),
											A2(
											$elm$parser$Parser$keeper,
											A2(
												$elm$parser$Parser$ignorer,
												$elm$parser$Parser$succeed($elm$core$Basics$identity),
												$elm$parser$Parser$symbol('(')),
											A2(
												$elm$parser$Parser$ignorer,
												A2(
													$elm$parser$Parser$map,
													function (matcher) {
														return function (key) {
															return A2(
																$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasLink,
																key,
																$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SpecificLink(matcher));
														};
													},
													$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$cyclic$matcherParser()),
												$elm$parser$Parser$symbol(')')))
										]))),
								$elm$parser$Parser$succeed(
								function (t) {
									return $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasTag(t);
								})
							]))),
					$elm$parser$Parser$succeed(
					$elm$parser$Parser$Done(acc))
				]));
	};
	return A2($elm$parser$Parser$loop, _List_Nil, helper);
}
try {
	var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$matcherParser = $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$cyclic$matcherParser();
	$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$cyclic$matcherParser = function () {
		return $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$matcherParser;
	};
	var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$queriesParser = $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$cyclic$queriesParser();
	$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$cyclic$queriesParser = function () {
		return $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$queriesParser;
	};
} catch ($) {
	throw 'Some top-level definitions from `NarrativeEngine.Syntax.RuleParser` are causing infinite recursion:\n\n  ┌─────┐\n  │    matcherParser\n  │     ↓\n  │    queriesParser\n  └─────┘\n\nThese errors are very tricky, so read https://elm-lang.org/0.19.1/bad-recursion to learn how to fix it!';}
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$parseMatcher = function (text) {
	return A2(
		$elm$core$Result$mapError,
		$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$deadEndsToString,
		A2(
			$elm$parser$Parser$run,
			A2($elm$parser$Parser$ignorer, $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$matcherParser, $elm$parser$Parser$end),
			text));
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$sequence = function (list) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (r, acc) {
				if (r.$ === 'Ok') {
					var a = r.a;
					return A2(
						$elm$core$Result$map,
						$elm$core$List$cons(a),
						acc);
				} else {
					var e = r.a;
					return $elm$core$Result$Err(e);
				}
			}),
		$elm$core$Result$Ok(_List_Nil),
		list);
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$parseMultiple = F2(
	function (parser, strings) {
		return $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$sequence(
			A2($elm$core$List$map, parser, strings));
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$fromResult = function (res) {
	if (res.$ === 'Ok') {
		var s = res.a;
		return $elm$parser$Parser$succeed(s);
	} else {
		var e = res.a;
		return $elm$parser$Parser$problem(e);
	}
};
var $elm$core$String$replace = F3(
	function (before, after, string) {
		return A2(
			$elm$core$String$join,
			after,
			A2($elm$core$String$split, before, string));
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$propertyText = function (config) {
	var keywords = A2(
		$elm$core$List$map,
		function (_v0) {
			var propName = _v0.a;
			var fn = _v0.b;
			return A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$succeed(fn),
				$elm$parser$Parser$keyword(propName));
		},
		$elm$core$Dict$toList(config.propKeywords));
	var getProp = F2(
		function (id, propFn) {
			return propFn(
				A3($elm$core$String$replace, '$', config.trigger, id));
		});
	return A2(
		$elm$parser$Parser$andThen,
		$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$fromResult,
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$keeper,
				$elm$parser$Parser$succeed(getProp),
				A2(
					$elm$parser$Parser$ignorer,
					A2(
						$elm$parser$Parser$andThen,
						$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$notEmpty,
						$elm$parser$Parser$getChompedString(
							$elm$parser$Parser$chompWhile(
								function (c) {
									return !A2(
										$elm$core$List$member,
										c,
										_List_fromArray(
											[
												_Utils_chr('{'),
												_Utils_chr('.'),
												_Utils_chr('|'),
												_Utils_chr('}')
											]));
								}))),
					$elm$parser$Parser$symbol('.'))),
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$oneOf(keywords),
				$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$close)));
};
var $elm$core$Dict$filter = F2(
	function (isGood, dict) {
		return A3(
			$elm$core$Dict$foldl,
			F3(
				function (k, v, d) {
					return A2(isGood, k, v) ? A3($elm$core$Dict$insert, k, v, d) : d;
				}),
			$elm$core$Dict$empty,
			dict);
	});
var $elm$core$Maybe$andThen = F2(
	function (callback, maybeValue) {
		if (maybeValue.$ === 'Just') {
			var value = maybeValue.a;
			return callback(value);
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $elm$core$Dict$get = F2(
	function (targetKey, dict) {
		get:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return $elm$core$Maybe$Nothing;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var _v1 = A2($elm$core$Basics$compare, targetKey, key);
				switch (_v1.$) {
					case 'LT':
						var $temp$targetKey = targetKey,
							$temp$dict = left;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
					case 'EQ':
						return $elm$core$Maybe$Just(value);
					default:
						var $temp$targetKey = targetKey,
							$temp$dict = right;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
				}
			}
		}
	});
var $elm$core$Maybe$map2 = F3(
	function (func, ma, mb) {
		if (ma.$ === 'Nothing') {
			return $elm$core$Maybe$Nothing;
		} else {
			var a = ma.a;
			if (mb.$ === 'Nothing') {
				return $elm$core$Maybe$Nothing;
			} else {
				var b = mb.a;
				return $elm$core$Maybe$Just(
					A2(func, a, b));
			}
		}
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$hasStat = F5(
	function (key, comparator, statMatcher, store, entity) {
		if (statMatcher.$ === 'SpecificStat') {
			var value = statMatcher.a;
			return function (actual) {
				return _Utils_eq(
					A2($elm$core$Basics$compare, actual, value),
					comparator);
			}(
				A2(
					$elm$core$Maybe$withDefault,
					0,
					A2($elm$core$Dict$get, key, entity.stats)));
		} else {
			var compareID = statMatcher.a;
			var compareKey = statMatcher.b;
			return A2(
				$elm$core$Maybe$withDefault,
				false,
				A2(
					$elm$core$Maybe$map,
					$elm$core$Basics$eq(comparator),
					A3(
						$elm$core$Maybe$map2,
						$elm$core$Basics$compare,
						A2($elm$core$Dict$get, key, entity.stats),
						A2(
							$elm$core$Maybe$andThen,
							A2(
								$elm$core$Basics$composeR,
								function ($) {
									return $.stats;
								},
								$elm$core$Dict$get(compareKey)),
							A2($elm$core$Dict$get, compareID, store)))));
		}
	});
var $elm$core$Dict$member = F2(
	function (key, dict) {
		var _v0 = A2($elm$core$Dict$get, key, dict);
		if (_v0.$ === 'Just') {
			return true;
		} else {
			return false;
		}
	});
var $elm$core$Set$member = F2(
	function (key, _v0) {
		var dict = _v0.a;
		return A2($elm$core$Dict$member, key, dict);
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$hasTag = F2(
	function (value, entity) {
		return A2($elm$core$Set$member, value, entity.tags);
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$findSpecific = F3(
	function (id, queries, store) {
		var matchesQueries = function (entity) {
			return A2(
				$elm$core$List$all,
				function (q) {
					return A3($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$queryFn, q, store, entity);
				},
				queries) ? _List_fromArray(
				[
					_Utils_Tuple2(id, entity)
				]) : _List_Nil;
		};
		return A2(
			$elm$core$Maybe$withDefault,
			_List_Nil,
			A2(
				$elm$core$Maybe$map,
				matchesQueries,
				A2($elm$core$Dict$get, id, store)));
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$hasLink = F4(
	function (key, linkMatcher, store, entity) {
		var assertMatch = F2(
			function (matcher, actualID) {
				if (matcher.$ === 'Match') {
					var expectedID = matcher.a;
					var qs = matcher.b;
					return _Utils_eq(expectedID, actualID) && (!$elm$core$List$isEmpty(
						A3($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$findSpecific, actualID, qs, store)));
				} else {
					var qs = matcher.a;
					return !$elm$core$List$isEmpty(
						A3($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$findSpecific, actualID, qs, store));
				}
			});
		if (linkMatcher.$ === 'SpecificLink') {
			var entityMatcher = linkMatcher.a;
			return A2(
				$elm$core$Maybe$withDefault,
				false,
				A2(
					$elm$core$Maybe$map,
					assertMatch(entityMatcher),
					A2($elm$core$Dict$get, key, entity.links)));
		} else {
			var compareID = linkMatcher.a;
			var compareKey = linkMatcher.b;
			return A2(
				$elm$core$Maybe$withDefault,
				false,
				A3(
					$elm$core$Maybe$map2,
					$elm$core$Basics$eq,
					A2($elm$core$Dict$get, key, entity.links),
					A2(
						$elm$core$Maybe$andThen,
						A2(
							$elm$core$Basics$composeR,
							function ($) {
								return $.links;
							},
							$elm$core$Dict$get(compareKey)),
						A2($elm$core$Dict$get, compareID, store))));
		}
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$queryFn = F2(
	function (q, store) {
		switch (q.$) {
			case 'HasTag':
				var value = q.a;
				return $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$hasTag(value);
			case 'HasStat':
				var key = q.a;
				var comparator = q.b;
				var value = q.c;
				return A4($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$hasStat, key, comparator, value, store);
			case 'HasLink':
				var key = q.a;
				var value = q.b;
				return A3($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$hasLink, key, value, store);
			default:
				var nestedQuery = q.a;
				return A2(
					$elm$core$Basics$composeL,
					$elm$core$Basics$not,
					A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$queryFn, nestedQuery, store));
		}
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$findGeneral = F2(
	function (queries, store) {
		var gatherMatches = F2(
			function (id, entity) {
				return A2(
					$elm$core$List$all,
					function (q) {
						return A3($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$queryFn, q, store, entity);
					},
					queries);
			});
		return $elm$core$Dict$toList(
			A2($elm$core$Dict$filter, gatherMatches, store));
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$query = F2(
	function (matcher, store) {
		if (matcher.$ === 'Match') {
			var id = matcher.a;
			var queries = matcher.b;
			return A3($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$findSpecific, id, queries, store);
		} else {
			var queries = matcher.a;
			return A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$findGeneral, queries, store);
		}
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$replaceTrigger = F2(
	function (trigger, matcher) {
		var replaceInSelector = function (id) {
			return (id === '$') ? trigger : id;
		};
		var replaceInQuery = function (q) {
			_v1$3:
			while (true) {
				switch (q.$) {
					case 'HasStat':
						if ((q.c.$ === 'CompareStat') && (q.c.a === '$')) {
							var key = q.a;
							var comparison = q.b;
							var _v3 = q.c;
							var compareKey = _v3.b;
							return A3(
								$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasStat,
								key,
								comparison,
								A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$CompareStat, trigger, compareKey));
						} else {
							break _v1$3;
						}
					case 'HasLink':
						if (q.b.$ === 'SpecificLink') {
							if ((q.b.a.$ === 'Match') && (q.b.a.a === '$')) {
								var key = q.a;
								var _v2 = q.b.a;
								var queries = _v2.b;
								return A2(
									$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasLink,
									key,
									$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SpecificLink(
										A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Match, trigger, queries)));
							} else {
								break _v1$3;
							}
						} else {
							if (q.b.a === '$') {
								var key = q.a;
								var _v4 = q.b;
								var compareKey = _v4.b;
								return A2(
									$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$HasLink,
									key,
									A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$CompareLink, trigger, compareKey));
							} else {
								break _v1$3;
							}
						}
					default:
						break _v1$3;
				}
			}
			return q;
		};
		if (matcher.$ === 'MatchAny') {
			var queries = matcher.a;
			return $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$MatchAny(
				A2($elm$core$List$map, replaceInQuery, queries));
		} else {
			var id = matcher.a;
			var queries = matcher.b;
			return A2(
				$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Match,
				replaceInSelector(id),
				A2($elm$core$List$map, replaceInQuery, queries));
		}
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$notReserved = function (_char) {
	return !A2(
		$elm$core$List$member,
		_char,
		_List_fromArray(
			[
				_Utils_chr('{'),
				_Utils_chr('}'),
				_Utils_chr('|')
			]));
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$staticText = A2(
	$elm$parser$Parser$andThen,
	$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$notEmpty,
	$elm$parser$Parser$getChompedString(
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed(_Utils_Tuple0),
			$elm$parser$Parser$chompWhile($jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$notReserved))));
var $elm$random$Random$step = F2(
	function (_v0, seed) {
		var generator = _v0.a;
		return generator(seed);
	});
var $elm$core$String$trim = _String_trim;
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$conditionalText = function (config) {
	var assert = function (matcher) {
		return !$elm$core$List$isEmpty(
			A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$query, matcher, config.worldModel));
	};
	var process = function (_v5) {
		var queryText = _v5.a;
		var ifText = _v5.b;
		var elseText = _v5.c;
		return function (_final) {
			if (_final.$ === 'Ok') {
				if (_final.a) {
					return $elm$parser$Parser$commit(ifText);
				} else {
					return $elm$parser$Parser$commit(elseText);
				}
			} else {
				var e = _final.a;
				return $elm$parser$Parser$problem(e);
			}
		}(
			A2(
				$elm$core$Result$map,
				$elm$core$List$all(
					A2(
						$elm$core$Basics$composeR,
						$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$replaceTrigger(config.trigger),
						assert)),
				A2(
					$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$parseMultiple,
					$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$parseMatcher,
					A2(
						$elm$core$List$map,
						$elm$core$String$trim,
						A2($elm$core$String$split, '&', queryText)))));
	};
	return A2(
		$elm$parser$Parser$andThen,
		process,
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$keeper,
					$elm$parser$Parser$succeed(
						F3(
							function (a, b, c) {
								return _Utils_Tuple3(a, b, c);
							})),
					A2(
						$elm$parser$Parser$ignorer,
						A2(
							$elm$parser$Parser$andThen,
							$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$notEmpty,
							$elm$parser$Parser$getChompedString(
								$elm$parser$Parser$chompUntil('?'))),
						$elm$parser$Parser$symbol('?'))),
				$elm$parser$Parser$lazy(
					function (_v2) {
						return $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$parseText(config);
					})),
			$elm$parser$Parser$oneOf(
				_List_fromArray(
					[
						A2(
						$elm$parser$Parser$keeper,
						A2(
							$elm$parser$Parser$ignorer,
							$elm$parser$Parser$succeed($elm$core$Basics$identity),
							$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$break),
						A2(
							$elm$parser$Parser$ignorer,
							$elm$parser$Parser$lazy(
								function (_v3) {
									return $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$parseText(config);
								}),
							$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$close)),
						A2(
						$elm$parser$Parser$map,
						$elm$core$Basics$always(''),
						$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$close)
					]))));
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$cyclingText = function (config) {
	var helper = function (acc) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$map,
					$elm$core$Basics$always(
						$elm$parser$Parser$Loop(
							A2($elm$core$List$cons, '', acc))),
					$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$break),
					A2(
					$elm$parser$Parser$map,
					$elm$core$Basics$always(
						$elm$parser$Parser$Done(
							$elm$core$List$reverse(
								A2($elm$core$List$cons, '', acc)))),
					$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$close),
					A2(
					$elm$parser$Parser$keeper,
					A2(
						$elm$parser$Parser$keeper,
						$elm$parser$Parser$succeed(
							F2(
								function (a, f) {
									return f(a);
								})),
						$elm$parser$Parser$lazy(
							function (_v1) {
								return $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$parseText(config);
							})),
					$elm$parser$Parser$oneOf(
						_List_fromArray(
							[
								A2(
								$elm$parser$Parser$map,
								$elm$core$Basics$always(
									function (t) {
										return $elm$parser$Parser$Loop(
											A2($elm$core$List$cons, t, acc));
									}),
								$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$break),
								A2(
								$elm$parser$Parser$map,
								$elm$core$Basics$always(
									function (t) {
										return $elm$parser$Parser$Done(
											$elm$core$List$reverse(
												A2($elm$core$List$cons, t, acc)));
									}),
								$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$close)
							])))
				]));
	};
	var findCurrent = F2(
		function (cycleType, l) {
			switch (cycleType.$) {
				case 'Randomly':
					return A2(
						$elm$core$Maybe$withDefault,
						'ERROR finding correct cycling text',
						function (i) {
							return A2(
								$elm$core$Array$get,
								i,
								$elm$core$Array$fromList(l));
						}(
							A2(
								$elm$core$Basics$modBy,
								$elm$core$List$length(l),
								A2(
									$elm$random$Random$step,
									A2($elm$random$Random$int, 0, 200),
									$elm$random$Random$initialSeed(
										config.cycleIndex * $elm$core$String$length(config.trigger))).a)));
				case 'Looping':
					return A2(
						$elm$core$Maybe$withDefault,
						'ERROR finding correct cycling text',
						A2(
							$elm$core$Array$get,
							A2(
								$elm$core$Basics$modBy,
								$elm$core$List$length(l),
								config.cycleIndex),
							$elm$core$Array$fromList(l)));
				default:
					return A2(
						$elm$core$Maybe$withDefault,
						'ERROR finding correct cycling text',
						A2(
							$elm$core$Array$get,
							A2(
								$elm$core$Basics$min,
								$elm$core$List$length(l) - 1,
								config.cycleIndex),
							$elm$core$Array$fromList(l)));
			}
		});
	return A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			$elm$parser$Parser$succeed(findCurrent),
			$elm$parser$Parser$oneOf(
				_List_fromArray(
					[
						A2(
						$elm$parser$Parser$map,
						$elm$core$Basics$always($jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$Looping),
						$elm$parser$Parser$symbol('~')),
						A2(
						$elm$parser$Parser$map,
						$elm$core$Basics$always($jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$Randomly),
						$elm$parser$Parser$symbol('?')),
						$elm$parser$Parser$succeed($jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$Sticking)
					]))),
		A2($elm$parser$Parser$loop, _List_Nil, helper));
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$parseText = function (config) {
	var topLevel = $elm$parser$Parser$oneOf(
		_List_fromArray(
			[
				A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed($elm$core$Basics$identity),
					$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$open),
				$elm$parser$Parser$oneOf(
					_List_fromArray(
						[
							$elm$parser$Parser$backtrackable(
							$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$conditionalText(config)),
							$elm$parser$Parser$backtrackable(
							$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$propertyText(config)),
							$elm$parser$Parser$backtrackable(
							$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$cyclingText(config))
						]))),
				$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$staticText
			]));
	var join = F2(
		function (next, base) {
			return $elm$parser$Parser$Loop(
				_Utils_ap(next, base));
		});
	var l = function (base) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$map,
					join(base),
					topLevel),
					$elm$parser$Parser$succeed(
					$elm$parser$Parser$Done(base))
				]));
	};
	return A2(
		$elm$parser$Parser$keeper,
		$elm$parser$Parser$succeed($elm$core$Basics$identity),
		A2($elm$parser$Parser$loop, '', l));
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$top = function (config) {
	return A2(
		$elm$parser$Parser$ignorer,
		$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$parseText(config),
		$elm$parser$Parser$end);
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$parseMany = function (content) {
	var emptyConfig = {cycleIndex: 0, propKeywords: $elm$core$Dict$empty, trigger: '', worldModel: $elm$core$Dict$empty};
	var displayError = F3(
		function (k, v, e) {
			return _Utils_Tuple2(
				'Narrative content: ' + (k + ('\n' + (v + ' '))),
				$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$deadEndsToString(e));
		});
	return A3(
		$elm$core$Dict$foldl,
		F3(
			function (k, v, acc) {
				var _v0 = A2(
					$elm$parser$Parser$run,
					$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$top(emptyConfig),
					v);
				if (_v0.$ === 'Ok') {
					return acc;
				} else {
					var e = _v0.a;
					if (acc.$ === 'Ok') {
						return $elm$core$Result$Err(
							_List_fromArray(
								[
									A3(displayError, k, v, e)
								]));
					} else {
						var errors = acc.a;
						return $elm$core$Result$Err(
							A2(
								$elm$core$List$cons,
								A3(displayError, k, v, e),
								errors));
					}
				}
			}),
		$elm$core$Result$Ok(_Utils_Tuple0),
		content);
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$Rules$EntityTrigger = function (a) {
	return {$: 'EntityTrigger', a: a};
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$Rules$SpecificTrigger = function (a) {
	return {$: 'SpecificTrigger', a: a};
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$AddTag = function (a) {
	return {$: 'AddTag', a: a};
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$DecStat = F2(
	function (a, b) {
		return {$: 'DecStat', a: a, b: b};
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$IncStat = F2(
	function (a, b) {
		return {$: 'IncStat', a: a, b: b};
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$LookUpLinkTarget = F2(
	function (a, b) {
		return {$: 'LookUpLinkTarget', a: a, b: b};
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$RemoveTag = function (a) {
	return {$: 'RemoveTag', a: a};
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SetLink = F2(
	function (a, b) {
		return {$: 'SetLink', a: a, b: b};
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SetStat = F2(
	function (a, b) {
		return {$: 'SetStat', a: a, b: b};
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SpecificLinkTarget = function (a) {
	return {$: 'SpecificLinkTarget', a: a};
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$changeEntityParser = function () {
	var toUpdateEntity = F3(
		function (acc, propName, updateConstructor) {
			return $elm$parser$Parser$Loop(
				A2(
					$elm$core$List$cons,
					updateConstructor(propName),
					acc));
		});
	var lookupParser = function (mapper) {
		return A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$ignorer,
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed(mapper),
						$elm$parser$Parser$keyword('(link')),
					$elm$parser$Parser$chompWhile(
						$elm$core$Basics$eq(
							_Utils_chr(' ')))),
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$oneOf(
						_List_fromArray(
							[
								A2(
								$elm$parser$Parser$map,
								$elm$core$Basics$always('$'),
								$elm$parser$Parser$token('$')),
								$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$idParser
							])),
					$elm$parser$Parser$symbol('.'))),
			A2(
				$elm$parser$Parser$ignorer,
				$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$propertyNameParser,
				$elm$parser$Parser$symbol(')')));
	};
	var helper = function (acc) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$keeper,
					A2(
						$elm$parser$Parser$ignorer,
						A2(
							$elm$parser$Parser$ignorer,
							$elm$parser$Parser$succeed($elm$core$Basics$identity),
							$elm$parser$Parser$chompWhile(
								$elm$core$Basics$eq(
									_Utils_chr(' ')))),
						$elm$parser$Parser$symbol('.')),
					$elm$parser$Parser$oneOf(
						_List_fromArray(
							[
								A2(
								$elm$parser$Parser$keeper,
								A2(
									$elm$parser$Parser$ignorer,
									$elm$parser$Parser$succeed(
										function (t) {
											return $elm$parser$Parser$Loop(
												A2(
													$elm$core$List$cons,
													$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$RemoveTag(t),
													acc));
										}),
									$elm$parser$Parser$symbol('-')),
								$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$propertyNameParser),
								A2(
								$elm$parser$Parser$keeper,
								A2(
									$elm$parser$Parser$keeper,
									$elm$parser$Parser$succeed(
										toUpdateEntity(acc)),
									$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$propertyNameParser),
								$elm$parser$Parser$oneOf(
									_List_fromArray(
										[
											A2(
											$elm$parser$Parser$keeper,
											A2(
												$elm$parser$Parser$ignorer,
												$elm$parser$Parser$succeed($elm$core$Basics$identity),
												$elm$parser$Parser$symbol('+')),
											A2(
												$elm$parser$Parser$map,
												function (n) {
													return function (key) {
														return A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$IncStat, key, n);
													};
												},
												$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$numberParser)),
											A2(
											$elm$parser$Parser$keeper,
											A2(
												$elm$parser$Parser$ignorer,
												$elm$parser$Parser$succeed($elm$core$Basics$identity),
												$elm$parser$Parser$symbol('-')),
											A2(
												$elm$parser$Parser$map,
												function (n) {
													return function (key) {
														return A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$DecStat, key, n);
													};
												},
												$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$numberParser)),
											A2(
											$elm$parser$Parser$keeper,
											A2(
												$elm$parser$Parser$ignorer,
												$elm$parser$Parser$succeed($elm$core$Basics$identity),
												$elm$parser$Parser$symbol('=')),
											$elm$parser$Parser$oneOf(
												_List_fromArray(
													[
														A2(
														$elm$parser$Parser$map,
														function (n) {
															return function (key) {
																return A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SetStat, key, n);
															};
														},
														$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$numberParser),
														A2(
														$elm$parser$Parser$map,
														function (_v0) {
															return function (key) {
																return A2(
																	$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SetLink,
																	key,
																	$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SpecificLinkTarget('$'));
															};
														},
														$elm$parser$Parser$symbol('$')),
														A2(
														$elm$parser$Parser$map,
														function (id) {
															return function (key) {
																return A2(
																	$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SetLink,
																	key,
																	$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SpecificLinkTarget(id));
															};
														},
														$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$idParser),
														lookupParser(
														F3(
															function (lookupID, lookupKey, key) {
																return A2(
																	$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$SetLink,
																	key,
																	A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$LookUpLinkTarget, lookupID, lookupKey));
															}))
													]))),
											$elm$parser$Parser$succeed(
											function (t) {
												return $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$AddTag(t);
											})
										])))
							]))),
					$elm$parser$Parser$succeed(
					$elm$parser$Parser$Done(acc))
				]));
	};
	return A2($elm$parser$Parser$loop, _List_Nil, helper);
}();
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Update = F2(
	function (a, b) {
		return {$: 'Update', a: a, b: b};
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$UpdateAll = F2(
	function (a, b) {
		return {$: 'UpdateAll', a: a, b: b};
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$updateTargetParser = $elm$parser$Parser$oneOf(
	_List_fromArray(
		[
			A2(
			$elm$parser$Parser$map,
			$elm$core$Basics$always(
				$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Update('$')),
			$elm$parser$Parser$symbol('$')),
			A2($elm$parser$Parser$map, $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Update, $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$idParser),
			A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed($elm$core$Basics$identity),
					$elm$parser$Parser$symbol('(')),
				$elm$parser$Parser$symbol('*')),
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$map,
					function (queries) {
						return $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$UpdateAll(queries);
					},
					$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$queriesParser),
				$elm$parser$Parser$symbol(')')))
		]));
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$changesParser = function () {
	var toChange = F2(
		function (selector, updates) {
			return selector(updates);
		});
	return A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			$elm$parser$Parser$succeed(toChange),
			$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$updateTargetParser),
		$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$changeEntityParser);
}();
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$ruleParser = function () {
	var toRule = F3(
		function (trigger, conditions, changes) {
			return {changes: changes, conditions: conditions, trigger: trigger};
		});
	var specificTriggerParser = A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed($elm$core$Basics$identity),
			$elm$parser$Parser$token('\"')),
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$getChompedString(
				$elm$parser$Parser$chompUntil('\"')),
			$elm$parser$Parser$symbol('\"')));
	var triggerParser = A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$ignorer,
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed($elm$core$Basics$identity),
					$elm$parser$Parser$spaces),
				$elm$parser$Parser$oneOf(
					_List_fromArray(
						[
							$elm$parser$Parser$keyword('ON:'),
							$elm$parser$Parser$keyword('ON')
						]))),
			$elm$parser$Parser$spaces),
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$oneOf(
				_List_fromArray(
					[
						A2($elm$parser$Parser$map, $jschomay$elm_narrative_engine$NarrativeEngine$Core$Rules$SpecificTrigger, specificTriggerParser),
						A2($elm$parser$Parser$map, $jschomay$elm_narrative_engine$NarrativeEngine$Core$Rules$EntityTrigger, $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$matcherParser)
					])),
			$elm$parser$Parser$spaces));
	var conditionsParser = A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$ignorer,
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$succeed($elm$core$Basics$identity),
				$elm$parser$Parser$oneOf(
					_List_fromArray(
						[
							$elm$parser$Parser$keyword('IF:'),
							$elm$parser$Parser$keyword('IF'),
							$elm$parser$Parser$succeed(_Utils_Tuple0)
						]))),
			$elm$parser$Parser$spaces),
		A2(
			$elm$parser$Parser$loop,
			_List_Nil,
			function (acc) {
				return $elm$parser$Parser$oneOf(
					_List_fromArray(
						[
							A2(
							$elm$parser$Parser$map,
							function (_v1) {
								return $elm$parser$Parser$Done(
									$elm$core$List$reverse(acc));
							},
							A2(
								$elm$parser$Parser$ignorer,
								$elm$parser$Parser$oneOf(
									_List_fromArray(
										[
											$elm$parser$Parser$keyword('DO:'),
											$elm$parser$Parser$keyword('DO'),
											$elm$parser$Parser$end
										])),
								$elm$parser$Parser$spaces)),
							A2(
							$elm$parser$Parser$map,
							function (condition) {
								return $elm$parser$Parser$Loop(
									A2($elm$core$List$cons, condition, acc));
							},
							A2($elm$parser$Parser$ignorer, $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$matcherParser, $elm$parser$Parser$spaces))
						]));
			}));
	var changesParser_ = A2(
		$elm$parser$Parser$loop,
		_List_Nil,
		function (acc) {
			return $elm$parser$Parser$oneOf(
				_List_fromArray(
					[
						A2(
						$elm$parser$Parser$map,
						function (_v0) {
							return $elm$parser$Parser$Done(
								$elm$core$List$reverse(acc));
						},
						$elm$parser$Parser$end),
						A2(
						$elm$parser$Parser$map,
						function (condition) {
							return $elm$parser$Parser$Loop(
								A2($elm$core$List$cons, condition, acc));
						},
						A2($elm$parser$Parser$ignorer, $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$changesParser, $elm$parser$Parser$spaces))
					]));
		});
	return A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$keeper,
				$elm$parser$Parser$succeed(toRule),
				triggerParser),
			conditionsParser),
		changesParser_);
}();
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$parseRule = F2(
	function (extendFn, _v0) {
		var source = _v0.a;
		var extraFields = _v0.b;
		return A2(
			$elm$core$Result$mapError,
			$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$Helpers$deadEndsToString,
			A2(
				$elm$core$Result$map,
				extendFn(extraFields),
				A2(
					$elm$parser$Parser$run,
					A2($elm$parser$Parser$ignorer, $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$ruleParser, $elm$parser$Parser$end),
					source)));
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$parseRules = F2(
	function (extendFn, rules) {
		var displayError = F3(
			function (k, v, e) {
				return _Utils_Tuple2('Rule: ' + (k + ('\n' + (v.a + ' '))), e);
			});
		var addParsedRule = F3(
			function (id, ruleSpec, acc) {
				var _v0 = A2($jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$parseRule, extendFn, ruleSpec);
				if (_v0.$ === 'Ok') {
					var parsedRule = _v0.a;
					return A2(
						$elm$core$Result$map,
						A2($elm$core$Dict$insert, id, parsedRule),
						acc);
				} else {
					var err = _v0.a;
					if (acc.$ === 'Ok') {
						return $elm$core$Result$Err(
							_List_fromArray(
								[
									A3(displayError, id, ruleSpec, err)
								]));
					} else {
						var errors = acc.a;
						return $elm$core$Result$Err(
							A2(
								$elm$core$List$cons,
								A3(displayError, id, ruleSpec, err),
								errors));
					}
				}
			});
		return A3(
			$elm$core$Dict$foldl,
			addParsedRule,
			$elm$core$Result$Ok($elm$core$Dict$empty),
			rules);
	});
var $author$project$Rules$rule_______________________ = F3(
	function (k, v, dict) {
		return A3(
			$elm$core$Dict$insert,
			k,
			_Utils_Tuple2(
				v,
				{}),
			dict);
	});
var $author$project$Rules$rulesSpec = A3(
	$author$project$Rules$rule_______________________,
	'park default',
	'\r\n            ON: ALLENPARK.day=1.trigger=2\r\n            IF: ADKINS.trigger=1\r\n            DO: BODYPARKSHOES.choices=0\r\n                SCARONNECK.choices=0\r\n                BELONGINGS.choices=0\r\n                CATHERINEASK.choices=0\r\n                CATHERINEALIBI.choices=0\r\n                ADKINSASK.choices=0\r\n                ADKINSALIBI.choices=0\r\n                NOTHING.allentalkpark.choices=0\r\n                SHOE.allentalkpark.choices=0\r\n                WEAPON.allentalkpark.choices=0\r\n            ',
	A3(
		$author$project$Rules$rule_______________________,
		'talk with allen park 2',
		'\r\n            ON: CATHERINE.trigger=1\r\n            DO: ALLENPARK.trigger=3\r\n                BODYPARKSHOES.choices=0\r\n                SCARONNECK.choices=0\r\n                BELONGINGS.choices=0\r\n                CATHERINEASK.choices=0\r\n                CATHERINEALIBI.choices=0\r\n                ADKINSASK.choices=0\r\n                ADKINSALIBI.choices=0\r\n                NOTHING.allentalkpark.choices=0\r\n                SHOE.allentalkpark.choices=0\r\n                WEAPON.allentalkpark.choices=0\r\n            ',
		A3(
			$author$project$Rules$rule_______________________,
			'ask catherine alibi2',
			'\r\n            ON: CATHERINEASK.choices=1\r\n            DO: CATHERINEASK.choices=0\r\n                ALLENPARK.day=1.trigger=2\r\n                BODYPARKSHOES.choices=0\r\n                SCARONNECK.choices=0\r\n                BELONGINGS.choices=0\r\n                CATHERINEALIBI.choices=0\r\n                ADKINSASK.choices=0\r\n                ADKINSALIBI.choices=0\r\n                NOTHING.allentalkpark.choices=0\r\n                SHOE.allentalkpark.choices=0\r\n                WEAPON.allentalkpark.choices=0\r\n            ',
			A3(
				$author$project$Rules$rule_______________________,
				'ask catherine alibi',
				'\r\n            ON: CATHERINEALIBI.choices=1\r\n            DO: CATHERINEALIBI.choices=0\r\n                CATHERINEASK.choices=1\r\n                BODYPARKSHOES.choices=0\r\n                SCARONNECK.choices=0\r\n                BELONGINGS.choices=0\r\n                ADKINSASK.choices=0\r\n                ADKINSALIBI.choices=0\r\n                NOTHING.allentalkpark.choices=0\r\n                SHOE.allentalkpark.choices=0\r\n                WEAPON.allentalkpark.choices=0\r\n            ',
				A3(
					$author$project$Rules$rule_______________________,
					'talk with catherine',
					'\r\n            ON: CATHERINE.day=1\r\n            IF: CATHERINE.trigger=0\r\n            DO: CATHERINE.trigger=1\r\n                CATHERINEALIBI.choices=1\r\n                BODYPARKSHOES.choices=0\r\n                SCARONNECK.choices=0\r\n                BELONGINGS.choices=0\r\n                CATHERINEASK.choices=0\r\n                ADKINSASK.choices=0\r\n                ADKINSALIBI.choices=0\r\n                NOTHING.allentalkpark.choices=0\r\n                SHOE.allentalkpark.choices=0\r\n                WEAPON.allentalkpark.choices=0\r\n            ',
					A3(
						$author$project$Rules$rule_______________________,
						'ask adkins alibi2',
						'\r\n            ON: ADKINSASK.choices=1\r\n            DO: ADKINSASK.choices=0\r\n                ALLENPARK.day=1.trigger=2\r\n                BODYPARKSHOES.choices=0\r\n                SCARONNECK.choices=0\r\n                BELONGINGS.choices=0\r\n                CATHERINEASK.choices=0\r\n                CATHERINEALIBI.choices=0\r\n                ADKINSALIBI.choices=0\r\n                NOTHING.allentalkpark.choices=0\r\n                SHOE.allentalkpark.choices=0\r\n                WEAPON.allentalkpark.choices=0\r\n            ',
						A3(
							$author$project$Rules$rule_______________________,
							'ask adkins alibi',
							'\r\n            ON: ADKINSALIBI.choices=1\r\n            DO: ADKINSALIBI.choices=0\r\n                ADKINSASK.choices=1\r\n                BODYPARKSHOES.choices=0\r\n                SCARONNECK.choices=0\r\n                BELONGINGS.choices=0\r\n                CATHERINEASK.choices=0\r\n                CATHERINEALIBI.choices=0\r\n                NOTHING.allentalkpark.choices=0\r\n                SHOE.allentalkpark.choices=0\r\n                WEAPON.allentalkpark.choices=0\r\n            ',
							A3(
								$author$project$Rules$rule_______________________,
								'talk with adkins',
								'\r\n            ON: ADKINS.day=1\r\n            IF: ADKINS.trigger=0\r\n            DO: ADKINS.trigger=1\r\n                ADKINSALIBI.choices=1\r\n                BODYPARKSHOES.choices=0\r\n                SCARONNECK.choices=0\r\n                BELONGINGS.choices=0\r\n                CATHERINEASK.choices=0\r\n                CATHERINEALIBI.choices=0\r\n                ADKINSASK.choices=0\r\n                NOTHING.allentalkpark.choices=0\r\n                SHOE.allentalkpark.choices=0\r\n                WEAPON.allentalkpark.choices=0\r\n            ',
								A3(
									$author$project$Rules$rule_______________________,
									'invest belongings',
									'\r\n            ON: BELONGINGS.choices=1\r\n            DO: LEEPARK.trigger=1\r\n                BELONGINGS.choices=0\r\n            ',
									A3(
										$author$project$Rules$rule_______________________,
										'invest scar',
										'\r\n            ON: SCARONNECK.choices=1\r\n            DO: LEEPARK.trigger=1\r\n                SCARONNECK.choices=0\r\n            ',
										A3(
											$author$project$Rules$rule_______________________,
											'invest shoes',
											'\r\n            ON: BODYPARKSHOES.choices=1\r\n            DO: LEEPARK.trigger=1\r\n                BODYPARKSHOES.choices=0\r\n            ',
											A3(
												$author$project$Rules$rule_______________________,
												'talk with lee park',
												'\r\n            ON: LEEPARK.day=1\r\n            IF: LEEPARK.trigger=0\r\n            DO: LEEPARK.trigger=1\r\n                BODYPARKSHOES.choices=1\r\n                SCARONNECK.choices=1\r\n                BELONGINGS.choices=1\r\n                CATHERINEASK.choices=0\r\n                CATHERINEALIBI.choices=0\r\n                ADKINSASK.choices=0\r\n                ADKINSALIBI.choices=0\r\n                NOTHING.allentalkpark.choices=0\r\n                SHOE.allentalkpark.choices=0\r\n                WEAPON.allentalkpark.choices=0\r\n            ',
												A3(
													$author$project$Rules$rule_______________________,
													'weapon',
													'\r\n            ON: WEAPON.allentalkpark\r\n            DO: ALLENPARK.trigger=1\r\n                NOTHING.allentalkpark.choices=0\r\n                SHOE.allentalkpark.choices=0\r\n                WEAPON.allentalkpark.choices=0\r\n            ',
													A3(
														$author$project$Rules$rule_______________________,
														'shoes',
														'\r\n            ON: SHOE.allentalkpark\r\n            DO: ALLENPARK.trigger=1\r\n                NOTHING.allentalkpark.choices=0\r\n                SHOE.allentalkpark.choices=0\r\n                WEAPON.allentalkpark.choices=0\r\n                CATHERINE.suspect=1\r\n                ADKINS.suspect=1\r\n            ',
														A3(
															$author$project$Rules$rule_______________________,
															'nothing',
															'\r\n            ON: NOTHING.allentalkpark\r\n            DO: ALLENPARK.trigger=1\r\n                NOTHING.allentalkpark.choices=0\r\n                SHOE.allentalkpark.choices=0\r\n                WEAPON.allentalkpark.choices=0\r\n            ',
															A3(
																$author$project$Rules$rule_______________________,
																'talk with allen park',
																'\r\n            ON: ALLENPARK.day=1\r\n            IF: ALLENPARK.trigger=0\r\n            DO: NOTHING.allentalkpark.choices=1\r\n                SHOE.allentalkpark.choices=1\r\n                WEAPON.allentalkpark.choices=1\r\n                ALLENPARK.trigger=1\r\n                BODYPARKSHOES.choices=0\r\n                SCARONNECK.choices=0\r\n                BELONGINGS.choices=0\r\n                CATHERINEASK.choices=0\r\n                CATHERINEALIBI.choices=0\r\n                ADKINSASK.choices=0\r\n                ADKINSALIBI.choices=0\r\n            ',
																A3(
																	$author$project$Rules$rule_______________________,
																	'talk with allen 1',
																	'\r\n            ON: ALLENPOLICEOFFICE.day=1\r\n            DO: ALLENPOLICEOFFICE.trigger=1\r\n                BOBPOLICEOFFICE.trigger=1\r\n                LEEPOLICEOFFICE.trigger=1\r\n                YES.bobtalk.choices=0\r\n                NO.bobtalk.choices=0\r\n                DOESNTMATTER.leetalk.choices=0\r\n                PAYATTENTION.leetalk.choices=0\r\n            ',
																	A3(
																		$author$project$Rules$rule_______________________,
																		'pay attention next time',
																		'\r\n            ON: PAYATTENTION.leetalk\r\n            DO: LEEPOLICEOFFICE.trigger=1\r\n                DOESNTMATTER.leetalk.choices=0\r\n                PAYATTENTION.leetalk.choices=0\r\n            ',
																		A3(
																			$author$project$Rules$rule_______________________,
																			'that doesn\'t matter',
																			'\r\n            ON: DOESNTMATTER.leetalk\r\n            DO: LEEPOLICEOFFICE.trigger=1\r\n                DOESNTMATTER.leetalk.choices=0\r\n                PAYATTENTION.leetalk.choices=0\r\n            ',
																			A3(
																				$author$project$Rules$rule_______________________,
																				'talk with lee',
																				'\r\n            ON: LEEPOLICEOFFICE.npc.day=1\r\n            IF: LEEPOLICEOFFICE.npc.day=1.trigger=0\r\n            DO: DOESNTMATTER.leetalk.choices=1\r\n                PAYATTENTION.leetalk.choices=1\r\n            ',
																				A3(
																					$author$project$Rules$rule_______________________,
																					'no',
																					'\r\n            ON: NO.bobtalk\r\n            DO: BOBPOLICEOFFICE.trigger=1\r\n                YES.bobtalk.choices=0\r\n                NO.bobtalk.choices=0\r\n            ',
																					A3(
																						$author$project$Rules$rule_______________________,
																						'yes',
																						'\r\n            ON: YES.bobtalk\r\n            DO: BOBPOLICEOFFICE.trigger=1\r\n                YES.bobtalk.choices=0\r\n                NO.bobtalk.choices=0\r\n            ',
																						A3($author$project$Rules$rule_______________________, 'talk with bob', '\r\n            ON: BOBPOLICEOFFICE\r\n            IF: BOBPOLICEOFFICE.trigger=0\r\n            DO: YES.bobtalk.choices=1\r\n                NO.bobtalk.choices=1\r\n            ', $elm$core$Dict$empty)))))))))))))))))))))));
var $elm$core$Result$withDefault = F2(
	function (def, result) {
		if (result.$ === 'Ok') {
			var a = result.a;
			return a;
		} else {
			return def;
		}
	});
var $author$project$Rules$initialWorldModel = function () {
	var addExtraRuleFields = F2(
		function (extraFields, rule) {
			return rule;
		});
	var addExtraEntityFields = F2(
		function (_v0, _v1) {
			var name = _v0.name;
			var description = _v0.description;
			var tags = _v1.tags;
			var stats = _v1.stats;
			var links = _v1.links;
			return {description: description, links: links, name: name, stats: stats, tags: tags};
		});
	var parsedData_ = A4(
		$elm$core$Result$map3,
		F3(
			function (parsedInitialWorldModel, narrative, parsedRules) {
				return _Utils_Tuple2(parsedInitialWorldModel, parsedRules);
			}),
		A2($jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$parseMany, addExtraEntityFields, $author$project$Rules$initialWorldModelSpec),
		$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$parseMany($author$project$Rules$narrative_content),
		A2($jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$parseRules, addExtraRuleFields, $author$project$Rules$rulesSpec));
	return A2(
		$elm$core$Result$withDefault,
		$elm$core$Dict$empty,
		A2($elm$core$Result$map, $elm$core$Tuple$first, parsedData_));
}();
var $author$project$Model$Game = {$: 'Game'};
var $author$project$Model$gameMode______ = $author$project$Model$Game;
var $author$project$Model$policeOfficeBarrier = function () {
	var _v0 = $author$project$Model$gameMode______;
	if (_v0.$ === 'GettingCoordinates') {
		return _List_Nil;
	} else {
		return _List_fromArray(
			[
				{hei: 20, wid: 575, x: 230, y: 500},
				{hei: 20, wid: 610, x: 205, y: 260},
				{hei: 20, wid: 610, x: 205, y: 40},
				{hei: 30, wid: 120, x: 370, y: 500},
				{hei: 20, wid: 110, x: 290, y: 280},
				{hei: 20, wid: 135, x: 465, y: 280},
				{hei: 20, wid: 30, x: 645, y: 280},
				{hei: 20, wid: 55, x: 205, y: 280},
				{hei: 20, wid: 30, x: 205, y: 300},
				{hei: 180, wid: 20, x: 805, y: 420},
				{hei: 180, wid: 20, x: 805, y: 190},
				{hei: 180, wid: 20, x: 805, y: -40},
				{hei: 180, wid: 20, x: 185, y: 420},
				{hei: 180, wid: 20, x: 185, y: 190},
				{hei: 180, wid: 20, x: 185, y: -40},
				{hei: 20, wid: 600, x: 205, y: 600},
				{hei: 20, wid: 600, x: 205, y: 370},
				{hei: 20, wid: 600, x: 205, y: 140}
			]);
	}
}();
var $author$project$Model$Elevator = {$: 'Elevator'};
var $author$project$Model$policeOfficeElevator = _List_fromArray(
	[
		{
		area: {hei: 110, wid: 115, x: 660, y: 430},
		which: $author$project$Model$Elevator
	},
		{
		area: {hei: 110, wid: 100, x: 675, y: 195},
		which: $author$project$Model$Elevator
	},
		{
		area: {hei: 85, wid: 115, x: 660, y: 0},
		which: $author$project$Model$Elevator
	}
	]);
var $author$project$Model$policeOfficeAttr = {
	barrier: $author$project$Model$policeOfficeBarrier,
	elevator: $author$project$Model$policeOfficeElevator,
	exit: {hei: 120, wid: 70, x: 150, y: 480},
	heroIni: {height: 60, width: 20, x: 300, y: 520},
	npcs: _List_fromArray(
		[$author$project$Model$cAllen, $author$project$Model$cBob, $author$project$Model$cLee]),
	story: 'Another day at work, another boring day. But I need to avoid being killed.'
};
var $author$project$Model$initial = {
	bag: $author$project$Items$bagIni,
	conclusion: 1,
	correctsolved: 0,
	debug: $jschomay$elm_narrative_engine$NarrativeEngine$Debug$init,
	energy: 60,
	energy_Cost_interact: 5,
	energy_Cost_pickup: 25,
	energy_Full: 100,
	hero: $author$project$Model$heroIni,
	heroDir: _Utils_Tuple2($elm$core$Maybe$Nothing, $elm$core$Maybe$Nothing),
	heroInteractWithNpc: false,
	heroMoveDown: false,
	heroMoveLeft: false,
	heroMoveRight: false,
	heroMoveUp: false,
	heroPickUp: false,
	interacttrue: false,
	items: _List_fromArray(
		[$author$project$Items$gunIni, $author$project$Items$bulletProofIni]),
	map: $author$project$Items$PoliceOffice,
	mapAttr: $author$project$Model$policeOfficeAttr,
	npcs: _List_fromArray(
		[$author$project$Model$cAllen, $author$project$Model$cBob, $author$project$Model$cLee]),
	portrait: '',
	quests: $author$project$Model$NoQuest,
	ruleCounts: $elm$core$Dict$empty,
	size: _Utils_Tuple2(900, 600),
	state: $author$project$Model$Playing,
	story: 'I\'m a novelist who travels to his own book. Yes, I think no better explanation can make the current condition clear. I\'m now \'Kay\', a policeman, and I know that I\'ll be killed by the police chief, Jonathon, because I know his scandal. I need to avoid being killed.',
	worldModel: $author$project$Rules$initialWorldModel
};
var $elm$json$Json$Decode$int = _Json_decodeInt;
var $elm$json$Json$Decode$map = _Json_map1;
var $elm$json$Json$Decode$map3 = _Json_map3;
var $elm$json$Json$Decode$string = _Json_decodeString;
var $author$project$Model$decode = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (state, heroX, heroY) {
			return _Utils_update(
				$author$project$Model$initial,
				{
					hero: {height: 60, width: 20, x: heroX, y: heroY},
					state: state
				});
		}),
	A2(
		$elm$json$Json$Decode$field,
		'state',
		A2($elm$json$Json$Decode$map, $author$project$Model$decodeState, $elm$json$Json$Decode$string)),
	A2($elm$json$Json$Decode$field, 'positionX', $elm$json$Json$Decode$int),
	A2($elm$json$Json$Decode$field, 'positionY', $elm$json$Json$Decode$int));
var $elm$json$Json$Decode$decodeValue = _Json_run;
var $elm$json$Json$Decode$map2 = _Json_map2;
var $elm$json$Json$Decode$succeed = _Json_succeed;
var $elm$virtual_dom$VirtualDom$toHandlerInt = function (handler) {
	switch (handler.$) {
		case 'Normal':
			return 0;
		case 'MayStopPropagation':
			return 1;
		case 'MayPreventDefault':
			return 2;
		default:
			return 3;
	}
};
var $elm$browser$Browser$External = function (a) {
	return {$: 'External', a: a};
};
var $elm$browser$Browser$Internal = function (a) {
	return {$: 'Internal', a: a};
};
var $elm$browser$Browser$Dom$NotFound = function (a) {
	return {$: 'NotFound', a: a};
};
var $elm$url$Url$Http = {$: 'Http'};
var $elm$url$Url$Https = {$: 'Https'};
var $elm$url$Url$Url = F6(
	function (protocol, host, port_, path, query, fragment) {
		return {fragment: fragment, host: host, path: path, port_: port_, protocol: protocol, query: query};
	});
var $elm$core$String$contains = _String_contains;
var $elm$core$String$dropLeft = F2(
	function (n, string) {
		return (n < 1) ? string : A3(
			$elm$core$String$slice,
			n,
			$elm$core$String$length(string),
			string);
	});
var $elm$core$String$indexes = _String_indexes;
var $elm$core$String$left = F2(
	function (n, string) {
		return (n < 1) ? '' : A3($elm$core$String$slice, 0, n, string);
	});
var $elm$url$Url$chompBeforePath = F5(
	function (protocol, path, params, frag, str) {
		if ($elm$core$String$isEmpty(str) || A2($elm$core$String$contains, '@', str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, ':', str);
			if (!_v0.b) {
				return $elm$core$Maybe$Just(
					A6($elm$url$Url$Url, protocol, str, $elm$core$Maybe$Nothing, path, params, frag));
			} else {
				if (!_v0.b.b) {
					var i = _v0.a;
					var _v1 = $elm$core$String$toInt(
						A2($elm$core$String$dropLeft, i + 1, str));
					if (_v1.$ === 'Nothing') {
						return $elm$core$Maybe$Nothing;
					} else {
						var port_ = _v1;
						return $elm$core$Maybe$Just(
							A6(
								$elm$url$Url$Url,
								protocol,
								A2($elm$core$String$left, i, str),
								port_,
								path,
								params,
								frag));
					}
				} else {
					return $elm$core$Maybe$Nothing;
				}
			}
		}
	});
var $elm$url$Url$chompBeforeQuery = F4(
	function (protocol, params, frag, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '/', str);
			if (!_v0.b) {
				return A5($elm$url$Url$chompBeforePath, protocol, '/', params, frag, str);
			} else {
				var i = _v0.a;
				return A5(
					$elm$url$Url$chompBeforePath,
					protocol,
					A2($elm$core$String$dropLeft, i, str),
					params,
					frag,
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$url$Url$chompBeforeFragment = F3(
	function (protocol, frag, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '?', str);
			if (!_v0.b) {
				return A4($elm$url$Url$chompBeforeQuery, protocol, $elm$core$Maybe$Nothing, frag, str);
			} else {
				var i = _v0.a;
				return A4(
					$elm$url$Url$chompBeforeQuery,
					protocol,
					$elm$core$Maybe$Just(
						A2($elm$core$String$dropLeft, i + 1, str)),
					frag,
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$url$Url$chompAfterProtocol = F2(
	function (protocol, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '#', str);
			if (!_v0.b) {
				return A3($elm$url$Url$chompBeforeFragment, protocol, $elm$core$Maybe$Nothing, str);
			} else {
				var i = _v0.a;
				return A3(
					$elm$url$Url$chompBeforeFragment,
					protocol,
					$elm$core$Maybe$Just(
						A2($elm$core$String$dropLeft, i + 1, str)),
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$core$String$startsWith = _String_startsWith;
var $elm$url$Url$fromString = function (str) {
	return A2($elm$core$String$startsWith, 'http://', str) ? A2(
		$elm$url$Url$chompAfterProtocol,
		$elm$url$Url$Http,
		A2($elm$core$String$dropLeft, 7, str)) : (A2($elm$core$String$startsWith, 'https://', str) ? A2(
		$elm$url$Url$chompAfterProtocol,
		$elm$url$Url$Https,
		A2($elm$core$String$dropLeft, 8, str)) : $elm$core$Maybe$Nothing);
};
var $elm$core$Basics$never = function (_v0) {
	never:
	while (true) {
		var nvr = _v0.a;
		var $temp$_v0 = nvr;
		_v0 = $temp$_v0;
		continue never;
	}
};
var $elm$core$Task$Perform = function (a) {
	return {$: 'Perform', a: a};
};
var $elm$core$Task$succeed = _Scheduler_succeed;
var $elm$core$Task$init = $elm$core$Task$succeed(_Utils_Tuple0);
var $elm$core$Task$andThen = _Scheduler_andThen;
var $elm$core$Task$map = F2(
	function (func, taskA) {
		return A2(
			$elm$core$Task$andThen,
			function (a) {
				return $elm$core$Task$succeed(
					func(a));
			},
			taskA);
	});
var $elm$core$Task$map2 = F3(
	function (func, taskA, taskB) {
		return A2(
			$elm$core$Task$andThen,
			function (a) {
				return A2(
					$elm$core$Task$andThen,
					function (b) {
						return $elm$core$Task$succeed(
							A2(func, a, b));
					},
					taskB);
			},
			taskA);
	});
var $elm$core$Task$sequence = function (tasks) {
	return A3(
		$elm$core$List$foldr,
		$elm$core$Task$map2($elm$core$List$cons),
		$elm$core$Task$succeed(_List_Nil),
		tasks);
};
var $elm$core$Platform$sendToApp = _Platform_sendToApp;
var $elm$core$Task$spawnCmd = F2(
	function (router, _v0) {
		var task = _v0.a;
		return _Scheduler_spawn(
			A2(
				$elm$core$Task$andThen,
				$elm$core$Platform$sendToApp(router),
				task));
	});
var $elm$core$Task$onEffects = F3(
	function (router, commands, state) {
		return A2(
			$elm$core$Task$map,
			function (_v0) {
				return _Utils_Tuple0;
			},
			$elm$core$Task$sequence(
				A2(
					$elm$core$List$map,
					$elm$core$Task$spawnCmd(router),
					commands)));
	});
var $elm$core$Task$onSelfMsg = F3(
	function (_v0, _v1, _v2) {
		return $elm$core$Task$succeed(_Utils_Tuple0);
	});
var $elm$core$Task$cmdMap = F2(
	function (tagger, _v0) {
		var task = _v0.a;
		return $elm$core$Task$Perform(
			A2($elm$core$Task$map, tagger, task));
	});
_Platform_effectManagers['Task'] = _Platform_createManager($elm$core$Task$init, $elm$core$Task$onEffects, $elm$core$Task$onSelfMsg, $elm$core$Task$cmdMap);
var $elm$core$Task$command = _Platform_leaf('Task');
var $elm$core$Task$perform = F2(
	function (toMessage, task) {
		return $elm$core$Task$command(
			$elm$core$Task$Perform(
				A2($elm$core$Task$map, toMessage, task)));
	});
var $elm$browser$Browser$element = _Browser_element;
var $elm$browser$Browser$Dom$getViewport = _Browser_withWindow(_Browser_getViewport);
var $author$project$Message$Resize = F2(
	function (a, b) {
		return {$: 'Resize', a: a, b: b};
	});
var $author$project$Message$Tick = function (a) {
	return {$: 'Tick', a: a};
};
var $elm$core$Platform$Sub$batch = _Platform_batch;
var $author$project$Message$EnterVehicle = function (a) {
	return {$: 'EnterVehicle', a: a};
};
var $author$project$Message$InteractByKey = function (a) {
	return {$: 'InteractByKey', a: a};
};
var $author$project$Message$MoveDown = function (a) {
	return {$: 'MoveDown', a: a};
};
var $author$project$Message$MoveLeft = function (a) {
	return {$: 'MoveLeft', a: a};
};
var $author$project$Message$MoveRight = function (a) {
	return {$: 'MoveRight', a: a};
};
var $author$project$Message$MoveUp = function (a) {
	return {$: 'MoveUp', a: a};
};
var $author$project$Message$Noop = {$: 'Noop'};
var $author$project$Message$PickUp = function (a) {
	return {$: 'PickUp', a: a};
};
var $author$project$Main$key = F2(
	function (on, keycode) {
		switch (keycode) {
			case 37:
				return $author$project$Message$MoveLeft(on);
			case 39:
				return $author$project$Message$MoveRight(on);
			case 38:
				return $author$project$Message$MoveUp(on);
			case 40:
				return $author$project$Message$MoveDown(on);
			case 81:
				return $author$project$Message$PickUp(on);
			case 70:
				return $author$project$Message$EnterVehicle(on);
			case 88:
				return $author$project$Message$InteractByKey(on);
			default:
				return $author$project$Message$Noop;
		}
	});
var $elm$html$Html$Events$keyCode = A2($elm$json$Json$Decode$field, 'keyCode', $elm$json$Json$Decode$int);
var $elm$core$Platform$Sub$none = $elm$core$Platform$Sub$batch(_List_Nil);
var $elm$browser$Browser$AnimationManager$Delta = function (a) {
	return {$: 'Delta', a: a};
};
var $elm$browser$Browser$AnimationManager$State = F3(
	function (subs, request, oldTime) {
		return {oldTime: oldTime, request: request, subs: subs};
	});
var $elm$browser$Browser$AnimationManager$init = $elm$core$Task$succeed(
	A3($elm$browser$Browser$AnimationManager$State, _List_Nil, $elm$core$Maybe$Nothing, 0));
var $elm$core$Process$kill = _Scheduler_kill;
var $elm$browser$Browser$AnimationManager$now = _Browser_now(_Utils_Tuple0);
var $elm$browser$Browser$AnimationManager$rAF = _Browser_rAF(_Utils_Tuple0);
var $elm$core$Platform$sendToSelf = _Platform_sendToSelf;
var $elm$core$Process$spawn = _Scheduler_spawn;
var $elm$browser$Browser$AnimationManager$onEffects = F3(
	function (router, subs, _v0) {
		var request = _v0.request;
		var oldTime = _v0.oldTime;
		var _v1 = _Utils_Tuple2(request, subs);
		if (_v1.a.$ === 'Nothing') {
			if (!_v1.b.b) {
				var _v2 = _v1.a;
				return $elm$browser$Browser$AnimationManager$init;
			} else {
				var _v4 = _v1.a;
				return A2(
					$elm$core$Task$andThen,
					function (pid) {
						return A2(
							$elm$core$Task$andThen,
							function (time) {
								return $elm$core$Task$succeed(
									A3(
										$elm$browser$Browser$AnimationManager$State,
										subs,
										$elm$core$Maybe$Just(pid),
										time));
							},
							$elm$browser$Browser$AnimationManager$now);
					},
					$elm$core$Process$spawn(
						A2(
							$elm$core$Task$andThen,
							$elm$core$Platform$sendToSelf(router),
							$elm$browser$Browser$AnimationManager$rAF)));
			}
		} else {
			if (!_v1.b.b) {
				var pid = _v1.a.a;
				return A2(
					$elm$core$Task$andThen,
					function (_v3) {
						return $elm$browser$Browser$AnimationManager$init;
					},
					$elm$core$Process$kill(pid));
			} else {
				return $elm$core$Task$succeed(
					A3($elm$browser$Browser$AnimationManager$State, subs, request, oldTime));
			}
		}
	});
var $elm$time$Time$Posix = function (a) {
	return {$: 'Posix', a: a};
};
var $elm$time$Time$millisToPosix = $elm$time$Time$Posix;
var $elm$browser$Browser$AnimationManager$onSelfMsg = F3(
	function (router, newTime, _v0) {
		var subs = _v0.subs;
		var oldTime = _v0.oldTime;
		var send = function (sub) {
			if (sub.$ === 'Time') {
				var tagger = sub.a;
				return A2(
					$elm$core$Platform$sendToApp,
					router,
					tagger(
						$elm$time$Time$millisToPosix(newTime)));
			} else {
				var tagger = sub.a;
				return A2(
					$elm$core$Platform$sendToApp,
					router,
					tagger(newTime - oldTime));
			}
		};
		return A2(
			$elm$core$Task$andThen,
			function (pid) {
				return A2(
					$elm$core$Task$andThen,
					function (_v1) {
						return $elm$core$Task$succeed(
							A3(
								$elm$browser$Browser$AnimationManager$State,
								subs,
								$elm$core$Maybe$Just(pid),
								newTime));
					},
					$elm$core$Task$sequence(
						A2($elm$core$List$map, send, subs)));
			},
			$elm$core$Process$spawn(
				A2(
					$elm$core$Task$andThen,
					$elm$core$Platform$sendToSelf(router),
					$elm$browser$Browser$AnimationManager$rAF)));
	});
var $elm$browser$Browser$AnimationManager$Time = function (a) {
	return {$: 'Time', a: a};
};
var $elm$browser$Browser$AnimationManager$subMap = F2(
	function (func, sub) {
		if (sub.$ === 'Time') {
			var tagger = sub.a;
			return $elm$browser$Browser$AnimationManager$Time(
				A2($elm$core$Basics$composeL, func, tagger));
		} else {
			var tagger = sub.a;
			return $elm$browser$Browser$AnimationManager$Delta(
				A2($elm$core$Basics$composeL, func, tagger));
		}
	});
_Platform_effectManagers['Browser.AnimationManager'] = _Platform_createManager($elm$browser$Browser$AnimationManager$init, $elm$browser$Browser$AnimationManager$onEffects, $elm$browser$Browser$AnimationManager$onSelfMsg, 0, $elm$browser$Browser$AnimationManager$subMap);
var $elm$browser$Browser$AnimationManager$subscription = _Platform_leaf('Browser.AnimationManager');
var $elm$browser$Browser$AnimationManager$onAnimationFrameDelta = function (tagger) {
	return $elm$browser$Browser$AnimationManager$subscription(
		$elm$browser$Browser$AnimationManager$Delta(tagger));
};
var $elm$browser$Browser$Events$onAnimationFrameDelta = $elm$browser$Browser$AnimationManager$onAnimationFrameDelta;
var $elm$browser$Browser$Events$Document = {$: 'Document'};
var $elm$browser$Browser$Events$MySub = F3(
	function (a, b, c) {
		return {$: 'MySub', a: a, b: b, c: c};
	});
var $elm$browser$Browser$Events$State = F2(
	function (subs, pids) {
		return {pids: pids, subs: subs};
	});
var $elm$browser$Browser$Events$init = $elm$core$Task$succeed(
	A2($elm$browser$Browser$Events$State, _List_Nil, $elm$core$Dict$empty));
var $elm$browser$Browser$Events$nodeToKey = function (node) {
	if (node.$ === 'Document') {
		return 'd_';
	} else {
		return 'w_';
	}
};
var $elm$browser$Browser$Events$addKey = function (sub) {
	var node = sub.a;
	var name = sub.b;
	return _Utils_Tuple2(
		_Utils_ap(
			$elm$browser$Browser$Events$nodeToKey(node),
			name),
		sub);
};
var $elm$core$Dict$fromList = function (assocs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, dict) {
				var key = _v0.a;
				var value = _v0.b;
				return A3($elm$core$Dict$insert, key, value, dict);
			}),
		$elm$core$Dict$empty,
		assocs);
};
var $elm$core$Dict$merge = F6(
	function (leftStep, bothStep, rightStep, leftDict, rightDict, initialResult) {
		var stepState = F3(
			function (rKey, rValue, _v0) {
				stepState:
				while (true) {
					var list = _v0.a;
					var result = _v0.b;
					if (!list.b) {
						return _Utils_Tuple2(
							list,
							A3(rightStep, rKey, rValue, result));
					} else {
						var _v2 = list.a;
						var lKey = _v2.a;
						var lValue = _v2.b;
						var rest = list.b;
						if (_Utils_cmp(lKey, rKey) < 0) {
							var $temp$rKey = rKey,
								$temp$rValue = rValue,
								$temp$_v0 = _Utils_Tuple2(
								rest,
								A3(leftStep, lKey, lValue, result));
							rKey = $temp$rKey;
							rValue = $temp$rValue;
							_v0 = $temp$_v0;
							continue stepState;
						} else {
							if (_Utils_cmp(lKey, rKey) > 0) {
								return _Utils_Tuple2(
									list,
									A3(rightStep, rKey, rValue, result));
							} else {
								return _Utils_Tuple2(
									rest,
									A4(bothStep, lKey, lValue, rValue, result));
							}
						}
					}
				}
			});
		var _v3 = A3(
			$elm$core$Dict$foldl,
			stepState,
			_Utils_Tuple2(
				$elm$core$Dict$toList(leftDict),
				initialResult),
			rightDict);
		var leftovers = _v3.a;
		var intermediateResult = _v3.b;
		return A3(
			$elm$core$List$foldl,
			F2(
				function (_v4, result) {
					var k = _v4.a;
					var v = _v4.b;
					return A3(leftStep, k, v, result);
				}),
			intermediateResult,
			leftovers);
	});
var $elm$browser$Browser$Events$Event = F2(
	function (key, event) {
		return {event: event, key: key};
	});
var $elm$browser$Browser$Events$spawn = F3(
	function (router, key, _v0) {
		var node = _v0.a;
		var name = _v0.b;
		var actualNode = function () {
			if (node.$ === 'Document') {
				return _Browser_doc;
			} else {
				return _Browser_window;
			}
		}();
		return A2(
			$elm$core$Task$map,
			function (value) {
				return _Utils_Tuple2(key, value);
			},
			A3(
				_Browser_on,
				actualNode,
				name,
				function (event) {
					return A2(
						$elm$core$Platform$sendToSelf,
						router,
						A2($elm$browser$Browser$Events$Event, key, event));
				}));
	});
var $elm$core$Dict$union = F2(
	function (t1, t2) {
		return A3($elm$core$Dict$foldl, $elm$core$Dict$insert, t2, t1);
	});
var $elm$browser$Browser$Events$onEffects = F3(
	function (router, subs, state) {
		var stepRight = F3(
			function (key, sub, _v6) {
				var deads = _v6.a;
				var lives = _v6.b;
				var news = _v6.c;
				return _Utils_Tuple3(
					deads,
					lives,
					A2(
						$elm$core$List$cons,
						A3($elm$browser$Browser$Events$spawn, router, key, sub),
						news));
			});
		var stepLeft = F3(
			function (_v4, pid, _v5) {
				var deads = _v5.a;
				var lives = _v5.b;
				var news = _v5.c;
				return _Utils_Tuple3(
					A2($elm$core$List$cons, pid, deads),
					lives,
					news);
			});
		var stepBoth = F4(
			function (key, pid, _v2, _v3) {
				var deads = _v3.a;
				var lives = _v3.b;
				var news = _v3.c;
				return _Utils_Tuple3(
					deads,
					A3($elm$core$Dict$insert, key, pid, lives),
					news);
			});
		var newSubs = A2($elm$core$List$map, $elm$browser$Browser$Events$addKey, subs);
		var _v0 = A6(
			$elm$core$Dict$merge,
			stepLeft,
			stepBoth,
			stepRight,
			state.pids,
			$elm$core$Dict$fromList(newSubs),
			_Utils_Tuple3(_List_Nil, $elm$core$Dict$empty, _List_Nil));
		var deadPids = _v0.a;
		var livePids = _v0.b;
		var makeNewPids = _v0.c;
		return A2(
			$elm$core$Task$andThen,
			function (pids) {
				return $elm$core$Task$succeed(
					A2(
						$elm$browser$Browser$Events$State,
						newSubs,
						A2(
							$elm$core$Dict$union,
							livePids,
							$elm$core$Dict$fromList(pids))));
			},
			A2(
				$elm$core$Task$andThen,
				function (_v1) {
					return $elm$core$Task$sequence(makeNewPids);
				},
				$elm$core$Task$sequence(
					A2($elm$core$List$map, $elm$core$Process$kill, deadPids))));
	});
var $elm$core$List$maybeCons = F3(
	function (f, mx, xs) {
		var _v0 = f(mx);
		if (_v0.$ === 'Just') {
			var x = _v0.a;
			return A2($elm$core$List$cons, x, xs);
		} else {
			return xs;
		}
	});
var $elm$core$List$filterMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			$elm$core$List$maybeCons(f),
			_List_Nil,
			xs);
	});
var $elm$browser$Browser$Events$onSelfMsg = F3(
	function (router, _v0, state) {
		var key = _v0.key;
		var event = _v0.event;
		var toMessage = function (_v2) {
			var subKey = _v2.a;
			var _v3 = _v2.b;
			var node = _v3.a;
			var name = _v3.b;
			var decoder = _v3.c;
			return _Utils_eq(subKey, key) ? A2(_Browser_decodeEvent, decoder, event) : $elm$core$Maybe$Nothing;
		};
		var messages = A2($elm$core$List$filterMap, toMessage, state.subs);
		return A2(
			$elm$core$Task$andThen,
			function (_v1) {
				return $elm$core$Task$succeed(state);
			},
			$elm$core$Task$sequence(
				A2(
					$elm$core$List$map,
					$elm$core$Platform$sendToApp(router),
					messages)));
	});
var $elm$browser$Browser$Events$subMap = F2(
	function (func, _v0) {
		var node = _v0.a;
		var name = _v0.b;
		var decoder = _v0.c;
		return A3(
			$elm$browser$Browser$Events$MySub,
			node,
			name,
			A2($elm$json$Json$Decode$map, func, decoder));
	});
_Platform_effectManagers['Browser.Events'] = _Platform_createManager($elm$browser$Browser$Events$init, $elm$browser$Browser$Events$onEffects, $elm$browser$Browser$Events$onSelfMsg, 0, $elm$browser$Browser$Events$subMap);
var $elm$browser$Browser$Events$subscription = _Platform_leaf('Browser.Events');
var $elm$browser$Browser$Events$on = F3(
	function (node, name, decoder) {
		return $elm$browser$Browser$Events$subscription(
			A3($elm$browser$Browser$Events$MySub, node, name, decoder));
	});
var $elm$browser$Browser$Events$onKeyDown = A2($elm$browser$Browser$Events$on, $elm$browser$Browser$Events$Document, 'keydown');
var $elm$browser$Browser$Events$onKeyUp = A2($elm$browser$Browser$Events$on, $elm$browser$Browser$Events$Document, 'keyup');
var $elm$browser$Browser$Events$Window = {$: 'Window'};
var $elm$browser$Browser$Events$onResize = function (func) {
	return A3(
		$elm$browser$Browser$Events$on,
		$elm$browser$Browser$Events$Window,
		'resize',
		A2(
			$elm$json$Json$Decode$field,
			'target',
			A3(
				$elm$json$Json$Decode$map2,
				func,
				A2($elm$json$Json$Decode$field, 'innerWidth', $elm$json$Json$Decode$int),
				A2($elm$json$Json$Decode$field, 'innerHeight', $elm$json$Json$Decode$int))));
};
var $author$project$Main$subscriptions = function (model) {
	return $elm$core$Platform$Sub$batch(
		_List_fromArray(
			[
				_Utils_eq(model.state, $author$project$Model$Playing) ? $elm$browser$Browser$Events$onAnimationFrameDelta($author$project$Message$Tick) : $elm$core$Platform$Sub$none,
				$elm$browser$Browser$Events$onKeyUp(
				A2(
					$elm$json$Json$Decode$map,
					$author$project$Main$key(false),
					$elm$html$Html$Events$keyCode)),
				$elm$browser$Browser$Events$onKeyDown(
				A2(
					$elm$json$Json$Decode$map,
					$author$project$Main$key(true),
					$elm$html$Html$Events$keyCode)),
				$elm$browser$Browser$Events$onResize($author$project$Message$Resize)
			]));
};
var $author$project$Items$Home = {$: 'Home'};
var $author$project$Items$Switching = {$: 'Switching'};
var $author$project$Update$judgeAreaOverlap = F2(
	function (model, area) {
		var _v0 = _Utils_Tuple2(area.x, area.y);
		var x2 = _v0.a;
		var y2 = _v0.b;
		var _v1 = _Utils_Tuple2(model.hero.x, model.hero.y);
		var x1 = _v1.a;
		var y1 = _v1.b;
		var _v2 = _Utils_Tuple2(area.wid, area.hei);
		var w2 = _v2.a;
		var h2 = _v2.b;
		var _v3 = _Utils_Tuple2(model.hero.width, model.hero.height);
		var w1 = _v3.a;
		var h1 = _v3.b;
		return ((_Utils_cmp(x2 - w1, x1) < 1) && ((_Utils_cmp(x1, x2 + w2) < 1) && ((_Utils_cmp(y2 - h1, y1) < 1) && (_Utils_cmp(y1, y2 + h2) < 1)))) ? true : false;
	});
var $author$project$Update$judgeExit = function (model) {
	var exit = model.mapAttr.exit;
	return A2($author$project$Update$judgeAreaOverlap, model, exit);
};
var $author$project$Model$homeBarrier = function () {
	var _v0 = $author$project$Model$gameMode______;
	if (_v0.$ === 'GettingCoordinates') {
		return _List_Nil;
	} else {
		return _List_fromArray(
			[
				{hei: 20, wid: 575, x: 290, y: 500},
				{hei: 20, wid: 650, x: 205, y: 260},
				{hei: 20, wid: 610, x: 265, y: 45},
				{hei: 20, wid: 45, x: 475, y: 280},
				{hei: 20, wid: 45, x: 695, y: 520},
				{hei: 20, wid: 30, x: 205, y: 300},
				{hei: 20, wid: 50, x: 235, y: 275},
				{hei: 20, wid: 30, x: 590, y: 60},
				{hei: 80, wid: 20, x: 570, y: 65},
				{hei: 20, wid: 95, x: 655, y: 60},
				{hei: 80, wid: 20, x: 825, y: 520},
				{hei: 80, wid: 20, x: 825, y: 280},
				{hei: 80, wid: 20, x: 835, y: 65},
				{hei: 180, wid: 20, x: 185, y: 420},
				{hei: 180, wid: 20, x: 185, y: 190},
				{hei: 180, wid: 20, x: 185, y: -40},
				{hei: 20, wid: 660, x: 205, y: 600},
				{hei: 20, wid: 660, x: 205, y: 360},
				{hei: 20, wid: 660, x: 205, y: 145}
			]);
	}
}();
var $author$project$Model$homeElevator = _List_fromArray(
	[
		{
		area: {hei: 110, wid: 115, x: 760, y: 430},
		which: $author$project$Model$Elevator
	},
		{
		area: {hei: 110, wid: 100, x: 775, y: 195},
		which: $author$project$Model$Elevator
	},
		{
		area: {hei: 85, wid: 115, x: 760, y: 0},
		which: $author$project$Model$Elevator
	}
	]);
var $author$project$Model$homeAttr = {
	barrier: $author$project$Model$homeBarrier,
	elevator: $author$project$Model$homeElevator,
	exit: {hei: 150, wid: 20, x: 345, y: 450},
	heroIni: {height: 60, width: 20, x: 400, y: 520},
	npcs: _List_Nil,
	story: ''
};
var $author$project$Model$Adkins = {$: 'Adkins'};
var $author$project$Model$pAdkins = {
	area: {hei: 60, wid: 20, x: 450, y: 400},
	description: 'ADKINS.npc.day=1',
	interacttrue: false,
	itemType: $author$project$Model$Adkins
};
var $author$project$Model$pAllen = {
	area: {hei: 60, wid: 20, x: 300, y: 500},
	description: 'ALLENPARK.npc.day=1',
	interacttrue: false,
	itemType: $author$project$Model$Allen
};
var $author$project$Model$Catherine = {$: 'Catherine'};
var $author$project$Model$pCatherine = {
	area: {hei: 60, wid: 20, x: 400, y: 400},
	description: 'CATHERINE.npc.day=1',
	interacttrue: false,
	itemType: $author$project$Model$Catherine
};
var $author$project$Model$pLee = {
	area: {hei: 60, wid: 20, x: 400, y: 270},
	description: 'LEEPARK.npc.day=1',
	interacttrue: false,
	itemType: $author$project$Model$Lee
};
var $author$project$Model$parkAttr = {
	barrier: _List_Nil,
	elevator: _List_Nil,
	exit: {hei: 90, wid: 200, x: 620, y: 250},
	heroIni: {height: 90, width: 30, x: 500, y: 250},
	npcs: _List_fromArray(
		[$author$project$Model$pAllen, $author$project$Model$pLee, $author$project$Model$pAdkins, $author$project$Model$pCatherine]),
	story: 'I arrive at the park. This is a desolate place.'
};
var $author$project$Model$switchingAttr = {
	barrier: _List_Nil,
	elevator: _List_Nil,
	exit: {hei: 0, wid: 0, x: 0, y: 0},
	heroIni: {height: 60, width: 20, x: 6000, y: 6000},
	npcs: _List_Nil,
	story: ''
};
var $author$project$Update$mapSwitch = F2(
	function (newMap, model) {
		var mapAttr = function () {
			switch (newMap.$) {
				case 'PoliceOffice':
					return $author$project$Model$policeOfficeAttr;
				case 'Park':
					return $author$project$Model$parkAttr;
				case 'Home':
					return $author$project$Model$homeAttr;
				default:
					return $author$project$Model$switchingAttr;
			}
		}();
		var npcs = mapAttr.npcs;
		var story = mapAttr.story;
		var hero = mapAttr.heroIni;
		return _Utils_update(
			model,
			{hero: hero, map: newMap, mapAttr: mapAttr, npcs: npcs, story: story});
	});
var $author$project$Update$goToSwitching = function (model) {
	return $author$project$Update$judgeExit(model) ? A2($author$project$Update$mapSwitch, $author$project$Items$Switching, model) : model;
};
var $author$project$Update$isEnergyEnoughInteract = function (model) {
	var energy_Cost = model.energy_Cost_interact;
	var energy = model.energy;
	return ((energy - energy_Cost) >= 0) ? true : false;
};
var $author$project$Update$canInteract = F2(
	function (model, npc) {
		return (A2($author$project$Update$judgeAreaOverlap, model, npc.area) && $author$project$Update$isEnergyEnoughInteract(model)) ? true : false;
	});
var $author$project$Update$interact = F2(
	function (model, npc) {
		return A2($author$project$Update$canInteract, model, npc) ? _Utils_update(
			npc,
			{interacttrue: true}) : _Utils_update(
			npc,
			{interacttrue: false});
	});
var $author$project$Update$interactable = function (model) {
	var interacted_npcs = A2(
		$elm$core$List$map,
		$author$project$Update$interact(model),
		model.npcs);
	return _Utils_update(
		model,
		{npcs: interacted_npcs});
};
var $author$project$Update$judgeinteract = function (npc) {
	var _v0 = npc.interacttrue;
	if (_v0) {
		return true;
	} else {
		return false;
	}
};
var $author$project$Update$judgeInteract = function (model) {
	return _Utils_update(
		model,
		{
			interacttrue: A2(
				$elm$core$List$member,
				true,
				A2($elm$core$List$map, $author$project$Update$judgeinteract, model.npcs))
		});
};
var $author$project$Update$activateButton = F3(
	function (interval, elapsed, state) {
		var elapsed_ = state.elapsed + elapsed;
		return (_Utils_cmp(elapsed_, interval) > 0) ? _Utils_update(
			state,
			{active: true, elapsed: elapsed_ - interval}) : _Utils_update(
			state,
			{active: false, elapsed: elapsed_});
	});
var $author$project$Update$directionLR = function (_v0) {
	var heroMoveLeft = _v0.heroMoveLeft;
	var heroMoveRight = _v0.heroMoveRight;
	var _v1 = _Utils_Tuple2(heroMoveLeft, heroMoveRight);
	_v1$2:
	while (true) {
		if (_v1.a) {
			if (!_v1.b) {
				return -1;
			} else {
				break _v1$2;
			}
		} else {
			if (_v1.b) {
				return 1;
			} else {
				break _v1$2;
			}
		}
	}
	return 0;
};
var $author$project$Update$LeftSide = {$: 'LeftSide'};
var $author$project$Update$RightSide = {$: 'RightSide'};
var $elm$core$List$filter = F2(
	function (isGood, list) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, xs) {
					return isGood(x) ? A2($elm$core$List$cons, x, xs) : xs;
				}),
			_List_Nil,
			list);
	});
var $author$project$Update$DownSide = {$: 'DownSide'};
var $author$project$Update$Err = {$: 'Err'};
var $author$project$Update$NoStuck = {$: 'NoStuck'};
var $author$project$Update$UpSide = {$: 'UpSide'};
var $author$project$Update$stride = 5;
var $author$project$Update$isStuck = F2(
	function (model, area) {
		var _v0 = _Utils_Tuple2(area.x, area.y);
		var x2 = _v0.a;
		var y2 = _v0.b;
		var _v1 = _Utils_Tuple2(model.hero.x, model.hero.y);
		var x1 = _v1.a;
		var y1 = _v1.b;
		var _v2 = _Utils_Tuple2(area.wid, area.hei);
		var w2 = _v2.a;
		var h2 = _v2.b;
		var _v3 = _Utils_Tuple2(model.hero.width, model.hero.height);
		var w1 = _v3.a;
		var h1 = _v3.b;
		var _v4 = _Utils_Tuple2(y2 - h1, y2 + h2);
		var yu = _v4.a;
		var yd = _v4.b;
		var downSide = (_Utils_cmp(y1, yd) < 1) && (_Utils_cmp(y1, yd - $author$project$Update$stride) > -1);
		var upSide = (_Utils_cmp(y1, yu + $author$project$Update$stride) < 1) && (_Utils_cmp(y1, yu) > -1);
		var _v5 = _Utils_Tuple2(x2 - w1, x2 + w2);
		var xl = _v5.a;
		var xr = _v5.b;
		var leftSide = (_Utils_cmp(x1, xl) > -1) && (_Utils_cmp(x1, xl + $author$project$Update$stride) < 1);
		var rightSide = (_Utils_cmp(x1, xr - $author$project$Update$stride) > -1) && (_Utils_cmp(x1, xr) < 1);
		var corner = (leftSide || rightSide) && (upSide || downSide);
		return (corner || (!A2($author$project$Update$judgeAreaOverlap, model, area))) ? $author$project$Update$NoStuck : (leftSide ? $author$project$Update$LeftSide : (rightSide ? $author$project$Update$RightSide : (upSide ? $author$project$Update$UpSide : (downSide ? $author$project$Update$DownSide : $author$project$Update$Err))));
	});
var $elm$core$Basics$neq = _Utils_notEqual;
var $author$project$Update$moveHeroLR_ = F2(
	function (dx, model) {
		var overlapAreas = A2(
			$elm$core$List$filter,
			$author$project$Update$judgeAreaOverlap(model),
			model.mapAttr.barrier);
		var hero = model.hero;
		var _v0 = _Utils_Tuple2(model.hero.x, model.hero.y);
		var x = _v0.a;
		var y = _v0.b;
		var x_ = (!$elm$core$List$length(overlapAreas)) ? (x + (dx * $author$project$Update$stride)) : ((!(!$elm$core$List$length(
			A2(
				$elm$core$List$filter,
				function (a) {
					return _Utils_eq(
						A2($author$project$Update$isStuck, model, a),
						$author$project$Update$LeftSide);
				},
				overlapAreas)))) ? ((dx > 0) ? x : (x + (dx * $author$project$Update$stride))) : ((!(!$elm$core$List$length(
			A2(
				$elm$core$List$filter,
				function (a) {
					return _Utils_eq(
						A2($author$project$Update$isStuck, model, a),
						$author$project$Update$RightSide);
				},
				overlapAreas)))) ? ((dx < 0) ? x : (x + (dx * $author$project$Update$stride))) : (x + (dx * $author$project$Update$stride))));
		var hero_ = _Utils_update(
			hero,
			{x: x_});
		return _Utils_update(
			model,
			{hero: hero_});
	});
var $elm$core$Tuple$second = function (_v0) {
	var y = _v0.b;
	return y;
};
var $author$project$Update$moveHeroLR = F2(
	function (elapsed, model) {
		var udState = model.heroDir.b;
		var lrState = model.heroDir.a;
		if (lrState.$ === 'Just') {
			var state = lrState.a;
			return (state.active ? $author$project$Update$moveHeroLR_(
				$author$project$Update$directionLR(model)) : $elm$core$Basics$identity)(
				_Utils_update(
					model,
					{
						heroDir: _Utils_Tuple2(
							$elm$core$Maybe$Just(
								A3($author$project$Update$activateButton, 50, elapsed, state)),
							udState)
					}));
		} else {
			return model;
		}
	});
var $author$project$Update$directionUD = function (_v0) {
	var heroMoveUp = _v0.heroMoveUp;
	var heroMoveDown = _v0.heroMoveDown;
	var _v1 = _Utils_Tuple2(heroMoveUp, heroMoveDown);
	_v1$2:
	while (true) {
		if (_v1.a) {
			if (!_v1.b) {
				return -1;
			} else {
				break _v1$2;
			}
		} else {
			if (_v1.b) {
				return 1;
			} else {
				break _v1$2;
			}
		}
	}
	return 0;
};
var $author$project$Update$moveHeroUD_ = F2(
	function (dy, model) {
		var overlapAreas = A2(
			$elm$core$List$filter,
			$author$project$Update$judgeAreaOverlap(model),
			model.mapAttr.barrier);
		var hero = model.hero;
		var _v0 = _Utils_Tuple2(model.hero.x, model.hero.y);
		var x = _v0.a;
		var y = _v0.b;
		var y_ = (!$elm$core$List$length(overlapAreas)) ? (y + (dy * $author$project$Update$stride)) : ((!(!$elm$core$List$length(
			A2(
				$elm$core$List$filter,
				function (a) {
					return _Utils_eq(
						A2($author$project$Update$isStuck, model, a),
						$author$project$Update$UpSide);
				},
				overlapAreas)))) ? ((dy > 0) ? y : (y + (dy * $author$project$Update$stride))) : ((!(!$elm$core$List$length(
			A2(
				$elm$core$List$filter,
				function (a) {
					return _Utils_eq(
						A2($author$project$Update$isStuck, model, a),
						$author$project$Update$DownSide);
				},
				overlapAreas)))) ? ((dy < 0) ? y : (y + (dy * $author$project$Update$stride))) : (y + (dy * $author$project$Update$stride))));
		var hero_ = _Utils_update(
			hero,
			{y: y_});
		return _Utils_update(
			model,
			{hero: hero_});
	});
var $author$project$Update$moveHeroUD = F2(
	function (elapsed, model) {
		var udState = model.heroDir.b;
		var lrState = model.heroDir.a;
		if (udState.$ === 'Just') {
			var state = udState.a;
			return (state.active ? $author$project$Update$moveHeroUD_(
				$author$project$Update$directionUD(model)) : $elm$core$Basics$identity)(
				_Utils_update(
					model,
					{
						heroDir: _Utils_Tuple2(
							lrState,
							$elm$core$Maybe$Just(
								A3($author$project$Update$activateButton, 50, elapsed, state)))
					}));
		} else {
			return model;
		}
	});
var $author$project$Tosvg$getnpc = function (npc) {
	var npc_ = function () {
		var _v0 = npc.interacttrue;
		if (_v0) {
			return npc.description;
		} else {
			return '';
		}
	}();
	return npc_;
};
var $author$project$Tosvg$getnpc_ = function (model) {
	return A2($elm$core$List$map, $author$project$Tosvg$getnpc, model.npcs);
};
var $author$project$Tosvg$getdescription = function (model) {
	return A2(
		$elm$core$List$filter,
		function (x) {
			return x !== '';
		},
		$author$project$Tosvg$getnpc_(model));
};
var $elm$core$List$head = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(x);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Update$myItem = function (model) {
	return _Utils_update(
		model,
		{
			portrait: A2(
				$elm$core$Maybe$withDefault,
				'',
				$elm$core$List$head(
					$author$project$Tosvg$getdescription(model)))
		});
};
var $author$project$Update$animate = F2(
	function (elapsed, model) {
		return $author$project$Update$myItem(
			$author$project$Update$interactable(
				$author$project$Update$judgeInteract(
					$author$project$Update$goToSwitching(
						A2(
							$author$project$Update$moveHeroUD,
							elapsed,
							A2($author$project$Update$moveHeroLR, elapsed, model))))));
	});
var $author$project$Model$ElevatorQuest = {$: 'ElevatorQuest'};
var $author$project$Update$elevateQuestOut = F2(
	function (elevator, model) {
		var isNear = A2($author$project$Update$judgeAreaOverlap, model, elevator.area);
		return isNear;
	});
var $author$project$Update$judgeWhichVehicle = F2(
	function (model, vehicle) {
		var _v0 = vehicle.which;
		if (_v0.$ === 'Elevator') {
			return A2($author$project$Update$elevateQuestOut, vehicle, model);
		} else {
			return false;
		}
	});
var $author$project$Update$enterElevators = function (model) {
	var questCurr = model.quests;
	var elevators = model.mapAttr.elevator;
	var isNearList = A2(
		$elm$core$List$map,
		$author$project$Update$judgeWhichVehicle(model),
		elevators);
	var isNear = A3($elm$core$List$foldl, $elm$core$Basics$or, false, isNearList);
	if (isNear) {
		if (questCurr.$ === 'ElevatorQuest') {
			return _Utils_update(
				model,
				{quests: $author$project$Model$NoQuest});
		} else {
			return _Utils_update(
				model,
				{quests: $author$project$Model$ElevatorQuest});
		}
	} else {
		return model;
	}
};
var $author$project$Model$None = {$: 'None'};
var $author$project$Model$emptyNPC = {
	area: {hei: 60, wid: 20, x: 4000, y: 2700},
	description: '',
	interacttrue: false,
	itemType: $author$project$Model$None
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$decStat = F3(
	function (key, delta, entity) {
		var current = A2(
			$elm$core$Maybe$withDefault,
			0,
			A2($elm$core$Dict$get, key, entity.stats));
		return _Utils_update(
			entity,
			{
				stats: A3($elm$core$Dict$insert, key, current - delta, entity.stats)
			});
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$incStat = F3(
	function (key, delta, entity) {
		var current = A2(
			$elm$core$Maybe$withDefault,
			0,
			A2($elm$core$Dict$get, key, entity.stats));
		return _Utils_update(
			entity,
			{
				stats: A3($elm$core$Dict$insert, key, current + delta, entity.stats)
			});
	});
var $elm$core$Dict$getMin = function (dict) {
	getMin:
	while (true) {
		if ((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) {
			var left = dict.d;
			var $temp$dict = left;
			dict = $temp$dict;
			continue getMin;
		} else {
			return dict;
		}
	}
};
var $elm$core$Dict$moveRedLeft = function (dict) {
	if (((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) && (dict.e.$ === 'RBNode_elm_builtin')) {
		if ((dict.e.d.$ === 'RBNode_elm_builtin') && (dict.e.d.a.$ === 'Red')) {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v1 = dict.d;
			var lClr = _v1.a;
			var lK = _v1.b;
			var lV = _v1.c;
			var lLeft = _v1.d;
			var lRight = _v1.e;
			var _v2 = dict.e;
			var rClr = _v2.a;
			var rK = _v2.b;
			var rV = _v2.c;
			var rLeft = _v2.d;
			var _v3 = rLeft.a;
			var rlK = rLeft.b;
			var rlV = rLeft.c;
			var rlL = rLeft.d;
			var rlR = rLeft.e;
			var rRight = _v2.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				$elm$core$Dict$Red,
				rlK,
				rlV,
				A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					rlL),
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, rK, rV, rlR, rRight));
		} else {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v4 = dict.d;
			var lClr = _v4.a;
			var lK = _v4.b;
			var lV = _v4.c;
			var lLeft = _v4.d;
			var lRight = _v4.e;
			var _v5 = dict.e;
			var rClr = _v5.a;
			var rK = _v5.b;
			var rV = _v5.c;
			var rLeft = _v5.d;
			var rRight = _v5.e;
			if (clr.$ === 'Black') {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			}
		}
	} else {
		return dict;
	}
};
var $elm$core$Dict$moveRedRight = function (dict) {
	if (((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) && (dict.e.$ === 'RBNode_elm_builtin')) {
		if ((dict.d.d.$ === 'RBNode_elm_builtin') && (dict.d.d.a.$ === 'Red')) {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v1 = dict.d;
			var lClr = _v1.a;
			var lK = _v1.b;
			var lV = _v1.c;
			var _v2 = _v1.d;
			var _v3 = _v2.a;
			var llK = _v2.b;
			var llV = _v2.c;
			var llLeft = _v2.d;
			var llRight = _v2.e;
			var lRight = _v1.e;
			var _v4 = dict.e;
			var rClr = _v4.a;
			var rK = _v4.b;
			var rV = _v4.c;
			var rLeft = _v4.d;
			var rRight = _v4.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				$elm$core$Dict$Red,
				lK,
				lV,
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, llK, llV, llLeft, llRight),
				A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					lRight,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight)));
		} else {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v5 = dict.d;
			var lClr = _v5.a;
			var lK = _v5.b;
			var lV = _v5.c;
			var lLeft = _v5.d;
			var lRight = _v5.e;
			var _v6 = dict.e;
			var rClr = _v6.a;
			var rK = _v6.b;
			var rV = _v6.c;
			var rLeft = _v6.d;
			var rRight = _v6.e;
			if (clr.$ === 'Black') {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			}
		}
	} else {
		return dict;
	}
};
var $elm$core$Dict$removeHelpPrepEQGT = F7(
	function (targetKey, dict, color, key, value, left, right) {
		if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
			var _v1 = left.a;
			var lK = left.b;
			var lV = left.c;
			var lLeft = left.d;
			var lRight = left.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				lK,
				lV,
				lLeft,
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, lRight, right));
		} else {
			_v2$2:
			while (true) {
				if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Black')) {
					if (right.d.$ === 'RBNode_elm_builtin') {
						if (right.d.a.$ === 'Black') {
							var _v3 = right.a;
							var _v4 = right.d;
							var _v5 = _v4.a;
							return $elm$core$Dict$moveRedRight(dict);
						} else {
							break _v2$2;
						}
					} else {
						var _v6 = right.a;
						var _v7 = right.d;
						return $elm$core$Dict$moveRedRight(dict);
					}
				} else {
					break _v2$2;
				}
			}
			return dict;
		}
	});
var $elm$core$Dict$removeMin = function (dict) {
	if ((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) {
		var color = dict.a;
		var key = dict.b;
		var value = dict.c;
		var left = dict.d;
		var lColor = left.a;
		var lLeft = left.d;
		var right = dict.e;
		if (lColor.$ === 'Black') {
			if ((lLeft.$ === 'RBNode_elm_builtin') && (lLeft.a.$ === 'Red')) {
				var _v3 = lLeft.a;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					key,
					value,
					$elm$core$Dict$removeMin(left),
					right);
			} else {
				var _v4 = $elm$core$Dict$moveRedLeft(dict);
				if (_v4.$ === 'RBNode_elm_builtin') {
					var nColor = _v4.a;
					var nKey = _v4.b;
					var nValue = _v4.c;
					var nLeft = _v4.d;
					var nRight = _v4.e;
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						$elm$core$Dict$removeMin(nLeft),
						nRight);
				} else {
					return $elm$core$Dict$RBEmpty_elm_builtin;
				}
			}
		} else {
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				key,
				value,
				$elm$core$Dict$removeMin(left),
				right);
		}
	} else {
		return $elm$core$Dict$RBEmpty_elm_builtin;
	}
};
var $elm$core$Dict$removeHelp = F2(
	function (targetKey, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		} else {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			if (_Utils_cmp(targetKey, key) < 0) {
				if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Black')) {
					var _v4 = left.a;
					var lLeft = left.d;
					if ((lLeft.$ === 'RBNode_elm_builtin') && (lLeft.a.$ === 'Red')) {
						var _v6 = lLeft.a;
						return A5(
							$elm$core$Dict$RBNode_elm_builtin,
							color,
							key,
							value,
							A2($elm$core$Dict$removeHelp, targetKey, left),
							right);
					} else {
						var _v7 = $elm$core$Dict$moveRedLeft(dict);
						if (_v7.$ === 'RBNode_elm_builtin') {
							var nColor = _v7.a;
							var nKey = _v7.b;
							var nValue = _v7.c;
							var nLeft = _v7.d;
							var nRight = _v7.e;
							return A5(
								$elm$core$Dict$balance,
								nColor,
								nKey,
								nValue,
								A2($elm$core$Dict$removeHelp, targetKey, nLeft),
								nRight);
						} else {
							return $elm$core$Dict$RBEmpty_elm_builtin;
						}
					}
				} else {
					return A5(
						$elm$core$Dict$RBNode_elm_builtin,
						color,
						key,
						value,
						A2($elm$core$Dict$removeHelp, targetKey, left),
						right);
				}
			} else {
				return A2(
					$elm$core$Dict$removeHelpEQGT,
					targetKey,
					A7($elm$core$Dict$removeHelpPrepEQGT, targetKey, dict, color, key, value, left, right));
			}
		}
	});
var $elm$core$Dict$removeHelpEQGT = F2(
	function (targetKey, dict) {
		if (dict.$ === 'RBNode_elm_builtin') {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			if (_Utils_eq(targetKey, key)) {
				var _v1 = $elm$core$Dict$getMin(right);
				if (_v1.$ === 'RBNode_elm_builtin') {
					var minKey = _v1.b;
					var minValue = _v1.c;
					return A5(
						$elm$core$Dict$balance,
						color,
						minKey,
						minValue,
						left,
						$elm$core$Dict$removeMin(right));
				} else {
					return $elm$core$Dict$RBEmpty_elm_builtin;
				}
			} else {
				return A5(
					$elm$core$Dict$balance,
					color,
					key,
					value,
					left,
					A2($elm$core$Dict$removeHelp, targetKey, right));
			}
		} else {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		}
	});
var $elm$core$Dict$remove = F2(
	function (key, dict) {
		var _v0 = A2($elm$core$Dict$removeHelp, key, dict);
		if ((_v0.$ === 'RBNode_elm_builtin') && (_v0.a.$ === 'Red')) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $elm$core$Set$remove = F2(
	function (key, _v0) {
		var dict = _v0.a;
		return $elm$core$Set$Set_elm_builtin(
			A2($elm$core$Dict$remove, key, dict));
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$removeTag = F2(
	function (value, entity) {
		return _Utils_update(
			entity,
			{
				tags: A2($elm$core$Set$remove, value, entity.tags)
			});
	});
var $elm$core$Dict$update = F3(
	function (targetKey, alter, dictionary) {
		var _v0 = alter(
			A2($elm$core$Dict$get, targetKey, dictionary));
		if (_v0.$ === 'Just') {
			var value = _v0.a;
			return A3($elm$core$Dict$insert, targetKey, value, dictionary);
		} else {
			return A2($elm$core$Dict$remove, targetKey, dictionary);
		}
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$update = F3(
	function (id, updateFn, store) {
		return A3(
			$elm$core$Dict$update,
			id,
			$elm$core$Maybe$map(updateFn),
			store);
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$applyChanges = F3(
	function (entityUpdates, trigger, store) {
		var parseID = function (id) {
			if (id === '$') {
				return trigger;
			} else {
				return id;
			}
		};
		var applyChange = F3(
			function (id, change, updated_store) {
				switch (change.$) {
					case 'AddTag':
						var tag_ = change.a;
						return A3(
							$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$update,
							id,
							$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$addTag(tag_),
							updated_store);
					case 'RemoveTag':
						var tag_ = change.a;
						return A3(
							$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$update,
							id,
							$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$removeTag(tag_),
							updated_store);
					case 'SetStat':
						var key = change.a;
						var stat_ = change.b;
						return A3(
							$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$update,
							id,
							A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$setStat, key, stat_),
							updated_store);
					case 'IncStat':
						var key = change.a;
						var amount = change.b;
						return A3(
							$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$update,
							id,
							A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$incStat, key, amount),
							updated_store);
					case 'DecStat':
						var key = change.a;
						var amount = change.b;
						return A3(
							$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$update,
							id,
							A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$decStat, key, amount),
							updated_store);
					default:
						if (change.b.$ === 'SpecificLinkTarget') {
							var key = change.a;
							var linkID = change.b.a;
							return A3(
								$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$update,
								id,
								A2(
									$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$setLink,
									key,
									parseID(linkID)),
								updated_store);
						} else {
							var key = change.a;
							var _v3 = change.b;
							var linkID = _v3.a;
							var linkKey = _v3.b;
							return A2(
								$elm$core$Maybe$withDefault,
								updated_store,
								A2(
									$elm$core$Maybe$map,
									function (targetID) {
										return A3(
											$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$update,
											id,
											A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$setLink, key, targetID),
											updated_store);
									},
									A2(
										$elm$core$Maybe$andThen,
										A2(
											$elm$core$Basics$composeR,
											function ($) {
												return $.links;
											},
											$elm$core$Dict$get(linkKey)),
										A2(
											$elm$core$Dict$get,
											parseID(linkID),
											updated_store))));
						}
				}
			});
		var updateEntity = function (id) {
			return $elm$core$List$foldl(
				applyChange(id));
		};
		var applyUpdate = F2(
			function (entityUpdate, updated_store) {
				if (entityUpdate.$ === 'Update') {
					var id = entityUpdate.a;
					var changes = entityUpdate.b;
					return A3(
						updateEntity,
						parseID(id),
						updated_store,
						changes);
				} else {
					var queries = entityUpdate.a;
					var changes = entityUpdate.b;
					return A3(
						$elm$core$List$foldl,
						F2(
							function (_v1, acc) {
								var id = _v1.a;
								return A3(updateEntity, id, acc, changes);
							}),
						updated_store,
						A2(
							$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$query,
							$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$MatchAny(queries),
							updated_store));
				}
			});
		return A3($elm$core$List$foldl, applyUpdate, store, entityUpdates);
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$Rules$matchCondition = F3(
	function (trigger, store, matcher) {
		return !$elm$core$List$isEmpty(
			function (m) {
				return A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$query, m, store);
			}(
				A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$replaceTrigger, trigger, matcher)));
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$Rules$matchTrigger = F3(
	function (store, trigger, triggerMatcher) {
		if (triggerMatcher.$ === 'SpecificTrigger') {
			var t = triggerMatcher.a;
			return _Utils_eq(trigger, t);
		} else {
			if (triggerMatcher.a.$ === 'Match') {
				var em = triggerMatcher.a;
				var id = em.a;
				var qs = em.b;
				return _Utils_eq(id, trigger) && (!$elm$core$List$isEmpty(
					A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$query, em, store)));
			} else {
				var qs = triggerMatcher.a.a;
				return !$elm$core$List$isEmpty(
					A2(
						$jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$query,
						A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$Match, trigger, qs),
						store));
			}
		}
	});
var $elm$core$List$sortBy = _List_sortBy;
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$Rules$weight = function (_v0) {
	var trigger = _v0.trigger;
	var conditions = _v0.conditions;
	var queryScore = function (matcher) {
		if (matcher.$ === 'Match') {
			var id = matcher.a;
			var queries = matcher.b;
			return $elm$core$List$length(queries);
		} else {
			var queries = matcher.a;
			return $elm$core$List$length(queries);
		}
	};
	var triggerScore = function () {
		if (trigger.$ === 'SpecificTrigger') {
			return 0;
		} else {
			if (trigger.a.$ === 'Match') {
				var em = trigger.a;
				return 100 + queryScore(em);
			} else {
				var em = trigger.a;
				return 0 + queryScore(em);
			}
		}
	}();
	var conditionsScore = A3(
		$elm$core$List$foldl,
		F2(
			function (matcher, acc) {
				if (matcher.$ === 'Match') {
					return (10 + queryScore(matcher)) + acc;
				} else {
					return (0 + queryScore(matcher)) + acc;
				}
			}),
		0,
		conditions);
	return conditionsScore + triggerScore;
};
var $jschomay$elm_narrative_engine$NarrativeEngine$Core$Rules$findMatchingRule = F3(
	function (trigger, rules, store) {
		return $elm$core$List$head(
			$elm$core$List$reverse(
				A2(
					$elm$core$List$sortBy,
					A2($elm$core$Basics$composeR, $elm$core$Tuple$second, $jschomay$elm_narrative_engine$NarrativeEngine$Core$Rules$weight),
					$elm$core$Dict$toList(
						A2(
							$elm$core$Dict$filter,
							F2(
								function (ruleId, rule) {
									return A3($jschomay$elm_narrative_engine$NarrativeEngine$Core$Rules$matchTrigger, store, trigger, rule.trigger) && A2(
										$elm$core$List$all,
										A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$Rules$matchCondition, trigger, store),
										rule.conditions);
								}),
							rules)))));
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$parse = F2(
	function (config, text) {
		var _v0 = A2(
			$elm$parser$Parser$run,
			$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$top(config),
			text);
		if (_v0.$ === 'Ok') {
			var parsed = _v0.a;
			return A2(
				$elm$core$List$filter,
				A2(
					$elm$core$Basics$composeL,
					A2($elm$core$Basics$composeL, $elm$core$Basics$not, $elm$core$String$isEmpty),
					$elm$core$String$trim),
				A2($elm$core$String$split, '---', parsed));
		} else {
			var e = _v0.a;
			return _List_fromArray(
				['ERROR could not parse: ' + text]);
		}
	});
var $author$project$Model$getDescription = F3(
	function (config, entityID, worldModel_) {
		return A2(
			$elm$core$Maybe$withDefault,
			'ERROR parsing narrative content for ' + entityID,
			$elm$core$List$head(
				A2(
					$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$parse,
					config,
					A2(
						$elm$core$Maybe$withDefault,
						'ERROR can\'t find entity ' + entityID,
						A2(
							$elm$core$Maybe$map,
							function ($) {
								return $.description;
							},
							A2($elm$core$Dict$get, entityID, worldModel_))))));
	});
var $author$project$Model$getName = F2(
	function (entityID, worldModel_) {
		return A2(
			$elm$core$Maybe$withDefault,
			'ERROR can\'t find entity ' + entityID,
			A2(
				$elm$core$Maybe$map,
				function ($) {
					return $.name;
				},
				A2($elm$core$Dict$get, entityID, worldModel_)));
	});
var $elm$core$Dict$singleton = F2(
	function (key, value) {
		return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, key, value, $elm$core$Dict$RBEmpty_elm_builtin, $elm$core$Dict$RBEmpty_elm_builtin);
	});
var $author$project$Model$makeConfig = F3(
	function (trigger, matchedRule, model) {
		return {
			cycleIndex: A2(
				$elm$core$Maybe$withDefault,
				0,
				A2($elm$core$Dict$get, matchedRule, model.ruleCounts)),
			propKeywords: A2(
				$elm$core$Dict$singleton,
				'name',
				function (id) {
					return $elm$core$Result$Ok(
						A2($author$project$Model$getName, id, model.worldModel));
				}),
			trigger: trigger,
			worldModel: model.worldModel
		};
	});
var $elm$core$Platform$Cmd$batch = _Platform_batch;
var $elm$core$Platform$Cmd$none = $elm$core$Platform$Cmd$batch(_List_Nil);
var $author$project$Rules$parsedData = function () {
	var addExtraRuleFields = F2(
		function (extraFields, rule) {
			return rule;
		});
	var addExtraEntityFields = F2(
		function (_v0, _v1) {
			var name = _v0.name;
			var description = _v0.description;
			var tags = _v1.tags;
			var stats = _v1.stats;
			var links = _v1.links;
			return {description: description, links: links, name: name, stats: stats, tags: tags};
		});
	var parsedData_ = A4(
		$elm$core$Result$map3,
		F3(
			function (parsedInitialWorldModel, narrative, parsedRules) {
				return _Utils_Tuple2(parsedInitialWorldModel, parsedRules);
			}),
		A2($jschomay$elm_narrative_engine$NarrativeEngine$Syntax$EntityParser$parseMany, addExtraEntityFields, $author$project$Rules$initialWorldModelSpec),
		$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$parseMany($author$project$Rules$narrative_content),
		A2($jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$parseRules, addExtraRuleFields, $author$project$Rules$rulesSpec));
	return A2(
		$elm$core$Result$withDefault,
		$elm$core$Dict$empty,
		A2($elm$core$Result$map, $elm$core$Tuple$second, parsedData_));
}();
var $jschomay$elm_narrative_engine$NarrativeEngine$Debug$setLastInteractionId = F2(
	function (id, _v0) {
		var state = _v0.a;
		return $jschomay$elm_narrative_engine$NarrativeEngine$Debug$State(
			_Utils_update(
				state,
				{lastInteractionId: id}));
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Debug$setLastMatchedRuleId = F2(
	function (id, _v0) {
		var state = _v0.a;
		return $jschomay$elm_narrative_engine$NarrativeEngine$Debug$State(
			_Utils_update(
				state,
				{lastMatchedRuleId: id}));
	});
var $author$project$Update$interactWith__core = F2(
	function (trigger, model) {
		var _v0 = A3($jschomay$elm_narrative_engine$NarrativeEngine$Core$Rules$findMatchingRule, trigger, $author$project$Rules$parsedData, model.worldModel);
		if (_v0.$ === 'Just') {
			var _v1 = _v0.a;
			var matchedRuleID = _v1.a;
			var changes = _v1.b.changes;
			return _Utils_Tuple2(
				_Utils_update(
					model,
					{
						debug: A2(
							$jschomay$elm_narrative_engine$NarrativeEngine$Debug$setLastInteractionId,
							trigger,
							A2($jschomay$elm_narrative_engine$NarrativeEngine$Debug$setLastMatchedRuleId, matchedRuleID, model.debug)),
						energy: model.energy - model.energy_Cost_interact,
						ruleCounts: A3(
							$elm$core$Dict$update,
							matchedRuleID,
							A2(
								$elm$core$Basics$composeR,
								$elm$core$Maybe$map(
									$elm$core$Basics$add(1)),
								A2(
									$elm$core$Basics$composeR,
									$elm$core$Maybe$withDefault(1),
									$elm$core$Maybe$Just)),
							model.ruleCounts),
						story: A2(
							$elm$core$Maybe$withDefault,
							'ERROR parsing narrative content for ' + matchedRuleID,
							$elm$core$List$head(
								A2(
									$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$NarrativeParser$parse,
									A3($author$project$Model$makeConfig, trigger, matchedRuleID, model),
									A2(
										$elm$core$Maybe$withDefault,
										'ERROR finding narrative content for ' + matchedRuleID,
										A2($elm$core$Dict$get, matchedRuleID, $author$project$Rules$narrative_content))))),
						worldModel: A3($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$applyChanges, changes, trigger, model.worldModel)
					}),
				$elm$core$Platform$Cmd$none);
		} else {
			return _Utils_Tuple2(
				_Utils_update(
					model,
					{
						debug: A2(
							$jschomay$elm_narrative_engine$NarrativeEngine$Debug$setLastInteractionId,
							trigger,
							A2($jschomay$elm_narrative_engine$NarrativeEngine$Debug$setLastMatchedRuleId, trigger, model.debug)),
						ruleCounts: A3(
							$elm$core$Dict$update,
							trigger,
							A2(
								$elm$core$Basics$composeR,
								$elm$core$Maybe$map(
									$elm$core$Basics$add(1)),
								A2(
									$elm$core$Basics$composeR,
									$elm$core$Maybe$withDefault(1),
									$elm$core$Maybe$Just)),
							model.ruleCounts),
						story: A3(
							$author$project$Model$getDescription,
							A3($author$project$Model$makeConfig, trigger, trigger, model),
							trigger,
							model.worldModel)
					}),
				$elm$core$Platform$Cmd$none);
		}
	});
var $author$project$Model$query = F2(
	function (q, worldModel) {
		return A2(
			$elm$core$Result$withDefault,
			_List_Nil,
			A2(
				$elm$core$Result$map,
				function (parsedMatcher) {
					return A2($jschomay$elm_narrative_engine$NarrativeEngine$Core$WorldModel$query, parsedMatcher, worldModel);
				},
				$jschomay$elm_narrative_engine$NarrativeEngine$Syntax$RuleParser$parseMatcher(q)));
	});
var $author$project$Update$interactByKey = function (model) {
	var trueNPCs = A2(
		$elm$core$List$filter,
		function (a) {
			return a.interacttrue;
		},
		model.npcs);
	var currNPC = A2(
		$elm$core$Maybe$withDefault,
		$author$project$Model$emptyNPC,
		$elm$core$List$head(trueNPCs));
	var currTrigger = A2(
		$elm$core$Maybe$withDefault,
		'no such npc',
		$elm$core$List$head(
			A2(
				$elm$core$List$map,
				$elm$core$Tuple$first,
				A2($author$project$Model$query, currNPC.description, model.worldModel))));
	var model_ = A2($author$project$Update$interactWith__core, currTrigger, model).a;
	return $elm$core$List$isEmpty(trueNPCs) ? model : model_;
};
var $elm$core$Basics$pow = _Basics_pow;
var $author$project$Update$canPickUp = F2(
	function (model, item) {
		var distance = A2($elm$core$Basics$pow, model.hero.x - item.x, 2) + A2($elm$core$Basics$pow, model.hero.y - item.y, 2);
		return (distance > 50) ? false : true;
	});
var $author$project$Update$filter_picked_item = function (item) {
	return item.isPick ? false : true;
};
var $author$project$Update$isEnergyEnoughPickUp = function (model) {
	var energy_Cost = model.energy_Cost_pickup;
	var energy = model.energy;
	return ((energy - energy_Cost) >= 0) ? true : false;
};
var $author$project$Update$itemPickUp = F2(
	function (model, item) {
		return (A2($author$project$Update$canPickUp, model, item) && ($author$project$Update$isEnergyEnoughPickUp(model) && (model.heroPickUp && (!item.isPick)))) ? _Utils_update(
			item,
			{isPick: true}) : item;
	});
var $author$project$Update$pickUp = function (model) {
	var t9 = model.bag.grid9.itemType;
	var t8 = model.bag.grid8.itemType;
	var t7 = model.bag.grid7.itemType;
	var t6 = model.bag.grid6.itemType;
	var t5 = model.bag.grid5.itemType;
	var t4 = model.bag.grid4.itemType;
	var t3 = model.bag.grid3.itemType;
	var t2 = model.bag.grid2.itemType;
	var t10 = model.bag.grid10.itemType;
	var t1 = model.bag.grid1.itemType;
	var isPickUp = model.heroPickUp;
	var g9 = model.bag.grid9;
	var g8 = model.bag.grid8;
	var g7 = model.bag.grid7;
	var g6 = model.bag.grid6;
	var g5 = model.bag.grid5;
	var g4 = model.bag.grid4;
	var g3 = model.bag.grid3;
	var g2 = model.bag.grid2;
	var g10 = model.bag.grid10;
	var g1 = model.bag.grid1;
	var energy = model.energy;
	var energy_ = energy - model.energy_Cost_pickup;
	var carry_out_pick_up = A2(
		$elm$core$List$map,
		$author$project$Update$itemPickUp(model),
		model.items);
	var itemsLeft = A2($elm$core$List$filter, $author$project$Update$filter_picked_item, carry_out_pick_up);
	var abletoPick2 = $author$project$Update$isEnergyEnoughPickUp(model);
	var ableToPick = A2(
		$elm$core$List$filter,
		$author$project$Update$canPickUp(model),
		model.items);
	var isThereAny = $elm$core$List$length(ableToPick);
	var item = A2(
		$elm$core$Maybe$withDefault,
		$author$project$Items$gunIni,
		$elm$core$List$head(ableToPick));
	return (!isPickUp) ? model : (((isThereAny === 1) && (_Utils_eq(t1, $author$project$Items$Empty) && (abletoPick2 && isPickUp))) ? _Utils_update(
		model,
		{
			bag: {grid1: item, grid10: g10, grid2: g2, grid3: g3, grid4: g4, grid5: g5, grid6: g6, grid7: g7, grid8: g8, grid9: g9},
			energy: energy_,
			items: itemsLeft,
			story: 'get it'
		}) : (((isThereAny === 1) && ((!_Utils_eq(t1, $author$project$Items$Empty)) && (_Utils_eq(t2, $author$project$Items$Empty) && (abletoPick2 && isPickUp)))) ? _Utils_update(
		model,
		{
			bag: {grid1: g1, grid10: g10, grid2: item, grid3: g3, grid4: g4, grid5: g5, grid6: g6, grid7: g7, grid8: g8, grid9: g9},
			energy: energy_,
			items: itemsLeft
		}) : (((isThereAny === 1) && ((!_Utils_eq(t1, $author$project$Items$Empty)) && ((!_Utils_eq(t2, $author$project$Items$Empty)) && (_Utils_eq(t3, $author$project$Items$Empty) && (abletoPick2 && isPickUp))))) ? _Utils_update(
		model,
		{
			bag: {grid1: g1, grid10: g10, grid2: g2, grid3: item, grid4: g4, grid5: g5, grid6: g6, grid7: g7, grid8: g8, grid9: g9},
			energy: energy_,
			items: itemsLeft
		}) : (((isThereAny === 1) && ((!_Utils_eq(t1, $author$project$Items$Empty)) && ((!_Utils_eq(t2, $author$project$Items$Empty)) && ((!_Utils_eq(t3, $author$project$Items$Empty)) && (_Utils_eq(t4, $author$project$Items$Empty) && (abletoPick2 && isPickUp)))))) ? _Utils_update(
		model,
		{
			bag: {grid1: g1, grid10: g10, grid2: g2, grid3: g3, grid4: item, grid5: g5, grid6: g6, grid7: g7, grid8: g8, grid9: g9},
			energy: energy_,
			items: itemsLeft
		}) : (((isThereAny === 1) && ((!_Utils_eq(t1, $author$project$Items$Empty)) && ((!_Utils_eq(t2, $author$project$Items$Empty)) && ((!_Utils_eq(t3, $author$project$Items$Empty)) && ((!_Utils_eq(t4, $author$project$Items$Empty)) && (_Utils_eq(t5, $author$project$Items$Empty) && (abletoPick2 && isPickUp))))))) ? _Utils_update(
		model,
		{
			bag: {grid1: g1, grid10: g10, grid2: g2, grid3: g3, grid4: g4, grid5: item, grid6: g6, grid7: g7, grid8: g8, grid9: g9},
			energy: energy_,
			items: itemsLeft
		}) : (((isThereAny === 1) && ((!_Utils_eq(t1, $author$project$Items$Empty)) && ((!_Utils_eq(t2, $author$project$Items$Empty)) && ((!_Utils_eq(t3, $author$project$Items$Empty)) && ((!_Utils_eq(t4, $author$project$Items$Empty)) && ((!_Utils_eq(t5, $author$project$Items$Empty)) && (_Utils_eq(t6, $author$project$Items$Empty) && (abletoPick2 && isPickUp)))))))) ? _Utils_update(
		model,
		{
			bag: {grid1: g1, grid10: g10, grid2: g2, grid3: g3, grid4: g4, grid5: g5, grid6: item, grid7: g7, grid8: g8, grid9: g9},
			energy: energy_,
			items: itemsLeft
		}) : (((isThereAny === 1) && ((!_Utils_eq(t1, $author$project$Items$Empty)) && ((!_Utils_eq(t2, $author$project$Items$Empty)) && ((!_Utils_eq(t3, $author$project$Items$Empty)) && ((!_Utils_eq(t4, $author$project$Items$Empty)) && ((!_Utils_eq(t5, $author$project$Items$Empty)) && ((!_Utils_eq(t6, $author$project$Items$Empty)) && (_Utils_eq(t7, $author$project$Items$Empty) && (abletoPick2 && isPickUp))))))))) ? _Utils_update(
		model,
		{
			bag: {grid1: g1, grid10: g10, grid2: g2, grid3: g3, grid4: g4, grid5: g5, grid6: g6, grid7: item, grid8: g8, grid9: g9},
			energy: energy_,
			items: itemsLeft
		}) : (((isThereAny === 1) && ((!_Utils_eq(t1, $author$project$Items$Empty)) && ((!_Utils_eq(t2, $author$project$Items$Empty)) && ((!_Utils_eq(t3, $author$project$Items$Empty)) && ((!_Utils_eq(t4, $author$project$Items$Empty)) && ((!_Utils_eq(t5, $author$project$Items$Empty)) && ((!_Utils_eq(t6, $author$project$Items$Empty)) && ((!_Utils_eq(t7, $author$project$Items$Empty)) && (_Utils_eq(t8, $author$project$Items$Empty) && (abletoPick2 && isPickUp)))))))))) ? _Utils_update(
		model,
		{
			bag: {grid1: g1, grid10: g10, grid2: g2, grid3: g3, grid4: g4, grid5: g5, grid6: g6, grid7: g7, grid8: item, grid9: g9},
			energy: energy_,
			items: itemsLeft
		}) : (((isThereAny === 1) && ((!_Utils_eq(t1, $author$project$Items$Empty)) && ((!_Utils_eq(t2, $author$project$Items$Empty)) && ((!_Utils_eq(t3, $author$project$Items$Empty)) && ((!_Utils_eq(t4, $author$project$Items$Empty)) && ((!_Utils_eq(t5, $author$project$Items$Empty)) && ((!_Utils_eq(t6, $author$project$Items$Empty)) && ((!_Utils_eq(t7, $author$project$Items$Empty)) && ((!_Utils_eq(t8, $author$project$Items$Empty)) && (_Utils_eq(t9, $author$project$Items$Empty) && (abletoPick2 && isPickUp))))))))))) ? _Utils_update(
		model,
		{
			bag: {grid1: g1, grid10: g10, grid2: g2, grid3: g3, grid4: g4, grid5: g5, grid6: g6, grid7: g7, grid8: g8, grid9: item},
			energy: energy_,
			items: itemsLeft
		}) : (((isThereAny === 1) && ((!_Utils_eq(t1, $author$project$Items$Empty)) && ((!_Utils_eq(t2, $author$project$Items$Empty)) && ((!_Utils_eq(t3, $author$project$Items$Empty)) && ((!_Utils_eq(t4, $author$project$Items$Empty)) && ((!_Utils_eq(t5, $author$project$Items$Empty)) && ((!_Utils_eq(t6, $author$project$Items$Empty)) && ((!_Utils_eq(t7, $author$project$Items$Empty)) && ((!_Utils_eq(t8, $author$project$Items$Empty)) && ((!_Utils_eq(t9, $author$project$Items$Empty)) && (_Utils_eq(t10, $author$project$Items$Empty) && (abletoPick2 && isPickUp)))))))))))) ? _Utils_update(
		model,
		{
			bag: {grid1: g1, grid10: item, grid2: g2, grid3: g3, grid4: g4, grid5: g5, grid6: g6, grid7: g7, grid8: g8, grid9: g9},
			energy: energy_,
			items: itemsLeft
		}) : ((!isThereAny) ? _Utils_update(
		model,
		{story: 'Nothing to pick up！'}) : ((!abletoPick2) ? _Utils_update(
		model,
		{story: 'Energy is not enough!'}) : model))))))))))));
};
var $author$project$Model$encodeState = function (state) {
	switch (state.$) {
		case 'Paused':
			return 'paused';
		case 'Playing':
			return 'playing';
		default:
			return 'stopped';
	}
};
var $elm$json$Json$Encode$int = _Json_wrap;
var $elm$json$Json$Encode$object = function (pairs) {
	return _Json_wrap(
		A3(
			$elm$core$List$foldl,
			F2(
				function (_v0, obj) {
					var k = _v0.a;
					var v = _v0.b;
					return A3(_Json_addField, k, v, obj);
				}),
			_Json_emptyObject(_Utils_Tuple0),
			pairs));
};
var $elm$json$Json$Encode$string = _Json_wrap;
var $author$project$Model$encode = F2(
	function (indent, model) {
		return A2(
			$elm$json$Json$Encode$encode,
			indent,
			$elm$json$Json$Encode$object(
				_List_fromArray(
					[
						_Utils_Tuple2(
						'state',
						$elm$json$Json$Encode$string(
							$author$project$Model$encodeState(model.state))),
						_Utils_Tuple2(
						'positionX',
						$elm$json$Json$Encode$int(model.hero.x)),
						_Utils_Tuple2(
						'positionY',
						$elm$json$Json$Encode$int(model.hero.y))
					])));
	});
var $author$project$Update$save = _Platform_outgoingPort('save', $elm$json$Json$Encode$string);
var $author$project$Update$saveToStorage = function (model) {
	return _Utils_Tuple2(
		model,
		$author$project$Update$save(
			A2($author$project$Model$encode, 2, model)));
};
var $author$project$Update$startMove = function (model) {
	return ((!(!$author$project$Update$directionLR(model))) && (!(!$author$project$Update$directionUD(model)))) ? _Utils_update(
		model,
		{
			heroDir: _Utils_Tuple2(
				$elm$core$Maybe$Just(
					{active: true, elapsed: 0}),
				$elm$core$Maybe$Just(
					{active: true, elapsed: 0}))
		}) : (((!(!$author$project$Update$directionLR(model))) && (!$author$project$Update$directionUD(model))) ? _Utils_update(
		model,
		{
			heroDir: _Utils_Tuple2(
				$elm$core$Maybe$Just(
					{active: true, elapsed: 0}),
				$elm$core$Maybe$Nothing)
		}) : (((!$author$project$Update$directionLR(model)) && (!(!$author$project$Update$directionUD(model)))) ? _Utils_update(
		model,
		{
			heroDir: _Utils_Tuple2(
				$elm$core$Maybe$Nothing,
				$elm$core$Maybe$Just(
					{active: true, elapsed: 0}))
		}) : _Utils_update(
		model,
		{
			heroDir: _Utils_Tuple2($elm$core$Maybe$Nothing, $elm$core$Maybe$Nothing)
		})));
};
var $author$project$Update$teleportHero = F2(
	function (_v0, model) {
		var x = _v0.a;
		var y = _v0.b;
		var hero = model.hero;
		var hero_ = _Utils_update(
			hero,
			{x: x, y: y});
		return _Utils_update(
			model,
			{hero: hero_});
	});
var $jschomay$elm_narrative_engine$NarrativeEngine$Debug$updateSearch = F2(
	function (text, _v0) {
		var state = _v0.a;
		return $jschomay$elm_narrative_engine$NarrativeEngine$Debug$State(
			_Utils_update(
				state,
				{searchText: text}));
	});
var $author$project$Update$update = F2(
	function (msg, model) {
		switch (msg.$) {
			case 'Resize':
				var width = msg.a;
				var height = msg.b;
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{
							size: _Utils_Tuple2(width, height)
						}),
					$elm$core$Platform$Cmd$none);
			case 'GetViewport':
				var viewport = msg.a.viewport;
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{
							size: _Utils_Tuple2(viewport.width, viewport.height)
						}),
					$elm$core$Platform$Cmd$none);
			case 'Start':
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{state: $author$project$Model$Playing}),
					$elm$core$Platform$Cmd$none);
			case 'Pause':
				return $author$project$Update$saveToStorage(
					_Utils_update(
						model,
						{state: $author$project$Model$Paused}));
			case 'Resume':
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{state: $author$project$Model$Playing}),
					$elm$core$Platform$Cmd$none);
			case 'MoveLeft':
				var on = msg.a;
				return _Utils_Tuple2(
					$author$project$Update$startMove(
						_Utils_update(
							model,
							{heroMoveLeft: on})),
					$elm$core$Platform$Cmd$none);
			case 'MoveRight':
				var on = msg.a;
				return _Utils_Tuple2(
					$author$project$Update$startMove(
						_Utils_update(
							model,
							{heroMoveRight: on})),
					$elm$core$Platform$Cmd$none);
			case 'MoveUp':
				var on = msg.a;
				return _Utils_Tuple2(
					$author$project$Update$startMove(
						_Utils_update(
							model,
							{heroMoveUp: on})),
					$elm$core$Platform$Cmd$none);
			case 'MoveDown':
				var on = msg.a;
				return _Utils_Tuple2(
					$author$project$Update$startMove(
						_Utils_update(
							model,
							{heroMoveDown: on})),
					$elm$core$Platform$Cmd$none);
			case 'Tick':
				var time = msg.a;
				return $author$project$Update$saveToStorage(
					A2(
						$author$project$Update$animate,
						A2($elm$core$Basics$min, time, 25),
						model));
			case 'ToPoliceOffice':
				return _Utils_Tuple2(
					A2($author$project$Update$mapSwitch, $author$project$Items$PoliceOffice, model),
					$elm$core$Platform$Cmd$none);
			case 'ToPark':
				return _Utils_Tuple2(
					A2($author$project$Update$mapSwitch, $author$project$Items$Park, model),
					$elm$core$Platform$Cmd$none);
			case 'ToHome':
				return _Utils_Tuple2(
					A2($author$project$Update$mapSwitch, $author$project$Items$Home, model),
					$elm$core$Platform$Cmd$none);
			case 'PickUp':
				var on = msg.a;
				return _Utils_Tuple2(
					$author$project$Update$pickUp(
						_Utils_update(
							model,
							{heroPickUp: on})),
					$elm$core$Platform$Cmd$none);
			case 'ElevateTo1':
				var _v1 = model.map;
				switch (_v1.$) {
					case 'PoliceOffice':
						return _Utils_Tuple2(
							A2(
								$author$project$Update$teleportHero,
								_Utils_Tuple2(695, 520),
								model),
							$elm$core$Platform$Cmd$none);
					case 'Home':
						return _Utils_Tuple2(
							A2(
								$author$project$Update$teleportHero,
								_Utils_Tuple2(795, 520),
								model),
							$elm$core$Platform$Cmd$none);
					default:
						return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
				}
			case 'ElevateTo2':
				var _v2 = model.map;
				switch (_v2.$) {
					case 'PoliceOffice':
						return _Utils_Tuple2(
							A2(
								$author$project$Update$teleportHero,
								_Utils_Tuple2(695, 290),
								model),
							$elm$core$Platform$Cmd$none);
					case 'Home':
						return _Utils_Tuple2(
							A2(
								$author$project$Update$teleportHero,
								_Utils_Tuple2(795, 280),
								model),
							$elm$core$Platform$Cmd$none);
					default:
						return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
				}
			case 'ElevateTo3':
				var _v3 = model.map;
				switch (_v3.$) {
					case 'PoliceOffice':
						return _Utils_Tuple2(
							A2(
								$author$project$Update$teleportHero,
								_Utils_Tuple2(695, 60),
								model),
							$elm$core$Platform$Cmd$none);
					case 'Home':
						return _Utils_Tuple2(
							A2(
								$author$project$Update$teleportHero,
								_Utils_Tuple2(795, 65),
								model),
							$elm$core$Platform$Cmd$none);
					default:
						return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
				}
			case 'EnterVehicle':
				var on = msg.a;
				if (on) {
					return _Utils_Tuple2(
						$author$project$Update$enterElevators(model),
						$elm$core$Platform$Cmd$none);
				} else {
					return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
				}
			case 'Noop':
				return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
			case 'InteractByKey':
				var on = msg.a;
				if (on) {
					var model_ = _Utils_update(
						model,
						{heroInteractWithNpc: true});
					var _v6 = model.interacttrue;
					if (_v6) {
						return _Utils_Tuple2(
							$author$project$Update$interactByKey(model_),
							$elm$core$Platform$Cmd$none);
					} else {
						return _Utils_Tuple2(model_, $elm$core$Platform$Cmd$none);
					}
				} else {
					return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
				}
			case 'InteractWith':
				var trigger = msg.a;
				return A2($author$project$Update$interactWith__core, trigger, model);
			case 'UpdateDebugSearchText':
				var searchText = msg.a;
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{
							debug: A2($jschomay$elm_narrative_engine$NarrativeEngine$Debug$updateSearch, searchText, model.debug)
						}),
					$elm$core$Platform$Cmd$none);
			case 'Adkinscatch':
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{conclusion: 0, correctsolved: model.correctsolved + 1, story: 'I think Adkins\'s alibi is not always valid since he has his own office. He was the boss, so no one would disturb him and he could go out without anyone noticing. I told this to Allen, and he got the monitoring of Adkins\'s firm and found Brennan entered the firm without coming out. Then Adkins admitted that he killed Brennan because he was compared to Brennan from an early age. Everyone knew Brennan but no one heard him. Even Catherine was attracted only to Brennan. This is a tragedy of envy.'}),
					$elm$core$Platform$Cmd$none);
			case 'Catherinecatch':
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{conclusion: 0, story: 'I think Catherine\'s alibi is not always valid. We had her in custody, but we cannot found the key evidence. Catherine was devastated and refused to admit she had killed Brennan. We had to release her in the end, but everyone around him was talking about her...'}),
					$elm$core$Platform$Cmd$none);
			default:
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{conclusion: 0, story: 'I think this is just a robbery, though the message sent to Catherine was very strange. We comforted the two people who had lost important people, and issued an arrest warrant, but nothing came of it...'}),
					$elm$core$Platform$Cmd$none);
		}
	});
var $elm$json$Json$Decode$value = _Json_decodeValue;
var $elm$html$Html$br = _VirtualDom_node('br');
var $elm$html$Html$div = _VirtualDom_node('div');
var $elm$virtual_dom$VirtualDom$text = _VirtualDom_text;
var $elm$html$Html$text = $elm$virtual_dom$VirtualDom$text;
var $elm$core$Debug$toString = _Debug_toString;
var $author$project$View$axisHelper = function (model) {
	return (!_Utils_eq($author$project$Model$gameMode______, $author$project$Model$Game)) ? A2(
		$elm$html$Html$div,
		_List_Nil,
		_List_fromArray(
			[
				$elm$html$Html$text(
				$elm$core$Debug$toString(model.hero.x)),
				A2($elm$html$Html$br, _List_Nil, _List_Nil),
				$elm$html$Html$text(
				$elm$core$Debug$toString(model.hero.y))
			])) : A2($elm$html$Html$div, _List_Nil, _List_Nil);
};
var $elm$core$String$fromFloat = _String_fromNumber;
var $author$project$View$pixelHeight = 700;
var $author$project$View$pixelWidth = 1050;
var $author$project$Message$ToHome = {$: 'ToHome'};
var $author$project$Message$ToPark = {$: 'ToPark'};
var $author$project$Message$ToPoliceOffice = {$: 'ToPoliceOffice'};
var $elm$html$Html$button = _VirtualDom_node('button');
var $elm$virtual_dom$VirtualDom$Normal = function (a) {
	return {$: 'Normal', a: a};
};
var $elm$virtual_dom$VirtualDom$on = _VirtualDom_on;
var $elm$html$Html$Events$on = F2(
	function (event, decoder) {
		return A2(
			$elm$virtual_dom$VirtualDom$on,
			event,
			$elm$virtual_dom$VirtualDom$Normal(decoder));
	});
var $elm$html$Html$Events$onClick = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'click',
		$elm$json$Json$Decode$succeed(msg));
};
var $elm$virtual_dom$VirtualDom$style = _VirtualDom_style;
var $elm$html$Html$Attributes$style = $elm$virtual_dom$VirtualDom$style;
var $author$project$View$renderMapButton = function (model) {
	var _v0 = model.map;
	if (_v0.$ === 'Switching') {
		return A2(
			$elm$html$Html$div,
			_List_Nil,
			_List_fromArray(
				[
					A2(
					$elm$html$Html$button,
					_List_fromArray(
						[
							A2($elm$html$Html$Attributes$style, 'background', 'blue'),
							A2($elm$html$Html$Attributes$style, 'position', 'absolute'),
							A2($elm$html$Html$Attributes$style, 'left', '100px'),
							A2($elm$html$Html$Attributes$style, 'top', '400px'),
							A2($elm$html$Html$Attributes$style, 'color', '#f3f2e9'),
							A2($elm$html$Html$Attributes$style, 'cursor', 'pointer'),
							A2($elm$html$Html$Attributes$style, 'display', 'block'),
							A2($elm$html$Html$Attributes$style, 'font-family', 'Helvetica, Arial, sans-serif'),
							A2($elm$html$Html$Attributes$style, 'font-size', '18px'),
							A2($elm$html$Html$Attributes$style, 'font-weight', '300'),
							A2($elm$html$Html$Attributes$style, 'height', '80px'),
							A2($elm$html$Html$Attributes$style, 'line-height', '60px'),
							A2($elm$html$Html$Attributes$style, 'outline', 'none'),
							A2($elm$html$Html$Attributes$style, 'padding', '0'),
							A2($elm$html$Html$Attributes$style, 'width', '130px'),
							A2($elm$html$Html$Attributes$style, 'border-style', 'inset'),
							A2($elm$html$Html$Attributes$style, 'border-color', 'white'),
							A2($elm$html$Html$Attributes$style, 'border-width', '6px'),
							A2($elm$html$Html$Attributes$style, 'border-radius', '20%'),
							$elm$html$Html$Events$onClick($author$project$Message$ToPoliceOffice)
						]),
					_List_fromArray(
						[
							$elm$html$Html$text('Police Office')
						])),
					A2(
					$elm$html$Html$button,
					_List_fromArray(
						[
							A2($elm$html$Html$Attributes$style, 'background', 'red'),
							A2($elm$html$Html$Attributes$style, 'position', 'absolute'),
							A2($elm$html$Html$Attributes$style, 'left', '300px'),
							A2($elm$html$Html$Attributes$style, 'top', '400px'),
							A2($elm$html$Html$Attributes$style, 'color', '#f3f2e9'),
							A2($elm$html$Html$Attributes$style, 'cursor', 'pointer'),
							A2($elm$html$Html$Attributes$style, 'display', 'block'),
							A2($elm$html$Html$Attributes$style, 'font-family', 'Helvetica, Arial, sans-serif'),
							A2($elm$html$Html$Attributes$style, 'font-size', '18px'),
							A2($elm$html$Html$Attributes$style, 'font-weight', '300'),
							A2($elm$html$Html$Attributes$style, 'height', '80px'),
							A2($elm$html$Html$Attributes$style, 'line-height', '60px'),
							A2($elm$html$Html$Attributes$style, 'outline', 'none'),
							A2($elm$html$Html$Attributes$style, 'padding', '0'),
							A2($elm$html$Html$Attributes$style, 'width', '130px'),
							A2($elm$html$Html$Attributes$style, 'border-style', 'inset'),
							A2($elm$html$Html$Attributes$style, 'border-color', 'white'),
							A2($elm$html$Html$Attributes$style, 'border-width', '6px'),
							A2($elm$html$Html$Attributes$style, 'border-radius', '20%'),
							$elm$html$Html$Events$onClick($author$project$Message$ToPark)
						]),
					_List_fromArray(
						[
							$elm$html$Html$text('Park')
						])),
					A2(
					$elm$html$Html$button,
					_List_fromArray(
						[
							A2($elm$html$Html$Attributes$style, 'background', 'red'),
							A2($elm$html$Html$Attributes$style, 'position', 'absolute'),
							A2($elm$html$Html$Attributes$style, 'left', '500px'),
							A2($elm$html$Html$Attributes$style, 'top', '400px'),
							A2($elm$html$Html$Attributes$style, 'color', '#f3f2e9'),
							A2($elm$html$Html$Attributes$style, 'cursor', 'pointer'),
							A2($elm$html$Html$Attributes$style, 'display', 'block'),
							A2($elm$html$Html$Attributes$style, 'font-family', 'Helvetica, Arial, sans-serif'),
							A2($elm$html$Html$Attributes$style, 'font-size', '18px'),
							A2($elm$html$Html$Attributes$style, 'font-weight', '300'),
							A2($elm$html$Html$Attributes$style, 'height', '80px'),
							A2($elm$html$Html$Attributes$style, 'line-height', '60px'),
							A2($elm$html$Html$Attributes$style, 'outline', 'none'),
							A2($elm$html$Html$Attributes$style, 'padding', '0'),
							A2($elm$html$Html$Attributes$style, 'width', '130px'),
							A2($elm$html$Html$Attributes$style, 'border-style', 'inset'),
							A2($elm$html$Html$Attributes$style, 'border-color', 'white'),
							A2($elm$html$Html$Attributes$style, 'border-width', '6px'),
							A2($elm$html$Html$Attributes$style, 'border-radius', '20%'),
							$elm$html$Html$Events$onClick($author$project$Message$ToHome)
						]),
					_List_fromArray(
						[
							$elm$html$Html$text('Home')
						]))
				]));
	} else {
		return A2($elm$html$Html$div, _List_Nil, _List_Nil);
	}
};
var $elm$html$Html$audio = _VirtualDom_node('audio');
var $elm$json$Json$Encode$bool = _Json_wrap;
var $elm$html$Html$Attributes$boolProperty = F2(
	function (key, bool) {
		return A2(
			_VirtualDom_property,
			key,
			$elm$json$Json$Encode$bool(bool));
	});
var $elm$html$Html$Attributes$autoplay = $elm$html$Html$Attributes$boolProperty('autoplay');
var $elm$html$Html$Attributes$stringProperty = F2(
	function (key, string) {
		return A2(
			_VirtualDom_property,
			key,
			$elm$json$Json$Encode$string(string));
	});
var $elm$html$Html$Attributes$id = $elm$html$Html$Attributes$stringProperty('id');
var $elm$html$Html$iframe = _VirtualDom_node('iframe');
var $elm$html$Html$Attributes$loop = $elm$html$Html$Attributes$boolProperty('loop');
var $elm$html$Html$Attributes$src = function (url) {
	return A2(
		$elm$html$Html$Attributes$stringProperty,
		'src',
		_VirtualDom_noJavaScriptOrHtmlUri(url));
};
var $elm$html$Html$Attributes$type_ = $elm$html$Html$Attributes$stringProperty('type');
var $author$project$View$renderMusic = A2(
	$elm$html$Html$div,
	_List_Nil,
	_List_fromArray(
		[
			A2(
			$elm$html$Html$div,
			_List_Nil,
			_List_fromArray(
				[
					A2(
					$elm$html$Html$iframe,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$src('./trigger.mp3'),
							$elm$html$Html$Attributes$autoplay(true),
							A2($elm$html$Html$Attributes$style, 'display', 'none')
						]),
					_List_Nil)
				])),
			A2(
			$elm$html$Html$div,
			_List_Nil,
			_List_fromArray(
				[
					A2(
					$elm$html$Html$audio,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$id('player'),
							$elm$html$Html$Attributes$autoplay(true),
							$elm$html$Html$Attributes$loop(true),
							$elm$html$Html$Attributes$src('./bgm.mp3'),
							$elm$html$Html$Attributes$type_('audio/mp3')
						]),
					_List_Nil)
				]))
		]));
var $author$project$Message$ElevateTo1 = {$: 'ElevateTo1'};
var $author$project$Message$ElevateTo2 = {$: 'ElevateTo2'};
var $author$project$Message$ElevateTo3 = {$: 'ElevateTo3'};
var $elm$svg$Svg$Attributes$fill = _VirtualDom_attribute('fill');
var $elm$svg$Svg$Attributes$fontSize = _VirtualDom_attribute('font-size');
var $elm$svg$Svg$Attributes$height = _VirtualDom_attribute('height');
var $elm$svg$Svg$trustedNode = _VirtualDom_nodeNS('http://www.w3.org/2000/svg');
var $elm$svg$Svg$rect = $elm$svg$Svg$trustedNode('rect');
var $elm$svg$Svg$Attributes$stroke = _VirtualDom_attribute('stroke');
var $elm$svg$Svg$Attributes$strokeWidth = _VirtualDom_attribute('stroke-width');
var $elm$svg$Svg$text = $elm$virtual_dom$VirtualDom$text;
var $elm$svg$Svg$text_ = $elm$svg$Svg$trustedNode('text');
var $elm$svg$Svg$Attributes$width = _VirtualDom_attribute('width');
var $elm$svg$Svg$Attributes$x = _VirtualDom_attribute('x');
var $elm$svg$Svg$Attributes$y = _VirtualDom_attribute('y');
var $author$project$Tosvg$elevatorQuestToSvg = function (model) {
	var _v0 = model.quests;
	if (_v0.$ === 'ElevatorQuest') {
		return _List_fromArray(
			[
				A2(
				$elm$svg$Svg$rect,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$x('405'),
						$elm$svg$Svg$Attributes$y('140'),
						$elm$svg$Svg$Attributes$width('100'),
						$elm$svg$Svg$Attributes$height('280'),
						$elm$svg$Svg$Attributes$strokeWidth('0px'),
						$elm$svg$Svg$Attributes$stroke('black'),
						$elm$svg$Svg$Attributes$fill('grey')
					]),
				_List_Nil),
				A2(
				$elm$svg$Svg$rect,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$x('415'),
						$elm$svg$Svg$Attributes$y('150'),
						$elm$svg$Svg$Attributes$width('80'),
						$elm$svg$Svg$Attributes$height('80'),
						$elm$svg$Svg$Attributes$strokeWidth('5px'),
						$elm$svg$Svg$Attributes$stroke('black'),
						$elm$svg$Svg$Attributes$fill('white'),
						$elm$html$Html$Events$onClick($author$project$Message$ElevateTo1)
					]),
				_List_Nil),
				A2(
				$elm$svg$Svg$rect,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$x('415'),
						$elm$svg$Svg$Attributes$y('240'),
						$elm$svg$Svg$Attributes$width('80'),
						$elm$svg$Svg$Attributes$height('80'),
						$elm$svg$Svg$Attributes$strokeWidth('5px'),
						$elm$svg$Svg$Attributes$stroke('black'),
						$elm$svg$Svg$Attributes$fill('white'),
						$elm$html$Html$Events$onClick($author$project$Message$ElevateTo2)
					]),
				_List_Nil),
				A2(
				$elm$svg$Svg$rect,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$x('415'),
						$elm$svg$Svg$Attributes$y('330'),
						$elm$svg$Svg$Attributes$width('80'),
						$elm$svg$Svg$Attributes$height('80'),
						$elm$svg$Svg$Attributes$strokeWidth('5px'),
						$elm$svg$Svg$Attributes$stroke('black'),
						$elm$svg$Svg$Attributes$fill('white'),
						$elm$html$Html$Events$onClick($author$project$Message$ElevateTo3)
					]),
				_List_Nil),
				A2(
				$elm$svg$Svg$text_,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$x('445'),
						$elm$svg$Svg$Attributes$y('200'),
						$elm$svg$Svg$Attributes$fill('black'),
						$elm$svg$Svg$Attributes$fontSize('40px')
					]),
				_List_fromArray(
					[
						$elm$svg$Svg$text('1')
					])),
				A2(
				$elm$svg$Svg$text_,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$x('445'),
						$elm$svg$Svg$Attributes$y('290'),
						$elm$svg$Svg$Attributes$fill('black'),
						$elm$svg$Svg$Attributes$fontSize('40px')
					]),
				_List_fromArray(
					[
						$elm$svg$Svg$text('2')
					])),
				A2(
				$elm$svg$Svg$text_,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$x('445'),
						$elm$svg$Svg$Attributes$y('380'),
						$elm$svg$Svg$Attributes$fill('black'),
						$elm$svg$Svg$Attributes$fontSize('40px')
					]),
				_List_fromArray(
					[
						$elm$svg$Svg$text('3')
					]))
			]);
	} else {
		return _List_fromArray(
			[
				A2($elm$svg$Svg$rect, _List_Nil, _List_Nil)
			]);
	}
};
var $elm$svg$Svg$Attributes$fontFamily = _VirtualDom_attribute('font-family');
var $elm$core$String$toFloat = _String_toFloat;
var $author$project$Tosvg$intToFloat = function (a) {
	var c = $elm$core$Debug$toString(a);
	var o = $elm$core$String$toFloat(c);
	return A2($elm$core$Maybe$withDefault, 0, o);
};
var $author$project$Color$Color = function (a) {
	return {$: 'Color', a: a};
};
var $author$project$Color$rgb = F3(
	function (red, green, blue) {
		return $author$project$Color$Color(
			{blue: blue, green: green, red: red});
	});
var $elm$svg$Svg$Attributes$textDecoration = _VirtualDom_attribute('text-decoration');
var $author$project$Color$toString = function (_v0) {
	var red = _v0.a.red;
	var green = _v0.a.green;
	var blue = _v0.a.blue;
	return 'rgb(' + ($elm$core$String$fromInt(red) + (',' + ($elm$core$String$fromInt(green) + (',' + ($elm$core$String$fromInt(blue) + ')')))));
};
var $author$project$Tosvg$energytosvg = F2(
	function (energy, energyFull) {
		var wid = 10;
		var lenTotal = 100;
		var len = lenTotal * ($author$project$Tosvg$intToFloat(energy) / $author$project$Tosvg$intToFloat(energyFull));
		var _v0 = _Utils_Tuple2(70, 585);
		var x_ = _v0.a;
		var y_ = _v0.b;
		return _List_fromArray(
			[
				A2(
				$elm$svg$Svg$rect,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$x(
						$elm$core$Debug$toString(x_)),
						$elm$svg$Svg$Attributes$y(
						$elm$core$Debug$toString(y_)),
						$elm$svg$Svg$Attributes$height(
						$elm$core$Debug$toString(wid)),
						$elm$svg$Svg$Attributes$width(
						$elm$core$Debug$toString(lenTotal)),
						$elm$svg$Svg$Attributes$fill(
						$author$project$Color$toString(
							A3($author$project$Color$rgb, 10, 10, 10))),
						$elm$svg$Svg$Attributes$stroke(
						$author$project$Color$toString(
							A3($author$project$Color$rgb, 14, 13, 13))),
						$elm$svg$Svg$Attributes$strokeWidth('5px')
					]),
				_List_Nil),
				A2(
				$elm$svg$Svg$rect,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$x(
						$elm$core$Debug$toString(x_)),
						$elm$svg$Svg$Attributes$y(
						$elm$core$Debug$toString(y_)),
						$elm$svg$Svg$Attributes$height(
						$elm$core$Debug$toString(wid)),
						$elm$svg$Svg$Attributes$width(
						$elm$core$Debug$toString(len)),
						$elm$svg$Svg$Attributes$fill(
						$author$project$Color$toString(
							A3($author$project$Color$rgb, 255, 255, 187)))
					]),
				_List_Nil),
				A2(
				$elm$svg$Svg$text_,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$x(
						$elm$core$Debug$toString(x_ - 72)),
						$elm$svg$Svg$Attributes$y(
						$elm$core$Debug$toString(y_ + 10)),
						$elm$svg$Svg$Attributes$fill('#999C86'),
						$elm$svg$Svg$Attributes$fontSize('15'),
						$elm$svg$Svg$Attributes$fontFamily('Segoe UI Black'),
						$elm$svg$Svg$Attributes$textDecoration('underline')
					]),
				_List_fromArray(
					[
						$elm$svg$Svg$text('Energy')
					])),
				A2(
				$elm$svg$Svg$text_,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$x(
						$elm$core$Debug$toString(x_ - 20)),
						$elm$svg$Svg$Attributes$y(
						$elm$core$Debug$toString(y_ + 10)),
						$elm$svg$Svg$Attributes$textDecoration('underline'),
						$elm$svg$Svg$Attributes$fill('#999C86'),
						$elm$svg$Svg$Attributes$fontSize('15'),
						$elm$svg$Svg$Attributes$fontFamily('Segoe UI Black')
					]),
				_List_fromArray(
					[
						$elm$svg$Svg$text(
						$elm$core$Debug$toString(energy))
					]))
			]);
	});
var $author$project$Tosvg$entityView = function (npc) {
	var _v0 = _Utils_Tuple2(npc.area.x, npc.area.y);
	var x_ = _v0.a;
	var y_ = _v0.b;
	var _v1 = _Utils_Tuple2(npc.area.wid, npc.area.hei);
	var wid = _v1.a;
	var hei = _v1.b;
	return A2(
		$elm$svg$Svg$rect,
		_List_fromArray(
			[
				$elm$svg$Svg$Attributes$x(
				$elm$core$Debug$toString(x_)),
				$elm$svg$Svg$Attributes$y(
				$elm$core$Debug$toString(y_)),
				$elm$svg$Svg$Attributes$width(
				$elm$core$Debug$toString(wid)),
				$elm$svg$Svg$Attributes$height(
				$elm$core$Debug$toString(hei)),
				$elm$svg$Svg$Attributes$strokeWidth('5px'),
				$elm$svg$Svg$Attributes$stroke('#191970')
			]),
		_List_Nil);
};
var $author$project$Tosvg$heroToSvg = function (hero) {
	var _v0 = _Utils_Tuple2(hero.x, hero.y);
	var x_ = _v0.a;
	var y_ = _v0.b;
	var _v1 = _Utils_Tuple2(hero.width, hero.height);
	var wid = _v1.a;
	var hei = _v1.b;
	return _List_fromArray(
		[
			A2(
			$elm$svg$Svg$rect,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$x(
					$elm$core$Debug$toString(x_)),
					$elm$svg$Svg$Attributes$y(
					$elm$core$Debug$toString(y_)),
					$elm$svg$Svg$Attributes$width(
					$elm$core$Debug$toString(wid)),
					$elm$svg$Svg$Attributes$height(
					$elm$core$Debug$toString(hei)),
					$elm$svg$Svg$Attributes$strokeWidth('0px'),
					$elm$svg$Svg$Attributes$fill('black')
				]),
			_List_Nil)
		]);
};
var $elm$svg$Svg$image = $elm$svg$Svg$trustedNode('image');
var $author$project$Tosvg$formSvg = function (item) {
	return A2(
		$elm$svg$Svg$rect,
		_List_fromArray(
			[
				$elm$svg$Svg$Attributes$x(
				$elm$core$Debug$toString(item.x)),
				$elm$svg$Svg$Attributes$y(
				$elm$core$Debug$toString(item.y)),
				$elm$svg$Svg$Attributes$width('100'),
				$elm$svg$Svg$Attributes$height('20'),
				$elm$svg$Svg$Attributes$stroke(
				$author$project$Color$toString(
					A3($author$project$Color$rgb, 226, 0, 0))),
				$elm$svg$Svg$Attributes$fill(
				$author$project$Color$toString(
					A3($author$project$Color$rgb, 248, 0, 0)))
			]),
		_List_Nil);
};
var $author$project$Model$isItemAtMap = F2(
	function (model, item) {
		return _Utils_eq(model.map, item.scene) ? true : false;
	});
var $author$project$Items$isNotPick = function (item) {
	return item.isPick ? false : true;
};
var $author$project$Tosvg$itemsToSvg = function (model) {
	var itemsLeft = A2($elm$core$List$filter, $author$project$Items$isNotPick, model.items);
	var itemsExact = A2(
		$elm$core$List$filter,
		$author$project$Model$isItemAtMap(model),
		itemsLeft);
	return A2(
		$elm$core$List$map,
		function (a) {
			return $author$project$Tosvg$formSvg(a);
		},
		itemsExact);
};
var $elm$html$Html$Attributes$class = $elm$html$Html$Attributes$stringProperty('className');
var $author$project$Message$InteractWith = function (a) {
	return {$: 'InteractWith', a: a};
};
var $elm$html$Html$li = _VirtualDom_node('li');
var $author$project$Tosvg$entityViewchoices = function (_v0) {
	var id = _v0.a;
	var name = _v0.b.name;
	return A2(
		$elm$html$Html$li,
		_List_fromArray(
			[
				$elm$html$Html$Events$onClick(
				$author$project$Message$InteractWith(id)),
				A2($elm$html$Html$Attributes$style, 'cursor', 'pointer')
			]),
		_List_fromArray(
			[
				$elm$svg$Svg$text(name)
			]));
};
var $elm$svg$Svg$foreignObject = $elm$svg$Svg$trustedNode('foreignObject');
var $elm$html$Html$p = _VirtualDom_node('p');
var $elm$html$Html$ul = _VirtualDom_node('ul');
var $author$project$View$renderchoice = function (model) {
	var opacity = function () {
		var _v0 = A2($author$project$Model$query, '*.choices=1', model.worldModel);
		if (!_v0.b) {
			return '0';
		} else {
			return '1';
		}
	}();
	return A2(
		$elm$svg$Svg$foreignObject,
		_List_fromArray(
			[
				$elm$svg$Svg$Attributes$x('200'),
				$elm$svg$Svg$Attributes$y('200'),
				$elm$svg$Svg$Attributes$width('500'),
				$elm$svg$Svg$Attributes$height('100%'),
				A2($elm$html$Html$Attributes$style, 'opacity', opacity)
			]),
		_List_fromArray(
			[
				A2(
				$elm$html$Html$p,
				_List_fromArray(
					[
						A2($elm$html$Html$Attributes$style, 'flex', '1 1 auto'),
						A2($elm$html$Html$Attributes$style, 'font-size', '1.5em'),
						A2($elm$html$Html$Attributes$style, 'padding', '0 1em'),
						$elm$html$Html$Attributes$class('inset')
					]),
				_List_fromArray(
					[
						A2(
						$elm$html$Html$ul,
						_List_Nil,
						A2(
							$elm$core$List$map,
							$author$project$Tosvg$entityViewchoices,
							A2($author$project$Model$query, '*.choices=1', model.worldModel)))
					]))
			]));
};
var $author$project$View$renderdialog = function (model) {
	return A2(
		$elm$svg$Svg$foreignObject,
		_List_fromArray(
			[
				$elm$svg$Svg$Attributes$x('200'),
				$elm$svg$Svg$Attributes$y('600'),
				$elm$svg$Svg$Attributes$width('1000'),
				$elm$svg$Svg$Attributes$height('150')
			]),
		_List_fromArray(
			[
				A2(
				$elm$html$Html$p,
				_List_fromArray(
					[
						A2($elm$html$Html$Attributes$style, 'flex', '1 1 auto'),
						A2($elm$html$Html$Attributes$style, 'font-size', '1.5em'),
						A2($elm$html$Html$Attributes$style, 'padding', '0 1em'),
						$elm$html$Html$Attributes$class('inset')
					]),
				_List_fromArray(
					[
						$elm$html$Html$text(model.story)
					]))
			]));
};
var $elm$svg$Svg$Attributes$xlinkHref = function (value) {
	return A3(
		_VirtualDom_attributeNS,
		'http://www.w3.org/1999/xlink',
		'xlink:href',
		_VirtualDom_noJavaScriptUri(value));
};
var $author$project$View$renderportrait = function (model) {
	var portr = function () {
		var _v0 = model.portrait;
		if (_v0 === '') {
			return A2(
				$elm$svg$Svg$image,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$xlinkHref('./player.png'),
						$elm$svg$Svg$Attributes$x('10'),
						$elm$svg$Svg$Attributes$y('610'),
						$elm$svg$Svg$Attributes$width('140'),
						$elm$svg$Svg$Attributes$height('140')
					]),
				_List_Nil);
		} else {
			return A2(
				$elm$svg$Svg$image,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$xlinkHref('./' + (model.portrait + '.png')),
						$elm$svg$Svg$Attributes$x('10'),
						$elm$svg$Svg$Attributes$y('610'),
						$elm$svg$Svg$Attributes$width('140'),
						$elm$svg$Svg$Attributes$height('140')
					]),
				_List_Nil);
		}
	}();
	return portr;
};
var $elm$svg$Svg$svg = $elm$svg$Svg$trustedNode('svg');
var $author$project$Tosvg$areaToSvg = F2(
	function (area, color) {
		var color_ = $author$project$Color$toString(color);
		var _v0 = _Utils_Tuple2(area.x, area.y);
		var x_ = _v0.a;
		var y_ = _v0.b;
		var _v1 = _Utils_Tuple2(area.wid, area.hei);
		var wid = _v1.a;
		var hei = _v1.b;
		return _List_fromArray(
			[
				A2(
				$elm$svg$Svg$rect,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$x(
						$elm$core$Debug$toString(x_)),
						$elm$svg$Svg$Attributes$y(
						$elm$core$Debug$toString(y_)),
						$elm$svg$Svg$Attributes$width(
						$elm$core$Debug$toString(wid)),
						$elm$svg$Svg$Attributes$height(
						$elm$core$Debug$toString(hei)),
						$elm$svg$Svg$Attributes$strokeWidth('0px'),
						$elm$svg$Svg$Attributes$fill(color_)
					]),
				_List_Nil)
			]);
	});
var $author$project$Color$colorBarrier = A3($author$project$Color$rgb, 10, 10, 130);
var $author$project$Tosvg$barrierToSvg = function (area) {
	return A2($author$project$Tosvg$areaToSvg, area, $author$project$Color$colorBarrier);
};
var $author$project$Color$colorElevator = A3($author$project$Color$rgb, 10, 130, 10);
var $author$project$Tosvg$elevatorToSvg = function (area) {
	return A2($author$project$Tosvg$areaToSvg, area, $author$project$Color$colorElevator);
};
var $author$project$Color$colorExit = A3($author$project$Color$rgb, 130, 10, 10);
var $author$project$Tosvg$exitToSvg = function (area) {
	return A2($author$project$Tosvg$areaToSvg, area, $author$project$Color$colorExit);
};
var $author$project$Tosvg$testToSvg = function (model) {
	var mapAttr = model.mapAttr;
	var exitSvgList = $author$project$Tosvg$exitToSvg(mapAttr.exit);
	var elevatorAreas = A2(
		$elm$core$List$map,
		function (a) {
			return a.area;
		},
		mapAttr.elevator);
	var elevatorSvgListList = A2($elm$core$List$map, $author$project$Tosvg$elevatorToSvg, elevatorAreas);
	var elevatorSvgList = A3($elm$core$List$foldl, $elm$core$Basics$append, _List_Nil, elevatorSvgListList);
	var barrierSvgListList = A2($elm$core$List$map, $author$project$Tosvg$barrierToSvg, mapAttr.barrier);
	var barrierSvgList = A3($elm$core$List$foldl, $elm$core$Basics$append, _List_Nil, barrierSvgListList);
	var _v0 = $author$project$Model$gameMode______;
	if (_v0.$ === 'Test') {
		return _Utils_ap(
			elevatorSvgList,
			_Utils_ap(exitSvgList, barrierSvgList));
	} else {
		return _List_fromArray(
			[
				A2($elm$svg$Svg$rect, _List_Nil, _List_Nil)
			]);
	}
};
var $elm$svg$Svg$Attributes$transform = _VirtualDom_attribute('transform');
var $elm$svg$Svg$Attributes$viewBox = _VirtualDom_attribute('viewBox');
var $author$project$View$renderPic = function (model) {
	return A2(
		$elm$svg$Svg$svg,
		_List_fromArray(
			[
				$elm$svg$Svg$Attributes$width('1050'),
				$elm$svg$Svg$Attributes$height('700'),
				$elm$svg$Svg$Attributes$viewBox('0 0 1200 800')
			]),
		_Utils_ap(
			function () {
				var _v0 = model.map;
				switch (_v0.$) {
					case 'PoliceOffice':
						return _Utils_ap(
							_List_fromArray(
								[
									A2(
									$elm$svg$Svg$image,
									_List_fromArray(
										[
											$elm$svg$Svg$Attributes$xlinkHref('./police_office.png'),
											$elm$svg$Svg$Attributes$x('0'),
											$elm$svg$Svg$Attributes$y('0'),
											$elm$svg$Svg$Attributes$width('900'),
											$elm$svg$Svg$Attributes$height('630'),
											$elm$svg$Svg$Attributes$transform('translate(0,-20)')
										]),
									_List_Nil)
								]),
							_Utils_ap(
								_List_fromArray(
									[
										$author$project$Tosvg$entityView($author$project$Model$cBob)
									]),
								_Utils_ap(
									_List_fromArray(
										[
											$author$project$Tosvg$entityView($author$project$Model$cLee)
										]),
									_Utils_ap(
										_List_fromArray(
											[
												$author$project$Tosvg$entityView($author$project$Model$cAllen)
											]),
										_Utils_ap(
											$author$project$Tosvg$heroToSvg(model.hero),
											_Utils_ap(
												_List_fromArray(
													[
														$author$project$View$renderdialog(model)
													]),
												_Utils_ap(
													_List_fromArray(
														[
															$author$project$View$renderchoice(model)
														]),
													_Utils_ap(
														$author$project$Tosvg$elevatorQuestToSvg(model),
														_List_fromArray(
															[
																$author$project$View$renderportrait(model)
															])))))))));
					case 'Park':
						return _Utils_ap(
							_List_fromArray(
								[
									A2(
									$elm$svg$Svg$image,
									_List_fromArray(
										[
											$elm$svg$Svg$Attributes$xlinkHref('./park.png'),
											$elm$svg$Svg$Attributes$x('0'),
											$elm$svg$Svg$Attributes$y('0'),
											$elm$svg$Svg$Attributes$width('900'),
											$elm$svg$Svg$Attributes$height('630'),
											$elm$svg$Svg$Attributes$transform('translate(0,-20)')
										]),
									_List_Nil)
								]),
							_Utils_ap(
								$author$project$Tosvg$heroToSvg(model.hero),
								_Utils_ap(
									_List_fromArray(
										[
											$author$project$Tosvg$entityView($author$project$Model$pLee)
										]),
									_Utils_ap(
										_List_fromArray(
											[
												$author$project$Tosvg$entityView($author$project$Model$pAllen)
											]),
										_Utils_ap(
											_List_fromArray(
												[
													$author$project$Tosvg$entityView($author$project$Model$pAdkins)
												]),
											_Utils_ap(
												_List_fromArray(
													[
														$author$project$Tosvg$entityView($author$project$Model$pCatherine)
													]),
												_Utils_ap(
													_List_fromArray(
														[
															$author$project$View$renderdialog(model)
														]),
													_Utils_ap(
														_List_fromArray(
															[
																$author$project$View$renderchoice(model)
															]),
														_List_fromArray(
															[
																$author$project$View$renderportrait(model)
															])))))))));
					case 'Switching':
						return _List_fromArray(
							[
								A2(
								$elm$svg$Svg$rect,
								_List_fromArray(
									[
										$elm$svg$Svg$Attributes$x('0'),
										$elm$svg$Svg$Attributes$y('0'),
										$elm$svg$Svg$Attributes$width('900'),
										$elm$svg$Svg$Attributes$height('600'),
										$elm$svg$Svg$Attributes$fill('black')
									]),
								_List_Nil)
							]);
					default:
						return _Utils_ap(
							_List_fromArray(
								[
									A2(
									$elm$svg$Svg$image,
									_List_fromArray(
										[
											$elm$svg$Svg$Attributes$xlinkHref('./Kay\'s_home.png'),
											$elm$svg$Svg$Attributes$x('0'),
											$elm$svg$Svg$Attributes$y('0'),
											$elm$svg$Svg$Attributes$width('900'),
											$elm$svg$Svg$Attributes$height('630'),
											$elm$svg$Svg$Attributes$transform('translate(0,-20)')
										]),
									_List_Nil)
								]),
							_Utils_ap(
								_List_fromArray(
									[
										$author$project$View$renderdialog(model)
									]),
								_Utils_ap(
									_List_fromArray(
										[
											$author$project$View$renderchoice(model)
										]),
									_Utils_ap(
										$author$project$Tosvg$elevatorQuestToSvg(model),
										_Utils_ap(
											$author$project$Tosvg$heroToSvg(model.hero),
											_List_fromArray(
												[
													$author$project$View$renderportrait(model)
												]))))));
				}
			}(),
			_Utils_ap(
				A2($author$project$Tosvg$energytosvg, model.energy, model.energy_Full),
				_Utils_ap(
					$author$project$Tosvg$testToSvg(model),
					$author$project$Tosvg$itemsToSvg(model)))));
};
var $author$project$Message$Adkinscatch = {$: 'Adkinscatch'};
var $author$project$Message$Catherinecatch = {$: 'Catherinecatch'};
var $author$project$Message$Robbery = {$: 'Robbery'};
var $elm$html$Html$Attributes$for = $elm$html$Html$Attributes$stringProperty('htmlFor');
var $elm$html$Html$i = _VirtualDom_node('i');
var $elm$html$Html$input = _VirtualDom_node('input');
var $elm$html$Html$label = _VirtualDom_node('label');
var $author$project$View$rendersuspectlist = function (model) {
	var suspect = function () {
		var _v0 = model.map;
		if (_v0.$ === 'Park') {
			return _List_fromArray(
				[
					A2(
					$elm$html$Html$button,
					_List_fromArray(
						[
							$elm$html$Html$Events$onClick($author$project$Message$Catherinecatch),
							A2(
							$elm$html$Html$Attributes$style,
							'opacity',
							$elm$core$Debug$toString(model.conclusion))
						]),
					_List_fromArray(
						[
							$elm$html$Html$text('Catherine')
						])),
					A2(
					$elm$html$Html$button,
					_List_fromArray(
						[
							$elm$html$Html$Events$onClick($author$project$Message$Adkinscatch),
							A2(
							$elm$html$Html$Attributes$style,
							'opacity',
							$elm$core$Debug$toString(model.conclusion))
						]),
					_List_fromArray(
						[
							$elm$html$Html$text('Adkins')
						])),
					A2(
					$elm$html$Html$button,
					_List_fromArray(
						[
							$elm$html$Html$Events$onClick($author$project$Message$Robbery),
							A2(
							$elm$html$Html$Attributes$style,
							'opacity',
							$elm$core$Debug$toString(model.conclusion))
						]),
					_List_fromArray(
						[
							$elm$html$Html$text('This is a robbery.')
						]))
				]);
		} else {
			return _List_Nil;
		}
	}();
	return _List_fromArray(
		[
			A2(
			$elm$html$Html$input,
			_List_fromArray(
				[
					$elm$html$Html$Attributes$type_('checkbox'),
					$elm$html$Html$Attributes$id('menu-toggle')
				]),
			_List_Nil),
			A2(
			$elm$html$Html$label,
			_List_fromArray(
				[
					$elm$html$Html$Attributes$for('menu-toggle'),
					$elm$html$Html$Attributes$class('menu-icon')
				]),
			_List_fromArray(
				[
					A2(
					$elm$html$Html$i,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$class('fa fa-bars')
						]),
					_List_Nil)
				])),
			A2(
			$elm$html$Html$div,
			_List_fromArray(
				[
					$elm$html$Html$Attributes$class('slideout-sidebar')
				]),
			suspect)
		]);
};
var $author$project$View$view = function (model) {
	var _v0 = model.size;
	var w = _v0.a;
	var h = _v0.b;
	var r = (_Utils_cmp(w / h, $author$project$View$pixelWidth / $author$project$View$pixelHeight) > 0) ? A2($elm$core$Basics$min, 1, h / $author$project$View$pixelHeight) : A2($elm$core$Basics$min, 1, w / $author$project$View$pixelWidth);
	return A2(
		$elm$html$Html$div,
		_List_fromArray(
			[
				A2($elm$html$Html$Attributes$style, 'width', '100%'),
				A2($elm$html$Html$Attributes$style, 'height', '100%')
			]),
		_Utils_ap(
			_List_fromArray(
				[
					A2(
					$elm$html$Html$div,
					_List_fromArray(
						[
							A2(
							$elm$html$Html$Attributes$style,
							'width',
							$elm$core$String$fromFloat($author$project$View$pixelWidth) + 'px'),
							A2(
							$elm$html$Html$Attributes$style,
							'height',
							$elm$core$String$fromFloat($author$project$View$pixelHeight) + 'px'),
							A2($elm$html$Html$Attributes$style, 'position', 'absolute'),
							A2($elm$html$Html$Attributes$style, 'margin', 'auto'),
							A2($elm$html$Html$Attributes$style, 'left', '0'),
							A2($elm$html$Html$Attributes$style, 'top', '0'),
							A2($elm$html$Html$Attributes$style, 'right', '0'),
							A2($elm$html$Html$Attributes$style, 'bottom', '0'),
							A2($elm$html$Html$Attributes$style, 'transform-origin', '0 0'),
							A2(
							$elm$html$Html$Attributes$style,
							'transform',
							'scale(' + ($elm$core$String$fromFloat(r) + ')'))
						]),
					_List_fromArray(
						[
							$author$project$View$renderPic(model),
							$author$project$View$renderMapButton(model),
							$author$project$View$renderdialog(model),
							$author$project$View$renderMusic,
							$author$project$View$axisHelper(model)
						]))
				]),
			$author$project$View$rendersuspectlist(model)));
};
var $author$project$Main$main = $elm$browser$Browser$element(
	{
		init: function (value) {
			return _Utils_Tuple2(
				A2(
					$elm$core$Result$withDefault,
					$author$project$Model$initial,
					A2($elm$json$Json$Decode$decodeValue, $author$project$Model$decode, value)),
				A2($elm$core$Task$perform, $author$project$Message$GetViewport, $elm$browser$Browser$Dom$getViewport));
		},
		subscriptions: $author$project$Main$subscriptions,
		update: $author$project$Update$update,
		view: $author$project$View$view
	});
_Platform_export({'Main':{'init':$author$project$Main$main($elm$json$Json$Decode$value)(0)}});}(this));
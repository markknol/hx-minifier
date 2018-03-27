# Haxe HTML/CSS Minifier

This project does not aim to be the smallest but to provide just a way to minify HTML / CSS files.

## Installation

Install using [Haxelib](https://lib.haxe.org/minifier):

```
haxelib install minifier
```

To use in code, add to your build hxml:

```
-lib minifier
```

## API

 * `public static function minifyHtml(content:String, keepComments:Bool = true)`
   Minifies HTML. Assumes only `textarea`, `pre`, `script`, `code` tags contain meaningful spaces/newlines. 
   
 * `public static function minifyCss(content:String, keepComments:Bool = true)`]
   Minify a (valid) CSS document.
   
 * `public static function removeHtmlComments(content:String)`
   Remove HTML comments from given `content`.
   
 * `public static function removeCssComments(content:String)`
   Remove CSS comments from given `content`.

### Command-line

The library also comes as command-line tool. At the moment this is only per file, with specific extension.

```
HTML/CSS Minifier
https://github.com/markknol/hxminifier

[-in] <path>    : File to process. required. Should have extension
[-out] <path>   : Project out folder. By default same as in-path
[--overwrite]   : Allows overwriting in output. By default no file
[--no-comments] : Removes comments. By default comments are kept
```

### Dependencies

 * [Haxe](https://haxe.org/)

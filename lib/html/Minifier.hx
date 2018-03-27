package html;

/**
	@author $author
**/
class Minifier {
	
	/**
	   Minifies HTML. Assumes only `textarea`, `pre`, `script`, `code` tags contain meaningful spaces/newlines. 
	**/
	public static function minifyHtml(content:String, keepComments:Bool = true) {
		// adapted from <http://stackoverflow.com/questions/16134469/minify-html-with-boost-regex-in-c>
		content = new EReg("(?ix)(?>[^\\S]\\s*|\\s{2,})(?=[^<]*+(?:<(?!/?(?:textarea|pre|script|code)\\b)[^<]*+)*+(?:<(?>textarea|pre|script|code)\\b|\\z))", "ig").replace(content, " ");
		
		// remove comments
		if (!keepComments) content = removeHtmlComments(content);
		
		return content;
	}
	
	/**
	   Remove html comments `<!-- -->` from given `content`.
	**/
	public static function removeHtmlComments(content:String) {
		// adapted from <http://stackoverflow.com/questions/16134469/minify-html-with-boost-regex-in-c>
		return new EReg("<!--(.*?)-->", "g").replace(content, "");
	}
	
	/**
	   Minify a (valid) CSS document.
	**/
	public static function minifyCss(content:String, keepComments:Bool = true) {
		if (!keepComments) content = removeCssComments(content);
		
		// adapted from <https://gist.github.com/clipperhouse/1201239/cad48570925a4f5ff0579b654e865db97d73bcc4>
		content = ~/\s*([,>+;:}{]{1})\s*/ig.replace(content, "$1");
		
		// minor addition
        content = content.split(";}").join("}");
		
        return content;
	}
	
	/**
	   Remove CSS comments from given `content`.
	**/
	public static function removeCssComments(content:String) {
		return content = ~/(\/\*\*?(.|\n)+?\*?\*\/)/g.replace(content, "");
	}
	
}
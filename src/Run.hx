package;
import haxe.io.Path;
import html.Minifier;
import sys.FileSystem;
import sys.io.File;

/**
 * Commandline tool to minify html/css.
 * @author Mark Knol
 */
class Run {
	public static function main() {
		var data = {
			inPath: null, 
			outPath: null, 
			curPath: null, 
			overwrite: false,
			keepComments: true,
		};
		var argHandler = hxargs.Args.generate([
			@doc("File to process. required. Should have extension html or css")
			["-in"] => function(path:String) data.inPath = new Path(path),
			
			@doc("Project out folder. By default same as in-path")
			["-out"] => function(path:String) data.outPath = new Path(path),
			
			@doc("Allows overwriting in output. By default no file is overwritten")
			["--overwrite"] => function() data.overwrite = true,
			
			@doc("Removes comments. By default comments are kept")
			["--no-comments"] => function() data.keepComments = false,
			
			_ => function(path:String) 
				if (FileSystem.isDirectory(path)) data.curPath = new Path(path); 
				else throw 'Cannot parse argument "$path"',
		]);
		
		var args = Sys.args();
		if (args.length == 0) {
			printDocs(argHandler.getDoc());
		} else  {
			argHandler.parse(args);
			if (data.outPath == null) data.outPath = data.inPath;
			if (data.inPath != null) {
				if (!data.overwrite && FileSystem.exists(data.outPath.toString())) {
					printDocs(argHandler.getDoc(), 'Error: Cannot overwrite "${data.outPath.toString()}"');
				} else {
					var content = switch data.inPath.ext.toLowerCase() {
						case "html": 
							Minifier.minifyHtml(File.getContent(data.inPath.toString()), data.keepComments);
							
						case "css":
							Minifier.minifyCss(File.getContent(data.inPath.toString()), data.keepComments);
							
						case extension:
							printDocs(argHandler.getDoc(), 'Error: Unknown extension "$extension"');
							null;
					}
					if (content != null) File.saveContent(data.outPath.toString(), content);
				}
				
			} else {
				printDocs(argHandler.getDoc());
			}
		}
	}
	
	private static function printDocs(doc:String, msg:Null<String> = null) {
		Sys.println('HTML/CSS Minifier\nhttps://github.com/markknol/hxminifier\n\n${doc}' + (if (msg != null) '\n\n$msg' else '')); 
	}
}
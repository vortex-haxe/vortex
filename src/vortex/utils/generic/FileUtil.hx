package vortex.utils.generic;

import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;
import vortex.debug.Debug;
import haxe.zip.Reader as ZipReader;

/**
 * A class with some file utilities that Haxe doesn't
 * already have or is more inconvenient.
 */
class FileUtil {
	/**
	 * Copies a directory with all of it's files/directories to another directory.
	 * 
	 * @param source       The source directory to copy.
	 * @param destination  The destination directory to copy to.
	 */
	public static function copyDirectory(source:String, destination:String) {
		if (!FileSystem.exists(source)) {
			Debug.error('The directory at $source doesn\'t exist and cannot be copied.');
			return;
		}
		if (!FileSystem.exists(destination))
			FileSystem.createDirectory(destination);

		for (file in FileSystem.readDirectory(source)) {
			final sourceFile:String = source + "/" + file;
			final destinationFile:String = destination + "/" + file;

			if (FileSystem.isDirectory(sourceFile))
				copyDirectory(sourceFile, destinationFile);
			else {
				final bytes = File.getBytes(sourceFile);
				File.saveBytes(destinationFile, bytes);
			}
		}
	}

	/**
	 * Decompresses a zip file and extracts its contents to a specified destination.
	 *
	 * @param source            The path to the zip file to be extracted.
	 * @param destination       The destination folder where the contents will be extracted.
	 * @param ignoreRootFolder  An optional parameter to ignore a specified root folder during extraction (default is an empty string).
	 * 
	 * @see https://gist.github.com/ruby0x1/8dc3a206c325fbc9a97e
	 */
	public static function unzipFile(source:String, destination:String, ?ignoreRootFolder:String = "") {
		var _inFile = File.read(source);
		var _entries = ZipReader.readZip(_inFile);

		_inFile.close();

		for (_entry in _entries) {
			final fileName = _entry.fileName;
			if (fileName.charAt(0) != "/" && fileName.charAt(0) != "\\" && fileName.split("..").length <= 1) {
				final dirs = ~/[\/\\]/g.split(fileName);
				if ((ignoreRootFolder != "" && dirs.length > 1) || ignoreRootFolder == "") {
					if (ignoreRootFolder != "")
						dirs.shift();

					var path = "";
					final file = dirs.pop();
					for (d in dirs) {
						path += d;
						FileSystem.createDirectory(Path.normalize(Path.join([destination, path])));
						path += "/";
					}

					if (file == "")
						continue; // was just a directory

					path += file;

					final data = ZipReader.unzip(_entry);
					final f = File.write(Path.normalize(Path.join([destination, path])), true);
					f.write(data);
					f.close();
				}
			}
		}
	}
}

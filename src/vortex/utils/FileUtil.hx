package vortex.utils;

import sys.io.File;
import sys.FileSystem;
import vortex.debug.Debug;

class FileUtil {
	/**
	 * Copies a directory to another directory.
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
}

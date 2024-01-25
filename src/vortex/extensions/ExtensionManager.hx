package vortex.extensions;

/**
 * A manager class to add or remove extensions to the game.
 */
class ExtensionManager {
	/**
	 * Returns the instance of a specified extension.
	 * 
	 * Returns `null` if the extension wasn't added yet.
	 * 
	 * @param ext  The extension to return an instance of.
	 */
	public function get<T:Extension>(ext:Class<T>):T {
		final extClName:String = Type.getClassName(ext);
		return cast _cache.get(extClName);
	}

	/**
	 * Adds an extension to automatically be ticked/updated.
	 * 
	 * @param  ext   The extension to add.
	 * @param  args  Optional arguments to give to the extension when adding it.
	 * 
	 * @return Whether or not the extension was added successfully.
	 */
	public function add<T:Extension>(ext:Class<T>, ?args:Array<Dynamic>):Bool {
		final extClName:String = Type.getClassName(ext);
		final extClStr:String = extClName.substring(extClName.lastIndexOf(".") + 1, extClName.length);
		
		final c:T = cast _cache.get(extClName);
		if(c != null) {
			Debug.warn('Extension called "${extClStr}" is already added!');
			return false;
		}
		_cache.set(extClName, Type.createInstance(ext, args ?? []));
		return true;
	}

	/**
	 * Removes an extension and stops it from being 
	 * automatically be ticked/updated.
	 * 
	 * @param  ext   The extension to remove.
	 * 
	 * @return Whether or not the extension was removed successfully.
	 */
	public function remove<T:Extension>(ext:Class<T>):Bool {
		final extClName:String = Type.getClassName(ext);
		final extClStr:String = extClName.substring(extClName.lastIndexOf(".") + 1, extClName.length);

		final c:T = cast _cache.get(extClName);
		if(c != null) {
			_cache.remove(extClName);
			return true;
		} else if(_cache.exists(extClName)) // Silently remove if extension is null
			_cache.remove(extClName);

		Debug.warn('Extension called "${extClStr}" hasn\'t been added yet!');
		return false;
	}

	/**
	 * Ticks/updates every extension all at once.
	 * 
	 * @param delta  The time between the last frame in seconds.
	 */
	public function tick(delta:Float):Void {
		for(ext in _cache) {
			if(ext != null && ext.enabled)
				ext.tick(delta);
		}
	}

	// -------- //
	// Privates //
	// -------- //
	private var _cache:Map<String, Extension> = [];

	@:noCompletion
	public function new() {} // technically this is public but it's private as in you shouldn't use it
}
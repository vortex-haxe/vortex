package vortex;

import vortex.Basic;

/**
 * A container/group of several objects.
 */
typedef Container = TypedContainer<Basic>;

/**
 * A container/group of several classes that either are or extend `Basic`.
 * 
 * An object cannot be in multiple containers at once, said object
 * will instead be removed from it's current container before being
 * added to the new one.
 */
class TypedContainer<T:Basic> extends Object {
    /**
     * The objects within this container.
     */
    public var members(default, null):Array<T> = [];

    /**
     * The amount of objects inside of this container.
     * 
     * For performance and safety you should use this
     * to check the length of a container, unless you
     * know what you're doing!
     */
    public var length(default, null):Int = 0;

    /**
     * The maximum amount of objects allowed
     * inside of this container.
     */
    public var maxSize(default, null):Int = 0;

    /**
     * Makes a new `TypedContainer` instance.
     * 
     * @param  maxSize  The maximum amount of objects allowed inside of this container. 
     */
    public function new(maxSize:Int = 0) {
        super();
        this.maxSize = maxSize;
    }

    /**
     * Adds a given object to this container and
     * then returns it afterwards.
     * 
     * @param  object  The object to add.
     */
    public function add(object:T):T {
        if(object == null) {
            GlobalCtx.log.warn('You cannot add a null object to a container!');
            return null;
        }
        if(members.contains(object)) {
            GlobalCtx.log.warn('You cannot add the same object to this container twice!');
            return object;
        }
        if(maxSize > 0 && length >= maxSize) {
            GlobalCtx.log.warn('This container has reached it\'s maximum size!');
            return object;
        }
        if(object.container != null)
            object.container.remove(object);

        object.container = cast this;
        members.push(object);

        length++;
        return object;
    }

    /**
     * Adds a given object to this container at
     * a specified layer index and then returns it afterwards.
     * 
     * @param  layer   The layer of this group to add this object onto.
     * @param  object  The object to add.
     */
    public function insert(layer:Int, object:T):T {
        if(object == null) {
            GlobalCtx.log.warn('You cannot add a null object to a container!');
            return null;
        }
        if(layer < length && members[layer] == null) {
            if(object.container != null)
                object.container.remove(object);
    
            object.container = cast this;
            members[layer] = object;

            return object;
        }
        else if(maxSize > 0 && length >= maxSize) {
            GlobalCtx.log.warn('This container has reached it\'s maximum size!');
            return object;
        }
        if(object.container != null)
            object.container.remove(object);

        object.container = cast this;
        members.insert(layer, object);

        length++;
        return object;
    }

    /**
     * Removes a given object from this container and
     * then returns it afterwards.
     * 
     * @param  object  The object to remove.
     * @param  splice  Whether or not to remove from the members array
     *                 entirely or to set the item at the object's layer index to null.
     */
    public function remove(object:T, splice:Bool = true):T {
        if(object == null) {
            GlobalCtx.log.warn('You cannot remove a null object from a container!');
            return null;
        }
        if(splice)
            members.remove(object);
        else
            members[members.indexOf(object)] = null;
        
        object.container = null;
        length--;

        return object;
    }

    /**
     * Replaces a given object with another new object
     * and then returns the new object afterwards.
     * 
     * @param  input  The object to replace.
     * @param  with   The object to replace the old one with.
     */
    public function replace(input:T, with:T):T {
        final index:Int = members.indexOf(input);
        if(index == -1)
            return null;

        members[index] = with;
        return with;
    }

    /**
	 * Call this function to retrieve the first object with `alive == false` in the group.
	 * This is handy for recycling in general, e.g. respawning enemies.
	 *
	 * @param   objectClass  An optional parameter that lets you narrow the
	 *                       results to instances of this particular class.
     * 
	 * @param   force        Force the object to be an `ObjectClass` and not a super class of `ObjectClass`.
	 */
	public function getFirstAvailable(?objectClass:Class<T>, force = false):Null<T> {
		for(basic in members) {
			if(basic != null && !basic.alive && (objectClass == null || Std.isOfType(basic, objectClass))) {
				if(force && Type.getClassName(Type.getClass(basic)) != Type.getClassName(objectClass))
					continue;
				
				return basic;
			}
		}
		return null;
	}

    /**
     * Recycling is designed to help you reuse game objects without always re-allocating or "newing" them.
     * It behaves differently depending on whether `maxSize` equals `0` or is bigger than `0`.
     *
     * `maxSize > 0` / "rotating-recycling":
     *   - at capacity:  returns the next object in line, no matter its properties.
     *   - otherwise:    returns a new object.
     *
     * `maxSize == 0` / "grow-style-recycling"
     *   - tries to find the first object with `alive == false`
     *   - otherwise: adds a new object to the `members` array
     *
     * WARNING: If this function needs to create a new object, and no object class was provided,
     * it will return `null` instead of a valid object!
     *
     * @param  objectClass  The class type you want to recycle (e.g. `Sprite`, `EvilSlime`, etc).
     * @param  objectFactory  Optional factory function to create a new object
     *                        if there aren't any dead members to recycle.
     *                        If `null`, `Type.createInstance()` is used,
     *                        which requires the class to have no constructor parameters.
     * 
     * @param  force  Force the object to be an `ObjectClass` and not a super class of `ObjectClass`.
     * @param  revive  Whether recycled members should automatically be revived
     *                 (by calling `revive()` on them).
     */
    public function recycle(?objectClass:Class<T>, ?objectFactory:Void->T, force = false, revive = true):T {
        // Rotated recycling
		if(maxSize > 0) {
			// Create new instance
			if(length < maxSize)
				return _recycleCreateObject(objectClass, objectFactory);
			
			// Get the next member if at capacity
			final obj = members[_marker++];
			if(_marker >= maxSize)
				_marker = 0;

			if(revive)
				obj.revive();

			return cast obj;
		}
		
		// Grow-style recycling - Grab a obj with alive == false or create a new one
		final obj = getFirstAvailable(objectClass, force);
		if(obj != null) {
			if(revive)
				obj.revive();
            
			return cast obj;
		}
		return _recycleCreateObject(objectClass, objectFactory);
    }

    /**
     * Updates every object inside of this container.
     * 
     * @param  delta  The time since the last frame in seconds.
     */
    override function update(delta:Float):Void {
        for(i in 0...length) {
            final object:T = members[i];
            if(object != null && object.active && object.alive)
                object.update(delta);
        }
    }

    /**
     * Draws every object inside of this container
     * onto the screen.
     */
    override function draw() {
        for(i in 0...length) {
            final object:T = members[i];
            if(object != null && object.visible && object.alive)
                object.draw();
        }
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

	/**
	 * Internal helper variable for recycling objects
	 */
	@:noCompletion
	private var _marker:Int = 0;

    private inline function _recycleCreateObject(?objectClass:Class<T>, ?objectFactory:Void->T):T {
        if(objectFactory != null)
            return add(objectFactory());
        
        if(objectClass != null)
            return add(Type.createInstance(objectClass, []));
        
        return null;
    }
}
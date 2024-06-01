package vortex;

/**
 * A container/group of several objects.
 */
typedef Container = TypedContainer<Object>;

/**
 * A container/group that only allows types that
 * either *are* or *extend* `Object`.
 */
class TypedContainer<T:Object> extends Object {
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
     * Makes a new `Container` instance.
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
            members[layer] = object;
            return object;
        }
        else if(maxSize > 0 && length >= maxSize) {
            GlobalCtx.log.warn('This container has reached it\'s maximum size!');
            return object;
        }
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
     * Updates every object inside of this container.
     * 
     * @param  delta  The time since the last frame in seconds.
     */
    override function update(delta:Float):Void {
        for(i in 0...length) {
            final object:T = members[i];
            if(object != null && object.active)
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
            if(object != null && object.visible)
                object.draw();
        }
    }
}
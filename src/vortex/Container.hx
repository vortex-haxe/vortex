package vortex;

/**
 * A container/group of several entity objects.
 */
typedef Container = TypedContainer<Entity>;

/**
 * A container/group that only allows types that
 * either *are* or *extend* `Entity`.
 */
class TypedContainer<T:Entity> extends Entity {
    /**
     * The entities within this container.
     */
    public var members(default, null):Array<T> = [];

    /**
     * The amount of entities inside of this container.
     * 
     * For performance and safety you should use this
     * to check the length of a container, unless you
     * know what you're doing!
     */
    public var length(default, null):Int = 0;

    /**
     * The maximum amount of entities allowed
     * inside of this container.
     */
    public var maxSize(default, null):Int = 0;

    /**
     * Makes a new `Container` instance.
     * 
     * @param  maxSize  The maximum amount of entities allowed inside of this container. 
     */
    public function new(maxSize:Int = 0) {
        super();
        this.maxSize = maxSize;
    }

    /**
     * Adds a given entity to this container and
     * then returns it afterwards.
     * 
     * @param  entity  The entity to add.
     */
    public function add(entity:T):T {
        if(entity == null) {
            GlobalCtx.log.warn('You cannot add a null entity to a container!');
            return null;
        }
        if(members.contains(entity)) {
            GlobalCtx.log.warn('You cannot add the same entity to this container twice!');
            return entity;
        }
        if(maxSize > 0 && length >= maxSize) {
            GlobalCtx.log.warn('This container has reached it\'s maximum size!');
            return entity;
        }
        members.push(entity);
        length++;
        return entity;
    }

    /**
     * Adds a given entity to this container at
     * a specified layer index and then returns it afterwards.
     * 
     * @param  layer   The layer of this group to add this entity onto.
     * @param  entity  The entity to add.
     */
    public function insert(layer:Int, entity:T):T {
        if(entity == null) {
            GlobalCtx.log.warn('You cannot add a null entity to a container!');
            return null;
        }
        if(layer < length && members[layer] == null) {
            members[layer] = entity;
            return entity;
        }
        else if(maxSize > 0 && length >= maxSize) {
            GlobalCtx.log.warn('This container has reached it\'s maximum size!');
            return entity;
        }
        members.insert(layer, entity);
        length++;
        return entity;
    }

    /**
     * Removes a given entity from this container and
     * then returns it afterwards.
     * 
     * @param  entity  The entity to remove.
     * @param  splice  Whether or not to remove from the members array
     *                 entirely or to set the item at the entity's layer index to null.
     */
    public function remove(entity:T, splice:Bool = true):T {
        if(entity == null) {
            GlobalCtx.log.warn('You cannot remove a null entity from a container!');
            return null;
        }
        if(splice)
            members.remove(entity);
        else
            members[members.indexOf(entity)] = null;
        
        length--;
        return entity;
    }

    /**
     * Replaces a given entity with another new entity
     * and then returns the new entity afterwards.
     * 
     * @param  input  The entity to replace.
     * @param  with   The entity to replace the old one with.
     */
    public function replace(input:T, with:T):T {
        final index:Int = members.indexOf(input);
        if(index == -1)
            return null;

        members[index] = with;
        return with;
    }

    /**
     * Updates every entity inside of this container.
     * 
     * @param  delta  The time since the last frame in seconds.
     */
    override function update(delta:Float):Void {
        for(i in 0...length) {
            final entity:T = members[i];
            if(entity != null && entity.active)
                entity.update(delta);
        }
    }

    /**
     * Draws every entity inside of this container
     * onto the screen.
     */
    override function draw() {
        for(i in 0...length) {
            final entity:T = members[i];
            if(entity != null && entity.visible)
                entity.draw();
        }
    }
}
package vortex.system.frontend;

import vortex.display.Camera;

/**
 * Accessible via `GlobalCtx.cameras`.
 */
class CameraFrontEnd {
    /**
     * The global list of added cameras.
     */
    public var list(default, null):Array<Camera> = [];

    public function new() {
        reset();
    }

    /**
     * Removes all of the currently added cameras
     * and adds a given one as the first in the list.
     * 
     * @param  newCamera  The new first camera.
     */
    public function reset(?newCamera:Camera):Camera {
        for(camera in list) {
            if(camera != null)
                camera.destroy();
        }
        GlobalCtx.camera = newCamera ?? new Camera();

        list = [GlobalCtx.camera];
        return list[0];
    }

    /**
     * Adds a given camera to the global camera list.
     * 
     * @param  camera  The camera to add.
     */
    public function add(camera:Camera):Camera {
        if(list.contains(camera)) {
            GlobalCtx.log.warn("You cannot add the same camera twice!");
            return camera;
        }
        list.push(camera);
        return camera;
    }

    /**
     * Remove a given camera from the global camera list. Always returns null.
     * 
     * @param  camera   The camera to remove.
     * @param  destroy  Whether or not to destroy this camera before removing it.
     */
    public function remove(camera:Camera, ?destroy:Bool = true):Null<Camera> {
        if(!list.contains(camera)) {
            GlobalCtx.log.warn("This camera is already not in the global list!");
            return camera;
        }
        if(destroy)
            camera.destroy();

        list.remove(camera);
        return null;
    }

    /**
     * Clears all of the cameras in the list.
     */
    public function clear():Void {
        for(camera in list) {
            if(camera != null)
                camera.clear();
        }
    }

    /**
     * Updates all of the cameras in the list.
     * 
     * @param  delta  The time since the last frame in seconds.
     */
    public function update(delta:Float):Void {
        for(camera in list) {
            if(camera != null)
                camera.update(delta);
        }
    }

    /**
     * Draws all of the cameras in the list.
     */
    public function draw():Void {
        for(camera in list) {
            if(camera != null)
                camera.draw();
        }
    }
}
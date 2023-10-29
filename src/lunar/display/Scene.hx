package lunar.display;

import lunar.core.Object;
import lunar.display.Group;

class Scene extends Group<Object> {
	/**
	 * The function that gets called when this scene
	 * is finished initializing internally.
	 * 
	 * Override this when making scenes to
	 * initialize your own things.
	 */
	public function ready() {}
}
package vortex.utils.generic;

#if macro
import haxe.macro.Expr;
#else
import vortex.backend.interfaces.IDisposable;

/**
 * @see https://github.com/HaxeFlixel/flixel/blob/master/flixel/util/FlxSignal.hx
 */
@:multiType
abstract Signal<T>(ISignal<T>) {
	public var emit(get, never):T;

	public function new();

	public inline function connect(listener:T):Void {
		this.connect(listener);
	}

	public inline function connectOnce(listener:T):Void {
		this.connectOnce(listener);
	}

	public inline function disconnect(listener:T):Void {
		this.disconnect(listener);
	}

	public inline function has(listener:T):Bool {
		return this.has(listener);
	}

	public inline function disconnectAll():Void {
		this.disconnectAll();
	}

	public inline function dispose():Void {
		this.dispose();
	}

	inline function get_emit():T {
		return this.emit;
	}

	@:to
	static inline function toSignal0(signal:ISignal<Void->Void>):Signal0 {
		return new Signal0();
	}

	@:to
	static inline function toSignal1<T1>(signal:ISignal<T1->Void>):Signal1<T1> {
		return new Signal1();
	}

	@:to
	static inline function toSignal2<T1, T2>(signal:ISignal<T1->T2->Void>):Signal2<T1, T2> {
		return new Signal2();
	}

	@:to
	static inline function toSignal3<T1, T2, T3>(signal:ISignal<T1->T2->T3->Void>):Signal3<T1, T2, T3> {
		return new Signal3();
	}

	@:to
	static inline function toSignal4<T1, T2, T3, T4>(signal:ISignal<T1->T2->T3->T4->Void>):Signal4<T1, T2, T3, T4> {
		return new Signal4();
	}

	@:to
	static inline function toSignal5<T1, T2, T3, T4, T5>(signal:ISignal<T1->T2->T3->T4->T5->Void>):Signal5<T1, T2, T3, T4, T5> {
		return new Signal5();
	}
}

private class SignalHandler<T> implements IDisposable {
	public var disposed:Bool = false;
	public var listener:T;

	public var emitOnce(default, null):Bool = false;

	public function new(listener:T, emitOnce:Bool) {
		this.listener = listener;
		this.emitOnce = emitOnce;
	}

	public function dispose() {
		disposed = true;
		listener = null;
	}
}

private class BaseSignal<T> implements ISignal<T> {
	/**
	 * Typed function reference used to emit this signal.
	 */
	public var emit:T;

	public var disposed:Bool = false;

	var handlers:Array<SignalHandler<T>>;
	var pendingDisconnect:Array<SignalHandler<T>>;
	var processingListeners:Bool = false;

	public function new() {
		handlers = [];
		pendingDisconnect = [];
	}

	public function connect(listener:T) {
		if (listener != null)
			registerListener(listener, false);
	}

	public function connectOnce(listener:T):Void {
		if (listener != null)
			registerListener(listener, true);
	}

	public function disconnect(listener:T):Void {
		if (listener != null) {
			var handler = getHandler(listener);
			if (handler != null) {
				if (processingListeners)
					pendingDisconnect.push(handler);
				else {
					handlers.remove(handler);
					handler.dispose();
				}
			}
		}
	}

	public function has(listener:T):Bool {
		if (listener == null)
			return false;
		return getHandler(listener) != null;
	}

	public inline function disconnectAll():Void {
		for(s in handlers)
			s.dispose();
		handlers = [];
	}

	public function dispose():Void {
		disconnectAll();
		disposed = true;
		handlers = null;
		pendingDisconnect = null;
	}

	function registerListener(listener:T, emitOnce:Bool):SignalHandler<T> {
		var handler = getHandler(listener);

		if (handler == null) {
			handler = new SignalHandler<T>(listener, emitOnce);
			handlers.push(handler);
			return handler;
		} else {
			// If the listener was previously connected, definitely don't connect it again.
			// But throw an exception if their once values differ.
			if (handler.emitOnce != emitOnce)
				throw "You cannot connectOnce() then connect() the same listener without removing the relationship first.";
			else
				return handler;
		}
	}

	function getHandler(listener:T):SignalHandler<T> {
		for (handler in handlers) {
			if (#if (neko || hl) // simply comparing the functions doesn't do the trick on these targets
				Reflect.compareMethods(handler.listener, listener) #else handler.listener == listener #end) {
				return handler; // Listener was already registered.
			}
		}
		return null; // Listener not yet registered.
	}
}

private class Signal0 extends BaseSignal<Void->Void> {
	public function new() {
		super();
		this.emit = emit0;
	}

	public function emit0():Void {
		Macro.buildEmit();
	}
}

private class Signal1<T1> extends BaseSignal<T1->Void> {
	public function new() {
		super();
		this.emit = emit1;
	}

	public function emit1(value1:T1):Void {
		Macro.buildEmit(value1);
	}
}

private class Signal2<T1, T2> extends BaseSignal<T1->T2->Void> {
	public function new() {
		super();
		this.emit = emit2;
	}

	public function emit2(value1:T1, value2:T2):Void {
		Macro.buildEmit(value1, value2);
	}
}

private class Signal3<T1, T2, T3> extends BaseSignal<T1->T2->T3->Void> {
	public function new() {
		super();
		this.emit = emit3;
	}

	public function emit3(value1:T1, value2:T2, value3:T3):Void {
		Macro.buildEmit(value1, value2, value3);
	}
}

private class Signal4<T1, T2, T3, T4> extends BaseSignal<T1->T2->T3->T4->Void> {
	public function new() {
		super();
		this.emit = emit4;
	}

	public function emit4(value1:T1, value2:T2, value3:T3, value4:T4):Void {
		Macro.buildEmit(value1, value2, value3, value4);
	}
}

private class Signal5<T1, T2, T3, T4, T5> extends BaseSignal<T1->T2->T3->T4->T5->Void> {
	public function new() {
		super();
		this.emit = emit4;
	}

	public function emit4(value1:T1, value2:T2, value3:T3, value4:T4, value5:T5):Void {
		Macro.buildEmit(value1, value2, value3, value4, value5);
	}
}

interface ISignal<T> extends IDisposable {
	var emit:T;
	function connect(listener:T):Void;
	function connectOnce(listener:T):Void;
	function disconnect(listener:T):Void;
	function disconnectAll():Void;
	function has(listener:T):Bool;
}
#end

private class Macro {
	public static macro function buildEmit(exprs:Array<Expr>):Expr {
		return macro {
			processingListeners = true;
			for (handler in handlers) {
				handler.listener($a{exprs});

				if (handler.emitOnce)
					disconnect(handler.listener);
			}

			processingListeners = false;

			for (handler in pendingDisconnect) {
				disconnect(handler.listener);
			}
			if (pendingDisconnect.length > 0)
				pendingDisconnect = [];
		}
	}
}

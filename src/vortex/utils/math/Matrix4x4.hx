package vortex.utils.math;

import cpp.RawPointer;
import vortex.utils.math.Vector3;
import vortex.utils.math.Vector4;

@:forward abstract Matrix4x4(BaseMatrix4x4) to BaseMatrix4x4 from BaseMatrix4x4 {
	public function new(val:Float = 0) {
		this = new BaseMatrix4x4(val);
	}

    /**
     * Returns one of the vectors in this matrix.
     * 
     * @param vec  The index of the vector in this matrix.
     */
    @:op([]) public function get(vec:Int = 0) {
        @:privateAccess
        return this.vecs[vec];
    }

    /**
     * Creates an orthographic projection matrix.
     *
     * @param left   The left clipping plane coordinate.
     * @param right  The right clipping plane coordinate.
     * @param bottom The bottom clipping plane coordinate.
     * @param top    The top clipping plane coordinate.
     * @param zNear  The near clipping plane distance.
     * @param zFar   The far clipping plane distance.
     */
    public static function ortho(left:Float, right:Float, bottom:Float, top:Float, zNear:Float, zFar:Float):Matrix4x4 {
        return BaseMatrix4x4.ortho(left, right, bottom, top, zNear, zFar);
    }

	@:noCompletion
	@:op(A + B)
	private static inline function addOp(a:Matrix4x4, b:Matrix4x4) {
		return new Matrix4x4().copyFrom(a).add(b);
	}

    @:noCompletion
	@:op(A + B)
	private static inline function addFloatOp(a:Matrix4x4, b:Float) {
		return new Matrix4x4().copyFrom(a).addFloat(b);
	}

    @:noCompletion
	@:op(A += B)
	private static inline function addEqualOp(a:Matrix4x4, b:Matrix4x4) {
		return a.add(b);
	}

    @:noCompletion
	@:op(A - B)
	private static inline function subtractOp(a:Matrix4x4, b:Matrix4x4) {
		return new Matrix4x4().copyFrom(a).subtract(b);
	}

    @:noCompletion
	@:op(A - B)
	private static inline function subtractFloatOp(a:Matrix4x4, b:Float) {
		return new Matrix4x4().copyFrom(a).subtractFloat(b);
	}

    @:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualOp(a:Matrix4x4, b:Matrix4x4) {
		return a.subtract(b);
	}

    @:noCompletion
	@:op(A * B)
	private static inline function multiplyOp(a:Matrix4x4, b:Matrix4x4) {
		return new Matrix4x4().copyFrom(a).multiply(b);
	}

    @:noCompletion
	@:op(A * B)
	private static inline function multiplyFloatOp(a:Matrix4x4, b:Float) {
		return new Matrix4x4().copyFrom(a).multiplyFloat(b);
	}

    @:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualOp(a:Matrix4x4, b:Matrix4x4) {
		return a.multiply(b);
	}

    @:noCompletion
	@:op(A / B)
	private static inline function divideOp(a:Matrix4x4, b:Matrix4x4) {
		return new Matrix4x4().copyFrom(a).divide(b);
	}

    @:noCompletion
	@:op(A / B)
	private static inline function divideFloatOp(a:Matrix4x4, b:Float) {
		return new Matrix4x4().copyFrom(a).divideFloat(b);
	}

    @:noCompletion
	@:op(A /= B)
	private static inline function divideEqualOp(a:Matrix4x4, b:Matrix4x4) {
		return a.divide(b);
	}
}

/**
 * A simple 4x4 matrix class.
 */
class BaseMatrix4x4 {
    /**
     * Static matrix used for intermediate calculations.
     */
	private static var extraMat = new BaseMatrix4x4(1.0);

	/**
	 * Array of `Vector4` representing the rows of the matrix.
	 */
    private var vecs:Array<Vector4>;
    
	/**
     * Constructs a 4x4 matrix with initial values.
     *
     * @param val The initial value for the diagonal elements of the matrix.
     */
    public function new(val:Float = 0.0) {
		vecs = [
			new Vector4(), new Vector4(),
			new Vector4(), new Vector4()
		];
		reset(val);
	}

    /**
     * Resets the matrix with the specified value for the diagonal elements.
     *
     * @param val The value for the diagonal elements.
     */
    public function reset(val:Float) {
        vecs[0].set(val, 0.0, 0.0, 0.0);
        vecs[1].set(0.0, val, 0.0, 0.0);
        vecs[2].set(0.0, 0.0, val, 0.0);
        vecs[3].set(0.0, 0.0, 0.0, val);
    }
    
    /**
     * Translates the matrix by the specified `Vector3`.
     *
     * @param move The translation vector.
     */
	public function translate(move:Vector3):BaseMatrix4x4 {
        vecs[0].w += move.x;
        vecs[1].w += move.y;
        vecs[2].w += move.z;
		return this;
	}

    public function rotate270Z():BaseMatrix4x4 {
        extraMat.vecs[0].copyFrom(vecs[1]);
        extraMat.vecs[1].copyFrom(-vecs[0]);
		extraMat.vecs[2].copyFrom(vecs[2]);
		extraMat.vecs[3].copyFrom(vecs[3]);
		return copyFrom(extraMat);
    }


    /**
     * Rotates the matrix by the specified angle around the given axis.
     *
     * @param radians   The angle in radians.
     * @param inputAxis The axis of rotation as a Vector3.
     */
	public function radRotate(radians:Float, inputAxis:Vector3):BaseMatrix4x4 {
		var sin = Math.sin(radians);
		var cos = Math.cos(radians);
		return rotate(sin, cos, inputAxis);
	}

    /**
     * Rotates the matrix using the provided sine, cosine, and axis values.
     *
     * @param sin       The sine of the rotation angle.
     * @param cos       The cosine of the rotation angle.
     * @param inputAxis The axis of rotation as a `Vector3`.
     */
	//Thanks to https://github.com/RafGamign for helping with this function.
	public function rotate(sin:Float, cos:Float, inputAxis:Vector3):BaseMatrix4x4 {
		var x = inputAxis.x;
		var y = inputAxis.y;
		var z = inputAxis.z;

		extraMat.vecs[0].x = (cos + x * x * (1 - cos));
		extraMat.vecs[0].y = (x * y * (1 - cos) - z * sin);
		extraMat.vecs[0].z = (x * z * (1 - cos) + y * sin);

		extraMat.vecs[1].x = (y * x * (1 - cos) + z * sin);
		extraMat.vecs[1].y = (cos + y * y * (1 - cos));
		extraMat.vecs[1].z = (y * z * (1 - cos) - x * sin);

		extraMat.vecs[2].x = (z * x * (1 - cos) - y * sin);
		extraMat.vecs[2].y = (z * y * (1 - cos) + x * sin);
		extraMat.vecs[2].z = (cos + z * z * (1 - cos));

		extraMat.vecs[0].set(
			(vecs[0].x * extraMat.vecs[0].x + vecs[1].x * extraMat.vecs[0].y + vecs[2].x * extraMat.vecs[0].z),
			(vecs[0].y * extraMat.vecs[0].x + vecs[1].y * extraMat.vecs[0].y + vecs[2].y * extraMat.vecs[0].z),
			(vecs[0].z * extraMat.vecs[0].x + vecs[1].z * extraMat.vecs[0].y + vecs[2].z * extraMat.vecs[0].z),
			(vecs[0].w * extraMat.vecs[0].x + vecs[1].w * extraMat.vecs[0].y + vecs[2].w * extraMat.vecs[0].z)
		);

		extraMat.vecs[1].set(
			(vecs[0].x * extraMat.vecs[1].x + vecs[1].x * extraMat.vecs[1].y + vecs[2].x * extraMat.vecs[1].z),
			(vecs[0].y * extraMat.vecs[1].x + vecs[1].y * extraMat.vecs[1].y + vecs[2].y * extraMat.vecs[1].z),
			(vecs[0].z * extraMat.vecs[1].x + vecs[1].z * extraMat.vecs[1].y + vecs[2].z * extraMat.vecs[1].z),
			(vecs[0].w * extraMat.vecs[1].x + vecs[1].w * extraMat.vecs[1].y + vecs[2].w * extraMat.vecs[1].z)
		);

		extraMat.vecs[2].set(
			(vecs[0].x * extraMat.vecs[2].x + vecs[1].x * extraMat.vecs[2].y + vecs[2].x * extraMat.vecs[2].z),
			(vecs[0].y * extraMat.vecs[2].x + vecs[1].y * extraMat.vecs[2].y + vecs[2].y * extraMat.vecs[2].z),
			(vecs[0].z * extraMat.vecs[2].x + vecs[1].z * extraMat.vecs[2].y + vecs[2].z * extraMat.vecs[2].z),
			(vecs[0].w * extraMat.vecs[2].x + vecs[1].w * extraMat.vecs[2].y + vecs[2].w * extraMat.vecs[2].z)
		);
		extraMat.vecs[3].copyFrom(vecs[3]);
		return copyFrom(extraMat);
	}

    /**
     * Copies the values from another matrix into this matrix.
     *
     * @param mat The source matrix to copy from.
     */
    public function copyFrom(mat:BaseMatrix4x4):BaseMatrix4x4 {
        for (i in 0...4)
            vecs[i].copyFrom(mat.vecs[i]);
		return this;
    }

	/**
	 * Converts the matrix into a c array, mainly used for OpenGL Shaders.
	 * 
	 * NOTE: For proper memory management, please call `cpp.Helpers.free` when you are fully finished with the c array.
	 * 
	 * @return cpp.Star<cpp.Float32>
	 */
     public function toStar():cpp.Star<cpp.Float32> {
        var ptr:RawPointer<cpp.Float32> = cast cpp.Native.nativeMalloc(16 * cpp.Native.sizeof(cpp.Float32));
		ptr[0] = vecs[0].x;
        ptr[1] = vecs[1].x;
        ptr[2] = vecs[2].x;
        ptr[3] = vecs[3].x;
        ptr[4] = vecs[0].y;
        ptr[5] = vecs[1].y;
        ptr[6] = vecs[2].y;
        ptr[7] = vecs[3].y;
        ptr[8] = vecs[0].z;
        ptr[9] = vecs[1].z;
        ptr[10] = vecs[2].z;
        ptr[11] = vecs[3].z;
        ptr[12] = vecs[0].w;
        ptr[13] = vecs[1].w;
        ptr[14] = vecs[2].w;
        ptr[15] = vecs[3].w;
		return untyped __cpp__("{0}", ptr);
	}

    /**
     * Creates an orthographic projection matrix.
     *
     * @param left   The left clipping plane coordinate.
     * @param right  The right clipping plane coordinate.
     * @param bottom The bottom clipping plane coordinate.
     * @param top    The top clipping plane coordinate.
     * @param zNear  The near clipping plane distance.
     * @param zFar   The far clipping plane distance.
     */
	public static function ortho(left:Float, right:Float, bottom:Float, top:Float, zNear:Float, zFar:Float):BaseMatrix4x4 {
		var toReturn = new BaseMatrix4x4(1.0);

		toReturn.vecs[0].x = 2.0 / (right - left);
		toReturn.vecs[1].y = 2.0 / (top - bottom);
		toReturn.vecs[0].w = -(right + left) / (right - left);
		toReturn.vecs[1].w = -(top + bottom) / (top - bottom);

		toReturn.vecs[2].z = -2.0 / (zFar - zNear);
		toReturn.vecs[2].w = -(zFar + zNear) / (zFar - zNear);

		return toReturn;
	}

    /**
     * Adds another matrix to this matrix element-wise.
     *
     * @param mat The matrix to add.
     */
	public inline function add(mat:BaseMatrix4x4):BaseMatrix4x4 {
		for (i in 0...4) {
			vecs[i].x += mat.vecs[i].x;
            vecs[i].y += mat.vecs[i].y;
            vecs[i].z += mat.vecs[i].z;
            vecs[i].w += mat.vecs[i].w;
        }
		return this;
	}

    /**
     * Subtracts another matrix from this matrix element-wise.
     *
     * @param mat The matrix to subtract.
     */
	public inline function subtract(mat:BaseMatrix4x4):BaseMatrix4x4 {
		for (i in 0...4) {
			vecs[i].x -= mat.vecs[i].x;
            vecs[i].y -= mat.vecs[i].y;
            vecs[i].z -= mat.vecs[i].z;
            vecs[i].w -= mat.vecs[i].w;
        }
		return this;
	}

    /**
     * Multiplies this matrix by another matrix.
     *
     * @param mat The matrix to multiply.
     */
	public inline function multiply(mat:BaseMatrix4x4):BaseMatrix4x4 {
        // my god i hate these 16 liners
        vecs[0].x = vecs[0].x * mat.vecs[0].x + vecs[0].x * mat.vecs[0].y + vecs[0].x * mat.vecs[0].z + vecs[0].x * mat.vecs[0].w;
        vecs[1].x = vecs[1].x * mat.vecs[0].x + vecs[1].x * mat.vecs[0].y + vecs[1].x * mat.vecs[0].z + vecs[1].x * mat.vecs[0].w;
        vecs[2].x = vecs[2].x * mat.vecs[0].x + vecs[2].x * mat.vecs[0].y + vecs[2].x * mat.vecs[0].z + vecs[2].x * mat.vecs[0].w;
        vecs[3].x = vecs[3].x * mat.vecs[0].x + vecs[3].x * mat.vecs[0].y + vecs[3].x * mat.vecs[0].z + vecs[3].x * mat.vecs[0].w;
        vecs[0].y = vecs[0].y * mat.vecs[1].x + vecs[0].y * mat.vecs[1].y + vecs[0].y * mat.vecs[1].z + vecs[0].y * mat.vecs[1].w;
        vecs[1].y = vecs[1].y * mat.vecs[1].x + vecs[1].y * mat.vecs[1].y + vecs[1].y * mat.vecs[1].z + vecs[1].y * mat.vecs[1].w;
        vecs[2].y = vecs[2].y * mat.vecs[1].x + vecs[2].y * mat.vecs[1].y + vecs[2].y * mat.vecs[1].z + vecs[2].y * mat.vecs[1].w;
        vecs[3].y = vecs[3].y * mat.vecs[1].x + vecs[3].y * mat.vecs[1].y + vecs[3].y * mat.vecs[1].z + vecs[3].y * mat.vecs[1].w;
        vecs[0].z = vecs[0].z * mat.vecs[2].x + vecs[0].z * mat.vecs[2].y + vecs[0].z * mat.vecs[2].z + vecs[0].z * mat.vecs[2].w;
        vecs[1].z = vecs[1].z * mat.vecs[2].x + vecs[1].z * mat.vecs[2].y + vecs[1].z * mat.vecs[2].z + vecs[1].z * mat.vecs[2].w;
        vecs[2].z = vecs[2].z * mat.vecs[2].x + vecs[2].z * mat.vecs[2].y + vecs[2].z * mat.vecs[2].z + vecs[2].z * mat.vecs[2].w;
        vecs[3].z = vecs[3].z * mat.vecs[2].x + vecs[3].z * mat.vecs[2].y + vecs[3].z * mat.vecs[2].z + vecs[3].z * mat.vecs[2].w;
        vecs[0].w = vecs[0].w * mat.vecs[3].x + vecs[0].w * mat.vecs[3].y + vecs[0].w * mat.vecs[3].z + vecs[0].w * mat.vecs[3].w;
        vecs[1].w = vecs[1].w * mat.vecs[3].x + vecs[1].w * mat.vecs[3].y + vecs[1].w * mat.vecs[3].z + vecs[1].w * mat.vecs[3].w;
        vecs[2].w = vecs[2].w * mat.vecs[3].x + vecs[2].w * mat.vecs[3].y + vecs[2].w * mat.vecs[3].z + vecs[2].w * mat.vecs[3].w;
        vecs[3].w = vecs[3].w * mat.vecs[3].x + vecs[3].w * mat.vecs[3].y + vecs[3].w * mat.vecs[3].z + vecs[3].w * mat.vecs[3].w;

		return this;
	}

    /**
     * Adds a scalar value from a Vector3 to each element of the matrix.
     *
     * @param add The scalar vector to add.
     */
    public function scale(scalar:Vector3):Matrix4x4 {
		vecs[0] *= scalar.x;
		vecs[1] *= scalar.y;
	    vecs[2] *= scalar.z;
		return this;
	}

    /**
     * Divides this matrix by another matrix element-wise.
     *
     * @param mat The matrix to divide by.
     */
	public inline function divide(mat:BaseMatrix4x4):BaseMatrix4x4 {
		for (i in 0...4) {
			vecs[i].x /= mat.vecs[i].x;
            vecs[i].y /= mat.vecs[i].y;
            vecs[i].z /= mat.vecs[i].z;
            vecs[i].w /= mat.vecs[i].w;
        }
		return this;
	}

    /**
     * Adds a scalar value to each element of the matrix.
     *
     * @param add The scalar value to add.
     */
	public inline function addFloat(add:Float):BaseMatrix4x4 {
		for (i in 0...4) {
			vecs[i].x += add;
            vecs[i].y += add;
            vecs[i].z += add;
            vecs[i].w += add;
        }
		return this;
	}

    /**
     * Subtracts a scalar value from each element of the matrix.
     *
     * @param sub The scalar value to subtract.
     */
	public inline function subtractFloat(sub:Float):BaseMatrix4x4 {
		for (i in 0...4) {
			vecs[i].x -= sub;
            vecs[i].y -= sub;
            vecs[i].z -= sub;
            vecs[i].w -= sub;
        }
		return this;
	}

    /**
     * Multiplies each element of the matrix by a scalar value.
     *
     * @param mult The scalar value to multiply.
     */
	public inline function multiplyFloat(mult:Float):BaseMatrix4x4 {
		for (i in 0...4) {
			vecs[i].x *= mult;
            vecs[i].y *= mult;
            vecs[i].z *= mult;
            vecs[i].w *= mult;
        }
		return this;
	}

    /**
     * Divides each element of the matrix by a scalar value.
     *
     * @param div The scalar value to divide by.
     */
	public inline function divideFloat(div:Float):BaseMatrix4x4 {
		for (i in 0...4) {
			vecs[i].x /= div;
            vecs[i].y /= div;
            vecs[i].z /= div;
            vecs[i].w /= div;
        }
		return this;
	}

    public function toString():String {
        return '(${vecs[0]}, ${vecs[1]}, ${vecs[2]}, ${vecs[3]})';
    }
}
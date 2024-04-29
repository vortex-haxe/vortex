package vortex.utilities.typelimit;

/**
 * Useful to limit a Dynamic function argument's type to the specified
 * type parameters. This does NOT make the use of Dynamic type-safe in
 * any way (the underlying type is still Dynamic and Std.is() checks +
 * casts are necessary).
 */
@:transitive
abstract OneOfTwo<T1, T2>(Dynamic) from T1 to T1 from T2 to T2 {}
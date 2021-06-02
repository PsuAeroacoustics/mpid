module mpid.datatype;

import mpid.dversion;
import mpid.include;
import mpid.nogcassert;

import std.string;
import std.traits;

static if(have_mpi) {
	alias Datatype = MPI_Datatype;
} else {
	struct Datatype {}

	public Datatype MPI_INT32_T;
	public Datatype MPI_UINT32_T;
	public Datatype MPI_INT64_T;
	public Datatype MPI_UINT64_T;
	public Datatype MPI_FLOAT;
	public Datatype MPI_DOUBLE;
	public Datatype MPI_CHAR;
}

private __gshared Datatype[string] custom_data_types;
private void delegate()[] mpi_type_registers;

static if(have_mpi) package void init_data_types() {
	foreach(ref mpi_type_register; mpi_type_registers) {
		mpi_type_register();
	}
}

static if(have_mpi) @nogc package void deinit_data_types() {
	foreach(custom_data_type; custom_data_types.byValue) {
		MPI_Type_free(&custom_data_type);
	}
}

import std.conv;
/++
 +	Registers a specified type with MPI so it can know how
 +	properly serialize it. Its a no-op for int,uint,long,
 +	ulong,float,double, and char.
 +/
@nogc private auto register_mpi_type(T)() {
	struct Registrar {
		// This static constructor will be run before main, and does
		// not need to adhear to @nogc. It registers a delegate that
		// creates the custom MPI data type. The delegates are called
		// by init after MPI_Init is called.
		static if(have_mpi) static this() {

			enum bool is_custom_type =
				!is(T: int) &&
				!is(T: uint) &&
				!is(T: long) &&
				!is(T: ulong) &&
				!is(T: float) &&
				!is(T: double) &&
				!is(T: char);

			static if(is_custom_type) {
				void delegate() new_delegate = () {
					enum key = fullyQualifiedName!T;
					auto custom_type = (key in custom_data_types); 
					if(custom_type is null) {
						immutable T inst;

						ptrdiff_t[] offsets;
						Datatype[] data_types;
						int[] blocklengths;

						foreach(uint i, member; FieldNameTuple!T) {
							static assert(!isDynamicArray!(Fields!T[i]), "Dynamic arrays not supported");
							static if(isArray!(Fields!T[i])) {
								static if(member == "") {
									mixin("blocklengths ~= inst.length;");
									mixin("data_types ~= to_mpi_type!("~ForeachType!(Fields!T[i]).stringof~");");
									mixin("offsets ~= cast(uint)(cast(void*)&inst[0] - cast(void*)&inst);");
								} else {
									alias Type = ForeachType!(Fields!T[i]);
									static if(isStaticArray!Type) {
										mixin("blocklengths ~= inst."~member~".length * inst."~member~"[0].length;");
										mixin("data_types ~= to_mpi_type!(ForeachType!Type);");
										mixin("offsets ~= cast(uint)(cast(void*)&inst."~member~"[0] - cast(void*)&inst);");
									} else {
										mixin("blocklengths ~= inst."~member~".length;");
										mixin("data_types ~= to_mpi_type!(Type);");
										mixin("offsets ~= cast(uint)(cast(void*)&inst."~member~"[0] - cast(void*)&inst);");
									}
									
								}
							} else {
								mixin("data_types ~= to_mpi_type!(Fields!T[i]);");
								blocklengths ~= 1;
								mixin("offsets ~= cast(uint)(cast(void*)&inst."~member~" - cast(void*)&inst);");
							}
						}

						register_custom_type!T(blocklengths, offsets, data_types);
					}
				};

				// We insert at the front so that any types that are embedded in
				// other types will be registered first.
				mpi_type_registers = new_delegate ~ mpi_type_registers;
			}
		}
	}

	return cast(void)Registrar();
}

/++
 +/
void register_custom_type(TypeID)(int[] block_lengths, ptrdiff_t[] offsets, Datatype[] data_types) {
	enum key = fullyQualifiedName!TypeID;
	auto new_datatype = create_struct(block_lengths, offsets, data_types);
	new_datatype.commit;
	custom_data_types[key] = new_datatype;
}

/++
 +/
@nogc Datatype to_mpi_type(_T, bool auto_register = true)() {
	static if(have_mpi) {
		alias T =  OriginalType!(Unqual!_T);
		static if(auto_register) register_mpi_type!T;
		static if(!is(T == char)) {
			static if(is(T == int) && !is(T == uint)) {
				return MPI_INT32_T;
			} else static if(is(T == uint)) {
				return MPI_UINT32_T;
			} else static if(is(T == long) && !is(T == ulong)) {
				return MPI_INT64_T;
			} else static if(is(T == ulong)) {
				return MPI_UINT64_T;
			} else static if(is(T == float) && !is(T == double)) {
				return MPI_FLOAT;
			} else static if(is(T == double)) {
				return MPI_DOUBLE;
			} else {
				enum key = fullyQualifiedName!T;
				auto custom_type = (key in custom_data_types); 
				assert(custom_type != null, "custom mpi type was null, register_mpi_type must not have been called");
				return *custom_type;
			}
		} else {
			return MPI_CHAR;
		}
	} else {
		return Datatype();
	}
}

@nogc Datatype create_struct(int[] block_lengths, ptrdiff_t[] offsets, Datatype[] data_types) {
	Datatype new_datatype;
	static if(have_mpi) {
		immutable ret = MPI_Type_create_struct(cast(int)block_lengths.length, block_lengths.ptr, offsets.ptr, data_types.ptr, &new_datatype);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Type_create_struct failed", ret);
	}
	return new_datatype;
}

@nogc auto commit(Datatype datatype) {
	static if(have_mpi) {
		immutable ret = MPI_Type_commit(&datatype);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Type_commit failed", ret);
		return ret;
	} else {
		return 0;
	}
}

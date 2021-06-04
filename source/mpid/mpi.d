module mpid.mpi;

import mpid.comm;
import mpid.datatype;
import mpid.dversion;
import mpid.include;
import mpid.nogcassert;

import std.algorithm : map;
import std.array : array;
import std.conv : to;
import std.exception : enforce;
import std.string : toStringz;

static if(!have_mpi) {
	enum MPI_ANY_SOURCE = -1;

	alias MPI_Offset = long;
	
	import std.datetime.stopwatch;
	private static StopWatch sw;
	static this()
	{
		sw.reset;
		sw.start;
	}

	struct MPI_File {}
	struct MPI_Info {}
}

private auto to_argv(string[] args) {
	auto argv = args.map!(arg => arg.toStringz).array;
	return cast(char**)argv.ptr;
}

/++
 +/
void mpi_init(string[] args, bool init_types = true) {
	static if(have_mpi) {
		int argc = cast(int)args.length;
		auto argv = args.to_argv;
		MPI_Init(&argc, &argv);

		if(init_types) init_data_types;
	}
}

/++
 +/
int mpi_init_thread(string[] args, int required, bool init_types = true) {
	static if(have_mpi) {
		int argc = cast(int)args.length;
		auto argv = args.to_argv;
		int provided;
		MPI_Init_thread(&argc, &argv, required, &provided);

		if(init_types) init_data_types;

		return provided;
	} else {
		return 0;
	}
}

/++
 +/
void mpi_init_data_types() {
	static if(have_mpi) {
		init_data_types;
	}
}

/++
 +/
@nogc double mpi_wtime() {
	static if(have_mpi) {
		return MPI_Wtime();
	} else {
		return sw.peek.total!"msecs"/1000.0;
	}
}

/++
 +/
int mpi_shutdown() {
	static if(have_mpi) {
		pragma(msg, "have mpi");
		
		deinit_data_types;

		return MPI_Finalize();
	} else {
		pragma(msg, "no mpi");
		return 0;
	}
}

/++
 +/
auto mpi_alloc_mem(T)(size_t num_elements, Info info = MPI_INFO_NULL) {
	static if(have_mpi) {
		T* mem_ptr;
		immutable ret = MPI_Alloc_mem(num_elements*T.sizeof, info, &mem_ptr);
		enforce(ret == MPI_SUCCESS, "MPI_Alloc_mem failed "~ret.to!string);
		return cast(T[])mem_ptr[0..num_elements];
	} else {
		return new T[num_elements];
	}
}

module mpid.comm;

//import albm.logging;
import mpid.datatype;
import mpid.dversion;
import mpid.group;
import mpid.include;
import mpid.nogcassert;

import std.array;
import std.conv;
import std.traits;

static if(have_mpi) {
	struct Comm {
		MPI_Comm comm;
		alias comm this;
	}

	alias Info = MPI_Info;
	alias Op = MPI_Op;
	alias Request = MPI_Request;
	alias Status = MPI_Status;
} else {
	struct Info {}
	struct Comm {}
	struct Op {}
	struct Request {}
	struct Status {
		int MPI_SOURCE;
        int MPI_TAG;
        int MPI_ERROR;
	}

	public Comm MPI_COMM_WORLD;
	public Comm MPI_COMM_SELF;
	
	public Op MPI_MIN;
	public Op MPI_MAX;
	public Op MPI_SUM;

	public Info MPI_INFO_NULL;

	public int MPI_COMM_TYPE_SHARED = 0;
}


/++
 +/
__gshared Comm world_comm;
static this() {
	static if(have_mpi) {
		world_comm = Comm(MPI_COMM_WORLD);
	}
}

/++
 +/
@nogc void abort(Comm communicator, int reason) {
	static if(have_mpi) {
		MPI_Abort(communicator, reason);
	}
}

/++
 +/
@nogc auto create(Comm parent_comm, Group group) {
	Comm new_comm;
	static if(have_mpi) {
		immutable ret = MPI_Comm_create(parent_comm, group, &new_comm.comm);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Comm_create failed", ret);
	}
	return new_comm;
}

/++
 +/
@nogc auto create_group(Comm parent_comm, Group group, int tag) {
	Comm new_comm;
	static if(have_mpi) {
		immutable ret = MPI_Comm_create_group(parent_comm, group, tag, &new_comm.comm);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Comm_create_group failed", ret);
	}
	return new_comm;
}

/++
 +/
@nogc auto split_type(Comm communicator, int type, int key, Info info) {
	Comm new_comm;
	static if(have_mpi) {
		immutable ret = MPI_Comm_split_type(communicator, type, key, info, &new_comm.comm);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Comm_split_type failed", ret);
	}
	return new_comm;
}

/++
 +/
@nogc auto rank(Comm communicator) {
	int rank;
	static if(have_mpi) {
		immutable ret = MPI_Comm_rank(communicator, &rank);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Comm_rank failed", ret);
	}
	return rank;
}

/++
 +/
@nogc int size(Comm communicator) {
	static if(have_mpi) {
		int p;
		MPI_Comm_size(communicator, &p);
		return p;
	} else {
		return 1;
	}
}

/++
 +/
@nogc auto group(Comm communicator) {
	Group group;
	static if(have_mpi) {
		immutable ret = MPI_Comm_group(communicator, &group.group);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Comm_group failed", ret);
	}
	return group;
}

/++
 +/
auto cartesian_create(Comm comm_old, const int[] dims, const bool[] periodic, bool reorder) {
	Comm new_comm;
	static if(have_mpi) {
		import std.algorithm : map;
		import std.array : array;

		auto int_periodic = periodic.map!(a => cast(int)a).array;

		immutable ret = MPI_Cart_create(comm_old, cast(int)dims.length, dims.ptr, int_periodic.ptr, cast(int)reorder, &new_comm.comm);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Cart_create failed", ret);
	}
	return new_comm;
}

/++
 +/
void name(Comm communicator, string name) {
	static if(have_mpi) {
		import std.string : toStringz;
		int ret = MPI_Comm_set_name(communicator, name.toStringz);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Comm_set_name failed", ret);
	}
}

/++
 +/
string name(Comm communicator) {
	static if(have_mpi) {
		char[64] name_buff;
		int name_len;
		int ret = MPI_Comm_get_name(communicator, name_buff.ptr, &name_len);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Comm_get_name failed", ret);
		return name_buff[0..name_len].to!string;
	} else {
		return "";
	}
}

/++
 +/
@nogc void barrier(Comm communicator) {
	static if(have_mpi) {
		immutable ret = MPI_Barrier(communicator);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Barrier failed", ret);
	}
}

/++
 +/
@nogc void send_init(T, bool auto_register = true)(Comm communicator, ref T buffer, int to, int tag, ref Request request) {
	static if(have_mpi) {
		static if(isArray!T) {
			immutable ret = MPI_Send_init(buffer.ptr, cast(int)buffer.length, to_mpi_type!(ForeachType!T, auto_register), to, tag, communicator, &request);
		} else {
			immutable ret = MPI_Send_init(buffer.ptr, 1, to_mpi_type!(T, auto_register), to, tag, communicator, &request);
		}
		nogc_assert(ret == MPI_SUCCESS, "MPI_Send_init failed", ret);
	}
}

@nogc void alltoall(T)(Comm communicator, ref T[] send_buff, ref T[] recv_buff, int size) {
	static if(have_mpi) {
		immutable ret = MPI_Alltoall(send_buff.ptr, size, to_mpi_type!T, recv_buff.ptr, size, to_mpi_type!T, communicator);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Alltoall failed", ret);
	}
}

/++
 +/
@nogc void start_all(Request[] requests) {
	static if(have_mpi) {
		if(requests.length > 0) {
			immutable ret = MPI_Startall(cast(int)requests.length, requests.ptr);
			nogc_assert(ret == MPI_SUCCESS, "MPI_Startall failed", ret);
		}
	}
}

/++
 +/
@nogc void wait_all(Request[] requests, Status[] statuses) {
	static if(have_mpi) {
		if(requests.length > 0) {
			immutable ret = MPI_Waitall(cast(int)requests.length, requests.ptr, statuses.ptr);
			nogc_assert(ret == MPI_SUCCESS, "MPI_Waitall failed", ret);
		}
	}
}

@nogc void wait(ref Request request, ref Status status) {
	static if(have_mpi) {
		immutable ret = MPI_Wait(&request, &status);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Wait failed", ret);
	}
}

/++
 +/
@nogc void all_reduce(T)(Comm communicator, T send, ref T recv, Op op)
	if(is(T: double) || is(T: uint) || is(T: int))
{
	static if(have_mpi) {
		static if(is(T: double)) {
			Datatype type = MPI_DOUBLE;
		} else static if(is(T: uint)) {
			Datatype type = MPI_UINT32_T;
		} else static if(is(T: int)) {
			Datatype type = MPI_INT32_T;
		}

		immutable ret = MPI_Allreduce(&send, &recv, 1, type, op, communicator);
		nogc_assert(ret == MPI_SUCCESS, "MPI_AllReduce failed", ret);
	}
}

/++
 +/
@nogc void reduce(T)(Comm communicator, T[] send, T[] recv, Op op, int root)
	if(is(T: double) || is(T: uint) || is(T: int))
{
	static if(have_mpi) {
		static if(is(T: double)) {
			Datatype type = MPI_DOUBLE;
		} else static if(is(T: uint)) {
			Datatype type = MPI_UINT32_T;
		} else static if(is(T: int)) {
			Datatype type = MPI_INT32_T;
		}

		immutable ret = MPI_Reduce(send.ptr, recv.ptr, cast(int)send.length, type, op, root, communicator);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Reduce failed", ret);
	}
}

/++
 +/
@nogc void recv_init(T, bool auto_register = true)(Comm communicator, ref T buffer, int from, int tag, ref Request request) {
	static if(have_mpi) {
		static if(isArray!T) {
			immutable ret = MPI_Recv_init(buffer.ptr, cast(int)buffer.length, to_mpi_type!(ForeachType!T, auto_register), from, tag, communicator, &request);
		} else {
			immutable ret = MPI_Recv_init(buffer.ptr, 1, to_mpi_type!(T, auto_register), from, tag, communicator, &request);
		}
		nogc_assert(ret == MPI_SUCCESS, "MPI_Recv_init failed", ret);
	}
}

/++
 +/
@nogc void send(T)(Comm communicator, auto ref T data, uint proc, int tag)
	if(!isDynamicArray!T && !isArray!T)
{
	static if(have_mpi) {
		immutable ret = MPI_Send(&data, 1, to_mpi_type!T, proc, tag, communicator);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Send failed", ret);
	}
}

/++
 +/
@nogc void send(T)(Comm communicator, auto ref T data, uint proc, int tag) if(isArray!T) {
	static if(have_mpi) {
		immutable ret = MPI_Send(data.ptr, cast(uint)data.length, to_mpi_type!(ForeachType!T), proc, tag, communicator);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Send failed", ret);
	}
}

/++
 +/
@nogc void bcast(T)(Comm communicator, ref T data, uint root)
	if(!isDynamicArray!T)
{
	static if(have_mpi) {
		immutable ret = MPI_Bcast(&data, 1, to_mpi_type!T, root, communicator);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Send failed", ret);
	}
}

/++
 +/
@nogc void recv(T)(Comm communicator, auto ref T[] data, uint from, int tag) {
	static if(have_mpi) {
		Status status;
		immutable ret = MPI_Recv(data.ptr, cast(int)data.length, to_mpi_type!T, from, tag, communicator, &status);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Recv failed", ret);
	}
}

/++
 +/
@nogc T recv(T)(Comm communicator, uint from, int tag)
	if(!isDynamicArray!T)
{
	static if(have_mpi) {
		T data;
		Status status;
		immutable ret = MPI_Recv(&data, 1, to_mpi_type!T, from, tag, communicator, &status);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Recv failed", ret);
		return data;
	} else {
		auto t = T.init;
		return t;
	}
}

/++
 +/
@nogc Request irecv(T)(Comm communicator, T[] data, uint from, uint tag) {
	Request request;
	static if(have_mpi) {
		immutable ret = MPI_Irecv(data.ptr, cast(int)data.length, to_mpi_type!T, from, tag, communicator, &request);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Irecv failed", ret);
	}
	return request;
}

/++
 +/
@nogc Request irecv(T)(Comm communicator, ref T data, uint from, uint tag) if(!isArray!T) {
	Request request;
	static if(have_mpi) {
		immutable ret = MPI_Irecv(&data, 1, to_mpi_type!T, from, tag, communicator, &request);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Irecv failed", ret);
	}
	return request;
}

/++
 +/
@nogc void probe(Comm communicator, int source, int tag, ref Status status) {
	static if(have_mpi) {
		immutable ret = MPI_Probe(source, tag, communicator, &status);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Probe failed", ret);
	}
}

/++
 +/
@nogc void send_array(T)(Comm communicator, T[] data, uint proc, int tag) {
	static if(have_mpi) {
		uint len = cast(uint)data.length;
		immutable ret_len = MPI_Send(&len, 1, MPI_UINT32_T, proc, tag, communicator);
		nogc_assert(ret_len == MPI_SUCCESS, "MPI_Send failed sending array length", ret_len);
		immutable ret_data = MPI_Send(data.ptr, cast(uint)data.length, to_mpi_type!T, proc, tag + 1, communicator);
		nogc_assert(ret_data == MPI_SUCCESS, "MPI_Send failed sending array data", ret_data);
	}
}

/++
 +/
T[] recv_array(T)(Comm communicator, uint from, const int tag) {
	static if(have_mpi) {
		uint nElems;
		T[] data;

		Status status;
		immutable ret_len = MPI_Recv(&nElems, 1, MPI_UINT32_T, from, tag, communicator, &status);
		nogc_assert(ret_len == MPI_SUCCESS, "MPI_Recv failed getting array length", ret_len);
		//dbgln!2("Recv'd array len: ", nElems);
		data = new T[nElems];
		
		assert(status.MPI_ERROR == MPI_SUCCESS, "Error receiving array length. MPI Error: "~status.MPI_ERROR.to!string);
		
		immutable ret_data = MPI_Recv(data.ptr, nElems, to_mpi_type!T, from, tag + 1, communicator, &status);
		nogc_assert(ret_data == MPI_SUCCESS, "MPI_Recv failed getting array data", ret_data);

		return data;
	} else {
		T[] t;
		return t;
	}
}

T[] send_recv_array(T)(Comm communicator, T[] data, uint to, uint from, const int tag) {
	static if(have_mpi) {
		T[] recv_data;
		uint send_length = data.length.to!uint;
		uint recv_length;
		Status status;
		immutable ret_len = MPI_Sendrecv(&send_length, 1, MPI_UINT32_T, to, tag, &recv_length, 1, MPI_UINT32_T, from, tag, communicator, &status);
		nogc_assert(ret_len == MPI_SUCCESS, "MPI_Sendrecv failed getting array length", ret_len);
		//dbgln!2("Recv'd array len: ", recv_length);
		recv_data = new T[recv_length];
		
		assert(status.MPI_ERROR == MPI_SUCCESS, "Error receiving array length. MPI Error: "~status.MPI_ERROR.to!string);

		immutable ret_data = MPI_Sendrecv(data.ptr, data.length.to!uint, to_mpi_type!T, to, tag, recv_data.ptr, recv_data.length.to!uint, to_mpi_type!T, from, tag, communicator, &status);
		nogc_assert(ret_data == MPI_SUCCESS, "MPI_Recv failed getting array data", ret_data);

		return recv_data;

	} else {
		T[] t;
		return t;
	}
}

/++
 +/
@nogc auto isend_array(T)(Comm communicator, T[] data, uint proc, int tag) {
	static if(have_mpi) {
		Request request;
		uint len = cast(uint)data.length;
		immutable ret_len = MPI_Isend(&len, 1, MPI_UINT32_T, proc, tag, communicator, &request);
		nogc_assert(ret_len == MPI_SUCCESS, "MPI_Send failed sending array length", ret_len);
		immutable ret_data = MPI_Isend(data.ptr, cast(uint)data.length, to_mpi_type!T, proc, tag + 1, communicator, &request);
		nogc_assert(ret_data == MPI_SUCCESS, "MPI_Send failed sending array data", ret_data);
		return request;
	}
}

/++
 +/
auto bsend_array(T)(Comm communicator, T[] data, uint proc, int tag) {
	static if(have_mpi) {
		import std.conv : to;
		int buff_size = (uint.sizeof + data.length*T.sizeof + MPI_BSEND_OVERHEAD).to!int;
		auto buff = new byte[buff_size];
		MPI_Buffer_attach(cast(void*)buff.ptr, buff_size);
		
		uint len = cast(uint)data.length;
		
		immutable ret_len = MPI_Bsend(&len, 1, MPI_UINT32_T, proc, tag, communicator);
		nogc_assert(ret_len == MPI_SUCCESS, "MPI_Send failed sending array length", ret_len);
		
		immutable ret_data = MPI_Bsend(data.ptr, cast(uint)data.length, to_mpi_type!T, proc, tag + 1, communicator);
		nogc_assert(ret_data == MPI_SUCCESS, "MPI_Send failed sending array data", ret_data);
	}
}

/++
 
T[] brecv_array(T)(Comm communicator, uint from, const int tag) {
	static if(have_mpi) {
		uint nElems;
		T[] data;

		Status status;
		immutable ret_len = MPI_Recv(&nElems, 1, MPI_UINT32_T, from, tag, communicator, &status);
		nogc_assert(ret_len == MPI_SUCCESS, "MPI_Recv failed getting array length", ret_len);

		data = new T[nElems];
		
		assert(status.MPI_ERROR == MPI_SUCCESS, "Error receiving array length. MPI Error: "~status.MPI_ERROR.to!string);
		
		immutable ret_data = MPI_Recv(data.ptr, nElems, to_mpi_type!T, 0, tag + 1, communicator, &status);
		nogc_assert(ret_data == MPI_SUCCESS, "MPI_Recv failed getting array data", ret_data);

		return data;
	} else {
		T[] t;
		return t;
	}
}
+/

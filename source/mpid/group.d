module mpid.group;

import mpid.dversion;
import mpid.include;
import mpid.nogcassert;

static if(have_mpi) {
	struct Group {
		MPI_Group group;
		alias group this;
	}
} else {
	struct Group {}
}

/++
 +/
@nogc auto include(Group group, const int[] ranks) {
	Group new_group;
	static if(have_mpi) {
		immutable ret = MPI_Group_incl(group, cast(int)ranks.length, ranks.ptr, &new_group.group);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Group_incl failed", ret);
	}
	return new_group;
}

/++
 +/
@nogc auto rank(Group group) {
	int rank;
	static if(have_mpi) {
		immutable ret = MPI_Group_rank(group, &rank);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Group_rank failed", ret);
	}
	return rank;
}

/++
 +/
@nogc auto size(Group group) {
	int size;
	static if(have_mpi) {
		immutable ret = MPI_Group_size(group, &size);
		nogc_assert(ret == MPI_SUCCESS, "MPI_Group_size failed", ret);
	}
	return size;
}

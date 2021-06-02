module mpid.dversion;

/++
 +/
bool have_mpi() {
	version(openmpi) {
		return true;
	} else version(mpich) {
		return true;
	} else version(impi) {
		return true;
	} else {
		return false;
	}
}

module mpid.include;

version(openmpi) {
	public import mpid.openmpi.include;
} else version(mpich) {
	public import mpid.mpich.include;
} else version(impi) {
	// intel mpi is abi compatible with mpich as of impi v5 and mpich v3.1
	public import mpid.mpich.include;
}

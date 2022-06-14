project('mpid', ['c', 'd'])

sources = [
	'./source/mpid/comm.d',
	'./source/mpid/datatype.d',
	'./source/mpid/dversion.d',
	'./source/mpid/group.d',
	'./source/mpid/include.d',
	'./source/mpid/mpi.d',
	'./source/mpid/nogcassert.d',
	'./source/mpid/package.d'
]

mpid_incdir = include_directories('source')

mpi_dep = dependency('impi')

mpi_d_version = ''

if mpi_dep.type_name() == 'pkgconfig'
	if (mpi_dep.name() == 'ompi-c') or (mpi_dep.name() == 'ompi') or (mpi_dep.name() == 'ompi-cxx') or (mpi_dep.name() == 'ompi-fort') or (mpi_dep.name() == 'mpi-c') or (mpi_dep.name() == 'mpi') or (mpi_dep.name() == 'mpi-cxx') or (mpi_dep.name() == 'mpi-fort')
		
		mpi_d_version = 'openmpi'
		sources += './source/mpid/openmpi/include.d'
		message('Setting D version to ompenmpi')

	elif (mpi_dep.name() == 'mpich') or (mpi_dep.name() == 'impi')
		
		sources += './source/mpid/mpich/include.d'
		
		if mpi_dep.name() == 'mpich'
			mpi_d_version = 'mpich'
			message('Setting D version to mpich')
		elif mpi_dep.name() == 'impi'
			mpi_d_version = 'impi'
			message('Setting D version to impi')
		endif
	endif
endif

if get_option('native')
	add_global_arguments('-mcpu=native', language: ['c', 'd'])
endif

if get_option('avx512')
	assert(meson.get_compiler('d').get_id() == 'llvm', 'The LLVM D Compiler (LDC) is required for avx512 support')
	add_global_arguments('-mattr=-prefer-256-bit,+prefer-mask-registers', language: ['c', 'd'])
endif

mpid_lib = static_library('mpid', sources, dependencies: mpi_dep, include_directories: mpid_incdir, d_module_versions: mpi_d_version)

mpid_dep = declare_dependency(link_with: mpid_lib, include_directories: mpid_incdir)

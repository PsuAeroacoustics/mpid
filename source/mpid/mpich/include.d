module mpid.mpich.include;

version(impi) {
    version = mpich;
}

version(mpich) {
        import core.stdc.config;
        import core.stdc.stdarg: va_list;
        static import core.simd;
        static import std.conv;

        struct Int128 { long lower; long upper; }
        struct UInt128 { ulong lower; ulong upper; }

        struct __locale_data { int dummy; }



alias _Bool = bool;
struct dpp {
    static struct Opaque(int N) {
        void[N] bytes;
    }

    static bool isEmpty(T)() {
        return T.tupleof.length == 0;
    }
    static struct Move(T) {
        T* ptr;
    }


    static auto move(T)(ref T value) {
        return Move!T(&value);
    }
    mixin template EnumD(string name, T, string prefix) if(is(T == enum)) {
        private static string _memberMixinStr(string member) {
            import std.conv: text;
            import std.array: replace;
            return text(` `, member.replace(prefix, ""), ` = `, T.stringof, `.`, member, `,`);
        }
        private static string _enumMixinStr() {
            import std.array: join;
            string[] ret;
            ret ~= "enum " ~ name ~ "{";
            static foreach(member; __traits(allMembers, T)) {
                ret ~= _memberMixinStr(member);
            }
            ret ~= "}";
            return ret.join("\n");
        }
        mixin(_enumMixinStr());
    }
}

extern(C)
{
    int PMPI_File_c2f(ADIOI_FileD*) @nogc nothrow;
    ADIOI_FileD* PMPI_File_f2c(int) @nogc nothrow;
    int PMPI_File_iwrite_all(ADIOI_FileD*, const(void)*, int, int, int*) @nogc nothrow;
    int PMPI_File_iread_all(ADIOI_FileD*, void*, int, int, int*) @nogc nothrow;
    int PMPI_File_iwrite_at_all(ADIOI_FileD*, long, const(void)*, int, int, int*) @nogc nothrow;
    int PMPI_File_iread_at_all(ADIOI_FileD*, long, void*, int, int, int*) @nogc nothrow;
    int PMPI_File_sync(ADIOI_FileD*) @nogc nothrow;
    int PMPI_File_get_atomicity(ADIOI_FileD*, int*) @nogc nothrow;
    int PMPI_File_set_atomicity(ADIOI_FileD*, int) @nogc nothrow;
    int PMPI_Register_datarep(const(char)*, int function(void*, int, int, void*, long, void*), int function(void*, int, int, void*, long, void*), int function(int, c_long*, void*), void*) @nogc nothrow;
    int PMPI_File_get_type_extent(ADIOI_FileD*, int, c_long*) @nogc nothrow;
    int PMPI_File_write_ordered_end(ADIOI_FileD*, const(void)*, MPI_Status*) @nogc nothrow;
    int PMPI_File_write_ordered_begin(ADIOI_FileD*, const(void)*, int, int) @nogc nothrow;
    int PMPI_File_read_ordered_end(ADIOI_FileD*, void*, MPI_Status*) @nogc nothrow;
    int PMPI_File_read_ordered_begin(ADIOI_FileD*, void*, int, int) @nogc nothrow;
    int PMPI_File_write_all_end(ADIOI_FileD*, const(void)*, MPI_Status*) @nogc nothrow;
    int PMPI_File_write_all_begin(ADIOI_FileD*, const(void)*, int, int) @nogc nothrow;
    int PMPI_File_read_all_end(ADIOI_FileD*, void*, MPI_Status*) @nogc nothrow;
    int PMPI_File_read_all_begin(ADIOI_FileD*, void*, int, int) @nogc nothrow;
    int PMPI_File_write_at_all_end(ADIOI_FileD*, const(void)*, MPI_Status*) @nogc nothrow;
    int PMPI_File_write_at_all_begin(ADIOI_FileD*, long, const(void)*, int, int) @nogc nothrow;
    int PMPI_File_read_at_all_end(ADIOI_FileD*, void*, MPI_Status*) @nogc nothrow;
    int PMPI_File_read_at_all_begin(ADIOI_FileD*, long, void*, int, int) @nogc nothrow;
    int PMPI_File_get_position_shared(ADIOI_FileD*, long*) @nogc nothrow;
    int PMPI_File_seek_shared(ADIOI_FileD*, long, int) @nogc nothrow;
    int PMPI_File_write_ordered(ADIOI_FileD*, const(void)*, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_File_read_ordered(ADIOI_FileD*, void*, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_File_iwrite_shared(ADIOI_FileD*, const(void)*, int, int, int*) @nogc nothrow;
    int PMPI_File_iread_shared(ADIOI_FileD*, void*, int, int, int*) @nogc nothrow;
    int PMPI_File_write_shared(ADIOI_FileD*, const(void)*, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_File_read_shared(ADIOI_FileD*, void*, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_File_get_byte_offset(ADIOI_FileD*, long, long*) @nogc nothrow;
    int PMPI_File_get_position(ADIOI_FileD*, long*) @nogc nothrow;
    int PMPI_File_seek(ADIOI_FileD*, long, int) @nogc nothrow;
    int PMPI_File_iwrite(ADIOI_FileD*, const(void)*, int, int, int*) @nogc nothrow;
    int PMPI_File_iread(ADIOI_FileD*, void*, int, int, int*) @nogc nothrow;
    int PMPI_File_write_all(ADIOI_FileD*, const(void)*, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_File_write(ADIOI_FileD*, const(void)*, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_File_read_all(ADIOI_FileD*, void*, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_File_read(ADIOI_FileD*, void*, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_File_iwrite_at(ADIOI_FileD*, long, const(void)*, int, int, int*) @nogc nothrow;
    int PMPI_File_iread_at(ADIOI_FileD*, long, void*, int, int, int*) @nogc nothrow;
    int PMPI_File_write_at_all(ADIOI_FileD*, long, const(void)*, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_File_write_at(ADIOI_FileD*, long, const(void)*, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_File_read_at_all(ADIOI_FileD*, long, void*, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_File_read_at(ADIOI_FileD*, long, void*, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_File_get_view(ADIOI_FileD*, long*, int*, int*, char*) @nogc nothrow;
    int PMPI_File_set_view(ADIOI_FileD*, long, int, int, const(char)*, int) @nogc nothrow;
    int PMPI_File_get_info(ADIOI_FileD*, int*) @nogc nothrow;
    int PMPI_File_set_info(ADIOI_FileD*, int) @nogc nothrow;
    int PMPI_File_get_amode(ADIOI_FileD*, int*) @nogc nothrow;
    int PMPI_File_get_group(ADIOI_FileD*, int*) @nogc nothrow;
    int PMPI_File_get_size(ADIOI_FileD*, long*) @nogc nothrow;
    int PMPI_File_preallocate(ADIOI_FileD*, long) @nogc nothrow;
    int PMPI_File_set_size(ADIOI_FileD*, long) @nogc nothrow;
    int PMPI_File_delete(const(char)*, int) @nogc nothrow;
    int PMPI_File_close(ADIOI_FileD**) @nogc nothrow;
    int PMPI_File_open(int, const(char)*, int, int, ADIOI_FileD**) @nogc nothrow;
    int MPI_File_c2f(ADIOI_FileD*) @nogc nothrow;
    ADIOI_FileD* MPI_File_f2c(int) @nogc nothrow;
    int MPI_File_iwrite_all(ADIOI_FileD*, const(void)*, int, int, int*) @nogc nothrow;
    int MPI_File_iread_all(ADIOI_FileD*, void*, int, int, int*) @nogc nothrow;
    int MPI_File_iwrite_at_all(ADIOI_FileD*, long, const(void)*, int, int, int*) @nogc nothrow;
    int MPI_File_iread_at_all(ADIOI_FileD*, long, void*, int, int, int*) @nogc nothrow;
    int MPI_File_sync(ADIOI_FileD*) @nogc nothrow;
    int MPI_File_get_atomicity(ADIOI_FileD*, int*) @nogc nothrow;
    int MPI_File_set_atomicity(ADIOI_FileD*, int) @nogc nothrow;
    int MPI_Register_datarep(const(char)*, int function(void*, int, int, void*, long, void*), int function(void*, int, int, void*, long, void*), int function(int, c_long*, void*), void*) @nogc nothrow;
    int MPI_File_get_type_extent(ADIOI_FileD*, int, c_long*) @nogc nothrow;
    int MPI_File_write_ordered_end(ADIOI_FileD*, const(void)*, MPI_Status*) @nogc nothrow;
    int MPI_File_write_ordered_begin(ADIOI_FileD*, const(void)*, int, int) @nogc nothrow;
    int MPI_File_read_ordered_end(ADIOI_FileD*, void*, MPI_Status*) @nogc nothrow;
    int MPI_File_read_ordered_begin(ADIOI_FileD*, void*, int, int) @nogc nothrow;
    int MPI_File_write_all_end(ADIOI_FileD*, const(void)*, MPI_Status*) @nogc nothrow;
    int MPI_File_write_all_begin(ADIOI_FileD*, const(void)*, int, int) @nogc nothrow;
    int MPI_File_read_all_end(ADIOI_FileD*, void*, MPI_Status*) @nogc nothrow;
    int MPI_File_read_all_begin(ADIOI_FileD*, void*, int, int) @nogc nothrow;
    int MPI_File_write_at_all_end(ADIOI_FileD*, const(void)*, MPI_Status*) @nogc nothrow;
    int MPI_File_write_at_all_begin(ADIOI_FileD*, long, const(void)*, int, int) @nogc nothrow;
    int MPI_File_read_at_all_end(ADIOI_FileD*, void*, MPI_Status*) @nogc nothrow;
    int MPI_File_read_at_all_begin(ADIOI_FileD*, long, void*, int, int) @nogc nothrow;
    int MPI_File_get_position_shared(ADIOI_FileD*, long*) @nogc nothrow;
    int MPI_File_seek_shared(ADIOI_FileD*, long, int) @nogc nothrow;
    int MPI_File_write_ordered(ADIOI_FileD*, const(void)*, int, int, MPI_Status*) @nogc nothrow;
    int MPI_File_read_ordered(ADIOI_FileD*, void*, int, int, MPI_Status*) @nogc nothrow;
    int MPI_File_iwrite_shared(ADIOI_FileD*, const(void)*, int, int, int*) @nogc nothrow;
    int MPI_File_iread_shared(ADIOI_FileD*, void*, int, int, int*) @nogc nothrow;
    int MPI_File_write_shared(ADIOI_FileD*, const(void)*, int, int, MPI_Status*) @nogc nothrow;
    int MPI_File_read_shared(ADIOI_FileD*, void*, int, int, MPI_Status*) @nogc nothrow;
    int MPI_File_get_byte_offset(ADIOI_FileD*, long, long*) @nogc nothrow;
    int MPI_File_get_position(ADIOI_FileD*, long*) @nogc nothrow;
    int MPI_File_seek(ADIOI_FileD*, long, int) @nogc nothrow;
    int MPI_File_iwrite(ADIOI_FileD*, const(void)*, int, int, int*) @nogc nothrow;
    int MPI_File_iread(ADIOI_FileD*, void*, int, int, int*) @nogc nothrow;
    int MPI_File_write_all(ADIOI_FileD*, const(void)*, int, int, MPI_Status*) @nogc nothrow;
    int MPI_File_write(ADIOI_FileD*, const(void)*, int, int, MPI_Status*) @nogc nothrow;
    int MPI_File_read_all(ADIOI_FileD*, void*, int, int, MPI_Status*) @nogc nothrow;
    int MPI_File_read(ADIOI_FileD*, void*, int, int, MPI_Status*) @nogc nothrow;
    int MPI_File_iwrite_at(ADIOI_FileD*, long, const(void)*, int, int, int*) @nogc nothrow;
    int MPI_File_iread_at(ADIOI_FileD*, long, void*, int, int, int*) @nogc nothrow;
    int MPI_File_write_at_all(ADIOI_FileD*, long, const(void)*, int, int, MPI_Status*) @nogc nothrow;
    int MPI_File_write_at(ADIOI_FileD*, long, const(void)*, int, int, MPI_Status*) @nogc nothrow;
    int MPI_File_read_at_all(ADIOI_FileD*, long, void*, int, int, MPI_Status*) @nogc nothrow;
    int MPI_File_read_at(ADIOI_FileD*, long, void*, int, int, MPI_Status*) @nogc nothrow;
    int MPI_File_get_view(ADIOI_FileD*, long*, int*, int*, char*) @nogc nothrow;
    int MPI_File_set_view(ADIOI_FileD*, long, int, int, const(char)*, int) @nogc nothrow;
    int MPI_File_get_info(ADIOI_FileD*, int*) @nogc nothrow;
    int MPI_File_set_info(ADIOI_FileD*, int) @nogc nothrow;
    int MPI_File_get_amode(ADIOI_FileD*, int*) @nogc nothrow;
    int MPI_File_get_group(ADIOI_FileD*, int*) @nogc nothrow;
    int MPI_File_get_size(ADIOI_FileD*, long*) @nogc nothrow;
    int MPI_File_preallocate(ADIOI_FileD*, long) @nogc nothrow;
    int MPI_File_set_size(ADIOI_FileD*, long) @nogc nothrow;
    int MPI_File_delete(const(char)*, int) @nogc nothrow;
    int MPI_File_close(ADIOI_FileD**) @nogc nothrow;
    int MPI_File_open(int, const(char)*, int, int, ADIOI_FileD**) @nogc nothrow;
    int PMPIX_Mutex_unlock(mpixi_mutex_s*, int, int) @nogc nothrow;
    int PMPIX_Mutex_lock(mpixi_mutex_s*, int, int) @nogc nothrow;
    int PMPIX_Mutex_free(mpixi_mutex_s**) @nogc nothrow;
    int PMPIX_Mutex_create(int, int, mpixi_mutex_s**) @nogc nothrow;
    alias int_least8_t = byte;
    alias int_least16_t = short;
    alias int_least32_t = int;
    alias int_least64_t = c_long;
    alias uint_least8_t = ubyte;
    alias uint_least16_t = ushort;
    alias uint_least32_t = uint;
    alias uint_least64_t = c_ulong;
    alias int_fast8_t = byte;
    alias int_fast16_t = c_long;
    alias int_fast32_t = c_long;
    alias int_fast64_t = c_long;
    alias uint_fast8_t = ubyte;
    alias uint_fast16_t = c_ulong;
    alias uint_fast32_t = c_ulong;
    alias uint_fast64_t = c_ulong;
    alias intptr_t = c_long;
    alias uintptr_t = c_ulong;
    alias intmax_t = c_long;
    alias uintmax_t = c_ulong;
    int PMPIX_Grequest_start(int function(void*, MPI_Status*), int function(void*), int function(void*, int), int function(void*, MPI_Status*), int function(int, void**, double, MPI_Status*), void*, int*) @nogc nothrow;
    int PMPIX_Grequest_class_allocate(int, void*, int*) @nogc nothrow;
    int PMPIX_Grequest_class_create(int function(void*, MPI_Status*), int function(void*), int function(void*, int), int function(void*, MPI_Status*), int function(int, void**, double, MPI_Status*), int*) @nogc nothrow;
    int MPIX_Mutex_unlock(mpixi_mutex_s*, int, int) @nogc nothrow;
    int MPIX_Mutex_lock(mpixi_mutex_s*, int, int) @nogc nothrow;
    int MPIX_Mutex_free(mpixi_mutex_s**) @nogc nothrow;
    int MPIX_Mutex_create(int, int, mpixi_mutex_s**) @nogc nothrow;
    alias MPIX_Mutex = mpixi_mutex_s*;
    struct mpixi_mutex_s;
    int MPIX_Grequest_start(int function(void*, MPI_Status*), int function(void*), int function(void*, int), int function(void*, MPI_Status*), int function(int, void**, double, MPI_Status*), void*, int*) @nogc nothrow;
    int MPIX_Grequest_class_allocate(int, void*, int*) @nogc nothrow;
    int MPIX_Grequest_class_create(int function(void*, MPI_Status*), int function(void*), int function(void*, int), int function(void*, MPI_Status*), int function(int, void**, double, MPI_Status*), int*) @nogc nothrow;
    alias MPIX_Grequest_class = int;
    int PMPIX_Comm_agree(int, int*) @nogc nothrow;
    int PMPIX_Comm_shrink(int, int*) @nogc nothrow;
    int PMPIX_Comm_revoke(int) @nogc nothrow;
    int PMPIX_Comm_failure_get_acked(int, int*) @nogc nothrow;
    int PMPIX_Comm_failure_ack(int) @nogc nothrow;
    int PMPI_T_category_get_index(const(char)*, int*) @nogc nothrow;
    int PMPI_T_pvar_get_index(const(char)*, int, int*) @nogc nothrow;
    int PMPI_T_cvar_get_index(const(char)*, int*) @nogc nothrow;
    int PMPI_T_category_changed(int*) @nogc nothrow;
    int PMPI_T_category_get_categories(int, int, int*) @nogc nothrow;
    int PMPI_T_category_get_pvars(int, int, int*) @nogc nothrow;
    int PMPI_T_category_get_cvars(int, int, int*) @nogc nothrow;
    int PMPI_T_category_get_info(int, char*, int*, char*, int*, int*, int*, int*) @nogc nothrow;
    int PMPI_T_category_get_num(int*) @nogc nothrow;
    int PMPI_T_pvar_readreset(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s*, void*) @nogc nothrow;
    int PMPI_T_pvar_reset(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s*) @nogc nothrow;
    int PMPI_T_pvar_write(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s*, const(void)*) @nogc nothrow;
    int PMPI_T_pvar_read(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s*, void*) @nogc nothrow;
    int PMPI_T_pvar_stop(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s*) @nogc nothrow;
    int PMPI_T_pvar_start(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s*) @nogc nothrow;
    int PMPI_T_pvar_handle_free(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s**) @nogc nothrow;
    int PMPI_T_pvar_handle_alloc(MPIR_T_pvar_session_s*, int, void*, MPIR_T_pvar_handle_s**, int*) @nogc nothrow;
    alias int8_t = byte;
    alias int16_t = short;
    alias int32_t = int;
    alias int64_t = c_long;
    int PMPI_T_pvar_session_free(MPIR_T_pvar_session_s**) @nogc nothrow;
    alias uint8_t = ubyte;
    alias uint16_t = ushort;
    alias uint32_t = uint;
    alias uint64_t = ulong;
    int PMPI_T_pvar_session_create(MPIR_T_pvar_session_s**) @nogc nothrow;
    int PMPI_T_pvar_get_info(int, char*, int*, int*, int*, int*, MPIR_T_enum_s**, char*, int*, int*, int*, int*, int*) @nogc nothrow;
    alias __u_char = ubyte;
    alias __u_short = ushort;
    alias __u_int = uint;
    alias __u_long = c_ulong;
    alias __int8_t = byte;
    alias __uint8_t = ubyte;
    alias __int16_t = short;
    alias __uint16_t = ushort;
    alias __int32_t = int;
    alias __uint32_t = uint;
    alias __int64_t = c_long;
    alias __uint64_t = c_ulong;
    alias __int_least8_t = byte;
    alias __uint_least8_t = ubyte;
    alias __int_least16_t = short;
    alias __uint_least16_t = ushort;
    alias __int_least32_t = int;
    alias __uint_least32_t = uint;
    alias __int_least64_t = c_long;
    alias __uint_least64_t = c_ulong;
    alias __quad_t = c_long;
    alias __u_quad_t = c_ulong;
    alias __intmax_t = c_long;
    alias __uintmax_t = c_ulong;
    int PMPI_T_pvar_get_num(int*) @nogc nothrow;
    int PMPI_T_cvar_write(MPIR_T_cvar_handle_s*, const(void)*) @nogc nothrow;
    int PMPI_T_cvar_read(MPIR_T_cvar_handle_s*, void*) @nogc nothrow;
    int PMPI_T_cvar_handle_free(MPIR_T_cvar_handle_s**) @nogc nothrow;
    int PMPI_T_cvar_handle_alloc(int, void*, MPIR_T_cvar_handle_s**, int*) @nogc nothrow;
    int PMPI_T_cvar_get_info(int, char*, int*, int*, int*, MPIR_T_enum_s**, char*, int*, int*, int*) @nogc nothrow;
    int PMPI_T_cvar_get_num(int*) @nogc nothrow;
    alias __dev_t = c_ulong;
    alias __uid_t = uint;
    alias __gid_t = uint;
    alias __ino_t = c_ulong;
    alias __ino64_t = c_ulong;
    alias __mode_t = uint;
    alias __nlink_t = c_ulong;
    alias __off_t = c_long;
    alias __off64_t = c_long;
    alias __pid_t = int;
    struct __fsid_t
    {
        int[2] __val;
    }
    alias __clock_t = c_long;
    alias __rlim_t = c_ulong;
    alias __rlim64_t = c_ulong;
    alias __id_t = uint;
    alias __time_t = c_long;
    alias __useconds_t = uint;
    alias __suseconds_t = c_long;
    alias __daddr_t = int;
    alias __key_t = int;
    alias __clockid_t = int;
    alias __timer_t = void*;
    alias __blksize_t = c_long;
    alias __blkcnt_t = c_long;
    alias __blkcnt64_t = c_long;
    alias __fsblkcnt_t = c_ulong;
    alias __fsblkcnt64_t = c_ulong;
    alias __fsfilcnt_t = c_ulong;
    alias __fsfilcnt64_t = c_ulong;
    alias __fsword_t = c_long;
    alias __ssize_t = c_long;
    alias __syscall_slong_t = c_long;
    alias __syscall_ulong_t = c_ulong;
    alias __loff_t = c_long;
    alias __caddr_t = char*;
    alias __intptr_t = c_long;
    alias __socklen_t = uint;
    alias __sig_atomic_t = int;
    int PMPI_T_enum_get_item(MPIR_T_enum_s*, int, int*, char*, int*) @nogc nothrow;
    int PMPI_T_enum_get_info(MPIR_T_enum_s*, int*, char*, int*) @nogc nothrow;
    int PMPI_T_finalize() @nogc nothrow;
    int PMPI_T_init_thread(int, int*) @nogc nothrow;
    c_long PMPI_Aint_diff(c_long, c_long) @nogc nothrow;
    c_long PMPI_Aint_add(c_long, c_long) @nogc nothrow;
    int PMPI_Type_size_x(int, long*) @nogc nothrow;
    int PMPI_Type_get_true_extent_x(int, long*, long*) @nogc nothrow;
    int PMPI_Type_get_extent_x(int, long*, long*) @nogc nothrow;
    int PMPI_Status_set_elements_x(MPI_Status*, int, long) @nogc nothrow;
    int PMPI_Get_elements_x(const(MPI_Status)*, int, long*) @nogc nothrow;
    int PMPI_Comm_create_group(int, int, int, int*) @nogc nothrow;
    int PMPI_Comm_split_type(int, int, int, int, int*) @nogc nothrow;
    int PMPI_Neighbor_alltoallw(const(void)*, const(int)*, const(c_long)*, const(int)*, void*, const(int)*, const(c_long)*, const(int)*, int) @nogc nothrow;
    int PMPI_Neighbor_alltoallv(const(void)*, const(int)*, const(int)*, int, void*, const(int)*, const(int)*, int, int) @nogc nothrow;
    int PMPI_Neighbor_alltoall(const(void)*, int, int, void*, int, int, int) @nogc nothrow;
    int PMPI_Neighbor_allgatherv(const(void)*, int, int, void*, const(int)*, const(int)*, int, int) @nogc nothrow;
    int PMPI_Neighbor_allgather(const(void)*, int, int, void*, int, int, int) @nogc nothrow;
    int PMPI_Ineighbor_alltoallw(const(void)*, const(int)*, const(c_long)*, const(int)*, void*, const(int)*, const(c_long)*, const(int)*, int, int*) @nogc nothrow;
    int PMPI_Ineighbor_alltoallv(const(void)*, const(int)*, const(int)*, int, void*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int PMPI_Ineighbor_alltoall(const(void)*, int, int, void*, int, int, int, int*) @nogc nothrow;
    int PMPI_Ineighbor_allgatherv(const(void)*, int, int, void*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int PMPI_Ineighbor_allgather(const(void)*, int, int, void*, int, int, int, int*) @nogc nothrow;
    int PMPI_Iexscan(const(void)*, void*, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Iscan(const(void)*, void*, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Ireduce_scatter_block(const(void)*, void*, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Ireduce_scatter(const(void)*, void*, const(int)*, int, int, int, int*) @nogc nothrow;
    int PMPI_Iallreduce(const(void)*, void*, int, int, int, int, int*) @nogc nothrow;
    alias MPI_Datatype = int;
    int PMPI_Ireduce(const(void)*, void*, int, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Ialltoallw(const(void)*, const(int)*, const(int)*, const(int)*, void*, const(int)*, const(int)*, const(int)*, int, int*) @nogc nothrow;
    int PMPI_Ialltoallv(const(void)*, const(int)*, const(int)*, int, void*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int PMPI_Ialltoall(const(void)*, int, int, void*, int, int, int, int*) @nogc nothrow;
    int PMPI_Iallgatherv(const(void)*, int, int, void*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int PMPI_Iallgather(const(void)*, int, int, void*, int, int, int, int*) @nogc nothrow;
    int PMPI_Iscatterv(const(void)*, const(int)*, const(int)*, int, void*, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Iscatter(const(void)*, int, int, void*, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Igatherv(const(void)*, int, int, void*, const(int)*, const(int)*, int, int, int, int*) @nogc nothrow;
    int PMPI_Igather(const(void)*, int, int, void*, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Ibcast(void*, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Ibarrier(int, int*) @nogc nothrow;
    int PMPI_Comm_idup(int, int*, int*) @nogc nothrow;
    int PMPI_Mrecv(void*, int, int, int*, MPI_Status*) @nogc nothrow;
    int PMPI_Mprobe(int, int, int, int*, MPI_Status*) @nogc nothrow;
    int PMPI_Imrecv(void*, int, int, int*, int*) @nogc nothrow;
    int PMPI_Improbe(int, int, int, int*, int*, MPI_Status*) @nogc nothrow;
    int PMPI_Dist_graph_neighbors(int, int, int*, int*, int, int*, int*) @nogc nothrow;
    int PMPI_Dist_graph_neighbors_count(int, int*, int*, int*) @nogc nothrow;
    int PMPI_Dist_graph_create(int, int, const(int)*, const(int)*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int PMPI_Dist_graph_create_adjacent(int, int, const(int)*, const(int)*, int, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int PMPI_Reduce_scatter_block(const(void)*, void*, int, int, int, int) @nogc nothrow;
    int PMPI_Op_commutative(int, int*) @nogc nothrow;
    alias MPI_Comm = int;
    int PMPI_Reduce_local(const(void)*, void*, int, int, int) @nogc nothrow;
    alias MPI_Group = int;
    int PMPI_Type_create_f90_complex(int, int, int*) @nogc nothrow;
    alias MPI_Win = int;
    int PMPI_Type_create_f90_real(int, int, int*) @nogc nothrow;
    alias MPI_File = ADIOI_FileD*;
    struct ADIOI_FileD;
    alias MPI_Op = int;
    int PMPI_Type_create_f90_integer(int, int*) @nogc nothrow;
    int PMPI_Win_set_errhandler(int, int) @nogc nothrow;
    int PMPI_Win_get_errhandler(int, int*) @nogc nothrow;
    int PMPI_Win_create_errhandler(void function(int*, int*, ...), int*) @nogc nothrow;
    int PMPI_Unpack_external(const(char)*, const(void)*, c_long, c_long*, void*, int, int) @nogc nothrow;
    int PMPI_Type_get_true_extent(int, c_long*, c_long*) @nogc nothrow;
    int PMPI_Type_get_extent(int, c_long*, c_long*) @nogc nothrow;
    int PMPI_Type_create_subarray(int, const(int)*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int PMPI_Type_create_struct(int, const(int)*, const(c_long)*, const(int)*, int*) @nogc nothrow;
    int PMPI_Type_create_resized(int, c_long, c_long, int*) @nogc nothrow;
    int PMPI_Type_create_hindexed_block(int, int, const(c_long)*, int, int*) @nogc nothrow;
    int PMPI_Type_create_indexed_block(int, int, const(int)*, int, int*) @nogc nothrow;
    int PMPI_Type_create_hvector(int, int, c_long, int, int*) @nogc nothrow;
    int PMPI_Type_create_hindexed(int, const(int)*, const(c_long)*, int, int*) @nogc nothrow;
    int PMPI_Type_create_darray(int, int, int, const(int)*, const(int)*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int PMPI_Status_f2c(const(int)*, MPI_Status*) @nogc nothrow;
    alias MPIR_Win_flavor_t = MPIR_Win_flavor;
    enum MPIR_Win_flavor
    {
        MPI_WIN_FLAVOR_CREATE = 1,
        MPI_WIN_FLAVOR_ALLOCATE = 2,
        MPI_WIN_FLAVOR_DYNAMIC = 3,
        MPI_WIN_FLAVOR_SHARED = 4,
    }
    enum MPI_WIN_FLAVOR_CREATE = MPIR_Win_flavor.MPI_WIN_FLAVOR_CREATE;
    enum MPI_WIN_FLAVOR_ALLOCATE = MPIR_Win_flavor.MPI_WIN_FLAVOR_ALLOCATE;
    enum MPI_WIN_FLAVOR_DYNAMIC = MPIR_Win_flavor.MPI_WIN_FLAVOR_DYNAMIC;
    enum MPI_WIN_FLAVOR_SHARED = MPIR_Win_flavor.MPI_WIN_FLAVOR_SHARED;
    alias MPIR_Win_model_t = MPIR_Win_model;
    enum MPIR_Win_model
    {
        MPI_WIN_SEPARATE = 1,
        MPI_WIN_UNIFIED = 2,
    }
    enum MPI_WIN_SEPARATE = MPIR_Win_model.MPI_WIN_SEPARATE;
    enum MPI_WIN_UNIFIED = MPIR_Win_model.MPI_WIN_UNIFIED;
    int PMPI_Status_c2f(const(MPI_Status)*, int*) @nogc nothrow;
    enum MPIR_Topo_type
    {
        MPI_GRAPH = 1,
        MPI_CART = 2,
        MPI_DIST_GRAPH = 3,
    }
    enum MPI_GRAPH = MPIR_Topo_type.MPI_GRAPH;
    enum MPI_CART = MPIR_Topo_type.MPI_CART;
    enum MPI_DIST_GRAPH = MPIR_Topo_type.MPI_DIST_GRAPH;
    extern __gshared int* MPI_UNWEIGHTED;
    extern __gshared int* MPI_WEIGHTS_EMPTY;
    int PMPI_Request_get_status(int, int*, MPI_Status*) @nogc nothrow;
    int PMPI_Pack_external_size(const(char)*, int, int, c_long*) @nogc nothrow;
    int PMPI_Pack_external(const(char)*, const(void)*, int, int, void*, c_long, c_long*) @nogc nothrow;
    alias MPI_Handler_function = void function(int*, int*);
    alias MPI_Comm_copy_attr_function = int function(int, int, void*, void*, void*, int*);
    alias MPI_Comm_delete_attr_function = int function(int, int, void*, void*);
    alias MPI_Type_copy_attr_function = int function(int, int, void*, void*, void*, int*);
    alias MPI_Type_delete_attr_function = int function(int, int, void*, void*);
    alias MPI_Win_copy_attr_function = int function(int, int, void*, void*, void*, int*);
    alias MPI_Win_delete_attr_function = int function(int, int, void*, void*);
    alias MPI_Comm_errhandler_function = void function(int*, int*);
    alias MPI_File_errhandler_function = void function(ADIOI_FileD**, int*);
    alias MPI_Win_errhandler_function = void function(int*, int*);
    alias MPI_Comm_errhandler_fn = void function(int*, int*);
    alias MPI_File_errhandler_fn = void function(ADIOI_FileD**, int*);
    alias MPI_Win_errhandler_fn = void function(int*, int*);
    int PMPI_Info_set(int, const(char)*, const(char)*) @nogc nothrow;
    alias MPI_Errhandler = int;
    int PMPI_Info_get_valuelen(int, const(char)*, int*, int*) @nogc nothrow;
    int PMPI_Info_get_nthkey(int, int, char*) @nogc nothrow;
    int PMPI_Info_get_nkeys(int, int*) @nogc nothrow;
    int PMPI_Info_get(int, const(char)*, int, char*, int*) @nogc nothrow;
    int PMPI_Info_free(int*) @nogc nothrow;
    int PMPI_Info_dup(int, int*) @nogc nothrow;
    alias MPI_Request = int;
    alias MPI_Message = int;
    alias MPI_User_function = void function(void*, void*, int*, int*);
    alias MPI_Copy_function = int function(int, int, void*, void*, void*, int*);
    alias MPI_Delete_function = int function(int, int, void*, void*);
    int PMPI_Info_delete(int, const(char)*) @nogc nothrow;
    int PMPI_Info_create(int*) @nogc nothrow;
    int PMPI_Get_address(const(void)*, c_long*) @nogc nothrow;
    int PMPI_Free_mem(void*) @nogc nothrow;
    int PMPI_Finalized(int*) @nogc nothrow;
    int PMPI_File_set_errhandler(ADIOI_FileD*, int) @nogc nothrow;
    enum MPIR_Combiner_enum
    {
        MPI_COMBINER_NAMED = 1,
        MPI_COMBINER_DUP = 2,
        MPI_COMBINER_CONTIGUOUS = 3,
        MPI_COMBINER_VECTOR = 4,
        MPI_COMBINER_HVECTOR_INTEGER = 5,
        MPI_COMBINER_HVECTOR = 6,
        MPI_COMBINER_INDEXED = 7,
        MPI_COMBINER_HINDEXED_INTEGER = 8,
        MPI_COMBINER_HINDEXED = 9,
        MPI_COMBINER_INDEXED_BLOCK = 10,
        MPI_COMBINER_STRUCT_INTEGER = 11,
        MPI_COMBINER_STRUCT = 12,
        MPI_COMBINER_SUBARRAY = 13,
        MPI_COMBINER_DARRAY = 14,
        MPI_COMBINER_F90_REAL = 15,
        MPI_COMBINER_F90_COMPLEX = 16,
        MPI_COMBINER_F90_INTEGER = 17,
        MPI_COMBINER_RESIZED = 18,
        MPI_COMBINER_HINDEXED_BLOCK = 19,
    }
    enum MPI_COMBINER_NAMED = MPIR_Combiner_enum.MPI_COMBINER_NAMED;
    enum MPI_COMBINER_DUP = MPIR_Combiner_enum.MPI_COMBINER_DUP;
    enum MPI_COMBINER_CONTIGUOUS = MPIR_Combiner_enum.MPI_COMBINER_CONTIGUOUS;
    enum MPI_COMBINER_VECTOR = MPIR_Combiner_enum.MPI_COMBINER_VECTOR;
    enum MPI_COMBINER_HVECTOR_INTEGER = MPIR_Combiner_enum.MPI_COMBINER_HVECTOR_INTEGER;
    enum MPI_COMBINER_HVECTOR = MPIR_Combiner_enum.MPI_COMBINER_HVECTOR;
    enum MPI_COMBINER_INDEXED = MPIR_Combiner_enum.MPI_COMBINER_INDEXED;
    enum MPI_COMBINER_HINDEXED_INTEGER = MPIR_Combiner_enum.MPI_COMBINER_HINDEXED_INTEGER;
    enum MPI_COMBINER_HINDEXED = MPIR_Combiner_enum.MPI_COMBINER_HINDEXED;
    enum MPI_COMBINER_INDEXED_BLOCK = MPIR_Combiner_enum.MPI_COMBINER_INDEXED_BLOCK;
    enum MPI_COMBINER_STRUCT_INTEGER = MPIR_Combiner_enum.MPI_COMBINER_STRUCT_INTEGER;
    enum MPI_COMBINER_STRUCT = MPIR_Combiner_enum.MPI_COMBINER_STRUCT;
    enum MPI_COMBINER_SUBARRAY = MPIR_Combiner_enum.MPI_COMBINER_SUBARRAY;
    enum MPI_COMBINER_DARRAY = MPIR_Combiner_enum.MPI_COMBINER_DARRAY;
    enum MPI_COMBINER_F90_REAL = MPIR_Combiner_enum.MPI_COMBINER_F90_REAL;
    enum MPI_COMBINER_F90_COMPLEX = MPIR_Combiner_enum.MPI_COMBINER_F90_COMPLEX;
    enum MPI_COMBINER_F90_INTEGER = MPIR_Combiner_enum.MPI_COMBINER_F90_INTEGER;
    enum MPI_COMBINER_RESIZED = MPIR_Combiner_enum.MPI_COMBINER_RESIZED;
    enum MPI_COMBINER_HINDEXED_BLOCK = MPIR_Combiner_enum.MPI_COMBINER_HINDEXED_BLOCK;
    alias MPI_Info = int;
    int PMPI_File_get_errhandler(ADIOI_FileD*, int*) @nogc nothrow;
    int PMPI_File_create_errhandler(void function(ADIOI_FileD**, int*, ...), int*) @nogc nothrow;
    int PMPI_Comm_set_errhandler(int, int) @nogc nothrow;
    int PMPI_Comm_get_errhandler(int, int*) @nogc nothrow;
    int PMPI_Comm_create_errhandler(void function(int*, int*, ...), int*) @nogc nothrow;
    int PMPI_Alloc_mem(c_long, int, void*) @nogc nothrow;
    int PMPI_Win_set_name(int, const(char)*) @nogc nothrow;
    int PMPI_Win_set_attr(int, int, void*) @nogc nothrow;
    int PMPI_Win_get_name(int, char*, int*) @nogc nothrow;
    alias MPI_Aint = c_long;
    alias MPI_Fint = int;
    alias MPI_Count = long;
    int PMPI_Win_get_attr(int, int, void*, int*) @nogc nothrow;
    int PMPI_Win_free_keyval(int*) @nogc nothrow;
    alias MPI_Offset = long;
    struct MPI_Status
    {
        int count_lo;
        int count_hi_and_cancelled;
        int MPI_SOURCE;
        int MPI_TAG;
        int MPI_ERROR;
    }
    struct MPIR_T_enum_s;
    struct MPIR_T_cvar_handle_s;
    struct MPIR_T_pvar_handle_s;
    struct MPIR_T_pvar_session_s;
    alias MPI_T_enum = MPIR_T_enum_s*;
    alias MPI_T_cvar_handle = MPIR_T_cvar_handle_s*;
    alias MPI_T_pvar_handle = MPIR_T_pvar_handle_s*;
    alias MPI_T_pvar_session = MPIR_T_pvar_session_s*;
    extern __gshared MPIR_T_pvar_handle_s* MPI_T_PVAR_ALL_HANDLES;
    int PMPI_Win_delete_attr(int, int) @nogc nothrow;
    int PMPI_Win_create_keyval(int function(int, int, void*, void*, void*, int*), int function(int, int, void*, void*), int*, void*) @nogc nothrow;
    enum MPIR_T_verbosity_t
    {
        MPIX_T_VERBOSITY_INVALID = 0,
        MPI_T_VERBOSITY_USER_BASIC = 221,
        MPI_T_VERBOSITY_USER_DETAIL = 222,
        MPI_T_VERBOSITY_USER_ALL = 223,
        MPI_T_VERBOSITY_TUNER_BASIC = 224,
        MPI_T_VERBOSITY_TUNER_DETAIL = 225,
        MPI_T_VERBOSITY_TUNER_ALL = 226,
        MPI_T_VERBOSITY_MPIDEV_BASIC = 227,
        MPI_T_VERBOSITY_MPIDEV_DETAIL = 228,
        MPI_T_VERBOSITY_MPIDEV_ALL = 229,
    }
    enum MPIX_T_VERBOSITY_INVALID = MPIR_T_verbosity_t.MPIX_T_VERBOSITY_INVALID;
    enum MPI_T_VERBOSITY_USER_BASIC = MPIR_T_verbosity_t.MPI_T_VERBOSITY_USER_BASIC;
    enum MPI_T_VERBOSITY_USER_DETAIL = MPIR_T_verbosity_t.MPI_T_VERBOSITY_USER_DETAIL;
    enum MPI_T_VERBOSITY_USER_ALL = MPIR_T_verbosity_t.MPI_T_VERBOSITY_USER_ALL;
    enum MPI_T_VERBOSITY_TUNER_BASIC = MPIR_T_verbosity_t.MPI_T_VERBOSITY_TUNER_BASIC;
    enum MPI_T_VERBOSITY_TUNER_DETAIL = MPIR_T_verbosity_t.MPI_T_VERBOSITY_TUNER_DETAIL;
    enum MPI_T_VERBOSITY_TUNER_ALL = MPIR_T_verbosity_t.MPI_T_VERBOSITY_TUNER_ALL;
    enum MPI_T_VERBOSITY_MPIDEV_BASIC = MPIR_T_verbosity_t.MPI_T_VERBOSITY_MPIDEV_BASIC;
    enum MPI_T_VERBOSITY_MPIDEV_DETAIL = MPIR_T_verbosity_t.MPI_T_VERBOSITY_MPIDEV_DETAIL;
    enum MPI_T_VERBOSITY_MPIDEV_ALL = MPIR_T_verbosity_t.MPI_T_VERBOSITY_MPIDEV_ALL;
    enum MPIR_T_bind_t
    {
        MPIX_T_BIND_INVALID = 0,
        MPI_T_BIND_NO_OBJECT = 9700,
        MPI_T_BIND_MPI_COMM = 9701,
        MPI_T_BIND_MPI_DATATYPE = 9702,
        MPI_T_BIND_MPI_ERRHANDLER = 9703,
        MPI_T_BIND_MPI_FILE = 9704,
        MPI_T_BIND_MPI_GROUP = 9705,
        MPI_T_BIND_MPI_OP = 9706,
        MPI_T_BIND_MPI_REQUEST = 9707,
        MPI_T_BIND_MPI_WIN = 9708,
        MPI_T_BIND_MPI_MESSAGE = 9709,
        MPI_T_BIND_MPI_INFO = 9710,
    }
    enum MPIX_T_BIND_INVALID = MPIR_T_bind_t.MPIX_T_BIND_INVALID;
    enum MPI_T_BIND_NO_OBJECT = MPIR_T_bind_t.MPI_T_BIND_NO_OBJECT;
    enum MPI_T_BIND_MPI_COMM = MPIR_T_bind_t.MPI_T_BIND_MPI_COMM;
    enum MPI_T_BIND_MPI_DATATYPE = MPIR_T_bind_t.MPI_T_BIND_MPI_DATATYPE;
    enum MPI_T_BIND_MPI_ERRHANDLER = MPIR_T_bind_t.MPI_T_BIND_MPI_ERRHANDLER;
    enum MPI_T_BIND_MPI_FILE = MPIR_T_bind_t.MPI_T_BIND_MPI_FILE;
    enum MPI_T_BIND_MPI_GROUP = MPIR_T_bind_t.MPI_T_BIND_MPI_GROUP;
    enum MPI_T_BIND_MPI_OP = MPIR_T_bind_t.MPI_T_BIND_MPI_OP;
    enum MPI_T_BIND_MPI_REQUEST = MPIR_T_bind_t.MPI_T_BIND_MPI_REQUEST;
    enum MPI_T_BIND_MPI_WIN = MPIR_T_bind_t.MPI_T_BIND_MPI_WIN;
    enum MPI_T_BIND_MPI_MESSAGE = MPIR_T_bind_t.MPI_T_BIND_MPI_MESSAGE;
    enum MPI_T_BIND_MPI_INFO = MPIR_T_bind_t.MPI_T_BIND_MPI_INFO;
    enum MPIR_T_scope_t
    {
        MPIX_T_SCOPE_INVALID = 0,
        MPI_T_SCOPE_CONSTANT = 60438,
        MPI_T_SCOPE_READONLY = 60439,
        MPI_T_SCOPE_LOCAL = 60440,
        MPI_T_SCOPE_GROUP = 60441,
        MPI_T_SCOPE_GROUP_EQ = 60442,
        MPI_T_SCOPE_ALL = 60443,
        MPI_T_SCOPE_ALL_EQ = 60444,
    }
    enum MPIX_T_SCOPE_INVALID = MPIR_T_scope_t.MPIX_T_SCOPE_INVALID;
    enum MPI_T_SCOPE_CONSTANT = MPIR_T_scope_t.MPI_T_SCOPE_CONSTANT;
    enum MPI_T_SCOPE_READONLY = MPIR_T_scope_t.MPI_T_SCOPE_READONLY;
    enum MPI_T_SCOPE_LOCAL = MPIR_T_scope_t.MPI_T_SCOPE_LOCAL;
    enum MPI_T_SCOPE_GROUP = MPIR_T_scope_t.MPI_T_SCOPE_GROUP;
    enum MPI_T_SCOPE_GROUP_EQ = MPIR_T_scope_t.MPI_T_SCOPE_GROUP_EQ;
    enum MPI_T_SCOPE_ALL = MPIR_T_scope_t.MPI_T_SCOPE_ALL;
    enum MPI_T_SCOPE_ALL_EQ = MPIR_T_scope_t.MPI_T_SCOPE_ALL_EQ;
    enum MPIR_T_pvar_class_t
    {
        MPIX_T_PVAR_CLASS_INVALID = 0,
        MPIR_T_PVAR_CLASS_FIRST = 240,
        MPI_T_PVAR_CLASS_STATE = 240,
        MPI_T_PVAR_CLASS_LEVEL = 241,
        MPI_T_PVAR_CLASS_SIZE = 242,
        MPI_T_PVAR_CLASS_PERCENTAGE = 243,
        MPI_T_PVAR_CLASS_HIGHWATERMARK = 244,
        MPI_T_PVAR_CLASS_LOWWATERMARK = 245,
        MPI_T_PVAR_CLASS_COUNTER = 246,
        MPI_T_PVAR_CLASS_AGGREGATE = 247,
        MPI_T_PVAR_CLASS_TIMER = 248,
        MPI_T_PVAR_CLASS_GENERIC = 249,
        MPIR_T_PVAR_CLASS_LAST = 250,
        MPIR_T_PVAR_CLASS_NUMBER = 10,
    }
    enum MPIX_T_PVAR_CLASS_INVALID = MPIR_T_pvar_class_t.MPIX_T_PVAR_CLASS_INVALID;
    enum MPIR_T_PVAR_CLASS_FIRST = MPIR_T_pvar_class_t.MPIR_T_PVAR_CLASS_FIRST;
    enum MPI_T_PVAR_CLASS_STATE = MPIR_T_pvar_class_t.MPI_T_PVAR_CLASS_STATE;
    enum MPI_T_PVAR_CLASS_LEVEL = MPIR_T_pvar_class_t.MPI_T_PVAR_CLASS_LEVEL;
    enum MPI_T_PVAR_CLASS_SIZE = MPIR_T_pvar_class_t.MPI_T_PVAR_CLASS_SIZE;
    enum MPI_T_PVAR_CLASS_PERCENTAGE = MPIR_T_pvar_class_t.MPI_T_PVAR_CLASS_PERCENTAGE;
    enum MPI_T_PVAR_CLASS_HIGHWATERMARK = MPIR_T_pvar_class_t.MPI_T_PVAR_CLASS_HIGHWATERMARK;
    enum MPI_T_PVAR_CLASS_LOWWATERMARK = MPIR_T_pvar_class_t.MPI_T_PVAR_CLASS_LOWWATERMARK;
    enum MPI_T_PVAR_CLASS_COUNTER = MPIR_T_pvar_class_t.MPI_T_PVAR_CLASS_COUNTER;
    enum MPI_T_PVAR_CLASS_AGGREGATE = MPIR_T_pvar_class_t.MPI_T_PVAR_CLASS_AGGREGATE;
    enum MPI_T_PVAR_CLASS_TIMER = MPIR_T_pvar_class_t.MPI_T_PVAR_CLASS_TIMER;
    enum MPI_T_PVAR_CLASS_GENERIC = MPIR_T_pvar_class_t.MPI_T_PVAR_CLASS_GENERIC;
    enum MPIR_T_PVAR_CLASS_LAST = MPIR_T_pvar_class_t.MPIR_T_PVAR_CLASS_LAST;
    enum MPIR_T_PVAR_CLASS_NUMBER = MPIR_T_pvar_class_t.MPIR_T_PVAR_CLASS_NUMBER;
    int PMPI_Win_call_errhandler(int, int) @nogc nothrow;
    int PMPI_Type_match_size(int, int, int*) @nogc nothrow;
    int PMPI_Type_set_name(int, const(char)*) @nogc nothrow;
    int PMPI_Type_set_attr(int, int, void*) @nogc nothrow;
    int PMPI_Type_get_name(int, char*, int*) @nogc nothrow;
    int PMPI_Type_get_envelope(int, int*, int*, int*, int*) @nogc nothrow;
    int PMPI_Type_get_contents(int, int, int, int, int*, c_long*, int*) @nogc nothrow;
    int PMPI_Type_get_attr(int, int, void*, int*) @nogc nothrow;
    int PMPI_Type_free_keyval(int*) @nogc nothrow;
    int PMPI_Type_dup(int, int*) @nogc nothrow;
    int PMPI_Type_delete_attr(int, int) @nogc nothrow;
    int PMPI_Type_create_keyval(int function(int, int, void*, void*, void*, int*), int function(int, int, void*, void*), int*, void*) @nogc nothrow;
    int PMPI_Status_set_elements(MPI_Status*, int, int) @nogc nothrow;
    int PMPI_Status_set_cancelled(MPI_Status*, int) @nogc nothrow;
    int PMPI_Query_thread(int*) @nogc nothrow;
    int PMPI_Is_thread_main(int*) @nogc nothrow;
    int PMPI_Init_thread(int*, char***, int, int*) @nogc nothrow;
    int PMPI_Grequest_start(int function(void*, MPI_Status*), int function(void*), int function(void*, int), void*, int*) @nogc nothrow;
    int PMPI_Grequest_complete(int) @nogc nothrow;
    int PMPI_File_call_errhandler(ADIOI_FileD*, int) @nogc nothrow;
    extern __gshared int* MPI_F_STATUS_IGNORE;
    extern __gshared int* MPI_F_STATUSES_IGNORE;
    int PMPI_Comm_set_name(int, const(char)*) @nogc nothrow;
    struct MPI_F08_status
    {
        int count_lo;
        int count_hi_and_cancelled;
        int MPI_SOURCE;
        int MPI_TAG;
        int MPI_ERROR;
    }
    extern __gshared MPI_F08_status MPIR_F08_MPI_STATUS_IGNORE_OBJ;
    extern __gshared MPI_F08_status[1] MPIR_F08_MPI_STATUSES_IGNORE_OBJ;
    extern __gshared int MPIR_F08_MPI_IN_PLACE;
    extern __gshared int MPIR_F08_MPI_BOTTOM;
    extern __gshared MPI_F08_status* MPI_F08_STATUS_IGNORE;
    extern __gshared MPI_F08_status* MPI_F08_STATUSES_IGNORE;
    int PMPI_Comm_set_attr(int, int, void*) @nogc nothrow;
    int PMPI_Comm_get_name(int, char*, int*) @nogc nothrow;
    alias MPI_Grequest_cancel_function = int function(void*, int);
    alias MPI_Grequest_free_function = int function(void*);
    alias MPI_Grequest_query_function = int function(void*, MPI_Status*);
    alias MPIX_Grequest_poll_function = int function(void*, MPI_Status*);
    alias MPIX_Grequest_wait_function = int function(int, void**, double, MPI_Status*);
    int PMPI_Comm_get_attr(int, int, void*, int*) @nogc nothrow;
    int PMPI_Comm_free_keyval(int*) @nogc nothrow;
    int PMPI_Comm_delete_attr(int, int) @nogc nothrow;
    int PMPI_Comm_create_keyval(int function(int, int, void*, void*, void*, int*), int function(int, int, void*, void*), int*, void*) @nogc nothrow;
    int PMPI_Comm_call_errhandler(int, int) @nogc nothrow;
    int PMPI_Add_error_string(int, const(char)*) @nogc nothrow;
    int PMPI_Add_error_code(int, int*) @nogc nothrow;
    int PMPI_Add_error_class(int*) @nogc nothrow;
    int PMPI_Win_sync(int) @nogc nothrow;
    int PMPI_Win_flush_local_all(int) @nogc nothrow;
    int PMPI_Win_flush_local(int, int) @nogc nothrow;
    int PMPI_Win_flush_all(int) @nogc nothrow;
    int PMPI_Win_flush(int, int) @nogc nothrow;
    int PMPI_Win_unlock_all(int) @nogc nothrow;
    int PMPI_Win_lock_all(int, int) @nogc nothrow;
    int PMPI_Rget_accumulate(const(void)*, int, int, void*, int, int, int, c_long, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Raccumulate(const(void)*, int, int, int, c_long, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Rget(void*, int, int, int, c_long, int, int, int, int*) @nogc nothrow;
    int PMPI_Rput(const(void)*, int, int, int, c_long, int, int, int, int*) @nogc nothrow;
    int PMPI_Compare_and_swap(const(void)*, const(void)*, void*, int, int, c_long, int) @nogc nothrow;
    int PMPI_Fetch_and_op(const(void)*, void*, int, int, c_long, int, int) @nogc nothrow;
    int PMPI_Get_accumulate(const(void)*, int, int, void*, int, int, int, c_long, int, int, int, int) @nogc nothrow;
    int PMPI_Win_set_info(int, int) @nogc nothrow;
    int PMPI_Win_get_info(int, int*) @nogc nothrow;
    int PMPI_Win_detach(int, const(void)*) @nogc nothrow;
    int PMPI_Win_attach(int, void*, c_long) @nogc nothrow;
    int PMPI_Win_create_dynamic(int, int, int*) @nogc nothrow;
    int PMPI_Win_shared_query(int, int, c_long*, int*, void*) @nogc nothrow;
    int PMPI_Win_allocate_shared(c_long, int, int, int, void*, int*) @nogc nothrow;
    int PMPI_Win_allocate(c_long, int, int, int, void*, int*) @nogc nothrow;
    int PMPI_Win_wait(int) @nogc nothrow;
    int PMPI_Win_unlock(int, int) @nogc nothrow;
    int PMPI_Win_test(int, int*) @nogc nothrow;
    int PMPI_Win_start(int, int, int) @nogc nothrow;
    int PMPI_Win_post(int, int, int) @nogc nothrow;
    int PMPI_Win_lock(int, int, int, int) @nogc nothrow;
    alias MPI_Datarep_conversion_function = int function(void*, int, int, void*, long, void*);
    alias MPI_Datarep_extent_function = int function(int, c_long*, void*);
    int MPI_Send(const(void)*, int, int, int, int, int) @nogc nothrow;
    int MPI_Recv(void*, int, int, int, int, int, MPI_Status*) @nogc nothrow;
    int MPI_Get_count(const(MPI_Status)*, int, int*) @nogc nothrow;
    int MPI_Bsend(const(void)*, int, int, int, int, int) @nogc nothrow;
    int MPI_Ssend(const(void)*, int, int, int, int, int) @nogc nothrow;
    int MPI_Rsend(const(void)*, int, int, int, int, int) @nogc nothrow;
    int MPI_Buffer_attach(void*, int) @nogc nothrow;
    int MPI_Buffer_detach(void*, int*) @nogc nothrow;
    int MPI_Isend(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int MPI_Ibsend(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int MPI_Issend(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int MPI_Irsend(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int MPI_Irecv(void*, int, int, int, int, int, int*) @nogc nothrow;
    int MPI_Wait(int*, MPI_Status*) @nogc nothrow;
    int MPI_Test(int*, int*, MPI_Status*) @nogc nothrow;
    int MPI_Request_free(int*) @nogc nothrow;
    int MPI_Waitany(int, int*, int*, MPI_Status*) @nogc nothrow;
    int MPI_Testany(int, int*, int*, int*, MPI_Status*) @nogc nothrow;
    int MPI_Waitall(int, int*, MPI_Status*) @nogc nothrow;
    int MPI_Testall(int, int*, int*, MPI_Status*) @nogc nothrow;
    int MPI_Waitsome(int, int*, int*, int*, MPI_Status*) @nogc nothrow;
    int MPI_Testsome(int, int*, int*, int*, MPI_Status*) @nogc nothrow;
    int MPI_Iprobe(int, int, int, int*, MPI_Status*) @nogc nothrow;
    int MPI_Probe(int, int, int, MPI_Status*) @nogc nothrow;
    int MPI_Cancel(int*) @nogc nothrow;
    int MPI_Test_cancelled(const(MPI_Status)*, int*) @nogc nothrow;
    int MPI_Send_init(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int MPI_Bsend_init(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int MPI_Ssend_init(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int MPI_Rsend_init(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int MPI_Recv_init(void*, int, int, int, int, int, int*) @nogc nothrow;
    int MPI_Start(int*) @nogc nothrow;
    int MPI_Startall(int, int*) @nogc nothrow;
    int MPI_Sendrecv(const(void)*, int, int, int, int, void*, int, int, int, int, int, MPI_Status*) @nogc nothrow;
    int MPI_Sendrecv_replace(void*, int, int, int, int, int, int, int, MPI_Status*) @nogc nothrow;
    int MPI_Type_contiguous(int, int, int*) @nogc nothrow;
    int MPI_Type_vector(int, int, int, int, int*) @nogc nothrow;
    int MPI_Type_hvector(int, int, c_long, int, int*) @nogc nothrow;
    int MPI_Type_indexed(int, const(int)*, const(int)*, int, int*) @nogc nothrow;
    int MPI_Type_hindexed(int, int*, c_long*, int, int*) @nogc nothrow;
    int MPI_Type_struct(int, int*, c_long*, int*, int*) @nogc nothrow;
    int MPI_Address(void*, c_long*) @nogc nothrow;
    int MPI_Type_extent(int, c_long*) @nogc nothrow;
    int MPI_Type_size(int, int*) @nogc nothrow;
    int MPI_Type_lb(int, c_long*) @nogc nothrow;
    int MPI_Type_ub(int, c_long*) @nogc nothrow;
    int MPI_Type_commit(int*) @nogc nothrow;
    int MPI_Type_free(int*) @nogc nothrow;
    int MPI_Get_elements(const(MPI_Status)*, int, int*) @nogc nothrow;
    int MPI_Pack(const(void)*, int, int, void*, int, int*, int) @nogc nothrow;
    int MPI_Unpack(const(void)*, int, int*, void*, int, int, int) @nogc nothrow;
    int MPI_Pack_size(int, int, int, int*) @nogc nothrow;
    int MPI_Barrier(int) @nogc nothrow;
    int MPI_Bcast(void*, int, int, int, int) @nogc nothrow;
    int MPI_Gather(const(void)*, int, int, void*, int, int, int, int) @nogc nothrow;
    int MPI_Gatherv(const(void)*, int, int, void*, const(int)*, const(int)*, int, int, int) @nogc nothrow;
    int MPI_Scatter(const(void)*, int, int, void*, int, int, int, int) @nogc nothrow;
    int MPI_Scatterv(const(void)*, const(int)*, const(int)*, int, void*, int, int, int, int) @nogc nothrow;
    int MPI_Allgather(const(void)*, int, int, void*, int, int, int) @nogc nothrow;
    int MPI_Allgatherv(const(void)*, int, int, void*, const(int)*, const(int)*, int, int) @nogc nothrow;
    int MPI_Alltoall(const(void)*, int, int, void*, int, int, int) @nogc nothrow;
    int MPI_Alltoallv(const(void)*, const(int)*, const(int)*, int, void*, const(int)*, const(int)*, int, int) @nogc nothrow;
    int MPI_Alltoallw(const(void)*, const(int)*, const(int)*, const(int)*, void*, const(int)*, const(int)*, const(int)*, int) @nogc nothrow;
    int MPI_Exscan(const(void)*, void*, int, int, int, int) @nogc nothrow;
    int MPI_Reduce(const(void)*, void*, int, int, int, int, int) @nogc nothrow;
    int MPI_Op_create(void function(void*, void*, int*, int*), int, int*) @nogc nothrow;
    int MPI_Op_free(int*) @nogc nothrow;
    int MPI_Allreduce(const(void)*, void*, int, int, int, int) @nogc nothrow;
    int MPI_Reduce_scatter(const(void)*, void*, const(int)*, int, int, int) @nogc nothrow;
    int MPI_Scan(const(void)*, void*, int, int, int, int) @nogc nothrow;
    int MPI_Group_size(int, int*) @nogc nothrow;
    int MPI_Group_rank(int, int*) @nogc nothrow;
    int MPI_Group_translate_ranks(int, int, const(int)*, int, int*) @nogc nothrow;
    int MPI_Group_compare(int, int, int*) @nogc nothrow;
    int MPI_Comm_group(int, int*) @nogc nothrow;
    int MPI_Group_union(int, int, int*) @nogc nothrow;
    int MPI_Group_intersection(int, int, int*) @nogc nothrow;
    int MPI_Group_difference(int, int, int*) @nogc nothrow;
    int MPI_Group_incl(int, int, const(int)*, int*) @nogc nothrow;
    int MPI_Group_excl(int, int, const(int)*, int*) @nogc nothrow;
    int MPI_Group_range_incl(int, int, int[3]*, int*) @nogc nothrow;
    int MPI_Group_range_excl(int, int, int[3]*, int*) @nogc nothrow;
    int MPI_Group_free(int*) @nogc nothrow;
    int MPI_Comm_size(int, int*) @nogc nothrow;
    int MPI_Comm_rank(int, int*) @nogc nothrow;
    int MPI_Comm_compare(int, int, int*) @nogc nothrow;
    int MPI_Comm_dup(int, int*) @nogc nothrow;
    int MPI_Comm_dup_with_info(int, int, int*) @nogc nothrow;
    int MPI_Comm_create(int, int, int*) @nogc nothrow;
    int MPI_Comm_split(int, int, int, int*) @nogc nothrow;
    int MPI_Comm_free(int*) @nogc nothrow;
    int MPI_Comm_test_inter(int, int*) @nogc nothrow;
    int MPI_Comm_remote_size(int, int*) @nogc nothrow;
    int MPI_Comm_remote_group(int, int*) @nogc nothrow;
    int MPI_Intercomm_create(int, int, int, int, int, int*) @nogc nothrow;
    int MPI_Intercomm_merge(int, int, int*) @nogc nothrow;
    int MPI_Keyval_create(int function(int, int, void*, void*, void*, int*), int function(int, int, void*, void*), int*, void*) @nogc nothrow;
    int MPI_Keyval_free(int*) @nogc nothrow;
    int MPI_Attr_put(int, int, void*) @nogc nothrow;
    int MPI_Attr_get(int, int, void*, int*) @nogc nothrow;
    int MPI_Attr_delete(int, int) @nogc nothrow;
    int MPI_Topo_test(int, int*) @nogc nothrow;
    int MPI_Cart_create(int, int, const(int)*, const(int)*, int, int*) @nogc nothrow;
    int MPI_Dims_create(int, int, int*) @nogc nothrow;
    int MPI_Graph_create(int, int, const(int)*, const(int)*, int, int*) @nogc nothrow;
    int MPI_Graphdims_get(int, int*, int*) @nogc nothrow;
    int MPI_Graph_get(int, int, int, int*, int*) @nogc nothrow;
    int MPI_Cartdim_get(int, int*) @nogc nothrow;
    int MPI_Cart_get(int, int, int*, int*, int*) @nogc nothrow;
    int MPI_Cart_rank(int, const(int)*, int*) @nogc nothrow;
    int MPI_Cart_coords(int, int, int, int*) @nogc nothrow;
    int MPI_Graph_neighbors_count(int, int, int*) @nogc nothrow;
    int MPI_Graph_neighbors(int, int, int, int*) @nogc nothrow;
    int MPI_Cart_shift(int, int, int, int*, int*) @nogc nothrow;
    int MPI_Cart_sub(int, const(int)*, int*) @nogc nothrow;
    int MPI_Cart_map(int, int, const(int)*, const(int)*, int*) @nogc nothrow;
    int MPI_Graph_map(int, int, const(int)*, const(int)*, int*) @nogc nothrow;
    int MPI_Get_processor_name(char*, int*) @nogc nothrow;
    int MPI_Get_version(int*, int*) @nogc nothrow;
    int MPI_Get_library_version(char*, int*) @nogc nothrow;
    int MPI_Errhandler_create(void function(int*, int*, ...), int*) @nogc nothrow;
    int MPI_Errhandler_set(int, int) @nogc nothrow;
    int MPI_Errhandler_get(int, int*) @nogc nothrow;
    int MPI_Errhandler_free(int*) @nogc nothrow;
    int MPI_Error_string(int, char*, int*) @nogc nothrow;
    int MPI_Error_class(int, int*) @nogc nothrow;
    double MPI_Wtime() @nogc nothrow;
    double MPI_Wtick() @nogc nothrow;
    int MPI_Init(int*, char***) @nogc nothrow;
    int MPI_Finalize() @nogc nothrow;
    int MPI_Initialized(int*) @nogc nothrow;
    int MPI_Abort(int, int) @nogc nothrow;
    int MPI_Pcontrol(const(int), ...) @nogc nothrow;
    int MPIR_Dup_fn(int, int, void*, void*, void*, int*) @nogc nothrow;
    int MPI_Close_port(const(char)*) @nogc nothrow;
    int MPI_Comm_accept(const(char)*, int, int, int, int*) @nogc nothrow;
    int MPI_Comm_connect(const(char)*, int, int, int, int*) @nogc nothrow;
    int MPI_Comm_disconnect(int*) @nogc nothrow;
    int MPI_Comm_get_parent(int*) @nogc nothrow;
    int MPI_Comm_join(int, int*) @nogc nothrow;
    int MPI_Comm_spawn(const(char)*, char**, int, int, int, int, int*, int*) @nogc nothrow;
    int MPI_Comm_spawn_multiple(int, char**, char***, const(int)*, const(int)*, int, int, int*, int*) @nogc nothrow;
    int MPI_Lookup_name(const(char)*, int, char*) @nogc nothrow;
    int MPI_Open_port(int, char*) @nogc nothrow;
    int MPI_Publish_name(const(char)*, int, const(char)*) @nogc nothrow;
    int MPI_Unpublish_name(const(char)*, int, const(char)*) @nogc nothrow;
    int MPI_Comm_set_info(int, int) @nogc nothrow;
    int MPI_Comm_get_info(int, int*) @nogc nothrow;
    int MPI_Accumulate(const(void)*, int, int, int, c_long, int, int, int, int) @nogc nothrow;
    int MPI_Get(void*, int, int, int, c_long, int, int, int) @nogc nothrow;
    int MPI_Put(const(void)*, int, int, int, c_long, int, int, int) @nogc nothrow;
    int MPI_Win_complete(int) @nogc nothrow;
    int MPI_Win_create(void*, c_long, int, int, int, int*) @nogc nothrow;
    int MPI_Win_fence(int, int) @nogc nothrow;
    int MPI_Win_free(int*) @nogc nothrow;
    int MPI_Win_get_group(int, int*) @nogc nothrow;
    int MPI_Win_lock(int, int, int, int) @nogc nothrow;
    int MPI_Win_post(int, int, int) @nogc nothrow;
    int MPI_Win_start(int, int, int) @nogc nothrow;
    int MPI_Win_test(int, int*) @nogc nothrow;
    int MPI_Win_unlock(int, int) @nogc nothrow;
    int MPI_Win_wait(int) @nogc nothrow;
    int MPI_Win_allocate(c_long, int, int, int, void*, int*) @nogc nothrow;
    int MPI_Win_allocate_shared(c_long, int, int, int, void*, int*) @nogc nothrow;
    int MPI_Win_shared_query(int, int, c_long*, int*, void*) @nogc nothrow;
    int MPI_Win_create_dynamic(int, int, int*) @nogc nothrow;
    int MPI_Win_attach(int, void*, c_long) @nogc nothrow;
    int MPI_Win_detach(int, const(void)*) @nogc nothrow;
    int MPI_Win_get_info(int, int*) @nogc nothrow;
    int MPI_Win_set_info(int, int) @nogc nothrow;
    int MPI_Get_accumulate(const(void)*, int, int, void*, int, int, int, c_long, int, int, int, int) @nogc nothrow;
    int MPI_Fetch_and_op(const(void)*, void*, int, int, c_long, int, int) @nogc nothrow;
    int MPI_Compare_and_swap(const(void)*, const(void)*, void*, int, int, c_long, int) @nogc nothrow;
    int MPI_Rput(const(void)*, int, int, int, c_long, int, int, int, int*) @nogc nothrow;
    int MPI_Rget(void*, int, int, int, c_long, int, int, int, int*) @nogc nothrow;
    int MPI_Raccumulate(const(void)*, int, int, int, c_long, int, int, int, int, int*) @nogc nothrow;
    int MPI_Rget_accumulate(const(void)*, int, int, void*, int, int, int, c_long, int, int, int, int, int*) @nogc nothrow;
    int MPI_Win_lock_all(int, int) @nogc nothrow;
    int MPI_Win_unlock_all(int) @nogc nothrow;
    int MPI_Win_flush(int, int) @nogc nothrow;
    int MPI_Win_flush_all(int) @nogc nothrow;
    int MPI_Win_flush_local(int, int) @nogc nothrow;
    int MPI_Win_flush_local_all(int) @nogc nothrow;
    int MPI_Win_sync(int) @nogc nothrow;
    int MPI_Add_error_class(int*) @nogc nothrow;
    int MPI_Add_error_code(int, int*) @nogc nothrow;
    int MPI_Add_error_string(int, const(char)*) @nogc nothrow;
    int MPI_Comm_call_errhandler(int, int) @nogc nothrow;
    int MPI_Comm_create_keyval(int function(int, int, void*, void*, void*, int*), int function(int, int, void*, void*), int*, void*) @nogc nothrow;
    int MPI_Comm_delete_attr(int, int) @nogc nothrow;
    int MPI_Comm_free_keyval(int*) @nogc nothrow;
    int MPI_Comm_get_attr(int, int, void*, int*) @nogc nothrow;
    int MPI_Comm_get_name(int, char*, int*) @nogc nothrow;
    int MPI_Comm_set_attr(int, int, void*) @nogc nothrow;
    int MPI_Comm_set_name(int, const(char)*) @nogc nothrow;
    int MPI_File_call_errhandler(ADIOI_FileD*, int) @nogc nothrow;
    int MPI_Grequest_complete(int) @nogc nothrow;
    int MPI_Grequest_start(int function(void*, MPI_Status*), int function(void*), int function(void*, int), void*, int*) @nogc nothrow;
    int MPI_Init_thread(int*, char***, int, int*) @nogc nothrow;
    int MPI_Is_thread_main(int*) @nogc nothrow;
    int MPI_Query_thread(int*) @nogc nothrow;
    int MPI_Status_set_cancelled(MPI_Status*, int) @nogc nothrow;
    int MPI_Status_set_elements(MPI_Status*, int, int) @nogc nothrow;
    int MPI_Type_create_keyval(int function(int, int, void*, void*, void*, int*), int function(int, int, void*, void*), int*, void*) @nogc nothrow;
    int MPI_Type_delete_attr(int, int) @nogc nothrow;
    int MPI_Type_dup(int, int*) @nogc nothrow;
    int MPI_Type_free_keyval(int*) @nogc nothrow;
    int MPI_Type_get_attr(int, int, void*, int*) @nogc nothrow;
    int MPI_Type_get_contents(int, int, int, int, int*, c_long*, int*) @nogc nothrow;
    int MPI_Type_get_envelope(int, int*, int*, int*, int*) @nogc nothrow;
    int MPI_Type_get_name(int, char*, int*) @nogc nothrow;
    int MPI_Type_set_attr(int, int, void*) @nogc nothrow;
    int MPI_Type_set_name(int, const(char)*) @nogc nothrow;
    int MPI_Type_match_size(int, int, int*) @nogc nothrow;
    int MPI_Win_call_errhandler(int, int) @nogc nothrow;
    int MPI_Win_create_keyval(int function(int, int, void*, void*, void*, int*), int function(int, int, void*, void*), int*, void*) @nogc nothrow;
    int MPI_Win_delete_attr(int, int) @nogc nothrow;
    int MPI_Win_free_keyval(int*) @nogc nothrow;
    int MPI_Win_get_attr(int, int, void*, int*) @nogc nothrow;
    int MPI_Win_get_name(int, char*, int*) @nogc nothrow;
    int MPI_Win_set_attr(int, int, void*) @nogc nothrow;
    int MPI_Win_set_name(int, const(char)*) @nogc nothrow;
    int MPI_Alloc_mem(c_long, int, void*) @nogc nothrow;
    int MPI_Comm_create_errhandler(void function(int*, int*, ...), int*) @nogc nothrow;
    int MPI_Comm_get_errhandler(int, int*) @nogc nothrow;
    int MPI_Comm_set_errhandler(int, int) @nogc nothrow;
    int MPI_File_create_errhandler(void function(ADIOI_FileD**, int*, ...), int*) @nogc nothrow;
    int MPI_File_get_errhandler(ADIOI_FileD*, int*) @nogc nothrow;
    int MPI_File_set_errhandler(ADIOI_FileD*, int) @nogc nothrow;
    int MPI_Finalized(int*) @nogc nothrow;
    int MPI_Free_mem(void*) @nogc nothrow;
    int MPI_Get_address(const(void)*, c_long*) @nogc nothrow;
    int MPI_Info_create(int*) @nogc nothrow;
    int MPI_Info_delete(int, const(char)*) @nogc nothrow;
    int MPI_Info_dup(int, int*) @nogc nothrow;
    int MPI_Info_free(int*) @nogc nothrow;
    int MPI_Info_get(int, const(char)*, int, char*, int*) @nogc nothrow;
    int MPI_Info_get_nkeys(int, int*) @nogc nothrow;
    int MPI_Info_get_nthkey(int, int, char*) @nogc nothrow;
    int MPI_Info_get_valuelen(int, const(char)*, int*, int*) @nogc nothrow;
    int MPI_Info_set(int, const(char)*, const(char)*) @nogc nothrow;
    int MPI_Pack_external(const(char)*, const(void)*, int, int, void*, c_long, c_long*) @nogc nothrow;
    int MPI_Pack_external_size(const(char)*, int, int, c_long*) @nogc nothrow;
    int MPI_Request_get_status(int, int*, MPI_Status*) @nogc nothrow;
    int MPI_Status_c2f(const(MPI_Status)*, int*) @nogc nothrow;
    int MPI_Status_f2c(const(int)*, MPI_Status*) @nogc nothrow;
    int MPI_Type_create_darray(int, int, int, const(int)*, const(int)*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int MPI_Type_create_hindexed(int, const(int)*, const(c_long)*, int, int*) @nogc nothrow;
    int MPI_Type_create_hvector(int, int, c_long, int, int*) @nogc nothrow;
    int MPI_Type_create_indexed_block(int, int, const(int)*, int, int*) @nogc nothrow;
    int MPI_Type_create_hindexed_block(int, int, const(c_long)*, int, int*) @nogc nothrow;
    int MPI_Type_create_resized(int, c_long, c_long, int*) @nogc nothrow;
    int MPI_Type_create_struct(int, const(int)*, const(c_long)*, const(int)*, int*) @nogc nothrow;
    int MPI_Type_create_subarray(int, const(int)*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int MPI_Type_get_extent(int, c_long*, c_long*) @nogc nothrow;
    int MPI_Type_get_true_extent(int, c_long*, c_long*) @nogc nothrow;
    int MPI_Unpack_external(const(char)*, const(void)*, c_long, c_long*, void*, int, int) @nogc nothrow;
    int MPI_Win_create_errhandler(void function(int*, int*, ...), int*) @nogc nothrow;
    int MPI_Win_get_errhandler(int, int*) @nogc nothrow;
    int MPI_Win_set_errhandler(int, int) @nogc nothrow;
    int MPI_Type_create_f90_integer(int, int*) @nogc nothrow;
    int MPI_Type_create_f90_real(int, int, int*) @nogc nothrow;
    int MPI_Type_create_f90_complex(int, int, int*) @nogc nothrow;
    int MPI_Reduce_local(const(void)*, void*, int, int, int) @nogc nothrow;
    int MPI_Op_commutative(int, int*) @nogc nothrow;
    int MPI_Reduce_scatter_block(const(void)*, void*, int, int, int, int) @nogc nothrow;
    int MPI_Dist_graph_create_adjacent(int, int, const(int)*, const(int)*, int, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int MPI_Dist_graph_create(int, int, const(int)*, const(int)*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int MPI_Dist_graph_neighbors_count(int, int*, int*, int*) @nogc nothrow;
    int MPI_Dist_graph_neighbors(int, int, int*, int*, int, int*, int*) @nogc nothrow;
    int MPI_Improbe(int, int, int, int*, int*, MPI_Status*) @nogc nothrow;
    int MPI_Imrecv(void*, int, int, int*, int*) @nogc nothrow;
    int MPI_Mprobe(int, int, int, int*, MPI_Status*) @nogc nothrow;
    int MPI_Mrecv(void*, int, int, int*, MPI_Status*) @nogc nothrow;
    int MPI_Comm_idup(int, int*, int*) @nogc nothrow;
    int MPI_Ibarrier(int, int*) @nogc nothrow;
    int MPI_Ibcast(void*, int, int, int, int, int*) @nogc nothrow;
    int MPI_Igather(const(void)*, int, int, void*, int, int, int, int, int*) @nogc nothrow;
    int MPI_Igatherv(const(void)*, int, int, void*, const(int)*, const(int)*, int, int, int, int*) @nogc nothrow;
    int MPI_Iscatter(const(void)*, int, int, void*, int, int, int, int, int*) @nogc nothrow;
    int MPI_Iscatterv(const(void)*, const(int)*, const(int)*, int, void*, int, int, int, int, int*) @nogc nothrow;
    int MPI_Iallgather(const(void)*, int, int, void*, int, int, int, int*) @nogc nothrow;
    int MPI_Iallgatherv(const(void)*, int, int, void*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int MPI_Ialltoall(const(void)*, int, int, void*, int, int, int, int*) @nogc nothrow;
    int MPI_Ialltoallv(const(void)*, const(int)*, const(int)*, int, void*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int MPI_Ialltoallw(const(void)*, const(int)*, const(int)*, const(int)*, void*, const(int)*, const(int)*, const(int)*, int, int*) @nogc nothrow;
    int MPI_Ireduce(const(void)*, void*, int, int, int, int, int, int*) @nogc nothrow;
    int MPI_Iallreduce(const(void)*, void*, int, int, int, int, int*) @nogc nothrow;
    int MPI_Ireduce_scatter(const(void)*, void*, const(int)*, int, int, int, int*) @nogc nothrow;
    int MPI_Ireduce_scatter_block(const(void)*, void*, int, int, int, int, int*) @nogc nothrow;
    int MPI_Iscan(const(void)*, void*, int, int, int, int, int*) @nogc nothrow;
    int MPI_Iexscan(const(void)*, void*, int, int, int, int, int*) @nogc nothrow;
    int MPI_Ineighbor_allgather(const(void)*, int, int, void*, int, int, int, int*) @nogc nothrow;
    int MPI_Ineighbor_allgatherv(const(void)*, int, int, void*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int MPI_Ineighbor_alltoall(const(void)*, int, int, void*, int, int, int, int*) @nogc nothrow;
    int MPI_Ineighbor_alltoallv(const(void)*, const(int)*, const(int)*, int, void*, const(int)*, const(int)*, int, int, int*) @nogc nothrow;
    int MPI_Ineighbor_alltoallw(const(void)*, const(int)*, const(c_long)*, const(int)*, void*, const(int)*, const(c_long)*, const(int)*, int, int*) @nogc nothrow;
    int MPI_Neighbor_allgather(const(void)*, int, int, void*, int, int, int) @nogc nothrow;
    int MPI_Neighbor_allgatherv(const(void)*, int, int, void*, const(int)*, const(int)*, int, int) @nogc nothrow;
    int MPI_Neighbor_alltoall(const(void)*, int, int, void*, int, int, int) @nogc nothrow;
    int MPI_Neighbor_alltoallv(const(void)*, const(int)*, const(int)*, int, void*, const(int)*, const(int)*, int, int) @nogc nothrow;
    int MPI_Neighbor_alltoallw(const(void)*, const(int)*, const(c_long)*, const(int)*, void*, const(int)*, const(c_long)*, const(int)*, int) @nogc nothrow;
    int MPI_Comm_split_type(int, int, int, int, int*) @nogc nothrow;
    int MPI_Get_elements_x(const(MPI_Status)*, int, long*) @nogc nothrow;
    int MPI_Status_set_elements_x(MPI_Status*, int, long) @nogc nothrow;
    int MPI_Type_get_extent_x(int, long*, long*) @nogc nothrow;
    int MPI_Type_get_true_extent_x(int, long*, long*) @nogc nothrow;
    int MPI_Type_size_x(int, long*) @nogc nothrow;
    int MPI_Comm_create_group(int, int, int, int*) @nogc nothrow;
    c_long MPI_Aint_add(c_long, c_long) @nogc nothrow;
    c_long MPI_Aint_diff(c_long, c_long) @nogc nothrow;
    int MPI_T_init_thread(int, int*) @nogc nothrow;
    int MPI_T_finalize() @nogc nothrow;
    int MPI_T_enum_get_info(MPIR_T_enum_s*, int*, char*, int*) @nogc nothrow;
    int MPI_T_enum_get_item(MPIR_T_enum_s*, int, int*, char*, int*) @nogc nothrow;
    int MPI_T_cvar_get_num(int*) @nogc nothrow;
    int MPI_T_cvar_get_info(int, char*, int*, int*, int*, MPIR_T_enum_s**, char*, int*, int*, int*) @nogc nothrow;
    int MPI_T_cvar_handle_alloc(int, void*, MPIR_T_cvar_handle_s**, int*) @nogc nothrow;
    int MPI_T_cvar_handle_free(MPIR_T_cvar_handle_s**) @nogc nothrow;
    int MPI_T_cvar_read(MPIR_T_cvar_handle_s*, void*) @nogc nothrow;
    int MPI_T_cvar_write(MPIR_T_cvar_handle_s*, const(void)*) @nogc nothrow;
    int MPI_T_pvar_get_num(int*) @nogc nothrow;
    int MPI_T_pvar_get_info(int, char*, int*, int*, int*, int*, MPIR_T_enum_s**, char*, int*, int*, int*, int*, int*) @nogc nothrow;
    int MPI_T_pvar_session_create(MPIR_T_pvar_session_s**) @nogc nothrow;
    int MPI_T_pvar_session_free(MPIR_T_pvar_session_s**) @nogc nothrow;
    int MPI_T_pvar_handle_alloc(MPIR_T_pvar_session_s*, int, void*, MPIR_T_pvar_handle_s**, int*) @nogc nothrow;
    int MPI_T_pvar_handle_free(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s**) @nogc nothrow;
    int MPI_T_pvar_start(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s*) @nogc nothrow;
    int MPI_T_pvar_stop(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s*) @nogc nothrow;
    int MPI_T_pvar_read(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s*, void*) @nogc nothrow;
    int MPI_T_pvar_write(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s*, const(void)*) @nogc nothrow;
    int MPI_T_pvar_reset(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s*) @nogc nothrow;
    int MPI_T_pvar_readreset(MPIR_T_pvar_session_s*, MPIR_T_pvar_handle_s*, void*) @nogc nothrow;
    int MPI_T_category_get_num(int*) @nogc nothrow;
    int MPI_T_category_get_info(int, char*, int*, char*, int*, int*, int*, int*) @nogc nothrow;
    int MPI_T_category_get_cvars(int, int, int*) @nogc nothrow;
    int MPI_T_category_get_pvars(int, int, int*) @nogc nothrow;
    int MPI_T_category_get_categories(int, int, int*) @nogc nothrow;
    int MPI_T_category_changed(int*) @nogc nothrow;
    int MPI_T_cvar_get_index(const(char)*, int*) @nogc nothrow;
    int MPI_T_pvar_get_index(const(char)*, int, int*) @nogc nothrow;
    int MPI_T_category_get_index(const(char)*, int*) @nogc nothrow;
    int MPIX_Comm_failure_ack(int) @nogc nothrow;
    int MPIX_Comm_failure_get_acked(int, int*) @nogc nothrow;
    int MPIX_Comm_revoke(int) @nogc nothrow;
    int MPIX_Comm_shrink(int, int*) @nogc nothrow;
    int MPIX_Comm_agree(int, int*) @nogc nothrow;
    int PMPI_Send(const(void)*, int, int, int, int, int) @nogc nothrow;
    int PMPI_Recv(void*, int, int, int, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_Get_count(const(MPI_Status)*, int, int*) @nogc nothrow;
    int PMPI_Bsend(const(void)*, int, int, int, int, int) @nogc nothrow;
    int PMPI_Ssend(const(void)*, int, int, int, int, int) @nogc nothrow;
    int PMPI_Rsend(const(void)*, int, int, int, int, int) @nogc nothrow;
    int PMPI_Buffer_attach(void*, int) @nogc nothrow;
    int PMPI_Buffer_detach(void*, int*) @nogc nothrow;
    int PMPI_Isend(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Ibsend(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Issend(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Irsend(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Irecv(void*, int, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Wait(int*, MPI_Status*) @nogc nothrow;
    int PMPI_Test(int*, int*, MPI_Status*) @nogc nothrow;
    int PMPI_Request_free(int*) @nogc nothrow;
    int PMPI_Waitany(int, int*, int*, MPI_Status*) @nogc nothrow;
    int PMPI_Testany(int, int*, int*, int*, MPI_Status*) @nogc nothrow;
    int PMPI_Waitall(int, int*, MPI_Status*) @nogc nothrow;
    int PMPI_Testall(int, int*, int*, MPI_Status*) @nogc nothrow;
    int PMPI_Waitsome(int, int*, int*, int*, MPI_Status*) @nogc nothrow;
    int PMPI_Testsome(int, int*, int*, int*, MPI_Status*) @nogc nothrow;
    int PMPI_Iprobe(int, int, int, int*, MPI_Status*) @nogc nothrow;
    int PMPI_Probe(int, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_Cancel(int*) @nogc nothrow;
    int PMPI_Test_cancelled(const(MPI_Status)*, int*) @nogc nothrow;
    int PMPI_Send_init(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Bsend_init(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Ssend_init(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Rsend_init(const(void)*, int, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Recv_init(void*, int, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Start(int*) @nogc nothrow;
    int PMPI_Startall(int, int*) @nogc nothrow;
    int PMPI_Sendrecv(const(void)*, int, int, int, int, void*, int, int, int, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_Sendrecv_replace(void*, int, int, int, int, int, int, int, MPI_Status*) @nogc nothrow;
    int PMPI_Type_contiguous(int, int, int*) @nogc nothrow;
    int PMPI_Type_vector(int, int, int, int, int*) @nogc nothrow;
    int PMPI_Type_hvector(int, int, c_long, int, int*) @nogc nothrow;
    int PMPI_Type_indexed(int, const(int)*, const(int)*, int, int*) @nogc nothrow;
    int PMPI_Type_hindexed(int, int*, c_long*, int, int*) @nogc nothrow;
    int PMPI_Type_struct(int, int*, c_long*, int*, int*) @nogc nothrow;
    int PMPI_Address(void*, c_long*) @nogc nothrow;
    int PMPI_Type_extent(int, c_long*) @nogc nothrow;
    int PMPI_Type_size(int, int*) @nogc nothrow;
    int PMPI_Type_lb(int, c_long*) @nogc nothrow;
    int PMPI_Type_ub(int, c_long*) @nogc nothrow;
    int PMPI_Type_commit(int*) @nogc nothrow;
    int PMPI_Type_free(int*) @nogc nothrow;
    int PMPI_Get_elements(const(MPI_Status)*, int, int*) @nogc nothrow;
    int PMPI_Pack(const(void)*, int, int, void*, int, int*, int) @nogc nothrow;
    int PMPI_Unpack(const(void)*, int, int*, void*, int, int, int) @nogc nothrow;
    int PMPI_Pack_size(int, int, int, int*) @nogc nothrow;
    int PMPI_Barrier(int) @nogc nothrow;
    int PMPI_Bcast(void*, int, int, int, int) @nogc nothrow;
    int PMPI_Gather(const(void)*, int, int, void*, int, int, int, int) @nogc nothrow;
    int PMPI_Gatherv(const(void)*, int, int, void*, const(int)*, const(int)*, int, int, int) @nogc nothrow;
    int PMPI_Scatter(const(void)*, int, int, void*, int, int, int, int) @nogc nothrow;
    int PMPI_Scatterv(const(void)*, const(int)*, const(int)*, int, void*, int, int, int, int) @nogc nothrow;
    int PMPI_Allgather(const(void)*, int, int, void*, int, int, int) @nogc nothrow;
    int PMPI_Allgatherv(const(void)*, int, int, void*, const(int)*, const(int)*, int, int) @nogc nothrow;
    int PMPI_Alltoall(const(void)*, int, int, void*, int, int, int) @nogc nothrow;
    int PMPI_Alltoallv(const(void)*, const(int)*, const(int)*, int, void*, const(int)*, const(int)*, int, int) @nogc nothrow;
    int PMPI_Alltoallw(const(void)*, const(int)*, const(int)*, const(int)*, void*, const(int)*, const(int)*, const(int)*, int) @nogc nothrow;
    int PMPI_Exscan(const(void)*, void*, int, int, int, int) @nogc nothrow;
    int PMPI_Reduce(const(void)*, void*, int, int, int, int, int) @nogc nothrow;
    int PMPI_Op_create(void function(void*, void*, int*, int*), int, int*) @nogc nothrow;
    int PMPI_Op_free(int*) @nogc nothrow;
    int PMPI_Allreduce(const(void)*, void*, int, int, int, int) @nogc nothrow;
    int PMPI_Reduce_scatter(const(void)*, void*, const(int)*, int, int, int) @nogc nothrow;
    int PMPI_Scan(const(void)*, void*, int, int, int, int) @nogc nothrow;
    int PMPI_Group_size(int, int*) @nogc nothrow;
    int PMPI_Group_rank(int, int*) @nogc nothrow;
    int PMPI_Group_translate_ranks(int, int, const(int)*, int, int*) @nogc nothrow;
    int PMPI_Group_compare(int, int, int*) @nogc nothrow;
    int PMPI_Comm_group(int, int*) @nogc nothrow;
    int PMPI_Group_union(int, int, int*) @nogc nothrow;
    int PMPI_Group_intersection(int, int, int*) @nogc nothrow;
    int PMPI_Group_difference(int, int, int*) @nogc nothrow;
    int PMPI_Group_incl(int, int, const(int)*, int*) @nogc nothrow;
    int PMPI_Group_excl(int, int, const(int)*, int*) @nogc nothrow;
    int PMPI_Group_range_incl(int, int, int[3]*, int*) @nogc nothrow;
    int PMPI_Group_range_excl(int, int, int[3]*, int*) @nogc nothrow;
    int PMPI_Group_free(int*) @nogc nothrow;
    int PMPI_Comm_size(int, int*) @nogc nothrow;
    int PMPI_Comm_rank(int, int*) @nogc nothrow;
    int PMPI_Comm_compare(int, int, int*) @nogc nothrow;
    int PMPI_Comm_dup(int, int*) @nogc nothrow;
    int PMPI_Comm_dup_with_info(int, int, int*) @nogc nothrow;
    int PMPI_Comm_create(int, int, int*) @nogc nothrow;
    int PMPI_Comm_split(int, int, int, int*) @nogc nothrow;
    int PMPI_Comm_free(int*) @nogc nothrow;
    int PMPI_Comm_test_inter(int, int*) @nogc nothrow;
    int PMPI_Comm_remote_size(int, int*) @nogc nothrow;
    int PMPI_Comm_remote_group(int, int*) @nogc nothrow;
    int PMPI_Intercomm_create(int, int, int, int, int, int*) @nogc nothrow;
    int PMPI_Intercomm_merge(int, int, int*) @nogc nothrow;
    int PMPI_Keyval_create(int function(int, int, void*, void*, void*, int*), int function(int, int, void*, void*), int*, void*) @nogc nothrow;
    int PMPI_Keyval_free(int*) @nogc nothrow;
    int PMPI_Attr_put(int, int, void*) @nogc nothrow;
    int PMPI_Attr_get(int, int, void*, int*) @nogc nothrow;
    int PMPI_Attr_delete(int, int) @nogc nothrow;
    int PMPI_Topo_test(int, int*) @nogc nothrow;
    int PMPI_Cart_create(int, int, const(int)*, const(int)*, int, int*) @nogc nothrow;
    int PMPI_Dims_create(int, int, int*) @nogc nothrow;
    int PMPI_Graph_create(int, int, const(int)*, const(int)*, int, int*) @nogc nothrow;
    int PMPI_Graphdims_get(int, int*, int*) @nogc nothrow;
    int PMPI_Graph_get(int, int, int, int*, int*) @nogc nothrow;
    int PMPI_Cartdim_get(int, int*) @nogc nothrow;
    int PMPI_Cart_get(int, int, int*, int*, int*) @nogc nothrow;
    int PMPI_Cart_rank(int, const(int)*, int*) @nogc nothrow;
    int PMPI_Cart_coords(int, int, int, int*) @nogc nothrow;
    int PMPI_Graph_neighbors_count(int, int, int*) @nogc nothrow;
    int PMPI_Graph_neighbors(int, int, int, int*) @nogc nothrow;
    int PMPI_Cart_shift(int, int, int, int*, int*) @nogc nothrow;
    int PMPI_Cart_sub(int, const(int)*, int*) @nogc nothrow;
    int PMPI_Cart_map(int, int, const(int)*, const(int)*, int*) @nogc nothrow;
    int PMPI_Graph_map(int, int, const(int)*, const(int)*, int*) @nogc nothrow;
    int PMPI_Get_processor_name(char*, int*) @nogc nothrow;
    int PMPI_Get_version(int*, int*) @nogc nothrow;
    int PMPI_Get_library_version(char*, int*) @nogc nothrow;
    int PMPI_Errhandler_create(void function(int*, int*, ...), int*) @nogc nothrow;
    int PMPI_Errhandler_set(int, int) @nogc nothrow;
    int PMPI_Errhandler_get(int, int*) @nogc nothrow;
    int PMPI_Errhandler_free(int*) @nogc nothrow;
    int PMPI_Error_string(int, char*, int*) @nogc nothrow;
    int PMPI_Error_class(int, int*) @nogc nothrow;
    double PMPI_Wtime() @nogc nothrow;
    double PMPI_Wtick() @nogc nothrow;
    int PMPI_Init(int*, char***) @nogc nothrow;
    int PMPI_Finalize() @nogc nothrow;
    int PMPI_Initialized(int*) @nogc nothrow;
    int PMPI_Abort(int, int) @nogc nothrow;
    int PMPI_Pcontrol(const(int), ...) @nogc nothrow;
    int PMPI_Close_port(const(char)*) @nogc nothrow;
    int PMPI_Comm_accept(const(char)*, int, int, int, int*) @nogc nothrow;
    int PMPI_Comm_connect(const(char)*, int, int, int, int*) @nogc nothrow;
    int PMPI_Comm_disconnect(int*) @nogc nothrow;
    int PMPI_Comm_get_parent(int*) @nogc nothrow;
    int PMPI_Comm_join(int, int*) @nogc nothrow;
    int PMPI_Comm_spawn(const(char)*, char**, int, int, int, int, int*, int*) @nogc nothrow;
    int PMPI_Comm_spawn_multiple(int, char**, char***, const(int)*, const(int)*, int, int, int*, int*) @nogc nothrow;
    int PMPI_Lookup_name(const(char)*, int, char*) @nogc nothrow;
    int PMPI_Open_port(int, char*) @nogc nothrow;
    int PMPI_Publish_name(const(char)*, int, const(char)*) @nogc nothrow;
    int PMPI_Unpublish_name(const(char)*, int, const(char)*) @nogc nothrow;
    int PMPI_Comm_set_info(int, int) @nogc nothrow;
    int PMPI_Comm_get_info(int, int*) @nogc nothrow;
    int PMPI_Accumulate(const(void)*, int, int, int, c_long, int, int, int, int) @nogc nothrow;
    int PMPI_Get(void*, int, int, int, c_long, int, int, int) @nogc nothrow;
    int PMPI_Put(const(void)*, int, int, int, c_long, int, int, int) @nogc nothrow;
    int PMPI_Win_complete(int) @nogc nothrow;
    int PMPI_Win_create(void*, c_long, int, int, int, int*) @nogc nothrow;
    int PMPI_Win_fence(int, int) @nogc nothrow;
    int PMPI_Win_free(int*) @nogc nothrow;
    int PMPI_Win_get_group(int, int*) @nogc nothrow;



    static if(!is(typeof(MPI_CONVERSION_FN_NULL))) {
        private enum enumMixinStr_MPI_CONVERSION_FN_NULL = `enum MPI_CONVERSION_FN_NULL = ( ( MPI_Datarep_conversion_function * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CONVERSION_FN_NULL); }))) {
            mixin(enumMixinStr_MPI_CONVERSION_FN_NULL);
        }
    }




    static if(!is(typeof(MPICH_ERR_LAST_MPIX))) {
        private enum enumMixinStr_MPICH_ERR_LAST_MPIX = `enum MPICH_ERR_LAST_MPIX = MPICH_ERR_FIRST_MPIX + 5;`;
        static if(is(typeof({ mixin(enumMixinStr_MPICH_ERR_LAST_MPIX); }))) {
            mixin(enumMixinStr_MPICH_ERR_LAST_MPIX);
        }
    }




    static if(!is(typeof(MPIX_ERR_NOREQ))) {
        private enum enumMixinStr_MPIX_ERR_NOREQ = `enum MPIX_ERR_NOREQ = MPICH_ERR_FIRST_MPIX + 5;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIX_ERR_NOREQ); }))) {
            mixin(enumMixinStr_MPIX_ERR_NOREQ);
        }
    }




    static if(!is(typeof(MPIX_ERR_EAGAIN))) {
        private enum enumMixinStr_MPIX_ERR_EAGAIN = `enum MPIX_ERR_EAGAIN = MPICH_ERR_FIRST_MPIX + 4;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIX_ERR_EAGAIN); }))) {
            mixin(enumMixinStr_MPIX_ERR_EAGAIN);
        }
    }




    static if(!is(typeof(MPIX_ERR_REVOKED))) {
        private enum enumMixinStr_MPIX_ERR_REVOKED = `enum MPIX_ERR_REVOKED = MPICH_ERR_FIRST_MPIX + 3;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIX_ERR_REVOKED); }))) {
            mixin(enumMixinStr_MPIX_ERR_REVOKED);
        }
    }




    static if(!is(typeof(MPIX_ERR_PROC_FAILED_PENDING))) {
        private enum enumMixinStr_MPIX_ERR_PROC_FAILED_PENDING = `enum MPIX_ERR_PROC_FAILED_PENDING = MPICH_ERR_FIRST_MPIX + 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIX_ERR_PROC_FAILED_PENDING); }))) {
            mixin(enumMixinStr_MPIX_ERR_PROC_FAILED_PENDING);
        }
    }




    static if(!is(typeof(MPIX_ERR_PROC_FAILED))) {
        private enum enumMixinStr_MPIX_ERR_PROC_FAILED = `enum MPIX_ERR_PROC_FAILED = MPICH_ERR_FIRST_MPIX + 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIX_ERR_PROC_FAILED); }))) {
            mixin(enumMixinStr_MPIX_ERR_PROC_FAILED);
        }
    }




    static if(!is(typeof(MPICH_ERR_FIRST_MPIX))) {
        private enum enumMixinStr_MPICH_ERR_FIRST_MPIX = `enum MPICH_ERR_FIRST_MPIX = 100;`;
        static if(is(typeof({ mixin(enumMixinStr_MPICH_ERR_FIRST_MPIX); }))) {
            mixin(enumMixinStr_MPICH_ERR_FIRST_MPIX);
        }
    }




    static if(!is(typeof(MPICH_ERR_LAST_CLASS))) {
        private enum enumMixinStr_MPICH_ERR_LAST_CLASS = `enum MPICH_ERR_LAST_CLASS = 74;`;
        static if(is(typeof({ mixin(enumMixinStr_MPICH_ERR_LAST_CLASS); }))) {
            mixin(enumMixinStr_MPICH_ERR_LAST_CLASS);
        }
    }




    static if(!is(typeof(MPI_ERR_LASTCODE))) {
        private enum enumMixinStr_MPI_ERR_LASTCODE = `enum MPI_ERR_LASTCODE = 0x3fffffff;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_LASTCODE); }))) {
            mixin(enumMixinStr_MPI_ERR_LASTCODE);
        }
    }




    static if(!is(typeof(MPI_T_ERR_INVALID))) {
        private enum enumMixinStr_MPI_T_ERR_INVALID = `enum MPI_T_ERR_INVALID = 74;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_INVALID); }))) {
            mixin(enumMixinStr_MPI_T_ERR_INVALID);
        }
    }




    static if(!is(typeof(MPI_T_ERR_INVALID_NAME))) {
        private enum enumMixinStr_MPI_T_ERR_INVALID_NAME = `enum MPI_T_ERR_INVALID_NAME = 73;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_INVALID_NAME); }))) {
            mixin(enumMixinStr_MPI_T_ERR_INVALID_NAME);
        }
    }




    static if(!is(typeof(MPI_T_ERR_PVAR_NO_ATOMIC))) {
        private enum enumMixinStr_MPI_T_ERR_PVAR_NO_ATOMIC = `enum MPI_T_ERR_PVAR_NO_ATOMIC = 72;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_PVAR_NO_ATOMIC); }))) {
            mixin(enumMixinStr_MPI_T_ERR_PVAR_NO_ATOMIC);
        }
    }




    static if(!is(typeof(MPI_T_ERR_PVAR_NO_WRITE))) {
        private enum enumMixinStr_MPI_T_ERR_PVAR_NO_WRITE = `enum MPI_T_ERR_PVAR_NO_WRITE = 71;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_PVAR_NO_WRITE); }))) {
            mixin(enumMixinStr_MPI_T_ERR_PVAR_NO_WRITE);
        }
    }




    static if(!is(typeof(MPI_T_ERR_PVAR_NO_STARTSTOP))) {
        private enum enumMixinStr_MPI_T_ERR_PVAR_NO_STARTSTOP = `enum MPI_T_ERR_PVAR_NO_STARTSTOP = 70;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_PVAR_NO_STARTSTOP); }))) {
            mixin(enumMixinStr_MPI_T_ERR_PVAR_NO_STARTSTOP);
        }
    }




    static if(!is(typeof(MPI_T_ERR_CVAR_SET_NEVER))) {
        private enum enumMixinStr_MPI_T_ERR_CVAR_SET_NEVER = `enum MPI_T_ERR_CVAR_SET_NEVER = 69;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_CVAR_SET_NEVER); }))) {
            mixin(enumMixinStr_MPI_T_ERR_CVAR_SET_NEVER);
        }
    }




    static if(!is(typeof(MPI_T_ERR_CVAR_SET_NOT_NOW))) {
        private enum enumMixinStr_MPI_T_ERR_CVAR_SET_NOT_NOW = `enum MPI_T_ERR_CVAR_SET_NOT_NOW = 68;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_CVAR_SET_NOT_NOW); }))) {
            mixin(enumMixinStr_MPI_T_ERR_CVAR_SET_NOT_NOW);
        }
    }




    static if(!is(typeof(MPI_T_ERR_INVALID_SESSION))) {
        private enum enumMixinStr_MPI_T_ERR_INVALID_SESSION = `enum MPI_T_ERR_INVALID_SESSION = 67;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_INVALID_SESSION); }))) {
            mixin(enumMixinStr_MPI_T_ERR_INVALID_SESSION);
        }
    }




    static if(!is(typeof(MPI_T_ERR_OUT_OF_SESSIONS))) {
        private enum enumMixinStr_MPI_T_ERR_OUT_OF_SESSIONS = `enum MPI_T_ERR_OUT_OF_SESSIONS = 66;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_OUT_OF_SESSIONS); }))) {
            mixin(enumMixinStr_MPI_T_ERR_OUT_OF_SESSIONS);
        }
    }




    static if(!is(typeof(MPI_T_ERR_OUT_OF_HANDLES))) {
        private enum enumMixinStr_MPI_T_ERR_OUT_OF_HANDLES = `enum MPI_T_ERR_OUT_OF_HANDLES = 65;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_OUT_OF_HANDLES); }))) {
            mixin(enumMixinStr_MPI_T_ERR_OUT_OF_HANDLES);
        }
    }




    static if(!is(typeof(MPI_T_ERR_INVALID_HANDLE))) {
        private enum enumMixinStr_MPI_T_ERR_INVALID_HANDLE = `enum MPI_T_ERR_INVALID_HANDLE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_INVALID_HANDLE); }))) {
            mixin(enumMixinStr_MPI_T_ERR_INVALID_HANDLE);
        }
    }




    static if(!is(typeof(MPI_T_ERR_INVALID_ITEM))) {
        private enum enumMixinStr_MPI_T_ERR_INVALID_ITEM = `enum MPI_T_ERR_INVALID_ITEM = 63;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_INVALID_ITEM); }))) {
            mixin(enumMixinStr_MPI_T_ERR_INVALID_ITEM);
        }
    }




    static if(!is(typeof(MPI_T_ERR_INVALID_INDEX))) {
        private enum enumMixinStr_MPI_T_ERR_INVALID_INDEX = `enum MPI_T_ERR_INVALID_INDEX = 62;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_INVALID_INDEX); }))) {
            mixin(enumMixinStr_MPI_T_ERR_INVALID_INDEX);
        }
    }




    static if(!is(typeof(MPI_T_ERR_CANNOT_INIT))) {
        private enum enumMixinStr_MPI_T_ERR_CANNOT_INIT = `enum MPI_T_ERR_CANNOT_INIT = 61;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_CANNOT_INIT); }))) {
            mixin(enumMixinStr_MPI_T_ERR_CANNOT_INIT);
        }
    }




    static if(!is(typeof(MPI_T_ERR_NOT_INITIALIZED))) {
        private enum enumMixinStr_MPI_T_ERR_NOT_INITIALIZED = `enum MPI_T_ERR_NOT_INITIALIZED = 60;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_NOT_INITIALIZED); }))) {
            mixin(enumMixinStr_MPI_T_ERR_NOT_INITIALIZED);
        }
    }




    static if(!is(typeof(MPI_T_ERR_MEMORY))) {
        private enum enumMixinStr_MPI_T_ERR_MEMORY = `enum MPI_T_ERR_MEMORY = 59;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_MEMORY); }))) {
            mixin(enumMixinStr_MPI_T_ERR_MEMORY);
        }
    }




    static if(!is(typeof(MPI_ERR_RMA_FLAVOR))) {
        private enum enumMixinStr_MPI_ERR_RMA_FLAVOR = `enum MPI_ERR_RMA_FLAVOR = 58;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RMA_FLAVOR); }))) {
            mixin(enumMixinStr_MPI_ERR_RMA_FLAVOR);
        }
    }




    static if(!is(typeof(MPI_ERR_RMA_SHARED))) {
        private enum enumMixinStr_MPI_ERR_RMA_SHARED = `enum MPI_ERR_RMA_SHARED = 57;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RMA_SHARED); }))) {
            mixin(enumMixinStr_MPI_ERR_RMA_SHARED);
        }
    }




    static if(!is(typeof(MPI_ERR_RMA_ATTACH))) {
        private enum enumMixinStr_MPI_ERR_RMA_ATTACH = `enum MPI_ERR_RMA_ATTACH = 56;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RMA_ATTACH); }))) {
            mixin(enumMixinStr_MPI_ERR_RMA_ATTACH);
        }
    }




    static if(!is(typeof(MPI_ERR_RMA_RANGE))) {
        private enum enumMixinStr_MPI_ERR_RMA_RANGE = `enum MPI_ERR_RMA_RANGE = 55;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RMA_RANGE); }))) {
            mixin(enumMixinStr_MPI_ERR_RMA_RANGE);
        }
    }




    static if(!is(typeof(MPI_ERR_ASSERT))) {
        private enum enumMixinStr_MPI_ERR_ASSERT = `enum MPI_ERR_ASSERT = 53;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_ASSERT); }))) {
            mixin(enumMixinStr_MPI_ERR_ASSERT);
        }
    }




    static if(!is(typeof(MPI_ERR_DISP))) {
        private enum enumMixinStr_MPI_ERR_DISP = `enum MPI_ERR_DISP = 52;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_DISP); }))) {
            mixin(enumMixinStr_MPI_ERR_DISP);
        }
    }




    static if(!is(typeof(MPI_ERR_SIZE))) {
        private enum enumMixinStr_MPI_ERR_SIZE = `enum MPI_ERR_SIZE = 51;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_SIZE); }))) {
            mixin(enumMixinStr_MPI_ERR_SIZE);
        }
    }




    static if(!is(typeof(MPI_ERR_RMA_SYNC))) {
        private enum enumMixinStr_MPI_ERR_RMA_SYNC = `enum MPI_ERR_RMA_SYNC = 50;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RMA_SYNC); }))) {
            mixin(enumMixinStr_MPI_ERR_RMA_SYNC);
        }
    }




    static if(!is(typeof(MPI_ERR_RMA_CONFLICT))) {
        private enum enumMixinStr_MPI_ERR_RMA_CONFLICT = `enum MPI_ERR_RMA_CONFLICT = 49;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RMA_CONFLICT); }))) {
            mixin(enumMixinStr_MPI_ERR_RMA_CONFLICT);
        }
    }




    static if(!is(typeof(MPI_ERR_KEYVAL))) {
        private enum enumMixinStr_MPI_ERR_KEYVAL = `enum MPI_ERR_KEYVAL = 48;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_KEYVAL); }))) {
            mixin(enumMixinStr_MPI_ERR_KEYVAL);
        }
    }




    static if(!is(typeof(MPI_ERR_LOCKTYPE))) {
        private enum enumMixinStr_MPI_ERR_LOCKTYPE = `enum MPI_ERR_LOCKTYPE = 47;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_LOCKTYPE); }))) {
            mixin(enumMixinStr_MPI_ERR_LOCKTYPE);
        }
    }




    static if(!is(typeof(MPI_ERR_BASE))) {
        private enum enumMixinStr_MPI_ERR_BASE = `enum MPI_ERR_BASE = 46;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_BASE); }))) {
            mixin(enumMixinStr_MPI_ERR_BASE);
        }
    }




    static if(!is(typeof(MPI_ERR_WIN))) {
        private enum enumMixinStr_MPI_ERR_WIN = `enum MPI_ERR_WIN = 45;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_WIN); }))) {
            mixin(enumMixinStr_MPI_ERR_WIN);
        }
    }




    static if(!is(typeof(MPI_ERR_UNSUPPORTED_OPERATION))) {
        private enum enumMixinStr_MPI_ERR_UNSUPPORTED_OPERATION = `enum MPI_ERR_UNSUPPORTED_OPERATION = 44;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_UNSUPPORTED_OPERATION); }))) {
            mixin(enumMixinStr_MPI_ERR_UNSUPPORTED_OPERATION);
        }
    }




    static if(!is(typeof(MPI_ERR_SPAWN))) {
        private enum enumMixinStr_MPI_ERR_SPAWN = `enum MPI_ERR_SPAWN = 42;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_SPAWN); }))) {
            mixin(enumMixinStr_MPI_ERR_SPAWN);
        }
    }




    static if(!is(typeof(MPI_ERR_SERVICE))) {
        private enum enumMixinStr_MPI_ERR_SERVICE = `enum MPI_ERR_SERVICE = 41;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_SERVICE); }))) {
            mixin(enumMixinStr_MPI_ERR_SERVICE);
        }
    }




    static if(!is(typeof(MPI_ERR_QUOTA))) {
        private enum enumMixinStr_MPI_ERR_QUOTA = `enum MPI_ERR_QUOTA = 39;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_QUOTA); }))) {
            mixin(enumMixinStr_MPI_ERR_QUOTA);
        }
    }




    static if(!is(typeof(MPI_ERR_PORT))) {
        private enum enumMixinStr_MPI_ERR_PORT = `enum MPI_ERR_PORT = 38;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_PORT); }))) {
            mixin(enumMixinStr_MPI_ERR_PORT);
        }
    }




    static if(!is(typeof(MPI_ERR_NOT_SAME))) {
        private enum enumMixinStr_MPI_ERR_NOT_SAME = `enum MPI_ERR_NOT_SAME = 35;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_NOT_SAME); }))) {
            mixin(enumMixinStr_MPI_ERR_NOT_SAME);
        }
    }




    static if(!is(typeof(MPI_ERR_NO_MEM))) {
        private enum enumMixinStr_MPI_ERR_NO_MEM = `enum MPI_ERR_NO_MEM = 34;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_NO_MEM); }))) {
            mixin(enumMixinStr_MPI_ERR_NO_MEM);
        }
    }




    static if(!is(typeof(MPI_ERR_NAME))) {
        private enum enumMixinStr_MPI_ERR_NAME = `enum MPI_ERR_NAME = 33;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_NAME); }))) {
            mixin(enumMixinStr_MPI_ERR_NAME);
        }
    }




    static if(!is(typeof(MPI_ERR_INFO_NOKEY))) {
        private enum enumMixinStr_MPI_ERR_INFO_NOKEY = `enum MPI_ERR_INFO_NOKEY = 31;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_INFO_NOKEY); }))) {
            mixin(enumMixinStr_MPI_ERR_INFO_NOKEY);
        }
    }




    static if(!is(typeof(MPI_ERR_INFO_VALUE))) {
        private enum enumMixinStr_MPI_ERR_INFO_VALUE = `enum MPI_ERR_INFO_VALUE = 30;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_INFO_VALUE); }))) {
            mixin(enumMixinStr_MPI_ERR_INFO_VALUE);
        }
    }




    static if(!is(typeof(MPI_ERR_INFO_KEY))) {
        private enum enumMixinStr_MPI_ERR_INFO_KEY = `enum MPI_ERR_INFO_KEY = 29;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_INFO_KEY); }))) {
            mixin(enumMixinStr_MPI_ERR_INFO_KEY);
        }
    }




    static if(!is(typeof(MPI_ERR_INFO))) {
        private enum enumMixinStr_MPI_ERR_INFO = `enum MPI_ERR_INFO = 28;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_INFO); }))) {
            mixin(enumMixinStr_MPI_ERR_INFO);
        }
    }




    static if(!is(typeof(MPI_ERR_UNSUPPORTED_DATAREP))) {
        private enum enumMixinStr_MPI_ERR_UNSUPPORTED_DATAREP = `enum MPI_ERR_UNSUPPORTED_DATAREP = 43;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_UNSUPPORTED_DATAREP); }))) {
            mixin(enumMixinStr_MPI_ERR_UNSUPPORTED_DATAREP);
        }
    }




    static if(!is(typeof(MPI_ERR_READ_ONLY))) {
        private enum enumMixinStr_MPI_ERR_READ_ONLY = `enum MPI_ERR_READ_ONLY = 40;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_READ_ONLY); }))) {
            mixin(enumMixinStr_MPI_ERR_READ_ONLY);
        }
    }




    static if(!is(typeof(MPI_ERR_NO_SUCH_FILE))) {
        private enum enumMixinStr_MPI_ERR_NO_SUCH_FILE = `enum MPI_ERR_NO_SUCH_FILE = 37;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_NO_SUCH_FILE); }))) {
            mixin(enumMixinStr_MPI_ERR_NO_SUCH_FILE);
        }
    }




    static if(!is(typeof(MPI_ERR_NO_SPACE))) {
        private enum enumMixinStr_MPI_ERR_NO_SPACE = `enum MPI_ERR_NO_SPACE = 36;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_NO_SPACE); }))) {
            mixin(enumMixinStr_MPI_ERR_NO_SPACE);
        }
    }




    static if(!is(typeof(MPI_ERR_IO))) {
        private enum enumMixinStr_MPI_ERR_IO = `enum MPI_ERR_IO = 32;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_IO); }))) {
            mixin(enumMixinStr_MPI_ERR_IO);
        }
    }




    static if(!is(typeof(MPI_ERR_FILE))) {
        private enum enumMixinStr_MPI_ERR_FILE = `enum MPI_ERR_FILE = 27;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_FILE); }))) {
            mixin(enumMixinStr_MPI_ERR_FILE);
        }
    }




    static if(!is(typeof(MPI_ERR_FILE_IN_USE))) {
        private enum enumMixinStr_MPI_ERR_FILE_IN_USE = `enum MPI_ERR_FILE_IN_USE = 26;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_FILE_IN_USE); }))) {
            mixin(enumMixinStr_MPI_ERR_FILE_IN_USE);
        }
    }




    static if(!is(typeof(MPI_ERR_FILE_EXISTS))) {
        private enum enumMixinStr_MPI_ERR_FILE_EXISTS = `enum MPI_ERR_FILE_EXISTS = 25;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_FILE_EXISTS); }))) {
            mixin(enumMixinStr_MPI_ERR_FILE_EXISTS);
        }
    }




    static if(!is(typeof(MPI_ERR_DUP_DATAREP))) {
        private enum enumMixinStr_MPI_ERR_DUP_DATAREP = `enum MPI_ERR_DUP_DATAREP = 24;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_DUP_DATAREP); }))) {
            mixin(enumMixinStr_MPI_ERR_DUP_DATAREP);
        }
    }




    static if(!is(typeof(MPI_ERR_CONVERSION))) {
        private enum enumMixinStr_MPI_ERR_CONVERSION = `enum MPI_ERR_CONVERSION = 23;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_CONVERSION); }))) {
            mixin(enumMixinStr_MPI_ERR_CONVERSION);
        }
    }




    static if(!is(typeof(MPI_ERR_BAD_FILE))) {
        private enum enumMixinStr_MPI_ERR_BAD_FILE = `enum MPI_ERR_BAD_FILE = 22;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_BAD_FILE); }))) {
            mixin(enumMixinStr_MPI_ERR_BAD_FILE);
        }
    }




    static if(!is(typeof(MPI_ERR_AMODE))) {
        private enum enumMixinStr_MPI_ERR_AMODE = `enum MPI_ERR_AMODE = 21;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_AMODE); }))) {
            mixin(enumMixinStr_MPI_ERR_AMODE);
        }
    }




    static if(!is(typeof(MPI_ERR_ACCESS))) {
        private enum enumMixinStr_MPI_ERR_ACCESS = `enum MPI_ERR_ACCESS = 20;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_ACCESS); }))) {
            mixin(enumMixinStr_MPI_ERR_ACCESS);
        }
    }




    static if(!is(typeof(MPI_ERR_PENDING))) {
        private enum enumMixinStr_MPI_ERR_PENDING = `enum MPI_ERR_PENDING = 18;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_PENDING); }))) {
            mixin(enumMixinStr_MPI_ERR_PENDING);
        }
    }




    static if(!is(typeof(MPI_ERR_IN_STATUS))) {
        private enum enumMixinStr_MPI_ERR_IN_STATUS = `enum MPI_ERR_IN_STATUS = 17;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_IN_STATUS); }))) {
            mixin(enumMixinStr_MPI_ERR_IN_STATUS);
        }
    }




    static if(!is(typeof(MPI_ERR_INTERN))) {
        private enum enumMixinStr_MPI_ERR_INTERN = `enum MPI_ERR_INTERN = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_INTERN); }))) {
            mixin(enumMixinStr_MPI_ERR_INTERN);
        }
    }




    static if(!is(typeof(MPI_ERR_UNKNOWN))) {
        private enum enumMixinStr_MPI_ERR_UNKNOWN = `enum MPI_ERR_UNKNOWN = 13;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_UNKNOWN); }))) {
            mixin(enumMixinStr_MPI_ERR_UNKNOWN);
        }
    }




    static if(!is(typeof(MPI_ERR_OTHER))) {
        private enum enumMixinStr_MPI_ERR_OTHER = `enum MPI_ERR_OTHER = 15;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_OTHER); }))) {
            mixin(enumMixinStr_MPI_ERR_OTHER);
        }
    }




    static if(!is(typeof(MPI_ERR_ARG))) {
        private enum enumMixinStr_MPI_ERR_ARG = `enum MPI_ERR_ARG = 12;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_ARG); }))) {
            mixin(enumMixinStr_MPI_ERR_ARG);
        }
    }




    static if(!is(typeof(MPI_ERR_DIMS))) {
        private enum enumMixinStr_MPI_ERR_DIMS = `enum MPI_ERR_DIMS = 11;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_DIMS); }))) {
            mixin(enumMixinStr_MPI_ERR_DIMS);
        }
    }




    static if(!is(typeof(MPI_ERR_TOPOLOGY))) {
        private enum enumMixinStr_MPI_ERR_TOPOLOGY = `enum MPI_ERR_TOPOLOGY = 10;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_TOPOLOGY); }))) {
            mixin(enumMixinStr_MPI_ERR_TOPOLOGY);
        }
    }




    static if(!is(typeof(MPI_ERR_REQUEST))) {
        private enum enumMixinStr_MPI_ERR_REQUEST = `enum MPI_ERR_REQUEST = 19;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_REQUEST); }))) {
            mixin(enumMixinStr_MPI_ERR_REQUEST);
        }
    }




    static if(!is(typeof(MPI_ERR_OP))) {
        private enum enumMixinStr_MPI_ERR_OP = `enum MPI_ERR_OP = 9;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_OP); }))) {
            mixin(enumMixinStr_MPI_ERR_OP);
        }
    }




    static if(!is(typeof(MPI_ERR_GROUP))) {
        private enum enumMixinStr_MPI_ERR_GROUP = `enum MPI_ERR_GROUP = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_GROUP); }))) {
            mixin(enumMixinStr_MPI_ERR_GROUP);
        }
    }




    static if(!is(typeof(MPI_ERR_TRUNCATE))) {
        private enum enumMixinStr_MPI_ERR_TRUNCATE = `enum MPI_ERR_TRUNCATE = 14;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_TRUNCATE); }))) {
            mixin(enumMixinStr_MPI_ERR_TRUNCATE);
        }
    }




    static if(!is(typeof(MPI_ERR_ROOT))) {
        private enum enumMixinStr_MPI_ERR_ROOT = `enum MPI_ERR_ROOT = 7;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_ROOT); }))) {
            mixin(enumMixinStr_MPI_ERR_ROOT);
        }
    }




    static if(!is(typeof(MPI_ERR_RANK))) {
        private enum enumMixinStr_MPI_ERR_RANK = `enum MPI_ERR_RANK = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RANK); }))) {
            mixin(enumMixinStr_MPI_ERR_RANK);
        }
    }




    static if(!is(typeof(MPI_ERR_COMM))) {
        private enum enumMixinStr_MPI_ERR_COMM = `enum MPI_ERR_COMM = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_COMM); }))) {
            mixin(enumMixinStr_MPI_ERR_COMM);
        }
    }




    static if(!is(typeof(MPI_ERR_TAG))) {
        private enum enumMixinStr_MPI_ERR_TAG = `enum MPI_ERR_TAG = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_TAG); }))) {
            mixin(enumMixinStr_MPI_ERR_TAG);
        }
    }




    static if(!is(typeof(MPI_ERR_TYPE))) {
        private enum enumMixinStr_MPI_ERR_TYPE = `enum MPI_ERR_TYPE = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_TYPE); }))) {
            mixin(enumMixinStr_MPI_ERR_TYPE);
        }
    }




    static if(!is(typeof(MPI_ERR_COUNT))) {
        private enum enumMixinStr_MPI_ERR_COUNT = `enum MPI_ERR_COUNT = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_COUNT); }))) {
            mixin(enumMixinStr_MPI_ERR_COUNT);
        }
    }




    static if(!is(typeof(MPI_ERR_BUFFER))) {
        private enum enumMixinStr_MPI_ERR_BUFFER = `enum MPI_ERR_BUFFER = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_BUFFER); }))) {
            mixin(enumMixinStr_MPI_ERR_BUFFER);
        }
    }




    static if(!is(typeof(MPI_SUCCESS))) {
        private enum enumMixinStr_MPI_SUCCESS = `enum MPI_SUCCESS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SUCCESS); }))) {
            mixin(enumMixinStr_MPI_SUCCESS);
        }
    }




    static if(!is(typeof(MPI_THREAD_MULTIPLE))) {
        private enum enumMixinStr_MPI_THREAD_MULTIPLE = `enum MPI_THREAD_MULTIPLE = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_THREAD_MULTIPLE); }))) {
            mixin(enumMixinStr_MPI_THREAD_MULTIPLE);
        }
    }




    static if(!is(typeof(MPI_THREAD_SERIALIZED))) {
        private enum enumMixinStr_MPI_THREAD_SERIALIZED = `enum MPI_THREAD_SERIALIZED = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_THREAD_SERIALIZED); }))) {
            mixin(enumMixinStr_MPI_THREAD_SERIALIZED);
        }
    }




    static if(!is(typeof(MPI_THREAD_FUNNELED))) {
        private enum enumMixinStr_MPI_THREAD_FUNNELED = `enum MPI_THREAD_FUNNELED = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_THREAD_FUNNELED); }))) {
            mixin(enumMixinStr_MPI_THREAD_FUNNELED);
        }
    }




    static if(!is(typeof(MPI_THREAD_SINGLE))) {
        private enum enumMixinStr_MPI_THREAD_SINGLE = `enum MPI_THREAD_SINGLE = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_THREAD_SINGLE); }))) {
            mixin(enumMixinStr_MPI_THREAD_SINGLE);
        }
    }




    static if(!is(typeof(MPI_ARGVS_NULL))) {
        private enum enumMixinStr_MPI_ARGVS_NULL = `enum MPI_ARGVS_NULL = cast( char * * * ) 0;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ARGVS_NULL); }))) {
            mixin(enumMixinStr_MPI_ARGVS_NULL);
        }
    }




    static if(!is(typeof(MPI_ARGV_NULL))) {
        private enum enumMixinStr_MPI_ARGV_NULL = `enum MPI_ARGV_NULL = cast( char * * ) 0;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ARGV_NULL); }))) {
            mixin(enumMixinStr_MPI_ARGV_NULL);
        }
    }






    static if(!is(typeof(MPI_ERRCODES_IGNORE))) {
        private enum enumMixinStr_MPI_ERRCODES_IGNORE = `enum MPI_ERRCODES_IGNORE = cast( int * ) 0;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERRCODES_IGNORE); }))) {
            mixin(enumMixinStr_MPI_ERRCODES_IGNORE);
        }
    }




    static if(!is(typeof(MPI_STATUSES_IGNORE))) {
        private enum enumMixinStr_MPI_STATUSES_IGNORE = `enum MPI_STATUSES_IGNORE = cast( MPI_Status * ) 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_STATUSES_IGNORE); }))) {
            mixin(enumMixinStr_MPI_STATUSES_IGNORE);
        }
    }




    static if(!is(typeof(MPI_STATUS_IGNORE))) {
        private enum enumMixinStr_MPI_STATUS_IGNORE = `enum MPI_STATUS_IGNORE = cast( MPI_Status * ) 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_STATUS_IGNORE); }))) {
            mixin(enumMixinStr_MPI_STATUS_IGNORE);
        }
    }
    static if(!is(typeof(MPI_T_PVAR_SESSION_NULL))) {
        private enum enumMixinStr_MPI_T_PVAR_SESSION_NULL = `enum MPI_T_PVAR_SESSION_NULL = ( cast( MPI_T_pvar_session ) null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_PVAR_SESSION_NULL); }))) {
            mixin(enumMixinStr_MPI_T_PVAR_SESSION_NULL);
        }
    }




    static if(!is(typeof(MPI_T_PVAR_HANDLE_NULL))) {
        private enum enumMixinStr_MPI_T_PVAR_HANDLE_NULL = `enum MPI_T_PVAR_HANDLE_NULL = ( cast( MPI_T_pvar_handle ) null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_PVAR_HANDLE_NULL); }))) {
            mixin(enumMixinStr_MPI_T_PVAR_HANDLE_NULL);
        }
    }




    static if(!is(typeof(MPI_T_CVAR_HANDLE_NULL))) {
        private enum enumMixinStr_MPI_T_CVAR_HANDLE_NULL = `enum MPI_T_CVAR_HANDLE_NULL = ( cast( MPI_T_cvar_handle ) null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_CVAR_HANDLE_NULL); }))) {
            mixin(enumMixinStr_MPI_T_CVAR_HANDLE_NULL);
        }
    }




    static if(!is(typeof(MPI_T_ENUM_NULL))) {
        private enum enumMixinStr_MPI_T_ENUM_NULL = `enum MPI_T_ENUM_NULL = ( cast( MPI_T___dpp_aggregate__ ) null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ENUM_NULL); }))) {
            mixin(enumMixinStr_MPI_T_ENUM_NULL);
        }
    }






    static if(!is(typeof(MPI_AINT_FMT_HEX_SPEC))) {
        private enum enumMixinStr_MPI_AINT_FMT_HEX_SPEC = `enum MPI_AINT_FMT_HEX_SPEC = "%lx";`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_AINT_FMT_HEX_SPEC); }))) {
            mixin(enumMixinStr_MPI_AINT_FMT_HEX_SPEC);
        }
    }




    static if(!is(typeof(MPI_AINT_FMT_DEC_SPEC))) {
        private enum enumMixinStr_MPI_AINT_FMT_DEC_SPEC = `enum MPI_AINT_FMT_DEC_SPEC = "%ld";`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_AINT_FMT_DEC_SPEC); }))) {
            mixin(enumMixinStr_MPI_AINT_FMT_DEC_SPEC);
        }
    }




    static if(!is(typeof(MPIX_COMM_TYPE_NEIGHBORHOOD))) {
        private enum enumMixinStr_MPIX_COMM_TYPE_NEIGHBORHOOD = `enum MPIX_COMM_TYPE_NEIGHBORHOOD = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIX_COMM_TYPE_NEIGHBORHOOD); }))) {
            mixin(enumMixinStr_MPIX_COMM_TYPE_NEIGHBORHOOD);
        }
    }




    static if(!is(typeof(MPI_COMM_TYPE_SHARED))) {
        private enum enumMixinStr_MPI_COMM_TYPE_SHARED = `enum MPI_COMM_TYPE_SHARED = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_TYPE_SHARED); }))) {
            mixin(enumMixinStr_MPI_COMM_TYPE_SHARED);
        }
    }




    static if(!is(typeof(MPI_MODE_NOSUCCEED))) {
        private enum enumMixinStr_MPI_MODE_NOSUCCEED = `enum MPI_MODE_NOSUCCEED = 16384;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_NOSUCCEED); }))) {
            mixin(enumMixinStr_MPI_MODE_NOSUCCEED);
        }
    }




    static if(!is(typeof(MPI_MODE_NOPRECEDE))) {
        private enum enumMixinStr_MPI_MODE_NOPRECEDE = `enum MPI_MODE_NOPRECEDE = 8192;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_NOPRECEDE); }))) {
            mixin(enumMixinStr_MPI_MODE_NOPRECEDE);
        }
    }




    static if(!is(typeof(MPI_MODE_NOPUT))) {
        private enum enumMixinStr_MPI_MODE_NOPUT = `enum MPI_MODE_NOPUT = 4096;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_NOPUT); }))) {
            mixin(enumMixinStr_MPI_MODE_NOPUT);
        }
    }




    static if(!is(typeof(MPI_MODE_NOSTORE))) {
        private enum enumMixinStr_MPI_MODE_NOSTORE = `enum MPI_MODE_NOSTORE = 2048;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_NOSTORE); }))) {
            mixin(enumMixinStr_MPI_MODE_NOSTORE);
        }
    }




    static if(!is(typeof(MPI_MODE_NOCHECK))) {
        private enum enumMixinStr_MPI_MODE_NOCHECK = `enum MPI_MODE_NOCHECK = 1024;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_NOCHECK); }))) {
            mixin(enumMixinStr_MPI_MODE_NOCHECK);
        }
    }




    static if(!is(typeof(MPI_IN_PLACE))) {
        private enum enumMixinStr_MPI_IN_PLACE = `enum MPI_IN_PLACE = cast( void * ) - 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_IN_PLACE); }))) {
            mixin(enumMixinStr_MPI_IN_PLACE);
        }
    }




    static if(!is(typeof(MPI_DISTRIBUTE_DFLT_DARG))) {
        private enum enumMixinStr_MPI_DISTRIBUTE_DFLT_DARG = `enum MPI_DISTRIBUTE_DFLT_DARG = - 49767;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DISTRIBUTE_DFLT_DARG); }))) {
            mixin(enumMixinStr_MPI_DISTRIBUTE_DFLT_DARG);
        }
    }




    static if(!is(typeof(MPI_DISTRIBUTE_NONE))) {
        private enum enumMixinStr_MPI_DISTRIBUTE_NONE = `enum MPI_DISTRIBUTE_NONE = 123;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DISTRIBUTE_NONE); }))) {
            mixin(enumMixinStr_MPI_DISTRIBUTE_NONE);
        }
    }




    static if(!is(typeof(MPI_DISTRIBUTE_CYCLIC))) {
        private enum enumMixinStr_MPI_DISTRIBUTE_CYCLIC = `enum MPI_DISTRIBUTE_CYCLIC = 122;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DISTRIBUTE_CYCLIC); }))) {
            mixin(enumMixinStr_MPI_DISTRIBUTE_CYCLIC);
        }
    }




    static if(!is(typeof(MPI_DISTRIBUTE_BLOCK))) {
        private enum enumMixinStr_MPI_DISTRIBUTE_BLOCK = `enum MPI_DISTRIBUTE_BLOCK = 121;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DISTRIBUTE_BLOCK); }))) {
            mixin(enumMixinStr_MPI_DISTRIBUTE_BLOCK);
        }
    }




    static if(!is(typeof(MPI_ORDER_FORTRAN))) {
        private enum enumMixinStr_MPI_ORDER_FORTRAN = `enum MPI_ORDER_FORTRAN = 57;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ORDER_FORTRAN); }))) {
            mixin(enumMixinStr_MPI_ORDER_FORTRAN);
        }
    }




    static if(!is(typeof(MPI_ORDER_C))) {
        private enum enumMixinStr_MPI_ORDER_C = `enum MPI_ORDER_C = 56;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ORDER_C); }))) {
            mixin(enumMixinStr_MPI_ORDER_C);
        }
    }




    static if(!is(typeof(MPI_MAX_INFO_VAL))) {
        private enum enumMixinStr_MPI_MAX_INFO_VAL = `enum MPI_MAX_INFO_VAL = 1024;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_INFO_VAL); }))) {
            mixin(enumMixinStr_MPI_MAX_INFO_VAL);
        }
    }




    static if(!is(typeof(MPI_MAX_INFO_KEY))) {
        private enum enumMixinStr_MPI_MAX_INFO_KEY = `enum MPI_MAX_INFO_KEY = 255;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_INFO_KEY); }))) {
            mixin(enumMixinStr_MPI_MAX_INFO_KEY);
        }
    }




    static if(!is(typeof(MPI_INFO_ENV))) {
        private enum enumMixinStr_MPI_INFO_ENV = `enum MPI_INFO_ENV = ( cast( MPI_Info ) 0x5c000001 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INFO_ENV); }))) {
            mixin(enumMixinStr_MPI_INFO_ENV);
        }
    }




    static if(!is(typeof(MPI_INFO_NULL))) {
        private enum enumMixinStr_MPI_INFO_NULL = `enum MPI_INFO_NULL = ( cast( MPI_Info ) 0x1c000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INFO_NULL); }))) {
            mixin(enumMixinStr_MPI_INFO_NULL);
        }
    }






    static if(!is(typeof(MPICH_RELEASE_TYPE_PATCH))) {
        private enum enumMixinStr_MPICH_RELEASE_TYPE_PATCH = `enum MPICH_RELEASE_TYPE_PATCH = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_MPICH_RELEASE_TYPE_PATCH); }))) {
            mixin(enumMixinStr_MPICH_RELEASE_TYPE_PATCH);
        }
    }




    static if(!is(typeof(MPICH_RELEASE_TYPE_RC))) {
        private enum enumMixinStr_MPICH_RELEASE_TYPE_RC = `enum MPICH_RELEASE_TYPE_RC = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPICH_RELEASE_TYPE_RC); }))) {
            mixin(enumMixinStr_MPICH_RELEASE_TYPE_RC);
        }
    }




    static if(!is(typeof(MPICH_RELEASE_TYPE_BETA))) {
        private enum enumMixinStr_MPICH_RELEASE_TYPE_BETA = `enum MPICH_RELEASE_TYPE_BETA = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPICH_RELEASE_TYPE_BETA); }))) {
            mixin(enumMixinStr_MPICH_RELEASE_TYPE_BETA);
        }
    }




    static if(!is(typeof(MPICH_RELEASE_TYPE_ALPHA))) {
        private enum enumMixinStr_MPICH_RELEASE_TYPE_ALPHA = `enum MPICH_RELEASE_TYPE_ALPHA = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_MPICH_RELEASE_TYPE_ALPHA); }))) {
            mixin(enumMixinStr_MPICH_RELEASE_TYPE_ALPHA);
        }
    }




    static if(!is(typeof(MPICH_NUMVERSION))) {
        private enum enumMixinStr_MPICH_NUMVERSION = `enum MPICH_NUMVERSION = 30300300;`;
        static if(is(typeof({ mixin(enumMixinStr_MPICH_NUMVERSION); }))) {
            mixin(enumMixinStr_MPICH_NUMVERSION);
        }
    }




    static if(!is(typeof(MPICH_VERSION))) {
        private enum enumMixinStr_MPICH_VERSION = `enum MPICH_VERSION = "3.3";`;
        static if(is(typeof({ mixin(enumMixinStr_MPICH_VERSION); }))) {
            mixin(enumMixinStr_MPICH_VERSION);
        }
    }




    static if(!is(typeof(MPICH_HAS_C2F))) {
        private enum enumMixinStr_MPICH_HAS_C2F = `enum MPICH_HAS_C2F = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPICH_HAS_C2F); }))) {
            mixin(enumMixinStr_MPICH_HAS_C2F);
        }
    }




    static if(!is(typeof(MPICH))) {
        private enum enumMixinStr_MPICH = `enum MPICH = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPICH); }))) {
            mixin(enumMixinStr_MPICH);
        }
    }




    static if(!is(typeof(MPICH_NAME))) {
        private enum enumMixinStr_MPICH_NAME = `enum MPICH_NAME = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_MPICH_NAME); }))) {
            mixin(enumMixinStr_MPICH_NAME);
        }
    }




    static if(!is(typeof(MPI_SUBVERSION))) {
        private enum enumMixinStr_MPI_SUBVERSION = `enum MPI_SUBVERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SUBVERSION); }))) {
            mixin(enumMixinStr_MPI_SUBVERSION);
        }
    }




    static if(!is(typeof(MPI_VERSION))) {
        private enum enumMixinStr_MPI_VERSION = `enum MPI_VERSION = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_VERSION); }))) {
            mixin(enumMixinStr_MPI_VERSION);
        }
    }




    static if(!is(typeof(MPI_TYPE_DUP_FN))) {
        private enum enumMixinStr_MPI_TYPE_DUP_FN = `enum MPI_TYPE_DUP_FN = ( ( MPI_Type_copy_attr_function * ) MPI_DUP_FN );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TYPE_DUP_FN); }))) {
            mixin(enumMixinStr_MPI_TYPE_DUP_FN);
        }
    }




    static if(!is(typeof(MPI_TYPE_NULL_DELETE_FN))) {
        private enum enumMixinStr_MPI_TYPE_NULL_DELETE_FN = `enum MPI_TYPE_NULL_DELETE_FN = ( ( MPI_Type_delete_attr_function * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TYPE_NULL_DELETE_FN); }))) {
            mixin(enumMixinStr_MPI_TYPE_NULL_DELETE_FN);
        }
    }




    static if(!is(typeof(MPI_TYPE_NULL_COPY_FN))) {
        private enum enumMixinStr_MPI_TYPE_NULL_COPY_FN = `enum MPI_TYPE_NULL_COPY_FN = ( ( MPI_Type_copy_attr_function * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TYPE_NULL_COPY_FN); }))) {
            mixin(enumMixinStr_MPI_TYPE_NULL_COPY_FN);
        }
    }




    static if(!is(typeof(MPI_WIN_DUP_FN))) {
        private enum enumMixinStr_MPI_WIN_DUP_FN = `enum MPI_WIN_DUP_FN = ( ( MPI_Win_copy_attr_function * ) MPI_DUP_FN );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_DUP_FN); }))) {
            mixin(enumMixinStr_MPI_WIN_DUP_FN);
        }
    }




    static if(!is(typeof(MPI_WIN_NULL_DELETE_FN))) {
        private enum enumMixinStr_MPI_WIN_NULL_DELETE_FN = `enum MPI_WIN_NULL_DELETE_FN = ( ( MPI_Win_delete_attr_function * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_NULL_DELETE_FN); }))) {
            mixin(enumMixinStr_MPI_WIN_NULL_DELETE_FN);
        }
    }




    static if(!is(typeof(MPI_WIN_NULL_COPY_FN))) {
        private enum enumMixinStr_MPI_WIN_NULL_COPY_FN = `enum MPI_WIN_NULL_COPY_FN = ( ( MPI_Win_copy_attr_function * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_NULL_COPY_FN); }))) {
            mixin(enumMixinStr_MPI_WIN_NULL_COPY_FN);
        }
    }




    static if(!is(typeof(MPI_COMM_DUP_FN))) {
        private enum enumMixinStr_MPI_COMM_DUP_FN = `enum MPI_COMM_DUP_FN = ( ( MPI_Comm_copy_attr_function * ) MPI_DUP_FN );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_DUP_FN); }))) {
            mixin(enumMixinStr_MPI_COMM_DUP_FN);
        }
    }




    static if(!is(typeof(MPI_COMM_NULL_DELETE_FN))) {
        private enum enumMixinStr_MPI_COMM_NULL_DELETE_FN = `enum MPI_COMM_NULL_DELETE_FN = ( ( MPI_Comm_delete_attr_function * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_NULL_DELETE_FN); }))) {
            mixin(enumMixinStr_MPI_COMM_NULL_DELETE_FN);
        }
    }




    static if(!is(typeof(MPI_COMM_NULL_COPY_FN))) {
        private enum enumMixinStr_MPI_COMM_NULL_COPY_FN = `enum MPI_COMM_NULL_COPY_FN = ( ( MPI_Comm_copy_attr_function * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_NULL_COPY_FN); }))) {
            mixin(enumMixinStr_MPI_COMM_NULL_COPY_FN);
        }
    }




    static if(!is(typeof(MPI_DUP_FN))) {
        private enum enumMixinStr_MPI_DUP_FN = `enum MPI_DUP_FN = MPIR_Dup_fn;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DUP_FN); }))) {
            mixin(enumMixinStr_MPI_DUP_FN);
        }
    }




    static if(!is(typeof(MPI_NULL_DELETE_FN))) {
        private enum enumMixinStr_MPI_NULL_DELETE_FN = `enum MPI_NULL_DELETE_FN = ( ( MPI_Delete_function * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_NULL_DELETE_FN); }))) {
            mixin(enumMixinStr_MPI_NULL_DELETE_FN);
        }
    }




    static if(!is(typeof(MPI_NULL_COPY_FN))) {
        private enum enumMixinStr_MPI_NULL_COPY_FN = `enum MPI_NULL_COPY_FN = ( ( MPI_Copy_function * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_NULL_COPY_FN); }))) {
            mixin(enumMixinStr_MPI_NULL_COPY_FN);
        }
    }




    static if(!is(typeof(MPIR_ERRORS_THROW_EXCEPTIONS))) {
        private enum enumMixinStr_MPIR_ERRORS_THROW_EXCEPTIONS = `enum MPIR_ERRORS_THROW_EXCEPTIONS = ( cast( MPI_Errhandler ) 0x54000002 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPIR_ERRORS_THROW_EXCEPTIONS); }))) {
            mixin(enumMixinStr_MPIR_ERRORS_THROW_EXCEPTIONS);
        }
    }




    static if(!is(typeof(MPI_ERRORS_RETURN))) {
        private enum enumMixinStr_MPI_ERRORS_RETURN = `enum MPI_ERRORS_RETURN = ( cast( MPI_Errhandler ) 0x54000001 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERRORS_RETURN); }))) {
            mixin(enumMixinStr_MPI_ERRORS_RETURN);
        }
    }




    static if(!is(typeof(MPI_ERRORS_ARE_FATAL))) {
        private enum enumMixinStr_MPI_ERRORS_ARE_FATAL = `enum MPI_ERRORS_ARE_FATAL = ( cast( MPI_Errhandler ) 0x54000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERRORS_ARE_FATAL); }))) {
            mixin(enumMixinStr_MPI_ERRORS_ARE_FATAL);
        }
    }




    static if(!is(typeof(MPI_LOCK_SHARED))) {
        private enum enumMixinStr_MPI_LOCK_SHARED = `enum MPI_LOCK_SHARED = 235;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LOCK_SHARED); }))) {
            mixin(enumMixinStr_MPI_LOCK_SHARED);
        }
    }




    static if(!is(typeof(MPI_LOCK_EXCLUSIVE))) {
        private enum enumMixinStr_MPI_LOCK_EXCLUSIVE = `enum MPI_LOCK_EXCLUSIVE = 234;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LOCK_EXCLUSIVE); }))) {
            mixin(enumMixinStr_MPI_LOCK_EXCLUSIVE);
        }
    }




    static if(!is(typeof(MPI_ANY_TAG))) {
        private enum enumMixinStr_MPI_ANY_TAG = `enum MPI_ANY_TAG = ( - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ANY_TAG); }))) {
            mixin(enumMixinStr_MPI_ANY_TAG);
        }
    }




    static if(!is(typeof(MPI_ROOT))) {
        private enum enumMixinStr_MPI_ROOT = `enum MPI_ROOT = ( - 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ROOT); }))) {
            mixin(enumMixinStr_MPI_ROOT);
        }
    }




    static if(!is(typeof(MPI_ANY_SOURCE))) {
        private enum enumMixinStr_MPI_ANY_SOURCE = `enum MPI_ANY_SOURCE = ( - 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ANY_SOURCE); }))) {
            mixin(enumMixinStr_MPI_ANY_SOURCE);
        }
    }




    static if(!is(typeof(MPI_PROC_NULL))) {
        private enum enumMixinStr_MPI_PROC_NULL = `enum MPI_PROC_NULL = ( - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_PROC_NULL); }))) {
            mixin(enumMixinStr_MPI_PROC_NULL);
        }
    }




    static if(!is(typeof(MPI_BOTTOM))) {
        private enum enumMixinStr_MPI_BOTTOM = `enum MPI_BOTTOM = cast( void * ) 0;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_BOTTOM); }))) {
            mixin(enumMixinStr_MPI_BOTTOM);
        }
    }




    static if(!is(typeof(MPI_BSEND_OVERHEAD))) {
        private enum enumMixinStr_MPI_BSEND_OVERHEAD = `enum MPI_BSEND_OVERHEAD = 96;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_BSEND_OVERHEAD); }))) {
            mixin(enumMixinStr_MPI_BSEND_OVERHEAD);
        }
    }




    static if(!is(typeof(MPI_KEYVAL_INVALID))) {
        private enum enumMixinStr_MPI_KEYVAL_INVALID = `enum MPI_KEYVAL_INVALID = 0x24000000;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_KEYVAL_INVALID); }))) {
            mixin(enumMixinStr_MPI_KEYVAL_INVALID);
        }
    }




    static if(!is(typeof(MPI_UNDEFINED))) {
        private enum enumMixinStr_MPI_UNDEFINED = `enum MPI_UNDEFINED = ( - 32766 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNDEFINED); }))) {
            mixin(enumMixinStr_MPI_UNDEFINED);
        }
    }




    static if(!is(typeof(MPI_MAX_OBJECT_NAME))) {
        private enum enumMixinStr_MPI_MAX_OBJECT_NAME = `enum MPI_MAX_OBJECT_NAME = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_OBJECT_NAME); }))) {
            mixin(enumMixinStr_MPI_MAX_OBJECT_NAME);
        }
    }




    static if(!is(typeof(MPI_MAX_PORT_NAME))) {
        private enum enumMixinStr_MPI_MAX_PORT_NAME = `enum MPI_MAX_PORT_NAME = 256;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_PORT_NAME); }))) {
            mixin(enumMixinStr_MPI_MAX_PORT_NAME);
        }
    }




    static if(!is(typeof(MPI_MAX_ERROR_STRING))) {
        private enum enumMixinStr_MPI_MAX_ERROR_STRING = `enum MPI_MAX_ERROR_STRING = 512;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_ERROR_STRING); }))) {
            mixin(enumMixinStr_MPI_MAX_ERROR_STRING);
        }
    }




    static if(!is(typeof(MPI_MAX_LIBRARY_VERSION_STRING))) {
        private enum enumMixinStr_MPI_MAX_LIBRARY_VERSION_STRING = `enum MPI_MAX_LIBRARY_VERSION_STRING = 8192;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_LIBRARY_VERSION_STRING); }))) {
            mixin(enumMixinStr_MPI_MAX_LIBRARY_VERSION_STRING);
        }
    }




    static if(!is(typeof(MPI_MAX_PROCESSOR_NAME))) {
        private enum enumMixinStr_MPI_MAX_PROCESSOR_NAME = `enum MPI_MAX_PROCESSOR_NAME = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_PROCESSOR_NAME); }))) {
            mixin(enumMixinStr_MPI_MAX_PROCESSOR_NAME);
        }
    }




    static if(!is(typeof(MPI_WIN_MODEL))) {
        private enum enumMixinStr_MPI_WIN_MODEL = `enum MPI_WIN_MODEL = 0x66000009;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_MODEL); }))) {
            mixin(enumMixinStr_MPI_WIN_MODEL);
        }
    }




    static if(!is(typeof(MPI_WIN_CREATE_FLAVOR))) {
        private enum enumMixinStr_MPI_WIN_CREATE_FLAVOR = `enum MPI_WIN_CREATE_FLAVOR = 0x66000007;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_CREATE_FLAVOR); }))) {
            mixin(enumMixinStr_MPI_WIN_CREATE_FLAVOR);
        }
    }




    static if(!is(typeof(MPI_WIN_DISP_UNIT))) {
        private enum enumMixinStr_MPI_WIN_DISP_UNIT = `enum MPI_WIN_DISP_UNIT = 0x66000005;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_DISP_UNIT); }))) {
            mixin(enumMixinStr_MPI_WIN_DISP_UNIT);
        }
    }




    static if(!is(typeof(MPI_WIN_SIZE))) {
        private enum enumMixinStr_MPI_WIN_SIZE = `enum MPI_WIN_SIZE = 0x66000003;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_SIZE); }))) {
            mixin(enumMixinStr_MPI_WIN_SIZE);
        }
    }




    static if(!is(typeof(MPI_WIN_BASE))) {
        private enum enumMixinStr_MPI_WIN_BASE = `enum MPI_WIN_BASE = 0x66000001;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_BASE); }))) {
            mixin(enumMixinStr_MPI_WIN_BASE);
        }
    }




    static if(!is(typeof(MPI_APPNUM))) {
        private enum enumMixinStr_MPI_APPNUM = `enum MPI_APPNUM = 0x6440000d;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_APPNUM); }))) {
            mixin(enumMixinStr_MPI_APPNUM);
        }
    }




    static if(!is(typeof(MPI_LASTUSEDCODE))) {
        private enum enumMixinStr_MPI_LASTUSEDCODE = `enum MPI_LASTUSEDCODE = 0x6440000b;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LASTUSEDCODE); }))) {
            mixin(enumMixinStr_MPI_LASTUSEDCODE);
        }
    }




    static if(!is(typeof(MPI_UNIVERSE_SIZE))) {
        private enum enumMixinStr_MPI_UNIVERSE_SIZE = `enum MPI_UNIVERSE_SIZE = 0x64400009;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNIVERSE_SIZE); }))) {
            mixin(enumMixinStr_MPI_UNIVERSE_SIZE);
        }
    }




    static if(!is(typeof(MPI_WTIME_IS_GLOBAL))) {
        private enum enumMixinStr_MPI_WTIME_IS_GLOBAL = `enum MPI_WTIME_IS_GLOBAL = 0x64400007;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WTIME_IS_GLOBAL); }))) {
            mixin(enumMixinStr_MPI_WTIME_IS_GLOBAL);
        }
    }




    static if(!is(typeof(MPI_IO))) {
        private enum enumMixinStr_MPI_IO = `enum MPI_IO = 0x64400005;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_IO); }))) {
            mixin(enumMixinStr_MPI_IO);
        }
    }




    static if(!is(typeof(MPI_HOST))) {
        private enum enumMixinStr_MPI_HOST = `enum MPI_HOST = 0x64400003;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_HOST); }))) {
            mixin(enumMixinStr_MPI_HOST);
        }
    }




    static if(!is(typeof(MPI_TAG_UB))) {
        private enum enumMixinStr_MPI_TAG_UB = `enum MPI_TAG_UB = 0x64400001;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TAG_UB); }))) {
            mixin(enumMixinStr_MPI_TAG_UB);
        }
    }




    static if(!is(typeof(MPI_NO_OP))) {
        private enum enumMixinStr_MPI_NO_OP = `enum MPI_NO_OP = cast( MPI_Op ) ( 0x5800000e );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_NO_OP); }))) {
            mixin(enumMixinStr_MPI_NO_OP);
        }
    }




    static if(!is(typeof(MPI_REPLACE))) {
        private enum enumMixinStr_MPI_REPLACE = `enum MPI_REPLACE = cast( MPI_Op ) ( 0x5800000d );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_REPLACE); }))) {
            mixin(enumMixinStr_MPI_REPLACE);
        }
    }




    static if(!is(typeof(MPI_MAXLOC))) {
        private enum enumMixinStr_MPI_MAXLOC = `enum MPI_MAXLOC = cast( MPI_Op ) ( 0x5800000c );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAXLOC); }))) {
            mixin(enumMixinStr_MPI_MAXLOC);
        }
    }




    static if(!is(typeof(MPI_MINLOC))) {
        private enum enumMixinStr_MPI_MINLOC = `enum MPI_MINLOC = cast( MPI_Op ) ( 0x5800000b );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MINLOC); }))) {
            mixin(enumMixinStr_MPI_MINLOC);
        }
    }




    static if(!is(typeof(MPI_BXOR))) {
        private enum enumMixinStr_MPI_BXOR = `enum MPI_BXOR = cast( MPI_Op ) ( 0x5800000a );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_BXOR); }))) {
            mixin(enumMixinStr_MPI_BXOR);
        }
    }




    static if(!is(typeof(MPI_LXOR))) {
        private enum enumMixinStr_MPI_LXOR = `enum MPI_LXOR = cast( MPI_Op ) ( 0x58000009 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LXOR); }))) {
            mixin(enumMixinStr_MPI_LXOR);
        }
    }




    static if(!is(typeof(MPI_BOR))) {
        private enum enumMixinStr_MPI_BOR = `enum MPI_BOR = cast( MPI_Op ) ( 0x58000008 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_BOR); }))) {
            mixin(enumMixinStr_MPI_BOR);
        }
    }




    static if(!is(typeof(MPI_LOR))) {
        private enum enumMixinStr_MPI_LOR = `enum MPI_LOR = cast( MPI_Op ) ( 0x58000007 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LOR); }))) {
            mixin(enumMixinStr_MPI_LOR);
        }
    }




    static if(!is(typeof(MPI_BAND))) {
        private enum enumMixinStr_MPI_BAND = `enum MPI_BAND = cast( MPI_Op ) ( 0x58000006 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_BAND); }))) {
            mixin(enumMixinStr_MPI_BAND);
        }
    }




    static if(!is(typeof(MPI_LAND))) {
        private enum enumMixinStr_MPI_LAND = `enum MPI_LAND = cast( MPI_Op ) ( 0x58000005 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LAND); }))) {
            mixin(enumMixinStr_MPI_LAND);
        }
    }




    static if(!is(typeof(MPI_PROD))) {
        private enum enumMixinStr_MPI_PROD = `enum MPI_PROD = cast( MPI_Op ) ( 0x58000004 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_PROD); }))) {
            mixin(enumMixinStr_MPI_PROD);
        }
    }




    static if(!is(typeof(MPI_SUM))) {
        private enum enumMixinStr_MPI_SUM = `enum MPI_SUM = cast( MPI_Op ) ( 0x58000003 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SUM); }))) {
            mixin(enumMixinStr_MPI_SUM);
        }
    }




    static if(!is(typeof(MPI_MIN))) {
        private enum enumMixinStr_MPI_MIN = `enum MPI_MIN = cast( MPI_Op ) ( 0x58000002 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MIN); }))) {
            mixin(enumMixinStr_MPI_MIN);
        }
    }




    static if(!is(typeof(MPI_MAX))) {
        private enum enumMixinStr_MPI_MAX = `enum MPI_MAX = cast( MPI_Op ) ( 0x58000001 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX); }))) {
            mixin(enumMixinStr_MPI_MAX);
        }
    }




    static if(!is(typeof(MPI_FILE_NULL))) {
        private enum enumMixinStr_MPI_FILE_NULL = `enum MPI_FILE_NULL = ( cast( MPI_File ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_FILE_NULL); }))) {
            mixin(enumMixinStr_MPI_FILE_NULL);
        }
    }






    static if(!is(typeof(MPI_WIN_NULL))) {
        private enum enumMixinStr_MPI_WIN_NULL = `enum MPI_WIN_NULL = ( cast( MPI_Win ) 0x20000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_NULL); }))) {
            mixin(enumMixinStr_MPI_WIN_NULL);
        }
    }




    static if(!is(typeof(MPI_GROUP_EMPTY))) {
        private enum enumMixinStr_MPI_GROUP_EMPTY = `enum MPI_GROUP_EMPTY = ( cast( MPI_Group ) 0x48000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_GROUP_EMPTY); }))) {
            mixin(enumMixinStr_MPI_GROUP_EMPTY);
        }
    }




    static if(!is(typeof(MPI_COMM_SELF))) {
        private enum enumMixinStr_MPI_COMM_SELF = `enum MPI_COMM_SELF = ( cast( MPI_Comm ) 0x44000001 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_SELF); }))) {
            mixin(enumMixinStr_MPI_COMM_SELF);
        }
    }




    static if(!is(typeof(MPI_COMM_WORLD))) {
        private enum enumMixinStr_MPI_COMM_WORLD = `enum MPI_COMM_WORLD = ( cast( MPI_Comm ) 0x44000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_WORLD); }))) {
            mixin(enumMixinStr_MPI_COMM_WORLD);
        }
    }




    static if(!is(typeof(MPI_TYPECLASS_COMPLEX))) {
        private enum enumMixinStr_MPI_TYPECLASS_COMPLEX = `enum MPI_TYPECLASS_COMPLEX = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TYPECLASS_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_TYPECLASS_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_TYPECLASS_INTEGER))) {
        private enum enumMixinStr_MPI_TYPECLASS_INTEGER = `enum MPI_TYPECLASS_INTEGER = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TYPECLASS_INTEGER); }))) {
            mixin(enumMixinStr_MPI_TYPECLASS_INTEGER);
        }
    }




    static if(!is(typeof(MPI_TYPECLASS_REAL))) {
        private enum enumMixinStr_MPI_TYPECLASS_REAL = `enum MPI_TYPECLASS_REAL = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TYPECLASS_REAL); }))) {
            mixin(enumMixinStr_MPI_TYPECLASS_REAL);
        }
    }




    static if(!is(typeof(MPI_CXX_LONG_DOUBLE_COMPLEX))) {
        private enum enumMixinStr_MPI_CXX_LONG_DOUBLE_COMPLEX = `enum MPI_CXX_LONG_DOUBLE_COMPLEX = ( cast( MPI_Datatype ) 0x4c002036 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CXX_LONG_DOUBLE_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_CXX_LONG_DOUBLE_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_CXX_DOUBLE_COMPLEX))) {
        private enum enumMixinStr_MPI_CXX_DOUBLE_COMPLEX = `enum MPI_CXX_DOUBLE_COMPLEX = ( cast( MPI_Datatype ) 0x4c001035 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CXX_DOUBLE_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_CXX_DOUBLE_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_CXX_FLOAT_COMPLEX))) {
        private enum enumMixinStr_MPI_CXX_FLOAT_COMPLEX = `enum MPI_CXX_FLOAT_COMPLEX = ( cast( MPI_Datatype ) 0x4c000834 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CXX_FLOAT_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_CXX_FLOAT_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_CXX_BOOL))) {
        private enum enumMixinStr_MPI_CXX_BOOL = `enum MPI_CXX_BOOL = ( cast( MPI_Datatype ) 0x4c000133 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CXX_BOOL); }))) {
            mixin(enumMixinStr_MPI_CXX_BOOL);
        }
    }




    static if(!is(typeof(MPI_COUNT))) {
        private enum enumMixinStr_MPI_COUNT = `enum MPI_COUNT = ( cast( MPI_Datatype ) 0x4c000845 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COUNT); }))) {
            mixin(enumMixinStr_MPI_COUNT);
        }
    }




    static if(!is(typeof(MPI_OFFSET))) {
        private enum enumMixinStr_MPI_OFFSET = `enum MPI_OFFSET = ( cast( MPI_Datatype ) 0x4c000844 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_OFFSET); }))) {
            mixin(enumMixinStr_MPI_OFFSET);
        }
    }




    static if(!is(typeof(MPI_AINT))) {
        private enum enumMixinStr_MPI_AINT = `enum MPI_AINT = ( cast( MPI_Datatype ) 0x4c000843 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_AINT); }))) {
            mixin(enumMixinStr_MPI_AINT);
        }
    }




    static if(!is(typeof(MPI_C_LONG_DOUBLE_COMPLEX))) {
        private enum enumMixinStr_MPI_C_LONG_DOUBLE_COMPLEX = `enum MPI_C_LONG_DOUBLE_COMPLEX = ( cast( MPI_Datatype ) 0x4c002042 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_C_LONG_DOUBLE_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_C_LONG_DOUBLE_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_C_DOUBLE_COMPLEX))) {
        private enum enumMixinStr_MPI_C_DOUBLE_COMPLEX = `enum MPI_C_DOUBLE_COMPLEX = ( cast( MPI_Datatype ) 0x4c001041 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_C_DOUBLE_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_C_DOUBLE_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_C_COMPLEX))) {
        private enum enumMixinStr_MPI_C_COMPLEX = `enum MPI_C_COMPLEX = MPI_C_FLOAT_COMPLEX;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_C_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_C_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_C_FLOAT_COMPLEX))) {
        private enum enumMixinStr_MPI_C_FLOAT_COMPLEX = `enum MPI_C_FLOAT_COMPLEX = ( cast( MPI_Datatype ) 0x4c000840 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_C_FLOAT_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_C_FLOAT_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_C_BOOL))) {
        private enum enumMixinStr_MPI_C_BOOL = `enum MPI_C_BOOL = ( cast( MPI_Datatype ) 0x4c00013f );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_C_BOOL); }))) {
            mixin(enumMixinStr_MPI_C_BOOL);
        }
    }




    static if(!is(typeof(MPI_UINT64_T))) {
        private enum enumMixinStr_MPI_UINT64_T = `enum MPI_UINT64_T = ( cast( MPI_Datatype ) 0x4c00083e );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UINT64_T); }))) {
            mixin(enumMixinStr_MPI_UINT64_T);
        }
    }




    static if(!is(typeof(MPI_UINT32_T))) {
        private enum enumMixinStr_MPI_UINT32_T = `enum MPI_UINT32_T = ( cast( MPI_Datatype ) 0x4c00043d );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UINT32_T); }))) {
            mixin(enumMixinStr_MPI_UINT32_T);
        }
    }




    static if(!is(typeof(MPI_UINT16_T))) {
        private enum enumMixinStr_MPI_UINT16_T = `enum MPI_UINT16_T = ( cast( MPI_Datatype ) 0x4c00023c );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UINT16_T); }))) {
            mixin(enumMixinStr_MPI_UINT16_T);
        }
    }




    static if(!is(typeof(MPI_UINT8_T))) {
        private enum enumMixinStr_MPI_UINT8_T = `enum MPI_UINT8_T = ( cast( MPI_Datatype ) 0x4c00013b );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UINT8_T); }))) {
            mixin(enumMixinStr_MPI_UINT8_T);
        }
    }




    static if(!is(typeof(MPI_INT64_T))) {
        private enum enumMixinStr_MPI_INT64_T = `enum MPI_INT64_T = ( cast( MPI_Datatype ) 0x4c00083a );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INT64_T); }))) {
            mixin(enumMixinStr_MPI_INT64_T);
        }
    }




    static if(!is(typeof(MPI_INT32_T))) {
        private enum enumMixinStr_MPI_INT32_T = `enum MPI_INT32_T = ( cast( MPI_Datatype ) 0x4c000439 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INT32_T); }))) {
            mixin(enumMixinStr_MPI_INT32_T);
        }
    }




    static if(!is(typeof(MPI_INT16_T))) {
        private enum enumMixinStr_MPI_INT16_T = `enum MPI_INT16_T = ( cast( MPI_Datatype ) 0x4c000238 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INT16_T); }))) {
            mixin(enumMixinStr_MPI_INT16_T);
        }
    }




    static if(!is(typeof(MPI_INT8_T))) {
        private enum enumMixinStr_MPI_INT8_T = `enum MPI_INT8_T = ( cast( MPI_Datatype ) 0x4c000137 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INT8_T); }))) {
            mixin(enumMixinStr_MPI_INT8_T);
        }
    }




    static if(!is(typeof(MPI_INTEGER16))) {
        private enum enumMixinStr_MPI_INTEGER16 = `enum MPI_INTEGER16 = ( cast( MPI_Datatype ) MPI_DATATYPE_NULL );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INTEGER16); }))) {
            mixin(enumMixinStr_MPI_INTEGER16);
        }
    }




    static if(!is(typeof(MPI_INTEGER8))) {
        private enum enumMixinStr_MPI_INTEGER8 = `enum MPI_INTEGER8 = ( cast( MPI_Datatype ) 0x4c000831 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INTEGER8); }))) {
            mixin(enumMixinStr_MPI_INTEGER8);
        }
    }




    static if(!is(typeof(MPI_INTEGER4))) {
        private enum enumMixinStr_MPI_INTEGER4 = `enum MPI_INTEGER4 = ( cast( MPI_Datatype ) 0x4c000430 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INTEGER4); }))) {
            mixin(enumMixinStr_MPI_INTEGER4);
        }
    }




    static if(!is(typeof(MPI_INTEGER2))) {
        private enum enumMixinStr_MPI_INTEGER2 = `enum MPI_INTEGER2 = ( cast( MPI_Datatype ) 0x4c00022f );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INTEGER2); }))) {
            mixin(enumMixinStr_MPI_INTEGER2);
        }
    }




    static if(!is(typeof(MPI_INTEGER1))) {
        private enum enumMixinStr_MPI_INTEGER1 = `enum MPI_INTEGER1 = ( cast( MPI_Datatype ) 0x4c00012d );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INTEGER1); }))) {
            mixin(enumMixinStr_MPI_INTEGER1);
        }
    }




    static if(!is(typeof(MPI_COMPLEX32))) {
        private enum enumMixinStr_MPI_COMPLEX32 = `enum MPI_COMPLEX32 = ( cast( MPI_Datatype ) 0x4c00202c );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMPLEX32); }))) {
            mixin(enumMixinStr_MPI_COMPLEX32);
        }
    }




    static if(!is(typeof(MPI_COMPLEX16))) {
        private enum enumMixinStr_MPI_COMPLEX16 = `enum MPI_COMPLEX16 = ( cast( MPI_Datatype ) 0x4c00102a );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMPLEX16); }))) {
            mixin(enumMixinStr_MPI_COMPLEX16);
        }
    }




    static if(!is(typeof(MPI_COMPLEX8))) {
        private enum enumMixinStr_MPI_COMPLEX8 = `enum MPI_COMPLEX8 = ( cast( MPI_Datatype ) 0x4c000828 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMPLEX8); }))) {
            mixin(enumMixinStr_MPI_COMPLEX8);
        }
    }




    static if(!is(typeof(MPI_REAL16))) {
        private enum enumMixinStr_MPI_REAL16 = `enum MPI_REAL16 = ( cast( MPI_Datatype ) 0x4c00102b );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_REAL16); }))) {
            mixin(enumMixinStr_MPI_REAL16);
        }
    }




    static if(!is(typeof(MPI_REAL8))) {
        private enum enumMixinStr_MPI_REAL8 = `enum MPI_REAL8 = ( cast( MPI_Datatype ) 0x4c000829 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_REAL8); }))) {
            mixin(enumMixinStr_MPI_REAL8);
        }
    }




    static if(!is(typeof(MPI_REAL4))) {
        private enum enumMixinStr_MPI_REAL4 = `enum MPI_REAL4 = ( cast( MPI_Datatype ) 0x4c000427 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_REAL4); }))) {
            mixin(enumMixinStr_MPI_REAL4);
        }
    }




    static if(!is(typeof(MPI_CHARACTER))) {
        private enum enumMixinStr_MPI_CHARACTER = `enum MPI_CHARACTER = ( cast( MPI_Datatype ) 1275068698 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CHARACTER); }))) {
            mixin(enumMixinStr_MPI_CHARACTER);
        }
    }




    static if(!is(typeof(MPI_2DOUBLE_PRECISION))) {
        private enum enumMixinStr_MPI_2DOUBLE_PRECISION = `enum MPI_2DOUBLE_PRECISION = ( cast( MPI_Datatype ) 1275072547 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_2DOUBLE_PRECISION); }))) {
            mixin(enumMixinStr_MPI_2DOUBLE_PRECISION);
        }
    }




    static if(!is(typeof(MPI_2REAL))) {
        private enum enumMixinStr_MPI_2REAL = `enum MPI_2REAL = ( cast( MPI_Datatype ) 1275070497 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_2REAL); }))) {
            mixin(enumMixinStr_MPI_2REAL);
        }
    }




    static if(!is(typeof(MPI_2INTEGER))) {
        private enum enumMixinStr_MPI_2INTEGER = `enum MPI_2INTEGER = ( cast( MPI_Datatype ) 1275070496 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_2INTEGER); }))) {
            mixin(enumMixinStr_MPI_2INTEGER);
        }
    }




    static if(!is(typeof(MPI_INTEGER))) {
        private enum enumMixinStr_MPI_INTEGER = `enum MPI_INTEGER = ( cast( MPI_Datatype ) 1275069467 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INTEGER); }))) {
            mixin(enumMixinStr_MPI_INTEGER);
        }
    }




    static if(!is(typeof(MPI_DOUBLE_PRECISION))) {
        private enum enumMixinStr_MPI_DOUBLE_PRECISION = `enum MPI_DOUBLE_PRECISION = ( cast( MPI_Datatype ) 1275070495 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DOUBLE_PRECISION); }))) {
            mixin(enumMixinStr_MPI_DOUBLE_PRECISION);
        }
    }




    static if(!is(typeof(MPI_REAL))) {
        private enum enumMixinStr_MPI_REAL = `enum MPI_REAL = ( cast( MPI_Datatype ) 1275069468 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_REAL); }))) {
            mixin(enumMixinStr_MPI_REAL);
        }
    }




    static if(!is(typeof(MPI_LOGICAL))) {
        private enum enumMixinStr_MPI_LOGICAL = `enum MPI_LOGICAL = ( cast( MPI_Datatype ) 1275069469 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LOGICAL); }))) {
            mixin(enumMixinStr_MPI_LOGICAL);
        }
    }




    static if(!is(typeof(MPI_DOUBLE_COMPLEX))) {
        private enum enumMixinStr_MPI_DOUBLE_COMPLEX = `enum MPI_DOUBLE_COMPLEX = ( cast( MPI_Datatype ) 1275072546 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DOUBLE_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_DOUBLE_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_COMPLEX))) {
        private enum enumMixinStr_MPI_COMPLEX = `enum MPI_COMPLEX = ( cast( MPI_Datatype ) 1275070494 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_LONG_DOUBLE_INT))) {
        private enum enumMixinStr_MPI_LONG_DOUBLE_INT = `enum MPI_LONG_DOUBLE_INT = ( cast( MPI_Datatype ) 0x8c000004 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LONG_DOUBLE_INT); }))) {
            mixin(enumMixinStr_MPI_LONG_DOUBLE_INT);
        }
    }




    static if(!is(typeof(MPI_2INT))) {
        private enum enumMixinStr_MPI_2INT = `enum MPI_2INT = ( cast( MPI_Datatype ) 0x4c000816 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_2INT); }))) {
            mixin(enumMixinStr_MPI_2INT);
        }
    }




    static if(!is(typeof(MPI_SHORT_INT))) {
        private enum enumMixinStr_MPI_SHORT_INT = `enum MPI_SHORT_INT = ( cast( MPI_Datatype ) 0x8c000003 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SHORT_INT); }))) {
            mixin(enumMixinStr_MPI_SHORT_INT);
        }
    }




    static if(!is(typeof(MPI_LONG_INT))) {
        private enum enumMixinStr_MPI_LONG_INT = `enum MPI_LONG_INT = ( cast( MPI_Datatype ) 0x8c000002 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LONG_INT); }))) {
            mixin(enumMixinStr_MPI_LONG_INT);
        }
    }




    static if(!is(typeof(MPI_DOUBLE_INT))) {
        private enum enumMixinStr_MPI_DOUBLE_INT = `enum MPI_DOUBLE_INT = ( cast( MPI_Datatype ) 0x8c000001 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DOUBLE_INT); }))) {
            mixin(enumMixinStr_MPI_DOUBLE_INT);
        }
    }




    static if(!is(typeof(MPI_FLOAT_INT))) {
        private enum enumMixinStr_MPI_FLOAT_INT = `enum MPI_FLOAT_INT = ( cast( MPI_Datatype ) 0x8c000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_FLOAT_INT); }))) {
            mixin(enumMixinStr_MPI_FLOAT_INT);
        }
    }




    static if(!is(typeof(MPI_UB))) {
        private enum enumMixinStr_MPI_UB = `enum MPI_UB = ( cast( MPI_Datatype ) 0x4c000011 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UB); }))) {
            mixin(enumMixinStr_MPI_UB);
        }
    }




    static if(!is(typeof(MPI_LB))) {
        private enum enumMixinStr_MPI_LB = `enum MPI_LB = ( cast( MPI_Datatype ) 0x4c000010 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LB); }))) {
            mixin(enumMixinStr_MPI_LB);
        }
    }




    static if(!is(typeof(MPI_PACKED))) {
        private enum enumMixinStr_MPI_PACKED = `enum MPI_PACKED = ( cast( MPI_Datatype ) 0x4c00010f );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_PACKED); }))) {
            mixin(enumMixinStr_MPI_PACKED);
        }
    }




    static if(!is(typeof(MPI_LONG_LONG))) {
        private enum enumMixinStr_MPI_LONG_LONG = `enum MPI_LONG_LONG = MPI_LONG_LONG_INT;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LONG_LONG); }))) {
            mixin(enumMixinStr_MPI_LONG_LONG);
        }
    }




    static if(!is(typeof(MPI_UNSIGNED_LONG_LONG))) {
        private enum enumMixinStr_MPI_UNSIGNED_LONG_LONG = `enum MPI_UNSIGNED_LONG_LONG = ( cast( MPI_Datatype ) 0x4c000819 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNSIGNED_LONG_LONG); }))) {
            mixin(enumMixinStr_MPI_UNSIGNED_LONG_LONG);
        }
    }




    static if(!is(typeof(MPI_LONG_LONG_INT))) {
        private enum enumMixinStr_MPI_LONG_LONG_INT = `enum MPI_LONG_LONG_INT = ( cast( MPI_Datatype ) 0x4c000809 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LONG_LONG_INT); }))) {
            mixin(enumMixinStr_MPI_LONG_LONG_INT);
        }
    }




    static if(!is(typeof(MPI_LONG_DOUBLE))) {
        private enum enumMixinStr_MPI_LONG_DOUBLE = `enum MPI_LONG_DOUBLE = ( cast( MPI_Datatype ) 0x4c00100c );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LONG_DOUBLE); }))) {
            mixin(enumMixinStr_MPI_LONG_DOUBLE);
        }
    }




    static if(!is(typeof(MPI_DOUBLE))) {
        private enum enumMixinStr_MPI_DOUBLE = `enum MPI_DOUBLE = ( cast( MPI_Datatype ) 0x4c00080b );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DOUBLE); }))) {
            mixin(enumMixinStr_MPI_DOUBLE);
        }
    }




    static if(!is(typeof(MPI_FLOAT))) {
        private enum enumMixinStr_MPI_FLOAT = `enum MPI_FLOAT = ( cast( MPI_Datatype ) 0x4c00040a );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_FLOAT); }))) {
            mixin(enumMixinStr_MPI_FLOAT);
        }
    }




    static if(!is(typeof(MPI_UNSIGNED_LONG))) {
        private enum enumMixinStr_MPI_UNSIGNED_LONG = `enum MPI_UNSIGNED_LONG = ( cast( MPI_Datatype ) 0x4c000808 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNSIGNED_LONG); }))) {
            mixin(enumMixinStr_MPI_UNSIGNED_LONG);
        }
    }




    static if(!is(typeof(MPI_LONG))) {
        private enum enumMixinStr_MPI_LONG = `enum MPI_LONG = ( cast( MPI_Datatype ) 0x4c000807 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LONG); }))) {
            mixin(enumMixinStr_MPI_LONG);
        }
    }




    static if(!is(typeof(MPI_UNSIGNED))) {
        private enum enumMixinStr_MPI_UNSIGNED = `enum MPI_UNSIGNED = ( cast( MPI_Datatype ) 0x4c000406 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNSIGNED); }))) {
            mixin(enumMixinStr_MPI_UNSIGNED);
        }
    }




    static if(!is(typeof(MPI_INT))) {
        private enum enumMixinStr_MPI_INT = `enum MPI_INT = ( cast( MPI_Datatype ) 0x4c000405 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INT); }))) {
            mixin(enumMixinStr_MPI_INT);
        }
    }




    static if(!is(typeof(MPI_UNSIGNED_SHORT))) {
        private enum enumMixinStr_MPI_UNSIGNED_SHORT = `enum MPI_UNSIGNED_SHORT = ( cast( MPI_Datatype ) 0x4c000204 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNSIGNED_SHORT); }))) {
            mixin(enumMixinStr_MPI_UNSIGNED_SHORT);
        }
    }




    static if(!is(typeof(MPI_SHORT))) {
        private enum enumMixinStr_MPI_SHORT = `enum MPI_SHORT = ( cast( MPI_Datatype ) 0x4c000203 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SHORT); }))) {
            mixin(enumMixinStr_MPI_SHORT);
        }
    }




    static if(!is(typeof(MPI_WCHAR))) {
        private enum enumMixinStr_MPI_WCHAR = `enum MPI_WCHAR = ( cast( MPI_Datatype ) 0x4c00040e );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WCHAR); }))) {
            mixin(enumMixinStr_MPI_WCHAR);
        }
    }




    static if(!is(typeof(MPI_BYTE))) {
        private enum enumMixinStr_MPI_BYTE = `enum MPI_BYTE = ( cast( MPI_Datatype ) 0x4c00010d );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_BYTE); }))) {
            mixin(enumMixinStr_MPI_BYTE);
        }
    }




    static if(!is(typeof(MPI_UNSIGNED_CHAR))) {
        private enum enumMixinStr_MPI_UNSIGNED_CHAR = `enum MPI_UNSIGNED_CHAR = ( cast( MPI_Datatype ) 0x4c000102 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNSIGNED_CHAR); }))) {
            mixin(enumMixinStr_MPI_UNSIGNED_CHAR);
        }
    }




    static if(!is(typeof(MPI_SIGNED_CHAR))) {
        private enum enumMixinStr_MPI_SIGNED_CHAR = `enum MPI_SIGNED_CHAR = ( cast( MPI_Datatype ) 0x4c000118 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SIGNED_CHAR); }))) {
            mixin(enumMixinStr_MPI_SIGNED_CHAR);
        }
    }




    static if(!is(typeof(MPI_CHAR))) {
        private enum enumMixinStr_MPI_CHAR = `enum MPI_CHAR = ( cast( MPI_Datatype ) 0x4c000101 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CHAR); }))) {
            mixin(enumMixinStr_MPI_CHAR);
        }
    }




    static if(!is(typeof(MPI_UNEQUAL))) {
        private enum enumMixinStr_MPI_UNEQUAL = `enum MPI_UNEQUAL = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNEQUAL); }))) {
            mixin(enumMixinStr_MPI_UNEQUAL);
        }
    }




    static if(!is(typeof(MPI_SIMILAR))) {
        private enum enumMixinStr_MPI_SIMILAR = `enum MPI_SIMILAR = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SIMILAR); }))) {
            mixin(enumMixinStr_MPI_SIMILAR);
        }
    }




    static if(!is(typeof(MPI_CONGRUENT))) {
        private enum enumMixinStr_MPI_CONGRUENT = `enum MPI_CONGRUENT = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CONGRUENT); }))) {
            mixin(enumMixinStr_MPI_CONGRUENT);
        }
    }




    static if(!is(typeof(MPI_IDENT))) {
        private enum enumMixinStr_MPI_IDENT = `enum MPI_IDENT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_IDENT); }))) {
            mixin(enumMixinStr_MPI_IDENT);
        }
    }




    static if(!is(typeof(MPI_MESSAGE_NO_PROC))) {
        private enum enumMixinStr_MPI_MESSAGE_NO_PROC = `enum MPI_MESSAGE_NO_PROC = ( cast( MPI_Message ) 0x6c000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MESSAGE_NO_PROC); }))) {
            mixin(enumMixinStr_MPI_MESSAGE_NO_PROC);
        }
    }




    static if(!is(typeof(MPI_MESSAGE_NULL))) {
        private enum enumMixinStr_MPI_MESSAGE_NULL = `enum MPI_MESSAGE_NULL = ( cast( MPI_Message ) 0x2c000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MESSAGE_NULL); }))) {
            mixin(enumMixinStr_MPI_MESSAGE_NULL);
        }
    }




    static if(!is(typeof(MPI_ERRHANDLER_NULL))) {
        private enum enumMixinStr_MPI_ERRHANDLER_NULL = `enum MPI_ERRHANDLER_NULL = ( cast( MPI_Errhandler ) 0x14000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERRHANDLER_NULL); }))) {
            mixin(enumMixinStr_MPI_ERRHANDLER_NULL);
        }
    }




    static if(!is(typeof(MPI_REQUEST_NULL))) {
        private enum enumMixinStr_MPI_REQUEST_NULL = `enum MPI_REQUEST_NULL = ( cast( MPI_Request ) 0x2c000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_REQUEST_NULL); }))) {
            mixin(enumMixinStr_MPI_REQUEST_NULL);
        }
    }




    static if(!is(typeof(MPI_DATATYPE_NULL))) {
        private enum enumMixinStr_MPI_DATATYPE_NULL = `enum MPI_DATATYPE_NULL = ( cast( MPI_Datatype ) 0x0c000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DATATYPE_NULL); }))) {
            mixin(enumMixinStr_MPI_DATATYPE_NULL);
        }
    }




    static if(!is(typeof(MPI_GROUP_NULL))) {
        private enum enumMixinStr_MPI_GROUP_NULL = `enum MPI_GROUP_NULL = ( cast( MPI_Group ) 0x08000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_GROUP_NULL); }))) {
            mixin(enumMixinStr_MPI_GROUP_NULL);
        }
    }




    static if(!is(typeof(MPI_OP_NULL))) {
        private enum enumMixinStr_MPI_OP_NULL = `enum MPI_OP_NULL = ( cast( MPI_Op ) 0x18000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_OP_NULL); }))) {
            mixin(enumMixinStr_MPI_OP_NULL);
        }
    }




    static if(!is(typeof(MPI_COMM_NULL))) {
        private enum enumMixinStr_MPI_COMM_NULL = `enum MPI_COMM_NULL = ( cast( MPI_Comm ) 0x04000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_NULL); }))) {
            mixin(enumMixinStr_MPI_COMM_NULL);
        }
    }
    static if(!is(typeof(NO_TAGS_WITH_MODIFIERS))) {
        private enum enumMixinStr_NO_TAGS_WITH_MODIFIERS = `enum NO_TAGS_WITH_MODIFIERS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_NO_TAGS_WITH_MODIFIERS); }))) {
            mixin(enumMixinStr_NO_TAGS_WITH_MODIFIERS);
        }
    }
    static if(!is(typeof(__SYSCALL_WORDSIZE))) {
        private enum enumMixinStr___SYSCALL_WORDSIZE = `enum __SYSCALL_WORDSIZE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_WORDSIZE); }))) {
            mixin(enumMixinStr___SYSCALL_WORDSIZE);
        }
    }




    static if(!is(typeof(__WORDSIZE_TIME64_COMPAT32))) {
        private enum enumMixinStr___WORDSIZE_TIME64_COMPAT32 = `enum __WORDSIZE_TIME64_COMPAT32 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___WORDSIZE_TIME64_COMPAT32); }))) {
            mixin(enumMixinStr___WORDSIZE_TIME64_COMPAT32);
        }
    }




    static if(!is(typeof(__WORDSIZE))) {
        private enum enumMixinStr___WORDSIZE = `enum __WORDSIZE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___WORDSIZE); }))) {
            mixin(enumMixinStr___WORDSIZE);
        }
    }




    static if(!is(typeof(__WCHAR_MIN))) {
        private enum enumMixinStr___WCHAR_MIN = `enum __WCHAR_MIN = ( - __WCHAR_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr___WCHAR_MIN); }))) {
            mixin(enumMixinStr___WCHAR_MIN);
        }
    }




    static if(!is(typeof(__WCHAR_MAX))) {
        private enum enumMixinStr___WCHAR_MAX = `enum __WCHAR_MAX = 0x7fffffff;`;
        static if(is(typeof({ mixin(enumMixinStr___WCHAR_MAX); }))) {
            mixin(enumMixinStr___WCHAR_MAX);
        }
    }




    static if(!is(typeof(_BITS_WCHAR_H))) {
        private enum enumMixinStr__BITS_WCHAR_H = `enum _BITS_WCHAR_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_WCHAR_H); }))) {
            mixin(enumMixinStr__BITS_WCHAR_H);
        }
    }




    static if(!is(typeof(__FD_SETSIZE))) {
        private enum enumMixinStr___FD_SETSIZE = `enum __FD_SETSIZE = 1024;`;
        static if(is(typeof({ mixin(enumMixinStr___FD_SETSIZE); }))) {
            mixin(enumMixinStr___FD_SETSIZE);
        }
    }




    static if(!is(typeof(__RLIM_T_MATCHES_RLIM64_T))) {
        private enum enumMixinStr___RLIM_T_MATCHES_RLIM64_T = `enum __RLIM_T_MATCHES_RLIM64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM_T_MATCHES_RLIM64_T); }))) {
            mixin(enumMixinStr___RLIM_T_MATCHES_RLIM64_T);
        }
    }




    static if(!is(typeof(__INO_T_MATCHES_INO64_T))) {
        private enum enumMixinStr___INO_T_MATCHES_INO64_T = `enum __INO_T_MATCHES_INO64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___INO_T_MATCHES_INO64_T); }))) {
            mixin(enumMixinStr___INO_T_MATCHES_INO64_T);
        }
    }




    static if(!is(typeof(__OFF_T_MATCHES_OFF64_T))) {
        private enum enumMixinStr___OFF_T_MATCHES_OFF64_T = `enum __OFF_T_MATCHES_OFF64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF_T_MATCHES_OFF64_T); }))) {
            mixin(enumMixinStr___OFF_T_MATCHES_OFF64_T);
        }
    }




    static if(!is(typeof(__CPU_MASK_TYPE))) {
        private enum enumMixinStr___CPU_MASK_TYPE = `enum __CPU_MASK_TYPE = __SYSCALL_ULONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___CPU_MASK_TYPE); }))) {
            mixin(enumMixinStr___CPU_MASK_TYPE);
        }
    }




    static if(!is(typeof(__SSIZE_T_TYPE))) {
        private enum enumMixinStr___SSIZE_T_TYPE = `enum __SSIZE_T_TYPE = __SWORD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___SSIZE_T_TYPE); }))) {
            mixin(enumMixinStr___SSIZE_T_TYPE);
        }
    }




    static if(!is(typeof(__FSID_T_TYPE))) {
        private enum enumMixinStr___FSID_T_TYPE = `enum __FSID_T_TYPE = { int __val [ 2 ] ; };`;
        static if(is(typeof({ mixin(enumMixinStr___FSID_T_TYPE); }))) {
            mixin(enumMixinStr___FSID_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKSIZE_T_TYPE))) {
        private enum enumMixinStr___BLKSIZE_T_TYPE = `enum __BLKSIZE_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKSIZE_T_TYPE); }))) {
            mixin(enumMixinStr___BLKSIZE_T_TYPE);
        }
    }




    static if(!is(typeof(__TIMER_T_TYPE))) {
        private enum enumMixinStr___TIMER_T_TYPE = `enum __TIMER_T_TYPE = void *;`;
        static if(is(typeof({ mixin(enumMixinStr___TIMER_T_TYPE); }))) {
            mixin(enumMixinStr___TIMER_T_TYPE);
        }
    }




    static if(!is(typeof(__CLOCKID_T_TYPE))) {
        private enum enumMixinStr___CLOCKID_T_TYPE = `enum __CLOCKID_T_TYPE = __S32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___CLOCKID_T_TYPE); }))) {
            mixin(enumMixinStr___CLOCKID_T_TYPE);
        }
    }




    static if(!is(typeof(__KEY_T_TYPE))) {
        private enum enumMixinStr___KEY_T_TYPE = `enum __KEY_T_TYPE = __S32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___KEY_T_TYPE); }))) {
            mixin(enumMixinStr___KEY_T_TYPE);
        }
    }




    static if(!is(typeof(__DADDR_T_TYPE))) {
        private enum enumMixinStr___DADDR_T_TYPE = `enum __DADDR_T_TYPE = __S32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___DADDR_T_TYPE); }))) {
            mixin(enumMixinStr___DADDR_T_TYPE);
        }
    }




    static if(!is(typeof(__SUSECONDS_T_TYPE))) {
        private enum enumMixinStr___SUSECONDS_T_TYPE = `enum __SUSECONDS_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___SUSECONDS_T_TYPE); }))) {
            mixin(enumMixinStr___SUSECONDS_T_TYPE);
        }
    }




    static if(!is(typeof(__USECONDS_T_TYPE))) {
        private enum enumMixinStr___USECONDS_T_TYPE = `enum __USECONDS_T_TYPE = __U32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___USECONDS_T_TYPE); }))) {
            mixin(enumMixinStr___USECONDS_T_TYPE);
        }
    }




    static if(!is(typeof(__TIME_T_TYPE))) {
        private enum enumMixinStr___TIME_T_TYPE = `enum __TIME_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___TIME_T_TYPE); }))) {
            mixin(enumMixinStr___TIME_T_TYPE);
        }
    }




    static if(!is(typeof(__CLOCK_T_TYPE))) {
        private enum enumMixinStr___CLOCK_T_TYPE = `enum __CLOCK_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___CLOCK_T_TYPE); }))) {
            mixin(enumMixinStr___CLOCK_T_TYPE);
        }
    }




    static if(!is(typeof(__ID_T_TYPE))) {
        private enum enumMixinStr___ID_T_TYPE = `enum __ID_T_TYPE = __U32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___ID_T_TYPE); }))) {
            mixin(enumMixinStr___ID_T_TYPE);
        }
    }




    static if(!is(typeof(__FSFILCNT64_T_TYPE))) {
        private enum enumMixinStr___FSFILCNT64_T_TYPE = `enum __FSFILCNT64_T_TYPE = __UQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___FSFILCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___FSFILCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__FSFILCNT_T_TYPE))) {
        private enum enumMixinStr___FSFILCNT_T_TYPE = `enum __FSFILCNT_T_TYPE = __SYSCALL_ULONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___FSFILCNT_T_TYPE); }))) {
            mixin(enumMixinStr___FSFILCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__FSBLKCNT64_T_TYPE))) {
        private enum enumMixinStr___FSBLKCNT64_T_TYPE = `enum __FSBLKCNT64_T_TYPE = __UQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___FSBLKCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___FSBLKCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__FSBLKCNT_T_TYPE))) {
        private enum enumMixinStr___FSBLKCNT_T_TYPE = `enum __FSBLKCNT_T_TYPE = __SYSCALL_ULONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___FSBLKCNT_T_TYPE); }))) {
            mixin(enumMixinStr___FSBLKCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKCNT64_T_TYPE))) {
        private enum enumMixinStr___BLKCNT64_T_TYPE = `enum __BLKCNT64_T_TYPE = __SQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___BLKCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKCNT_T_TYPE))) {
        private enum enumMixinStr___BLKCNT_T_TYPE = `enum __BLKCNT_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKCNT_T_TYPE); }))) {
            mixin(enumMixinStr___BLKCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__RLIM64_T_TYPE))) {
        private enum enumMixinStr___RLIM64_T_TYPE = `enum __RLIM64_T_TYPE = __UQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM64_T_TYPE); }))) {
            mixin(enumMixinStr___RLIM64_T_TYPE);
        }
    }




    static if(!is(typeof(__RLIM_T_TYPE))) {
        private enum enumMixinStr___RLIM_T_TYPE = `enum __RLIM_T_TYPE = __SYSCALL_ULONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM_T_TYPE); }))) {
            mixin(enumMixinStr___RLIM_T_TYPE);
        }
    }




    static if(!is(typeof(__PID_T_TYPE))) {
        private enum enumMixinStr___PID_T_TYPE = `enum __PID_T_TYPE = __S32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___PID_T_TYPE); }))) {
            mixin(enumMixinStr___PID_T_TYPE);
        }
    }




    static if(!is(typeof(__OFF64_T_TYPE))) {
        private enum enumMixinStr___OFF64_T_TYPE = `enum __OFF64_T_TYPE = __SQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF64_T_TYPE); }))) {
            mixin(enumMixinStr___OFF64_T_TYPE);
        }
    }




    static if(!is(typeof(__OFF_T_TYPE))) {
        private enum enumMixinStr___OFF_T_TYPE = `enum __OFF_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF_T_TYPE); }))) {
            mixin(enumMixinStr___OFF_T_TYPE);
        }
    }




    static if(!is(typeof(__FSWORD_T_TYPE))) {
        private enum enumMixinStr___FSWORD_T_TYPE = `enum __FSWORD_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___FSWORD_T_TYPE); }))) {
            mixin(enumMixinStr___FSWORD_T_TYPE);
        }
    }




    static if(!is(typeof(__NLINK_T_TYPE))) {
        private enum enumMixinStr___NLINK_T_TYPE = `enum __NLINK_T_TYPE = __SYSCALL_ULONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___NLINK_T_TYPE); }))) {
            mixin(enumMixinStr___NLINK_T_TYPE);
        }
    }




    static if(!is(typeof(__MODE_T_TYPE))) {
        private enum enumMixinStr___MODE_T_TYPE = `enum __MODE_T_TYPE = __U32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___MODE_T_TYPE); }))) {
            mixin(enumMixinStr___MODE_T_TYPE);
        }
    }




    static if(!is(typeof(__INO64_T_TYPE))) {
        private enum enumMixinStr___INO64_T_TYPE = `enum __INO64_T_TYPE = __UQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___INO64_T_TYPE); }))) {
            mixin(enumMixinStr___INO64_T_TYPE);
        }
    }




    static if(!is(typeof(__INO_T_TYPE))) {
        private enum enumMixinStr___INO_T_TYPE = `enum __INO_T_TYPE = __SYSCALL_ULONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___INO_T_TYPE); }))) {
            mixin(enumMixinStr___INO_T_TYPE);
        }
    }




    static if(!is(typeof(__GID_T_TYPE))) {
        private enum enumMixinStr___GID_T_TYPE = `enum __GID_T_TYPE = __U32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___GID_T_TYPE); }))) {
            mixin(enumMixinStr___GID_T_TYPE);
        }
    }




    static if(!is(typeof(__UID_T_TYPE))) {
        private enum enumMixinStr___UID_T_TYPE = `enum __UID_T_TYPE = __U32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___UID_T_TYPE); }))) {
            mixin(enumMixinStr___UID_T_TYPE);
        }
    }




    static if(!is(typeof(__DEV_T_TYPE))) {
        private enum enumMixinStr___DEV_T_TYPE = `enum __DEV_T_TYPE = __UQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___DEV_T_TYPE); }))) {
            mixin(enumMixinStr___DEV_T_TYPE);
        }
    }




    static if(!is(typeof(__SYSCALL_ULONG_TYPE))) {
        private enum enumMixinStr___SYSCALL_ULONG_TYPE = `enum __SYSCALL_ULONG_TYPE = __ULONGWORD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_ULONG_TYPE); }))) {
            mixin(enumMixinStr___SYSCALL_ULONG_TYPE);
        }
    }




    static if(!is(typeof(__SYSCALL_SLONG_TYPE))) {
        private enum enumMixinStr___SYSCALL_SLONG_TYPE = `enum __SYSCALL_SLONG_TYPE = __SLONGWORD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_SLONG_TYPE); }))) {
            mixin(enumMixinStr___SYSCALL_SLONG_TYPE);
        }
    }




    static if(!is(typeof(_BITS_TYPESIZES_H))) {
        private enum enumMixinStr__BITS_TYPESIZES_H = `enum _BITS_TYPESIZES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TYPESIZES_H); }))) {
            mixin(enumMixinStr__BITS_TYPESIZES_H);
        }
    }




    static if(!is(typeof(__STD_TYPE))) {
        private enum enumMixinStr___STD_TYPE = `enum __STD_TYPE = typedef;`;
        static if(is(typeof({ mixin(enumMixinStr___STD_TYPE); }))) {
            mixin(enumMixinStr___STD_TYPE);
        }
    }




    static if(!is(typeof(__U64_TYPE))) {
        private enum enumMixinStr___U64_TYPE = `enum __U64_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___U64_TYPE); }))) {
            mixin(enumMixinStr___U64_TYPE);
        }
    }




    static if(!is(typeof(__S64_TYPE))) {
        private enum enumMixinStr___S64_TYPE = `enum __S64_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___S64_TYPE); }))) {
            mixin(enumMixinStr___S64_TYPE);
        }
    }




    static if(!is(typeof(__ULONG32_TYPE))) {
        private enum enumMixinStr___ULONG32_TYPE = `enum __ULONG32_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___ULONG32_TYPE); }))) {
            mixin(enumMixinStr___ULONG32_TYPE);
        }
    }




    static if(!is(typeof(__SLONG32_TYPE))) {
        private enum enumMixinStr___SLONG32_TYPE = `enum __SLONG32_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___SLONG32_TYPE); }))) {
            mixin(enumMixinStr___SLONG32_TYPE);
        }
    }




    static if(!is(typeof(__UWORD_TYPE))) {
        private enum enumMixinStr___UWORD_TYPE = `enum __UWORD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___UWORD_TYPE); }))) {
            mixin(enumMixinStr___UWORD_TYPE);
        }
    }




    static if(!is(typeof(__SWORD_TYPE))) {
        private enum enumMixinStr___SWORD_TYPE = `enum __SWORD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SWORD_TYPE); }))) {
            mixin(enumMixinStr___SWORD_TYPE);
        }
    }




    static if(!is(typeof(__UQUAD_TYPE))) {
        private enum enumMixinStr___UQUAD_TYPE = `enum __UQUAD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___UQUAD_TYPE); }))) {
            mixin(enumMixinStr___UQUAD_TYPE);
        }
    }




    static if(!is(typeof(__SQUAD_TYPE))) {
        private enum enumMixinStr___SQUAD_TYPE = `enum __SQUAD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SQUAD_TYPE); }))) {
            mixin(enumMixinStr___SQUAD_TYPE);
        }
    }




    static if(!is(typeof(__ULONGWORD_TYPE))) {
        private enum enumMixinStr___ULONGWORD_TYPE = `enum __ULONGWORD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___ULONGWORD_TYPE); }))) {
            mixin(enumMixinStr___ULONGWORD_TYPE);
        }
    }




    static if(!is(typeof(__SLONGWORD_TYPE))) {
        private enum enumMixinStr___SLONGWORD_TYPE = `enum __SLONGWORD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SLONGWORD_TYPE); }))) {
            mixin(enumMixinStr___SLONGWORD_TYPE);
        }
    }




    static if(!is(typeof(__U32_TYPE))) {
        private enum enumMixinStr___U32_TYPE = `enum __U32_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___U32_TYPE); }))) {
            mixin(enumMixinStr___U32_TYPE);
        }
    }




    static if(!is(typeof(__S32_TYPE))) {
        private enum enumMixinStr___S32_TYPE = `enum __S32_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___S32_TYPE); }))) {
            mixin(enumMixinStr___S32_TYPE);
        }
    }




    static if(!is(typeof(__U16_TYPE))) {
        private enum enumMixinStr___U16_TYPE = `enum __U16_TYPE = unsigned short int;`;
        static if(is(typeof({ mixin(enumMixinStr___U16_TYPE); }))) {
            mixin(enumMixinStr___U16_TYPE);
        }
    }




    static if(!is(typeof(__S16_TYPE))) {
        private enum enumMixinStr___S16_TYPE = `enum __S16_TYPE = short int;`;
        static if(is(typeof({ mixin(enumMixinStr___S16_TYPE); }))) {
            mixin(enumMixinStr___S16_TYPE);
        }
    }




    static if(!is(typeof(_BITS_TYPES_H))) {
        private enum enumMixinStr__BITS_TYPES_H = `enum _BITS_TYPES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TYPES_H); }))) {
            mixin(enumMixinStr__BITS_TYPES_H);
        }
    }




    static if(!is(typeof(__TIMESIZE))) {
        private enum enumMixinStr___TIMESIZE = `enum __TIMESIZE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___TIMESIZE); }))) {
            mixin(enumMixinStr___TIMESIZE);
        }
    }




    static if(!is(typeof(__TIME64_T_TYPE))) {
        private enum enumMixinStr___TIME64_T_TYPE = `enum __TIME64_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___TIME64_T_TYPE); }))) {
            mixin(enumMixinStr___TIME64_T_TYPE);
        }
    }




    static if(!is(typeof(_BITS_TIME64_H))) {
        private enum enumMixinStr__BITS_TIME64_H = `enum _BITS_TIME64_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TIME64_H); }))) {
            mixin(enumMixinStr__BITS_TIME64_H);
        }
    }




    static if(!is(typeof(_BITS_STDINT_UINTN_H))) {
        private enum enumMixinStr__BITS_STDINT_UINTN_H = `enum _BITS_STDINT_UINTN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_STDINT_UINTN_H); }))) {
            mixin(enumMixinStr__BITS_STDINT_UINTN_H);
        }
    }




    static if(!is(typeof(_BITS_STDINT_INTN_H))) {
        private enum enumMixinStr__BITS_STDINT_INTN_H = `enum _BITS_STDINT_INTN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_STDINT_INTN_H); }))) {
            mixin(enumMixinStr__BITS_STDINT_INTN_H);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_TYPES_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT = `enum __GLIBC_USE_IEC_60559_TYPES_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_FUNCS_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT = `enum __GLIBC_USE_IEC_60559_FUNCS_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_BFP_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT = `enum __GLIBC_USE_IEC_60559_BFP_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT);
        }
    }




    static if(!is(typeof(__GLIBC_USE_LIB_EXT2))) {
        private enum enumMixinStr___GLIBC_USE_LIB_EXT2 = `enum __GLIBC_USE_LIB_EXT2 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_LIB_EXT2); }))) {
            mixin(enumMixinStr___GLIBC_USE_LIB_EXT2);
        }
    }
    static if(!is(typeof(WINT_MAX))) {
        private enum enumMixinStr_WINT_MAX = `enum WINT_MAX = ( 4294967295u );`;
        static if(is(typeof({ mixin(enumMixinStr_WINT_MAX); }))) {
            mixin(enumMixinStr_WINT_MAX);
        }
    }




    static if(!is(typeof(WINT_MIN))) {
        private enum enumMixinStr_WINT_MIN = `enum WINT_MIN = ( 0u );`;
        static if(is(typeof({ mixin(enumMixinStr_WINT_MIN); }))) {
            mixin(enumMixinStr_WINT_MIN);
        }
    }




    static if(!is(typeof(WCHAR_MAX))) {
        private enum enumMixinStr_WCHAR_MAX = `enum WCHAR_MAX = 0x7fffffff;`;
        static if(is(typeof({ mixin(enumMixinStr_WCHAR_MAX); }))) {
            mixin(enumMixinStr_WCHAR_MAX);
        }
    }




    static if(!is(typeof(WCHAR_MIN))) {
        private enum enumMixinStr_WCHAR_MIN = `enum WCHAR_MIN = ( - 0x7fffffff - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_WCHAR_MIN); }))) {
            mixin(enumMixinStr_WCHAR_MIN);
        }
    }




    static if(!is(typeof(SIZE_MAX))) {
        private enum enumMixinStr_SIZE_MAX = `enum SIZE_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_SIZE_MAX); }))) {
            mixin(enumMixinStr_SIZE_MAX);
        }
    }




    static if(!is(typeof(SIG_ATOMIC_MAX))) {
        private enum enumMixinStr_SIG_ATOMIC_MAX = `enum SIG_ATOMIC_MAX = ( 2147483647 );`;
        static if(is(typeof({ mixin(enumMixinStr_SIG_ATOMIC_MAX); }))) {
            mixin(enumMixinStr_SIG_ATOMIC_MAX);
        }
    }




    static if(!is(typeof(SIG_ATOMIC_MIN))) {
        private enum enumMixinStr_SIG_ATOMIC_MIN = `enum SIG_ATOMIC_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_SIG_ATOMIC_MIN); }))) {
            mixin(enumMixinStr_SIG_ATOMIC_MIN);
        }
    }




    static if(!is(typeof(PTRDIFF_MAX))) {
        private enum enumMixinStr_PTRDIFF_MAX = `enum PTRDIFF_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_PTRDIFF_MAX); }))) {
            mixin(enumMixinStr_PTRDIFF_MAX);
        }
    }




    static if(!is(typeof(PTRDIFF_MIN))) {
        private enum enumMixinStr_PTRDIFF_MIN = `enum PTRDIFF_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_PTRDIFF_MIN); }))) {
            mixin(enumMixinStr_PTRDIFF_MIN);
        }
    }




    static if(!is(typeof(UINTMAX_MAX))) {
        private enum enumMixinStr_UINTMAX_MAX = `enum UINTMAX_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINTMAX_MAX); }))) {
            mixin(enumMixinStr_UINTMAX_MAX);
        }
    }




    static if(!is(typeof(INTMAX_MAX))) {
        private enum enumMixinStr_INTMAX_MAX = `enum INTMAX_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INTMAX_MAX); }))) {
            mixin(enumMixinStr_INTMAX_MAX);
        }
    }




    static if(!is(typeof(INTMAX_MIN))) {
        private enum enumMixinStr_INTMAX_MIN = `enum INTMAX_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INTMAX_MIN); }))) {
            mixin(enumMixinStr_INTMAX_MIN);
        }
    }




    static if(!is(typeof(UINTPTR_MAX))) {
        private enum enumMixinStr_UINTPTR_MAX = `enum UINTPTR_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINTPTR_MAX); }))) {
            mixin(enumMixinStr_UINTPTR_MAX);
        }
    }




    static if(!is(typeof(INTPTR_MAX))) {
        private enum enumMixinStr_INTPTR_MAX = `enum INTPTR_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INTPTR_MAX); }))) {
            mixin(enumMixinStr_INTPTR_MAX);
        }
    }




    static if(!is(typeof(INTPTR_MIN))) {
        private enum enumMixinStr_INTPTR_MIN = `enum INTPTR_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INTPTR_MIN); }))) {
            mixin(enumMixinStr_INTPTR_MIN);
        }
    }




    static if(!is(typeof(UINT_FAST64_MAX))) {
        private enum enumMixinStr_UINT_FAST64_MAX = `enum UINT_FAST64_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST64_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST64_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST32_MAX))) {
        private enum enumMixinStr_UINT_FAST32_MAX = `enum UINT_FAST32_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST32_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST32_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST16_MAX))) {
        private enum enumMixinStr_UINT_FAST16_MAX = `enum UINT_FAST16_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST16_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST16_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST8_MAX))) {
        private enum enumMixinStr_UINT_FAST8_MAX = `enum UINT_FAST8_MAX = ( 255 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST8_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST8_MAX);
        }
    }




    static if(!is(typeof(INT_FAST64_MAX))) {
        private enum enumMixinStr_INT_FAST64_MAX = `enum INT_FAST64_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST64_MAX); }))) {
            mixin(enumMixinStr_INT_FAST64_MAX);
        }
    }




    static if(!is(typeof(INT_FAST32_MAX))) {
        private enum enumMixinStr_INT_FAST32_MAX = `enum INT_FAST32_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST32_MAX); }))) {
            mixin(enumMixinStr_INT_FAST32_MAX);
        }
    }




    static if(!is(typeof(INT_FAST16_MAX))) {
        private enum enumMixinStr_INT_FAST16_MAX = `enum INT_FAST16_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST16_MAX); }))) {
            mixin(enumMixinStr_INT_FAST16_MAX);
        }
    }




    static if(!is(typeof(INT_FAST8_MAX))) {
        private enum enumMixinStr_INT_FAST8_MAX = `enum INT_FAST8_MAX = ( 127 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST8_MAX); }))) {
            mixin(enumMixinStr_INT_FAST8_MAX);
        }
    }




    static if(!is(typeof(INT_FAST64_MIN))) {
        private enum enumMixinStr_INT_FAST64_MIN = `enum INT_FAST64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST64_MIN); }))) {
            mixin(enumMixinStr_INT_FAST64_MIN);
        }
    }




    static if(!is(typeof(INT_FAST32_MIN))) {
        private enum enumMixinStr_INT_FAST32_MIN = `enum INT_FAST32_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST32_MIN); }))) {
            mixin(enumMixinStr_INT_FAST32_MIN);
        }
    }




    static if(!is(typeof(INT_FAST16_MIN))) {
        private enum enumMixinStr_INT_FAST16_MIN = `enum INT_FAST16_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST16_MIN); }))) {
            mixin(enumMixinStr_INT_FAST16_MIN);
        }
    }




    static if(!is(typeof(INT_FAST8_MIN))) {
        private enum enumMixinStr_INT_FAST8_MIN = `enum INT_FAST8_MIN = ( - 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST8_MIN); }))) {
            mixin(enumMixinStr_INT_FAST8_MIN);
        }
    }




    static if(!is(typeof(UINT_LEAST64_MAX))) {
        private enum enumMixinStr_UINT_LEAST64_MAX = `enum UINT_LEAST64_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST64_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST64_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST32_MAX))) {
        private enum enumMixinStr_UINT_LEAST32_MAX = `enum UINT_LEAST32_MAX = ( 4294967295U );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST32_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST32_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST16_MAX))) {
        private enum enumMixinStr_UINT_LEAST16_MAX = `enum UINT_LEAST16_MAX = ( 65535 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST16_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST16_MAX);
        }
    }




    static if(!is(typeof(MPIIMPL_ADVERTISES_FEATURES))) {
        private enum enumMixinStr_MPIIMPL_ADVERTISES_FEATURES = `enum MPIIMPL_ADVERTISES_FEATURES = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIIMPL_ADVERTISES_FEATURES); }))) {
            mixin(enumMixinStr_MPIIMPL_ADVERTISES_FEATURES);
        }
    }




    static if(!is(typeof(MPIIMPL_HAVE_MPI_INFO))) {
        private enum enumMixinStr_MPIIMPL_HAVE_MPI_INFO = `enum MPIIMPL_HAVE_MPI_INFO = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIIMPL_HAVE_MPI_INFO); }))) {
            mixin(enumMixinStr_MPIIMPL_HAVE_MPI_INFO);
        }
    }




    static if(!is(typeof(MPIIMPL_HAVE_MPI_COMBINER_DARRAY))) {
        private enum enumMixinStr_MPIIMPL_HAVE_MPI_COMBINER_DARRAY = `enum MPIIMPL_HAVE_MPI_COMBINER_DARRAY = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIIMPL_HAVE_MPI_COMBINER_DARRAY); }))) {
            mixin(enumMixinStr_MPIIMPL_HAVE_MPI_COMBINER_DARRAY);
        }
    }




    static if(!is(typeof(MPIIMPL_HAVE_MPI_TYPE_CREATE_DARRAY))) {
        private enum enumMixinStr_MPIIMPL_HAVE_MPI_TYPE_CREATE_DARRAY = `enum MPIIMPL_HAVE_MPI_TYPE_CREATE_DARRAY = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIIMPL_HAVE_MPI_TYPE_CREATE_DARRAY); }))) {
            mixin(enumMixinStr_MPIIMPL_HAVE_MPI_TYPE_CREATE_DARRAY);
        }
    }




    static if(!is(typeof(MPIIMPL_HAVE_MPI_COMBINER_SUBARRAY))) {
        private enum enumMixinStr_MPIIMPL_HAVE_MPI_COMBINER_SUBARRAY = `enum MPIIMPL_HAVE_MPI_COMBINER_SUBARRAY = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIIMPL_HAVE_MPI_COMBINER_SUBARRAY); }))) {
            mixin(enumMixinStr_MPIIMPL_HAVE_MPI_COMBINER_SUBARRAY);
        }
    }




    static if(!is(typeof(MPIIMPL_HAVE_MPI_COMBINER_DUP))) {
        private enum enumMixinStr_MPIIMPL_HAVE_MPI_COMBINER_DUP = `enum MPIIMPL_HAVE_MPI_COMBINER_DUP = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIIMPL_HAVE_MPI_COMBINER_DUP); }))) {
            mixin(enumMixinStr_MPIIMPL_HAVE_MPI_COMBINER_DUP);
        }
    }




    static if(!is(typeof(MPIIMPL_HAVE_MPI_GREQUEST))) {
        private enum enumMixinStr_MPIIMPL_HAVE_MPI_GREQUEST = `enum MPIIMPL_HAVE_MPI_GREQUEST = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIIMPL_HAVE_MPI_GREQUEST); }))) {
            mixin(enumMixinStr_MPIIMPL_HAVE_MPI_GREQUEST);
        }
    }




    static if(!is(typeof(MPIIMPL_HAVE_STATUS_SET_BYTES))) {
        private enum enumMixinStr_MPIIMPL_HAVE_STATUS_SET_BYTES = `enum MPIIMPL_HAVE_STATUS_SET_BYTES = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIIMPL_HAVE_STATUS_SET_BYTES); }))) {
            mixin(enumMixinStr_MPIIMPL_HAVE_STATUS_SET_BYTES);
        }
    }




    static if(!is(typeof(MPIIMPL_HAVE_STATUS_SET_INFO))) {
        private enum enumMixinStr_MPIIMPL_HAVE_STATUS_SET_INFO = `enum MPIIMPL_HAVE_STATUS_SET_INFO = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIIMPL_HAVE_STATUS_SET_INFO); }))) {
            mixin(enumMixinStr_MPIIMPL_HAVE_STATUS_SET_INFO);
        }
    }




    static if(!is(typeof(UINT_LEAST8_MAX))) {
        private enum enumMixinStr_UINT_LEAST8_MAX = `enum UINT_LEAST8_MAX = ( 255 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST8_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST8_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST64_MAX))) {
        private enum enumMixinStr_INT_LEAST64_MAX = `enum INT_LEAST64_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST64_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST64_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST32_MAX))) {
        private enum enumMixinStr_INT_LEAST32_MAX = `enum INT_LEAST32_MAX = ( 2147483647 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST32_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST32_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST16_MAX))) {
        private enum enumMixinStr_INT_LEAST16_MAX = `enum INT_LEAST16_MAX = ( 32767 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST16_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST16_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST8_MAX))) {
        private enum enumMixinStr_INT_LEAST8_MAX = `enum INT_LEAST8_MAX = ( 127 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST8_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST8_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST64_MIN))) {
        private enum enumMixinStr_INT_LEAST64_MIN = `enum INT_LEAST64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST64_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST64_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST32_MIN))) {
        private enum enumMixinStr_INT_LEAST32_MIN = `enum INT_LEAST32_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST32_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST32_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST16_MIN))) {
        private enum enumMixinStr_INT_LEAST16_MIN = `enum INT_LEAST16_MIN = ( - 32767 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST16_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST16_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST8_MIN))) {
        private enum enumMixinStr_INT_LEAST8_MIN = `enum INT_LEAST8_MIN = ( - 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST8_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST8_MIN);
        }
    }




    static if(!is(typeof(UINT64_MAX))) {
        private enum enumMixinStr_UINT64_MAX = `enum UINT64_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT64_MAX); }))) {
            mixin(enumMixinStr_UINT64_MAX);
        }
    }




    static if(!is(typeof(UINT32_MAX))) {
        private enum enumMixinStr_UINT32_MAX = `enum UINT32_MAX = ( 4294967295U );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT32_MAX); }))) {
            mixin(enumMixinStr_UINT32_MAX);
        }
    }




    static if(!is(typeof(UINT16_MAX))) {
        private enum enumMixinStr_UINT16_MAX = `enum UINT16_MAX = ( 65535 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT16_MAX); }))) {
            mixin(enumMixinStr_UINT16_MAX);
        }
    }




    static if(!is(typeof(UINT8_MAX))) {
        private enum enumMixinStr_UINT8_MAX = `enum UINT8_MAX = ( 255 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT8_MAX); }))) {
            mixin(enumMixinStr_UINT8_MAX);
        }
    }




    static if(!is(typeof(INT64_MAX))) {
        private enum enumMixinStr_INT64_MAX = `enum INT64_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT64_MAX); }))) {
            mixin(enumMixinStr_INT64_MAX);
        }
    }




    static if(!is(typeof(INT32_MAX))) {
        private enum enumMixinStr_INT32_MAX = `enum INT32_MAX = ( 2147483647 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT32_MAX); }))) {
            mixin(enumMixinStr_INT32_MAX);
        }
    }




    static if(!is(typeof(INT16_MAX))) {
        private enum enumMixinStr_INT16_MAX = `enum INT16_MAX = ( 32767 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT16_MAX); }))) {
            mixin(enumMixinStr_INT16_MAX);
        }
    }




    static if(!is(typeof(INT8_MAX))) {
        private enum enumMixinStr_INT8_MAX = `enum INT8_MAX = ( 127 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT8_MAX); }))) {
            mixin(enumMixinStr_INT8_MAX);
        }
    }




    static if(!is(typeof(INT64_MIN))) {
        private enum enumMixinStr_INT64_MIN = `enum INT64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT64_MIN); }))) {
            mixin(enumMixinStr_INT64_MIN);
        }
    }




    static if(!is(typeof(INT32_MIN))) {
        private enum enumMixinStr_INT32_MIN = `enum INT32_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT32_MIN); }))) {
            mixin(enumMixinStr_INT32_MIN);
        }
    }




    static if(!is(typeof(INT16_MIN))) {
        private enum enumMixinStr_INT16_MIN = `enum INT16_MIN = ( - 32767 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT16_MIN); }))) {
            mixin(enumMixinStr_INT16_MIN);
        }
    }




    static if(!is(typeof(INT8_MIN))) {
        private enum enumMixinStr_INT8_MIN = `enum INT8_MIN = ( - 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT8_MIN); }))) {
            mixin(enumMixinStr_INT8_MIN);
        }
    }
    static if(!is(typeof(_STDINT_H))) {
        private enum enumMixinStr__STDINT_H = `enum _STDINT_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STDINT_H); }))) {
            mixin(enumMixinStr__STDINT_H);
        }
    }




    static if(!is(typeof(_STDC_PREDEF_H))) {
        private enum enumMixinStr__STDC_PREDEF_H = `enum _STDC_PREDEF_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STDC_PREDEF_H); }))) {
            mixin(enumMixinStr__STDC_PREDEF_H);
        }
    }






    static if(!is(typeof(__GLIBC_MINOR__))) {
        private enum enumMixinStr___GLIBC_MINOR__ = `enum __GLIBC_MINOR__ = 30;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_MINOR__); }))) {
            mixin(enumMixinStr___GLIBC_MINOR__);
        }
    }






    static if(!is(typeof(__GLIBC__))) {
        private enum enumMixinStr___GLIBC__ = `enum __GLIBC__ = 2;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC__); }))) {
            mixin(enumMixinStr___GLIBC__);
        }
    }






    static if(!is(typeof(ROMIO_VERSION))) {
        private enum enumMixinStr_ROMIO_VERSION = `enum ROMIO_VERSION = 126;`;
        static if(is(typeof({ mixin(enumMixinStr_ROMIO_VERSION); }))) {
            mixin(enumMixinStr_ROMIO_VERSION);
        }
    }




    static if(!is(typeof(__GNU_LIBRARY__))) {
        private enum enumMixinStr___GNU_LIBRARY__ = `enum __GNU_LIBRARY__ = 6;`;
        static if(is(typeof({ mixin(enumMixinStr___GNU_LIBRARY__); }))) {
            mixin(enumMixinStr___GNU_LIBRARY__);
        }
    }




    static if(!is(typeof(HAVE_MPI_GREQUEST))) {
        private enum enumMixinStr_HAVE_MPI_GREQUEST = `enum HAVE_MPI_GREQUEST = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_HAVE_MPI_GREQUEST); }))) {
            mixin(enumMixinStr_HAVE_MPI_GREQUEST);
        }
    }




    static if(!is(typeof(__GLIBC_USE_DEPRECATED_SCANF))) {
        private enum enumMixinStr___GLIBC_USE_DEPRECATED_SCANF = `enum __GLIBC_USE_DEPRECATED_SCANF = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_DEPRECATED_SCANF); }))) {
            mixin(enumMixinStr___GLIBC_USE_DEPRECATED_SCANF);
        }
    }




    static if(!is(typeof(MPIO_Request))) {
        private enum enumMixinStr_MPIO_Request = `enum MPIO_Request = MPI_Request;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIO_Request); }))) {
            mixin(enumMixinStr_MPIO_Request);
        }
    }






    static if(!is(typeof(MPIO_Wait))) {
        private enum enumMixinStr_MPIO_Wait = `enum MPIO_Wait = MPI_Wait;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIO_Wait); }))) {
            mixin(enumMixinStr_MPIO_Wait);
        }
    }




    static if(!is(typeof(MPIO_Test))) {
        private enum enumMixinStr_MPIO_Test = `enum MPIO_Test = MPI_Test;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIO_Test); }))) {
            mixin(enumMixinStr_MPIO_Test);
        }
    }




    static if(!is(typeof(PMPIO_Wait))) {
        private enum enumMixinStr_PMPIO_Wait = `enum PMPIO_Wait = PMPI_Wait;`;
        static if(is(typeof({ mixin(enumMixinStr_PMPIO_Wait); }))) {
            mixin(enumMixinStr_PMPIO_Wait);
        }
    }




    static if(!is(typeof(PMPIO_Test))) {
        private enum enumMixinStr_PMPIO_Test = `enum PMPIO_Test = PMPI_Test;`;
        static if(is(typeof({ mixin(enumMixinStr_PMPIO_Test); }))) {
            mixin(enumMixinStr_PMPIO_Test);
        }
    }






    static if(!is(typeof(__GLIBC_USE_DEPRECATED_GETS))) {
        private enum enumMixinStr___GLIBC_USE_DEPRECATED_GETS = `enum __GLIBC_USE_DEPRECATED_GETS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_DEPRECATED_GETS); }))) {
            mixin(enumMixinStr___GLIBC_USE_DEPRECATED_GETS);
        }
    }






    static if(!is(typeof(__USE_FORTIFY_LEVEL))) {
        private enum enumMixinStr___USE_FORTIFY_LEVEL = `enum __USE_FORTIFY_LEVEL = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_FORTIFY_LEVEL); }))) {
            mixin(enumMixinStr___USE_FORTIFY_LEVEL);
        }
    }




    static if(!is(typeof(MPI_MODE_RDONLY))) {
        private enum enumMixinStr_MPI_MODE_RDONLY = `enum MPI_MODE_RDONLY = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_RDONLY); }))) {
            mixin(enumMixinStr_MPI_MODE_RDONLY);
        }
    }




    static if(!is(typeof(MPI_MODE_RDWR))) {
        private enum enumMixinStr_MPI_MODE_RDWR = `enum MPI_MODE_RDWR = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_RDWR); }))) {
            mixin(enumMixinStr_MPI_MODE_RDWR);
        }
    }




    static if(!is(typeof(MPI_MODE_WRONLY))) {
        private enum enumMixinStr_MPI_MODE_WRONLY = `enum MPI_MODE_WRONLY = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_WRONLY); }))) {
            mixin(enumMixinStr_MPI_MODE_WRONLY);
        }
    }




    static if(!is(typeof(MPI_MODE_CREATE))) {
        private enum enumMixinStr_MPI_MODE_CREATE = `enum MPI_MODE_CREATE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_CREATE); }))) {
            mixin(enumMixinStr_MPI_MODE_CREATE);
        }
    }




    static if(!is(typeof(MPI_MODE_EXCL))) {
        private enum enumMixinStr_MPI_MODE_EXCL = `enum MPI_MODE_EXCL = 64;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_EXCL); }))) {
            mixin(enumMixinStr_MPI_MODE_EXCL);
        }
    }




    static if(!is(typeof(MPI_MODE_DELETE_ON_CLOSE))) {
        private enum enumMixinStr_MPI_MODE_DELETE_ON_CLOSE = `enum MPI_MODE_DELETE_ON_CLOSE = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_DELETE_ON_CLOSE); }))) {
            mixin(enumMixinStr_MPI_MODE_DELETE_ON_CLOSE);
        }
    }




    static if(!is(typeof(MPI_MODE_UNIQUE_OPEN))) {
        private enum enumMixinStr_MPI_MODE_UNIQUE_OPEN = `enum MPI_MODE_UNIQUE_OPEN = 32;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_UNIQUE_OPEN); }))) {
            mixin(enumMixinStr_MPI_MODE_UNIQUE_OPEN);
        }
    }




    static if(!is(typeof(MPI_MODE_APPEND))) {
        private enum enumMixinStr_MPI_MODE_APPEND = `enum MPI_MODE_APPEND = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_APPEND); }))) {
            mixin(enumMixinStr_MPI_MODE_APPEND);
        }
    }




    static if(!is(typeof(MPI_MODE_SEQUENTIAL))) {
        private enum enumMixinStr_MPI_MODE_SEQUENTIAL = `enum MPI_MODE_SEQUENTIAL = 256;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_SEQUENTIAL); }))) {
            mixin(enumMixinStr_MPI_MODE_SEQUENTIAL);
        }
    }




    static if(!is(typeof(MPI_DISPLACEMENT_CURRENT))) {
        private enum enumMixinStr_MPI_DISPLACEMENT_CURRENT = `enum MPI_DISPLACEMENT_CURRENT = - 54278278;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DISPLACEMENT_CURRENT); }))) {
            mixin(enumMixinStr_MPI_DISPLACEMENT_CURRENT);
        }
    }




    static if(!is(typeof(__USE_ATFILE))) {
        private enum enumMixinStr___USE_ATFILE = `enum __USE_ATFILE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ATFILE); }))) {
            mixin(enumMixinStr___USE_ATFILE);
        }
    }




    static if(!is(typeof(MPIO_REQUEST_NULL))) {
        private enum enumMixinStr_MPIO_REQUEST_NULL = `enum MPIO_REQUEST_NULL = ( ( MPI_Request ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPIO_REQUEST_NULL); }))) {
            mixin(enumMixinStr_MPIO_REQUEST_NULL);
        }
    }




    static if(!is(typeof(MPI_SEEK_SET))) {
        private enum enumMixinStr_MPI_SEEK_SET = `enum MPI_SEEK_SET = 600;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SEEK_SET); }))) {
            mixin(enumMixinStr_MPI_SEEK_SET);
        }
    }




    static if(!is(typeof(MPI_SEEK_CUR))) {
        private enum enumMixinStr_MPI_SEEK_CUR = `enum MPI_SEEK_CUR = 602;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SEEK_CUR); }))) {
            mixin(enumMixinStr_MPI_SEEK_CUR);
        }
    }




    static if(!is(typeof(MPI_SEEK_END))) {
        private enum enumMixinStr_MPI_SEEK_END = `enum MPI_SEEK_END = 604;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SEEK_END); }))) {
            mixin(enumMixinStr_MPI_SEEK_END);
        }
    }




    static if(!is(typeof(MPI_MAX_DATAREP_STRING))) {
        private enum enumMixinStr_MPI_MAX_DATAREP_STRING = `enum MPI_MAX_DATAREP_STRING = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_DATAREP_STRING); }))) {
            mixin(enumMixinStr_MPI_MAX_DATAREP_STRING);
        }
    }






    static if(!is(typeof(__USE_MISC))) {
        private enum enumMixinStr___USE_MISC = `enum __USE_MISC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_MISC); }))) {
            mixin(enumMixinStr___USE_MISC);
        }
    }




    static if(!is(typeof(_ATFILE_SOURCE))) {
        private enum enumMixinStr__ATFILE_SOURCE = `enum _ATFILE_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__ATFILE_SOURCE); }))) {
            mixin(enumMixinStr__ATFILE_SOURCE);
        }
    }




    static if(!is(typeof(__USE_XOPEN2K8))) {
        private enum enumMixinStr___USE_XOPEN2K8 = `enum __USE_XOPEN2K8 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_XOPEN2K8); }))) {
            mixin(enumMixinStr___USE_XOPEN2K8);
        }
    }




    static if(!is(typeof(__USE_ISOC99))) {
        private enum enumMixinStr___USE_ISOC99 = `enum __USE_ISOC99 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC99); }))) {
            mixin(enumMixinStr___USE_ISOC99);
        }
    }




    static if(!is(typeof(__USE_ISOC95))) {
        private enum enumMixinStr___USE_ISOC95 = `enum __USE_ISOC95 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC95); }))) {
            mixin(enumMixinStr___USE_ISOC95);
        }
    }




    static if(!is(typeof(__USE_XOPEN2K))) {
        private enum enumMixinStr___USE_XOPEN2K = `enum __USE_XOPEN2K = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_XOPEN2K); }))) {
            mixin(enumMixinStr___USE_XOPEN2K);
        }
    }




    static if(!is(typeof(__USE_POSIX199506))) {
        private enum enumMixinStr___USE_POSIX199506 = `enum __USE_POSIX199506 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX199506); }))) {
            mixin(enumMixinStr___USE_POSIX199506);
        }
    }




    static if(!is(typeof(__USE_POSIX199309))) {
        private enum enumMixinStr___USE_POSIX199309 = `enum __USE_POSIX199309 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX199309); }))) {
            mixin(enumMixinStr___USE_POSIX199309);
        }
    }




    static if(!is(typeof(__USE_POSIX2))) {
        private enum enumMixinStr___USE_POSIX2 = `enum __USE_POSIX2 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX2); }))) {
            mixin(enumMixinStr___USE_POSIX2);
        }
    }




    static if(!is(typeof(__USE_POSIX))) {
        private enum enumMixinStr___USE_POSIX = `enum __USE_POSIX = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX); }))) {
            mixin(enumMixinStr___USE_POSIX);
        }
    }




    static if(!is(typeof(_POSIX_C_SOURCE))) {
        private enum enumMixinStr__POSIX_C_SOURCE = `enum _POSIX_C_SOURCE = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_C_SOURCE); }))) {
            mixin(enumMixinStr__POSIX_C_SOURCE);
        }
    }




    static if(!is(typeof(_POSIX_SOURCE))) {
        private enum enumMixinStr__POSIX_SOURCE = `enum _POSIX_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SOURCE); }))) {
            mixin(enumMixinStr__POSIX_SOURCE);
        }
    }




    static if(!is(typeof(__USE_POSIX_IMPLICITLY))) {
        private enum enumMixinStr___USE_POSIX_IMPLICITLY = `enum __USE_POSIX_IMPLICITLY = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX_IMPLICITLY); }))) {
            mixin(enumMixinStr___USE_POSIX_IMPLICITLY);
        }
    }




    static if(!is(typeof(__USE_ISOC11))) {
        private enum enumMixinStr___USE_ISOC11 = `enum __USE_ISOC11 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC11); }))) {
            mixin(enumMixinStr___USE_ISOC11);
        }
    }




    static if(!is(typeof(_DEFAULT_SOURCE))) {
        private enum enumMixinStr__DEFAULT_SOURCE = `enum _DEFAULT_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__DEFAULT_SOURCE); }))) {
            mixin(enumMixinStr__DEFAULT_SOURCE);
        }
    }
    static if(!is(typeof(_FEATURES_H))) {
        private enum enumMixinStr__FEATURES_H = `enum _FEATURES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__FEATURES_H); }))) {
            mixin(enumMixinStr__FEATURES_H);
        }
    }




    static if(!is(typeof(_SYS_CDEFS_H))) {
        private enum enumMixinStr__SYS_CDEFS_H = `enum _SYS_CDEFS_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_CDEFS_H); }))) {
            mixin(enumMixinStr__SYS_CDEFS_H);
        }
    }
    static if(!is(typeof(__THROW))) {
        private enum enumMixinStr___THROW = `enum __THROW = __attribute__ ( ( __nothrow__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___THROW); }))) {
            mixin(enumMixinStr___THROW);
        }
    }




    static if(!is(typeof(__THROWNL))) {
        private enum enumMixinStr___THROWNL = `enum __THROWNL = __attribute__ ( ( __nothrow__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___THROWNL); }))) {
            mixin(enumMixinStr___THROWNL);
        }
    }
    static if(!is(typeof(__ptr_t))) {
        private enum enumMixinStr___ptr_t = `enum __ptr_t = void *;`;
        static if(is(typeof({ mixin(enumMixinStr___ptr_t); }))) {
            mixin(enumMixinStr___ptr_t);
        }
    }
    static if(!is(typeof(__flexarr))) {
        private enum enumMixinStr___flexarr = `enum __flexarr = [ ];`;
        static if(is(typeof({ mixin(enumMixinStr___flexarr); }))) {
            mixin(enumMixinStr___flexarr);
        }
    }




    static if(!is(typeof(__glibc_c99_flexarr_available))) {
        private enum enumMixinStr___glibc_c99_flexarr_available = `enum __glibc_c99_flexarr_available = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___glibc_c99_flexarr_available); }))) {
            mixin(enumMixinStr___glibc_c99_flexarr_available);
        }
    }
    static if(!is(typeof(__attribute_malloc__))) {
        private enum enumMixinStr___attribute_malloc__ = `enum __attribute_malloc__ = __attribute__ ( ( __malloc__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_malloc__); }))) {
            mixin(enumMixinStr___attribute_malloc__);
        }
    }






    static if(!is(typeof(__attribute_pure__))) {
        private enum enumMixinStr___attribute_pure__ = `enum __attribute_pure__ = __attribute__ ( ( __pure__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_pure__); }))) {
            mixin(enumMixinStr___attribute_pure__);
        }
    }




    static if(!is(typeof(__attribute_const__))) {
        private enum enumMixinStr___attribute_const__ = `enum __attribute_const__ = __attribute__ ( cast( __const__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_const__); }))) {
            mixin(enumMixinStr___attribute_const__);
        }
    }




    static if(!is(typeof(__attribute_used__))) {
        private enum enumMixinStr___attribute_used__ = `enum __attribute_used__ = __attribute__ ( ( __used__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_used__); }))) {
            mixin(enumMixinStr___attribute_used__);
        }
    }




    static if(!is(typeof(__attribute_noinline__))) {
        private enum enumMixinStr___attribute_noinline__ = `enum __attribute_noinline__ = __attribute__ ( ( __noinline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_noinline__); }))) {
            mixin(enumMixinStr___attribute_noinline__);
        }
    }




    static if(!is(typeof(__attribute_deprecated__))) {
        private enum enumMixinStr___attribute_deprecated__ = `enum __attribute_deprecated__ = __attribute__ ( ( __deprecated__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_deprecated__); }))) {
            mixin(enumMixinStr___attribute_deprecated__);
        }
    }
    static if(!is(typeof(__attribute_warn_unused_result__))) {
        private enum enumMixinStr___attribute_warn_unused_result__ = `enum __attribute_warn_unused_result__ = __attribute__ ( ( __warn_unused_result__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_warn_unused_result__); }))) {
            mixin(enumMixinStr___attribute_warn_unused_result__);
        }
    }






    static if(!is(typeof(__always_inline))) {
        private enum enumMixinStr___always_inline = `enum __always_inline = __inline __attribute__ ( ( __always_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___always_inline); }))) {
            mixin(enumMixinStr___always_inline);
        }
    }






    static if(!is(typeof(__extern_inline))) {
        private enum enumMixinStr___extern_inline = `enum __extern_inline = extern __inline __attribute__ ( ( __gnu_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___extern_inline); }))) {
            mixin(enumMixinStr___extern_inline);
        }
    }




    static if(!is(typeof(__extern_always_inline))) {
        private enum enumMixinStr___extern_always_inline = `enum __extern_always_inline = extern __inline __attribute__ ( ( __always_inline__ ) ) __attribute__ ( ( __gnu_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___extern_always_inline); }))) {
            mixin(enumMixinStr___extern_always_inline);
        }
    }




    static if(!is(typeof(__fortify_function))) {
        private enum enumMixinStr___fortify_function = `enum __fortify_function = extern __inline __attribute__ ( ( __always_inline__ ) ) __attribute__ ( ( __gnu_inline__ ) ) ;`;
        static if(is(typeof({ mixin(enumMixinStr___fortify_function); }))) {
            mixin(enumMixinStr___fortify_function);
        }
    }




    static if(!is(typeof(__restrict_arr))) {
        private enum enumMixinStr___restrict_arr = `enum __restrict_arr = __restrict;`;
        static if(is(typeof({ mixin(enumMixinStr___restrict_arr); }))) {
            mixin(enumMixinStr___restrict_arr);
        }
    }
    static if(!is(typeof(__glibc_has_include))) {
        private enum enumMixinStr___glibc_has_include = `enum __glibc_has_include = __has_include;`;
        static if(is(typeof({ mixin(enumMixinStr___glibc_has_include); }))) {
            mixin(enumMixinStr___glibc_has_include);
        }
    }
    static if(!is(typeof(__HAVE_GENERIC_SELECTION))) {
        private enum enumMixinStr___HAVE_GENERIC_SELECTION = `enum __HAVE_GENERIC_SELECTION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_GENERIC_SELECTION); }))) {
            mixin(enumMixinStr___HAVE_GENERIC_SELECTION);
        }
    }

}
}
module mpid.openmpi.include;

version(openmpi) {
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
    extern __gshared {
        /*
        * External variables
        *
        * The below externs use the ompi_predefined_xxx_t structures to maintain
        * back compatibility between MPI library versions.
        * See ompi/communicator/communicator.h comments with struct ompi_communicator_t
        * for full explanation why we chose to use the ompi_predefined_xxx_t structure.
        */
        ompi_predefined_communicator_t ompi_mpi_comm_world;
        ompi_predefined_communicator_t ompi_mpi_comm_self;
        ompi_predefined_communicator_t ompi_mpi_comm_null;

        ompi_predefined_group_t ompi_mpi_group_empty;
        ompi_predefined_group_t ompi_mpi_group_null;

        ompi_predefined_request_t ompi_request_null;

        ompi_predefined_message_t ompi_message_null;
        ompi_predefined_message_t ompi_message_no_proc;

        ompi_predefined_op_t ompi_mpi_op_null;
        ompi_predefined_op_t ompi_mpi_op_min;
        ompi_predefined_op_t ompi_mpi_op_max;
        ompi_predefined_op_t ompi_mpi_op_sum;
        ompi_predefined_op_t ompi_mpi_op_prod;
        ompi_predefined_op_t ompi_mpi_op_land;
        ompi_predefined_op_t ompi_mpi_op_band;
        ompi_predefined_op_t ompi_mpi_op_lor;
        ompi_predefined_op_t ompi_mpi_op_bor;
        ompi_predefined_op_t ompi_mpi_op_lxor;
        ompi_predefined_op_t ompi_mpi_op_bxor;
        ompi_predefined_op_t ompi_mpi_op_maxloc;
        ompi_predefined_op_t ompi_mpi_op_minloc;
        ompi_predefined_op_t ompi_mpi_op_replace;
        ompi_predefined_op_t ompi_mpi_op_no_op;


        ompi_predefined_datatype_t ompi_mpi_datatype_null;

        //ompi_predefined_datatype_t ompi_mpi_lb __mpi_interface_deprecated__("MPI_LB is deprecated in MPI-2.0");
        //ompi_predefined_datatype_t ompi_mpi_ub __mpi_interface_deprecated__("MPI_UB is deprecated in MPI-2.0");
        ompi_predefined_datatype_t ompi_mpi_char;
        ompi_predefined_datatype_t ompi_mpi_signed_char;
        ompi_predefined_datatype_t ompi_mpi_unsigned_char;
        ompi_predefined_datatype_t ompi_mpi_byte;
        ompi_predefined_datatype_t ompi_mpi_short;
        ompi_predefined_datatype_t ompi_mpi_unsigned_short;
        ompi_predefined_datatype_t ompi_mpi_int;
        ompi_predefined_datatype_t ompi_mpi_unsigned;
        ompi_predefined_datatype_t ompi_mpi_long;
        ompi_predefined_datatype_t ompi_mpi_unsigned_long;
        ompi_predefined_datatype_t ompi_mpi_long_long_int;
        ompi_predefined_datatype_t ompi_mpi_unsigned_long_long;
        ompi_predefined_datatype_t ompi_mpi_float;
        ompi_predefined_datatype_t ompi_mpi_double;
        ompi_predefined_datatype_t ompi_mpi_long_double;
        ompi_predefined_datatype_t ompi_mpi_wchar;
        ompi_predefined_datatype_t ompi_mpi_packed;

        /*
        * Following are the C++/C99 datatypes
        */
        ompi_predefined_datatype_t ompi_mpi_cxx_bool;
        ompi_predefined_datatype_t ompi_mpi_cxx_cplex;
        ompi_predefined_datatype_t ompi_mpi_cxx_dblcplex;
        ompi_predefined_datatype_t ompi_mpi_cxx_ldblcplex;

        /*
        * Following are the Fortran datatypes
        */
        ompi_predefined_datatype_t ompi_mpi_logical;
        ompi_predefined_datatype_t ompi_mpi_character;
        ompi_predefined_datatype_t ompi_mpi_integer;
        ompi_predefined_datatype_t ompi_mpi_real;
        ompi_predefined_datatype_t ompi_mpi_dblprec;
        ompi_predefined_datatype_t ompi_mpi_cplex;
        ompi_predefined_datatype_t ompi_mpi_dblcplex;
        ompi_predefined_datatype_t ompi_mpi_ldblcplex;

        /* Aggregate struct datatypes are not const */
        ompi_predefined_datatype_t ompi_mpi_2int;
        ompi_predefined_datatype_t ompi_mpi_2integer;
        ompi_predefined_datatype_t ompi_mpi_2real;
        ompi_predefined_datatype_t ompi_mpi_2dblprec;
        ompi_predefined_datatype_t ompi_mpi_2cplex;
        ompi_predefined_datatype_t ompi_mpi_2dblcplex;

        ompi_predefined_datatype_t ompi_mpi_float_int;
        ompi_predefined_datatype_t ompi_mpi_double_int;
        ompi_predefined_datatype_t ompi_mpi_longdbl_int;
        ompi_predefined_datatype_t ompi_mpi_short_int;
        ompi_predefined_datatype_t ompi_mpi_long_int;

        /* Optional MPI2 datatypes, always declared and defined, but not "exported" as MPI_LOGICAL1 */
        ompi_predefined_datatype_t ompi_mpi_logical1;
        ompi_predefined_datatype_t ompi_mpi_logical2;
        ompi_predefined_datatype_t ompi_mpi_logical4;
        ompi_predefined_datatype_t ompi_mpi_logical8;
        ompi_predefined_datatype_t ompi_mpi_integer1;
        ompi_predefined_datatype_t ompi_mpi_integer2;
        ompi_predefined_datatype_t ompi_mpi_integer4;
        ompi_predefined_datatype_t ompi_mpi_integer8;
        ompi_predefined_datatype_t ompi_mpi_integer16;
        ompi_predefined_datatype_t ompi_mpi_real2;
        ompi_predefined_datatype_t ompi_mpi_real4;
        ompi_predefined_datatype_t ompi_mpi_real8;
        ompi_predefined_datatype_t ompi_mpi_real16;
        ompi_predefined_datatype_t ompi_mpi_complex8;
        ompi_predefined_datatype_t ompi_mpi_complex16;
        ompi_predefined_datatype_t ompi_mpi_complex32;

        /* New datatypes from the MPI 2.2 standard */
        ompi_predefined_datatype_t ompi_mpi_int8_t;
        ompi_predefined_datatype_t ompi_mpi_uint8_t;
        ompi_predefined_datatype_t ompi_mpi_int16_t;
        ompi_predefined_datatype_t ompi_mpi_uint16_t;
        ompi_predefined_datatype_t ompi_mpi_int32_t;
        ompi_predefined_datatype_t ompi_mpi_uint32_t;
        ompi_predefined_datatype_t ompi_mpi_int64_t;
        ompi_predefined_datatype_t ompi_mpi_uint64_t;
        ompi_predefined_datatype_t ompi_mpi_aint;
        ompi_predefined_datatype_t ompi_mpi_offset;
        ompi_predefined_datatype_t ompi_mpi_count;
        ompi_predefined_datatype_t ompi_mpi_c_bool;
        ompi_predefined_datatype_t ompi_mpi_c_float_complex;
        ompi_predefined_datatype_t ompi_mpi_c_double_complex;
        ompi_predefined_datatype_t ompi_mpi_c_long_double_complex;

        ompi_predefined_errhandler_t ompi_mpi_errhandler_null;
        ompi_predefined_errhandler_t ompi_mpi_errors_are_fatal;
        ompi_predefined_errhandler_t ompi_mpi_errors_return;

        ompi_predefined_win_t ompi_mpi_win_null;
        ompi_predefined_file_t ompi_mpi_file_null;

        ompi_predefined_info_t ompi_mpi_info_null;
        ompi_predefined_info_t ompi_mpi_info_env;
    }

    int MPI_T_enum_get_item(mca_base_var_enum_t*, int, int*, char*, int*) @nogc nothrow;
    int MPI_T_enum_get_info(mca_base_var_enum_t*, int*, char*, int*) @nogc nothrow;
    int MPI_T_pvar_readreset(mca_base_pvar_session_t*, mca_base_pvar_handle_t*, void*) @nogc nothrow;
    int MPI_T_pvar_reset(mca_base_pvar_session_t*, mca_base_pvar_handle_t*) @nogc nothrow;
    int MPI_T_pvar_write(mca_base_pvar_session_t*, mca_base_pvar_handle_t*, const(void)*) @nogc nothrow;
    int MPI_T_pvar_read(mca_base_pvar_session_t*, mca_base_pvar_handle_t*, void*) @nogc nothrow;
    int MPI_T_pvar_stop(mca_base_pvar_session_t*, mca_base_pvar_handle_t*) @nogc nothrow;
    int MPI_T_pvar_start(mca_base_pvar_session_t*, mca_base_pvar_handle_t*) @nogc nothrow;
    int MPI_T_pvar_handle_free(mca_base_pvar_session_t*, mca_base_pvar_handle_t**) @nogc nothrow;
    int MPI_T_pvar_handle_alloc(mca_base_pvar_session_t*, int, void*, mca_base_pvar_handle_t**, int*) @nogc nothrow;
    int MPI_T_pvar_session_free(mca_base_pvar_session_t**) @nogc nothrow;
    int MPI_T_pvar_session_create(mca_base_pvar_session_t**) @nogc nothrow;
    int MPI_T_pvar_get_index(const(char)*, int, int*) @nogc nothrow;
    int MPI_T_pvar_get_info(int, char*, int*, int*, int*, ompi_datatype_t**, mca_base_var_enum_t**, char*, int*, int*, int*, int*, int*) @nogc nothrow;
    int MPI_T_pvar_get_num(int*) @nogc nothrow;
    int MPI_T_category_changed(int*) @nogc nothrow;
    int MPI_T_category_get_categories(int, int, int*) @nogc nothrow;
    int MPI_T_category_get_pvars(int, int, int*) @nogc nothrow;
    int MPI_T_category_get_cvars(int, int, int*) @nogc nothrow;
    int MPI_T_category_get_index(const(char)*, int*) @nogc nothrow;
    int MPI_T_category_get_info(int, char*, int*, char*, int*, int*, int*, int*) @nogc nothrow;
    int MPI_T_category_get_num(int*) @nogc nothrow;
    int MPI_T_cvar_write(ompi_mpit_cvar_handle_t*, const(void)*) @nogc nothrow;
    int MPI_T_cvar_read(ompi_mpit_cvar_handle_t*, void*) @nogc nothrow;
    int MPI_T_cvar_handle_free(ompi_mpit_cvar_handle_t**) @nogc nothrow;
    int MPI_T_cvar_handle_alloc(int, void*, ompi_mpit_cvar_handle_t**, int*) @nogc nothrow;
    int MPI_T_cvar_get_index(const(char)*, int*) @nogc nothrow;
    int MPI_T_cvar_get_info(int, char*, int*, int*, ompi_datatype_t**, mca_base_var_enum_t**, char*, int*, int*, int*) @nogc nothrow;
    int MPI_T_cvar_get_num(int*) @nogc nothrow;
    int MPI_T_finalize() @nogc nothrow;
    int MPI_T_init_thread(int, int*) @nogc nothrow;
    int PMPI_T_enum_get_item(mca_base_var_enum_t*, int, int*, char*, int*) @nogc nothrow;
    int PMPI_T_enum_get_info(mca_base_var_enum_t*, int*, char*, int*) @nogc nothrow;
    int PMPI_T_pvar_readreset(mca_base_pvar_session_t*, mca_base_pvar_handle_t*, void*) @nogc nothrow;
    int PMPI_T_pvar_reset(mca_base_pvar_session_t*, mca_base_pvar_handle_t*) @nogc nothrow;
    int PMPI_T_pvar_write(mca_base_pvar_session_t*, mca_base_pvar_handle_t*, const(void)*) @nogc nothrow;
    int PMPI_T_pvar_read(mca_base_pvar_session_t*, mca_base_pvar_handle_t*, void*) @nogc nothrow;
    int PMPI_T_pvar_stop(mca_base_pvar_session_t*, mca_base_pvar_handle_t*) @nogc nothrow;
    int PMPI_T_pvar_start(mca_base_pvar_session_t*, mca_base_pvar_handle_t*) @nogc nothrow;
    int PMPI_T_pvar_handle_free(mca_base_pvar_session_t*, mca_base_pvar_handle_t**) @nogc nothrow;
    int PMPI_T_pvar_handle_alloc(mca_base_pvar_session_t*, int, void*, mca_base_pvar_handle_t**, int*) @nogc nothrow;
    int PMPI_T_pvar_session_free(mca_base_pvar_session_t**) @nogc nothrow;
    int PMPI_T_pvar_session_create(mca_base_pvar_session_t**) @nogc nothrow;
    int PMPI_T_pvar_get_index(const(char)*, int, int*) @nogc nothrow;
    int PMPI_T_pvar_get_info(int, char*, int*, int*, int*, ompi_datatype_t**, mca_base_var_enum_t**, char*, int*, int*, int*, int*, int*) @nogc nothrow;
    int PMPI_T_pvar_get_num(int*) @nogc nothrow;
    int PMPI_T_category_changed(int*) @nogc nothrow;
    int PMPI_T_category_get_categories(int, int, int*) @nogc nothrow;
    int PMPI_T_category_get_pvars(int, int, int*) @nogc nothrow;
    int PMPI_T_category_get_cvars(int, int, int*) @nogc nothrow;
    int PMPI_T_category_get_index(const(char)*, int*) @nogc nothrow;
    int PMPI_T_category_get_info(int, char*, int*, char*, int*, int*, int*, int*) @nogc nothrow;
    int PMPI_T_category_get_num(int*) @nogc nothrow;
    int PMPI_T_cvar_write(ompi_mpit_cvar_handle_t*, const(void)*) @nogc nothrow;
    int PMPI_T_cvar_read(ompi_mpit_cvar_handle_t*, void*) @nogc nothrow;
    int PMPI_T_cvar_handle_free(ompi_mpit_cvar_handle_t**) @nogc nothrow;
    int PMPI_T_cvar_handle_alloc(int, void*, ompi_mpit_cvar_handle_t**, int*) @nogc nothrow;
    int PMPI_T_cvar_get_index(const(char)*, int*) @nogc nothrow;
    int PMPI_T_cvar_get_info(int, char*, int*, int*, ompi_datatype_t**, mca_base_var_enum_t**, char*, int*, int*, int*) @nogc nothrow;
    int PMPI_T_cvar_get_num(int*) @nogc nothrow;
    int PMPI_T_finalize() @nogc nothrow;
    int PMPI_T_init_thread(int, int*) @nogc nothrow;
    double PMPI_Wtime() @nogc nothrow;
    double PMPI_Wtick() @nogc nothrow;
    int PMPI_Win_wait(ompi_win_t*) @nogc nothrow;
    int PMPI_Win_unlock_all(ompi_win_t*) @nogc nothrow;
    int PMPI_Win_unlock(int, ompi_win_t*) @nogc nothrow;
    int PMPI_Win_test(ompi_win_t*, int*) @nogc nothrow;
    int PMPI_Win_sync(ompi_win_t*) @nogc nothrow;
    int PMPI_Win_start(ompi_group_t*, int, ompi_win_t*) @nogc nothrow;
    int PMPI_Win_shared_query(ompi_win_t*, int, c_long*, int*, void*) @nogc nothrow;
    int PMPI_Win_set_name(ompi_win_t*, const(char)*) @nogc nothrow;
    int PMPI_Win_set_info(ompi_win_t*, ompi_info_t*) @nogc nothrow;
    int PMPI_Win_set_errhandler(ompi_win_t*, ompi_errhandler_t*) @nogc nothrow;
    int PMPI_Win_set_attr(ompi_win_t*, int, void*) @nogc nothrow;
    int PMPI_Win_post(ompi_group_t*, int, ompi_win_t*) @nogc nothrow;
    int PMPI_Win_lock_all(int, ompi_win_t*) @nogc nothrow;
    int PMPI_Win_lock(int, int, int, ompi_win_t*) @nogc nothrow;
    int PMPI_Win_get_name(ompi_win_t*, char*, int*) @nogc nothrow;
    int PMPI_Win_get_info(ompi_win_t*, ompi_info_t**) @nogc nothrow;
    int PMPI_Win_get_group(ompi_win_t*, ompi_group_t**) @nogc nothrow;
    int PMPI_Win_get_errhandler(ompi_win_t*, ompi_errhandler_t**) @nogc nothrow;
    int PMPI_Win_get_attr(ompi_win_t*, int, void*, int*) @nogc nothrow;
    int PMPI_Win_free_keyval(int*) @nogc nothrow;
    int PMPI_Win_free(ompi_win_t**) @nogc nothrow;
    int PMPI_Win_flush_local_all(ompi_win_t*) @nogc nothrow;
    int PMPI_Win_flush_local(int, ompi_win_t*) @nogc nothrow;
    int PMPI_Win_flush_all(ompi_win_t*) @nogc nothrow;
    int PMPI_Win_flush(int, ompi_win_t*) @nogc nothrow;
    int PMPI_Win_fence(int, ompi_win_t*) @nogc nothrow;
    ompi_win_t* PMPI_Win_f2c(int) @nogc nothrow;
    int PMPI_Win_detach(ompi_win_t*, const(void)*) @nogc nothrow;
    int PMPI_Win_delete_attr(ompi_win_t*, int) @nogc nothrow;
    int PMPI_Win_create_keyval(int function(ompi_win_t*, int, void*, void*, void*, int*), int function(ompi_win_t*, int, void*, void*), int*, void*) @nogc nothrow;
    int PMPI_Win_create_errhandler(void function(ompi_win_t**, int*, ...), ompi_errhandler_t**) @nogc nothrow;
    int PMPI_Win_create_dynamic(ompi_info_t*, ompi_communicator_t*, ompi_win_t**) @nogc nothrow;
    int PMPI_Win_create(void*, c_long, int, ompi_info_t*, ompi_communicator_t*, ompi_win_t**) @nogc nothrow;
    int PMPI_Win_complete(ompi_win_t*) @nogc nothrow;
    int PMPI_Win_call_errhandler(ompi_win_t*, int) @nogc nothrow;
    int PMPI_Win_c2f(ompi_win_t*) @nogc nothrow;
    int PMPI_Win_attach(ompi_win_t*, void*, c_long) @nogc nothrow;
    int PMPI_Win_allocate_shared(c_long, int, ompi_info_t*, ompi_communicator_t*, void*, ompi_win_t**) @nogc nothrow;
    int PMPI_Win_allocate(c_long, int, ompi_info_t*, ompi_communicator_t*, void*, ompi_win_t**) @nogc nothrow;
    int PMPI_Waitsome(int, ompi_request_t**, int*, int*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Wait(ompi_request_t**, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Waitany(int, ompi_request_t**, int*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Waitall(int, ompi_request_t**, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Unpack_external(const(char)*, const(void)*, c_long, c_long*, void*, int, ompi_datatype_t*) @nogc nothrow;
    int PMPI_Unpublish_name(const(char)*, ompi_info_t*, const(char)*) @nogc nothrow;
    int PMPI_Unpack(const(void)*, int, int*, void*, int, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Type_vector(int, int, int, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_ub(ompi_datatype_t*, c_long*) @nogc nothrow;
    int PMPI_Type_struct(int, int*, c_long*, ompi_datatype_t**, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_size_x(ompi_datatype_t*, long*) @nogc nothrow;
    int PMPI_Type_size(ompi_datatype_t*, int*) @nogc nothrow;
    int PMPI_Type_set_name(ompi_datatype_t*, const(char)*) @nogc nothrow;
    int PMPI_Type_set_attr(ompi_datatype_t*, int, void*) @nogc nothrow;
    int PMPI_Type_match_size(int, int, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_lb(ompi_datatype_t*, c_long*) @nogc nothrow;
    int PMPI_Type_indexed(int, const(int)*, const(int)*, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_hvector(int, int, c_long, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_hindexed(int, int*, c_long*, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_get_true_extent_x(ompi_datatype_t*, long*, long*) @nogc nothrow;
    int PMPI_Type_get_true_extent(ompi_datatype_t*, c_long*, c_long*) @nogc nothrow;
    int PMPI_Type_get_name(ompi_datatype_t*, char*, int*) @nogc nothrow;
    int PMPI_Type_get_extent_x(ompi_datatype_t*, long*, long*) @nogc nothrow;
    int PMPI_Type_get_extent(ompi_datatype_t*, c_long*, c_long*) @nogc nothrow;
    int PMPI_Type_get_envelope(ompi_datatype_t*, int*, int*, int*, int*) @nogc nothrow;
    int PMPI_Type_get_contents(ompi_datatype_t*, int, int, int, int*, c_long*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_get_attr(ompi_datatype_t*, int, void*, int*) @nogc nothrow;
    ompi_datatype_t* PMPI_Type_f2c(int) @nogc nothrow;
    int PMPI_Type_free_keyval(int*) @nogc nothrow;
    int PMPI_Type_free(ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_extent(ompi_datatype_t*, c_long*) @nogc nothrow;
    int PMPI_Type_dup(ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_delete_attr(ompi_datatype_t*, int) @nogc nothrow;
    int PMPI_Type_create_resized(ompi_datatype_t*, c_long, c_long, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_create_subarray(int, const(int)*, const(int)*, const(int)*, int, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_create_struct(int, const(int)*, const(c_long)*, const(ompi_datatype_t*)*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_create_indexed_block(int, int, const(int)*, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_create_hindexed_block(int, int, const(c_long)*, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_create_keyval(int function(ompi_datatype_t*, int, void*, void*, void*, int*), int function(ompi_datatype_t*, int, void*, void*), int*, void*) @nogc nothrow;
    int PMPI_Type_create_hvector(int, int, c_long, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_create_hindexed(int, const(int)*, const(c_long)*, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_create_f90_real(int, int, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_create_f90_integer(int, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_create_f90_complex(int, int, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_create_darray(int, int, int, const(int)*, const(int)*, const(int)*, const(int)*, int, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_contiguous(int, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_commit(ompi_datatype_t**) @nogc nothrow;
    int PMPI_Type_c2f(ompi_datatype_t*) @nogc nothrow;
    int PMPI_Topo_test(ompi_communicator_t*, int*) @nogc nothrow;
    int PMPI_Testsome(int, ompi_request_t**, int*, int*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Test_cancelled(const(ompi_status_public_t)*, int*) @nogc nothrow;
    int PMPI_Test(ompi_request_t**, int*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Testany(int, ompi_request_t**, int*, int*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Testall(int, ompi_request_t**, int*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Status_set_elements_x(ompi_status_public_t*, ompi_datatype_t*, long) @nogc nothrow;
    int PMPI_Status_set_elements(ompi_status_public_t*, ompi_datatype_t*, int) @nogc nothrow;
    int PMPI_Status_set_cancelled(ompi_status_public_t*, int) @nogc nothrow;
    int PMPI_Status_f2c(const(int)*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Status_c2f(const(ompi_status_public_t)*, int*) @nogc nothrow;
    int PMPI_Startall(int, ompi_request_t**) @nogc nothrow;
    int PMPI_Start(ompi_request_t**) @nogc nothrow;
    struct max_align_t
    {
        long __clang_max_align_nonce1;
        real __clang_max_align_nonce2;
    }
    int PMPI_Ssend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Ssend_init(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Sendrecv_replace(void*, int, ompi_datatype_t*, int, int, int, int, ompi_communicator_t*, ompi_status_public_t*) @nogc nothrow;
    alias ptrdiff_t = c_long;
    int PMPI_Sendrecv(const(void)*, int, ompi_datatype_t*, int, int, void*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_status_public_t*) @nogc nothrow;
    alias size_t = c_ulong;
    alias wchar_t = int;
    int PMPI_Send(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Send_init(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Iscatterv(const(void)*, const(int)*, const(int)*, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Scatterv(const(void)*, const(int)*, const(int)*, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Iscatter(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Scatter(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Iscan(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Scan(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Rsend_init(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Rsend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Rput(const(void)*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_win_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Rget_accumulate(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_op_t*, ompi_win_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Rget(void*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_win_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Request_get_status(ompi_request_t*, int*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Request_free(ompi_request_t**) @nogc nothrow;
    ompi_request_t* PMPI_Request_f2c(int) @nogc nothrow;
    int PMPI_Request_c2f(ompi_request_t*) @nogc nothrow;
    int PMPI_Register_datarep(const(char)*, int function(void*, ompi_datatype_t*, int, void*, long, void*), int function(void*, ompi_datatype_t*, int, void*, long, void*), int function(ompi_datatype_t*, c_long*, void*), void*) @nogc nothrow;
    int PMPI_Ireduce_scatter_block(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Reduce_scatter_block(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Ireduce_scatter(const(void)*, void*, const(int)*, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Reduce_scatter(const(void)*, void*, const(int)*, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Reduce_local(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*) @nogc nothrow;
    int PMPI_Ireduce(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Reduce(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, int, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Recv(void*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Recv_init(void*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Raccumulate(const(void)*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_op_t*, ompi_win_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Query_thread(int*) @nogc nothrow;
    int PMPI_Put(const(void)*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_win_t*) @nogc nothrow;
    alias MPI_Aint = c_long;
    alias MPI_Offset = long;
    alias MPI_Count = long;
    alias MPI_Comm = ompi_communicator_t*;
    struct ompi_communicator_t;
    alias MPI_Datatype = ompi_datatype_t*;
    struct ompi_datatype_t;
    alias MPI_Errhandler = ompi_errhandler_t*;
    struct ompi_errhandler_t;
    alias MPI_File = ompi_file_t*;
    struct ompi_file_t;
    alias MPI_Group = ompi_group_t*;
    struct ompi_group_t;
    alias MPI_Info = ompi_info_t*;
    struct ompi_info_t;
    alias MPI_Op = ompi_op_t*;
    struct ompi_op_t;
    alias MPI_Request = ompi_request_t*;
    struct ompi_request_t;
    alias MPI_Message = ompi_message_t*;
    struct ompi_message_t;
    alias MPI_Status = ompi_status_public_t;
    struct ompi_status_public_t
    {
        int MPI_SOURCE;
        int MPI_TAG;
        int MPI_ERROR;
        int _cancelled;
        c_ulong _ucount;
    }
    alias MPI_Win = ompi_win_t*;
    struct ompi_win_t;
    alias MPI_T_enum = mca_base_var_enum_t*;
    struct mca_base_var_enum_t;
    alias MPI_T_cvar_handle = ompi_mpit_cvar_handle_t*;
    struct ompi_mpit_cvar_handle_t;
    alias MPI_T_pvar_handle = mca_base_pvar_handle_t*;
    struct mca_base_pvar_handle_t;
    alias MPI_T_pvar_session = mca_base_pvar_session_t*;
    struct mca_base_pvar_session_t;
    alias MPI_Copy_function = int function(ompi_communicator_t*, int, void*, void*, void*, int*);
    alias MPI_Delete_function = int function(ompi_communicator_t*, int, void*, void*);
    alias MPI_Datarep_extent_function = int function(ompi_datatype_t*, c_long*, void*);
    alias MPI_Datarep_conversion_function = int function(void*, ompi_datatype_t*, int, void*, long, void*);
    alias MPI_Comm_errhandler_function = void function(ompi_communicator_t**, int*);
    alias MPI_Comm_errhandler_fn = void function(ompi_communicator_t**, int*);
    alias ompi_file_errhandler_fn = void function(ompi_file_t**, int*);
    alias MPI_File_errhandler_fn = void function(ompi_file_t**, int*);
    alias MPI_File_errhandler_function = void function(ompi_file_t**, int*);
    alias MPI_Win_errhandler_function = void function(ompi_win_t**, int*);
    alias MPI_Win_errhandler_fn = void function(ompi_win_t**, int*);
    alias MPI_Handler_function = void function(ompi_communicator_t**, int*);
    alias MPI_User_function = void function(void*, void*, int*, ompi_datatype_t**);
    alias MPI_Comm_copy_attr_function = int function(ompi_communicator_t*, int, void*, void*, void*, int*);
    alias MPI_Comm_delete_attr_function = int function(ompi_communicator_t*, int, void*, void*);
    alias MPI_Type_copy_attr_function = int function(ompi_datatype_t*, int, void*, void*, void*, int*);
    alias MPI_Type_delete_attr_function = int function(ompi_datatype_t*, int, void*, void*);
    alias MPI_Win_copy_attr_function = int function(ompi_win_t*, int, void*, void*, void*, int*);
    alias MPI_Win_delete_attr_function = int function(ompi_win_t*, int, void*, void*);
    alias MPI_Grequest_query_function = int function(void*, ompi_status_public_t*);
    alias MPI_Grequest_free_function = int function(void*);
    alias MPI_Grequest_cancel_function = int function(void*, int);
    int PMPI_Publish_name(const(char)*, ompi_info_t*, const(char)*) @nogc nothrow;
    int PMPI_Probe(int, int, ompi_communicator_t*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Pcontrol(const(int), ...) @nogc nothrow;
    int PMPI_Pack_size(int, ompi_datatype_t*, ompi_communicator_t*, int*) @nogc nothrow;
    int PMPI_Pack(const(void)*, int, ompi_datatype_t*, void*, int, int*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Pack_external_size(const(char)*, int, ompi_datatype_t*, c_long*) @nogc nothrow;
    int PMPI_Pack_external(const(char)*, const(void)*, int, ompi_datatype_t*, void*, c_long, c_long*) @nogc nothrow;
    int PMPI_Op_free(ompi_op_t**) @nogc nothrow;
    ompi_op_t* PMPI_Op_f2c(int) @nogc nothrow;
    int PMPI_Open_port(ompi_info_t*, char*) @nogc nothrow;
    int PMPI_Op_create(void function(void*, void*, int*, ompi_datatype_t**), int, ompi_op_t**) @nogc nothrow;
    int PMPI_Op_commutative(ompi_op_t*, int*) @nogc nothrow;
    int PMPI_Op_c2f(ompi_op_t*) @nogc nothrow;
    int PMPI_Ineighbor_alltoallw(const(void)*, const(int)*, const(c_long)*, const(ompi_datatype_t*)*, void*, const(int)*, const(c_long)*, const(ompi_datatype_t*)*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Neighbor_alltoallw(const(void)*, const(int)*, const(c_long)*, const(ompi_datatype_t*)*, void*, const(int)*, const(c_long)*, const(ompi_datatype_t*)*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Ineighbor_alltoallv(const(void)*, const(int)*, const(int)*, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Neighbor_alltoallv(const(void)*, const(int)*, const(int)*, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Ineighbor_alltoall(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Neighbor_alltoall(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Ineighbor_allgatherv(const(void)*, int, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Neighbor_allgatherv(const(void)*, int, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Ineighbor_allgather(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Neighbor_allgather(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Mrecv(void*, int, ompi_datatype_t*, ompi_message_t**, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Mprobe(int, int, ompi_communicator_t*, ompi_message_t**, ompi_status_public_t*) @nogc nothrow;
    ompi_message_t* PMPI_Message_f2c(int) @nogc nothrow;
    enum _Anonymous_0
    {
        MPI_TAG_UB = 0,
        MPI_HOST = 1,
        MPI_IO = 2,
        MPI_WTIME_IS_GLOBAL = 3,
        MPI_APPNUM = 4,
        MPI_LASTUSEDCODE = 5,
        MPI_UNIVERSE_SIZE = 6,
        MPI_WIN_BASE = 7,
        MPI_WIN_SIZE = 8,
        MPI_WIN_DISP_UNIT = 9,
        MPI_WIN_CREATE_FLAVOR = 10,
        MPI_WIN_MODEL = 11,
        IMPI_CLIENT_SIZE = 12,
        IMPI_CLIENT_COLOR = 13,
        IMPI_HOST_SIZE = 14,
        IMPI_HOST_COLOR = 15,
    }
    enum MPI_TAG_UB = _Anonymous_0.MPI_TAG_UB;
    enum MPI_HOST = _Anonymous_0.MPI_HOST;
    enum MPI_IO = _Anonymous_0.MPI_IO;
    enum MPI_WTIME_IS_GLOBAL = _Anonymous_0.MPI_WTIME_IS_GLOBAL;
    enum MPI_APPNUM = _Anonymous_0.MPI_APPNUM;
    enum MPI_LASTUSEDCODE = _Anonymous_0.MPI_LASTUSEDCODE;
    enum MPI_UNIVERSE_SIZE = _Anonymous_0.MPI_UNIVERSE_SIZE;
    enum MPI_WIN_BASE = _Anonymous_0.MPI_WIN_BASE;
    enum MPI_WIN_SIZE = _Anonymous_0.MPI_WIN_SIZE;
    enum MPI_WIN_DISP_UNIT = _Anonymous_0.MPI_WIN_DISP_UNIT;
    enum MPI_WIN_CREATE_FLAVOR = _Anonymous_0.MPI_WIN_CREATE_FLAVOR;
    enum MPI_WIN_MODEL = _Anonymous_0.MPI_WIN_MODEL;
    enum IMPI_CLIENT_SIZE = _Anonymous_0.IMPI_CLIENT_SIZE;
    enum IMPI_CLIENT_COLOR = _Anonymous_0.IMPI_CLIENT_COLOR;
    enum IMPI_HOST_SIZE = _Anonymous_0.IMPI_HOST_SIZE;
    enum IMPI_HOST_COLOR = _Anonymous_0.IMPI_HOST_COLOR;
    int PMPI_Message_c2f(ompi_message_t*) @nogc nothrow;
    int PMPI_Lookup_name(const(char)*, ompi_info_t*, char*) @nogc nothrow;
    int PMPI_Keyval_free(int*) @nogc nothrow;
    int PMPI_Keyval_create(int function(ompi_communicator_t*, int, void*, void*, void*, int*), int function(ompi_communicator_t*, int, void*, void*), int*, void*) @nogc nothrow;
    int PMPI_Is_thread_main(int*) @nogc nothrow;
    int PMPI_Issend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Isend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Irsend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Irecv(void*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Iprobe(int, int, ompi_communicator_t*, int*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Intercomm_merge(ompi_communicator_t*, int, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Intercomm_create(ompi_communicator_t*, int, ompi_communicator_t*, int, int, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Init_thread(int*, char***, int, int*) @nogc nothrow;
    int PMPI_Initialized(int*) @nogc nothrow;
    int PMPI_Init(int*, char***) @nogc nothrow;
    int PMPI_Info_set(ompi_info_t*, const(char)*, const(char)*) @nogc nothrow;
    int PMPI_Info_get_valuelen(ompi_info_t*, const(char)*, int*, int*) @nogc nothrow;
    int PMPI_Info_get_nthkey(ompi_info_t*, int, char*) @nogc nothrow;
    int PMPI_Info_get_nkeys(ompi_info_t*, int*) @nogc nothrow;
    int PMPI_Info_get(ompi_info_t*, const(char)*, int, char*, int*) @nogc nothrow;
    int PMPI_Info_free(ompi_info_t**) @nogc nothrow;
    ompi_info_t* PMPI_Info_f2c(int) @nogc nothrow;
    int PMPI_Info_dup(ompi_info_t*, ompi_info_t**) @nogc nothrow;
    int PMPI_Info_delete(ompi_info_t*, const(char)*) @nogc nothrow;
    int PMPI_Info_create(ompi_info_t**) @nogc nothrow;
    int PMPI_Info_c2f(ompi_info_t*) @nogc nothrow;
    int PMPI_Imrecv(void*, int, ompi_datatype_t*, ompi_message_t**, ompi_request_t**) @nogc nothrow;
    int PMPI_Improbe(int, int, ompi_communicator_t*, int*, ompi_message_t**, ompi_status_public_t*) @nogc nothrow;
    int PMPI_Ibsend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Group_union(ompi_group_t*, ompi_group_t*, ompi_group_t**) @nogc nothrow;
    int PMPI_Group_translate_ranks(ompi_group_t*, int, const(int)*, ompi_group_t*, int*) @nogc nothrow;
    int PMPI_Group_size(ompi_group_t*, int*) @nogc nothrow;
    int PMPI_Group_rank(ompi_group_t*, int*) @nogc nothrow;
    int PMPI_Group_range_incl(ompi_group_t*, int, int[3]*, ompi_group_t**) @nogc nothrow;
    int PMPI_Group_range_excl(ompi_group_t*, int, int[3]*, ompi_group_t**) @nogc nothrow;
    int PMPI_Group_intersection(ompi_group_t*, ompi_group_t*, ompi_group_t**) @nogc nothrow;
    enum _Anonymous_1
    {
        MPI_IDENT = 0,
        MPI_CONGRUENT = 1,
        MPI_SIMILAR = 2,
        MPI_UNEQUAL = 3,
    }
    enum MPI_IDENT = _Anonymous_1.MPI_IDENT;
    enum MPI_CONGRUENT = _Anonymous_1.MPI_CONGRUENT;
    enum MPI_SIMILAR = _Anonymous_1.MPI_SIMILAR;
    enum MPI_UNEQUAL = _Anonymous_1.MPI_UNEQUAL;
    enum _Anonymous_2
    {
        MPI_THREAD_SINGLE = 0,
        MPI_THREAD_FUNNELED = 1,
        MPI_THREAD_SERIALIZED = 2,
        MPI_THREAD_MULTIPLE = 3,
    }
    enum MPI_THREAD_SINGLE = _Anonymous_2.MPI_THREAD_SINGLE;
    enum MPI_THREAD_FUNNELED = _Anonymous_2.MPI_THREAD_FUNNELED;
    enum MPI_THREAD_SERIALIZED = _Anonymous_2.MPI_THREAD_SERIALIZED;
    enum MPI_THREAD_MULTIPLE = _Anonymous_2.MPI_THREAD_MULTIPLE;
    enum _Anonymous_3
    {
        MPI_COMBINER_NAMED = 0,
        MPI_COMBINER_DUP = 1,
        MPI_COMBINER_CONTIGUOUS = 2,
        MPI_COMBINER_VECTOR = 3,
        MPI_COMBINER_HVECTOR_INTEGER = 4,
        MPI_COMBINER_HVECTOR = 5,
        MPI_COMBINER_INDEXED = 6,
        MPI_COMBINER_HINDEXED_INTEGER = 7,
        MPI_COMBINER_HINDEXED = 8,
        MPI_COMBINER_INDEXED_BLOCK = 9,
        MPI_COMBINER_STRUCT_INTEGER = 10,
        MPI_COMBINER_STRUCT = 11,
        MPI_COMBINER_SUBARRAY = 12,
        MPI_COMBINER_DARRAY = 13,
        MPI_COMBINER_F90_REAL = 14,
        MPI_COMBINER_F90_COMPLEX = 15,
        MPI_COMBINER_F90_INTEGER = 16,
        MPI_COMBINER_RESIZED = 17,
        MPI_COMBINER_HINDEXED_BLOCK = 18,
    }
    enum MPI_COMBINER_NAMED = _Anonymous_3.MPI_COMBINER_NAMED;
    enum MPI_COMBINER_DUP = _Anonymous_3.MPI_COMBINER_DUP;
    enum MPI_COMBINER_CONTIGUOUS = _Anonymous_3.MPI_COMBINER_CONTIGUOUS;
    enum MPI_COMBINER_VECTOR = _Anonymous_3.MPI_COMBINER_VECTOR;
    enum MPI_COMBINER_HVECTOR_INTEGER = _Anonymous_3.MPI_COMBINER_HVECTOR_INTEGER;
    enum MPI_COMBINER_HVECTOR = _Anonymous_3.MPI_COMBINER_HVECTOR;
    enum MPI_COMBINER_INDEXED = _Anonymous_3.MPI_COMBINER_INDEXED;
    enum MPI_COMBINER_HINDEXED_INTEGER = _Anonymous_3.MPI_COMBINER_HINDEXED_INTEGER;
    enum MPI_COMBINER_HINDEXED = _Anonymous_3.MPI_COMBINER_HINDEXED;
    enum MPI_COMBINER_INDEXED_BLOCK = _Anonymous_3.MPI_COMBINER_INDEXED_BLOCK;
    enum MPI_COMBINER_STRUCT_INTEGER = _Anonymous_3.MPI_COMBINER_STRUCT_INTEGER;
    enum MPI_COMBINER_STRUCT = _Anonymous_3.MPI_COMBINER_STRUCT;
    enum MPI_COMBINER_SUBARRAY = _Anonymous_3.MPI_COMBINER_SUBARRAY;
    enum MPI_COMBINER_DARRAY = _Anonymous_3.MPI_COMBINER_DARRAY;
    enum MPI_COMBINER_F90_REAL = _Anonymous_3.MPI_COMBINER_F90_REAL;
    enum MPI_COMBINER_F90_COMPLEX = _Anonymous_3.MPI_COMBINER_F90_COMPLEX;
    enum MPI_COMBINER_F90_INTEGER = _Anonymous_3.MPI_COMBINER_F90_INTEGER;
    enum MPI_COMBINER_RESIZED = _Anonymous_3.MPI_COMBINER_RESIZED;
    enum MPI_COMBINER_HINDEXED_BLOCK = _Anonymous_3.MPI_COMBINER_HINDEXED_BLOCK;
    enum _Anonymous_4
    {
        MPI_COMM_TYPE_SHARED = 0,
        OMPI_COMM_TYPE_HWTHREAD = 1,
        OMPI_COMM_TYPE_CORE = 2,
        OMPI_COMM_TYPE_L1CACHE = 3,
        OMPI_COMM_TYPE_L2CACHE = 4,
        OMPI_COMM_TYPE_L3CACHE = 5,
        OMPI_COMM_TYPE_SOCKET = 6,
        OMPI_COMM_TYPE_NUMA = 7,
        OMPI_COMM_TYPE_BOARD = 8,
        OMPI_COMM_TYPE_HOST = 9,
        OMPI_COMM_TYPE_CU = 10,
        OMPI_COMM_TYPE_CLUSTER = 11,
    }
    enum MPI_COMM_TYPE_SHARED = _Anonymous_4.MPI_COMM_TYPE_SHARED;
    enum OMPI_COMM_TYPE_HWTHREAD = _Anonymous_4.OMPI_COMM_TYPE_HWTHREAD;
    enum OMPI_COMM_TYPE_CORE = _Anonymous_4.OMPI_COMM_TYPE_CORE;
    enum OMPI_COMM_TYPE_L1CACHE = _Anonymous_4.OMPI_COMM_TYPE_L1CACHE;
    enum OMPI_COMM_TYPE_L2CACHE = _Anonymous_4.OMPI_COMM_TYPE_L2CACHE;
    enum OMPI_COMM_TYPE_L3CACHE = _Anonymous_4.OMPI_COMM_TYPE_L3CACHE;
    enum OMPI_COMM_TYPE_SOCKET = _Anonymous_4.OMPI_COMM_TYPE_SOCKET;
    enum OMPI_COMM_TYPE_NUMA = _Anonymous_4.OMPI_COMM_TYPE_NUMA;
    enum OMPI_COMM_TYPE_BOARD = _Anonymous_4.OMPI_COMM_TYPE_BOARD;
    enum OMPI_COMM_TYPE_HOST = _Anonymous_4.OMPI_COMM_TYPE_HOST;
    enum OMPI_COMM_TYPE_CU = _Anonymous_4.OMPI_COMM_TYPE_CU;
    enum OMPI_COMM_TYPE_CLUSTER = _Anonymous_4.OMPI_COMM_TYPE_CLUSTER;
    enum _Anonymous_5
    {
        MPI_T_VERBOSITY_USER_BASIC = 0,
        MPI_T_VERBOSITY_USER_DETAIL = 1,
        MPI_T_VERBOSITY_USER_ALL = 2,
        MPI_T_VERBOSITY_TUNER_BASIC = 3,
        MPI_T_VERBOSITY_TUNER_DETAIL = 4,
        MPI_T_VERBOSITY_TUNER_ALL = 5,
        MPI_T_VERBOSITY_MPIDEV_BASIC = 6,
        MPI_T_VERBOSITY_MPIDEV_DETAIL = 7,
        MPI_T_VERBOSITY_MPIDEV_ALL = 8,
    }
    enum MPI_T_VERBOSITY_USER_BASIC = _Anonymous_5.MPI_T_VERBOSITY_USER_BASIC;
    enum MPI_T_VERBOSITY_USER_DETAIL = _Anonymous_5.MPI_T_VERBOSITY_USER_DETAIL;
    enum MPI_T_VERBOSITY_USER_ALL = _Anonymous_5.MPI_T_VERBOSITY_USER_ALL;
    enum MPI_T_VERBOSITY_TUNER_BASIC = _Anonymous_5.MPI_T_VERBOSITY_TUNER_BASIC;
    enum MPI_T_VERBOSITY_TUNER_DETAIL = _Anonymous_5.MPI_T_VERBOSITY_TUNER_DETAIL;
    enum MPI_T_VERBOSITY_TUNER_ALL = _Anonymous_5.MPI_T_VERBOSITY_TUNER_ALL;
    enum MPI_T_VERBOSITY_MPIDEV_BASIC = _Anonymous_5.MPI_T_VERBOSITY_MPIDEV_BASIC;
    enum MPI_T_VERBOSITY_MPIDEV_DETAIL = _Anonymous_5.MPI_T_VERBOSITY_MPIDEV_DETAIL;
    enum MPI_T_VERBOSITY_MPIDEV_ALL = _Anonymous_5.MPI_T_VERBOSITY_MPIDEV_ALL;
    enum _Anonymous_6
    {
        MPI_T_SCOPE_CONSTANT = 0,
        MPI_T_SCOPE_READONLY = 1,
        MPI_T_SCOPE_LOCAL = 2,
        MPI_T_SCOPE_GROUP = 3,
        MPI_T_SCOPE_GROUP_EQ = 4,
        MPI_T_SCOPE_ALL = 5,
        MPI_T_SCOPE_ALL_EQ = 6,
    }
    enum MPI_T_SCOPE_CONSTANT = _Anonymous_6.MPI_T_SCOPE_CONSTANT;
    enum MPI_T_SCOPE_READONLY = _Anonymous_6.MPI_T_SCOPE_READONLY;
    enum MPI_T_SCOPE_LOCAL = _Anonymous_6.MPI_T_SCOPE_LOCAL;
    enum MPI_T_SCOPE_GROUP = _Anonymous_6.MPI_T_SCOPE_GROUP;
    enum MPI_T_SCOPE_GROUP_EQ = _Anonymous_6.MPI_T_SCOPE_GROUP_EQ;
    enum MPI_T_SCOPE_ALL = _Anonymous_6.MPI_T_SCOPE_ALL;
    enum MPI_T_SCOPE_ALL_EQ = _Anonymous_6.MPI_T_SCOPE_ALL_EQ;
    enum _Anonymous_7
    {
        MPI_T_BIND_NO_OBJECT = 0,
        MPI_T_BIND_MPI_COMM = 1,
        MPI_T_BIND_MPI_DATATYPE = 2,
        MPI_T_BIND_MPI_ERRHANDLER = 3,
        MPI_T_BIND_MPI_FILE = 4,
        MPI_T_BIND_MPI_GROUP = 5,
        MPI_T_BIND_MPI_OP = 6,
        MPI_T_BIND_MPI_REQUEST = 7,
        MPI_T_BIND_MPI_WIN = 8,
        MPI_T_BIND_MPI_MESSAGE = 9,
        MPI_T_BIND_MPI_INFO = 10,
    }
    enum MPI_T_BIND_NO_OBJECT = _Anonymous_7.MPI_T_BIND_NO_OBJECT;
    enum MPI_T_BIND_MPI_COMM = _Anonymous_7.MPI_T_BIND_MPI_COMM;
    enum MPI_T_BIND_MPI_DATATYPE = _Anonymous_7.MPI_T_BIND_MPI_DATATYPE;
    enum MPI_T_BIND_MPI_ERRHANDLER = _Anonymous_7.MPI_T_BIND_MPI_ERRHANDLER;
    enum MPI_T_BIND_MPI_FILE = _Anonymous_7.MPI_T_BIND_MPI_FILE;
    enum MPI_T_BIND_MPI_GROUP = _Anonymous_7.MPI_T_BIND_MPI_GROUP;
    enum MPI_T_BIND_MPI_OP = _Anonymous_7.MPI_T_BIND_MPI_OP;
    enum MPI_T_BIND_MPI_REQUEST = _Anonymous_7.MPI_T_BIND_MPI_REQUEST;
    enum MPI_T_BIND_MPI_WIN = _Anonymous_7.MPI_T_BIND_MPI_WIN;
    enum MPI_T_BIND_MPI_MESSAGE = _Anonymous_7.MPI_T_BIND_MPI_MESSAGE;
    enum MPI_T_BIND_MPI_INFO = _Anonymous_7.MPI_T_BIND_MPI_INFO;
    enum _Anonymous_8
    {
        MPI_T_PVAR_CLASS_STATE = 0,
        MPI_T_PVAR_CLASS_LEVEL = 1,
        MPI_T_PVAR_CLASS_SIZE = 2,
        MPI_T_PVAR_CLASS_PERCENTAGE = 3,
        MPI_T_PVAR_CLASS_HIGHWATERMARK = 4,
        MPI_T_PVAR_CLASS_LOWWATERMARK = 5,
        MPI_T_PVAR_CLASS_COUNTER = 6,
        MPI_T_PVAR_CLASS_AGGREGATE = 7,
        MPI_T_PVAR_CLASS_TIMER = 8,
        MPI_T_PVAR_CLASS_GENERIC = 9,
    }
    enum MPI_T_PVAR_CLASS_STATE = _Anonymous_8.MPI_T_PVAR_CLASS_STATE;
    enum MPI_T_PVAR_CLASS_LEVEL = _Anonymous_8.MPI_T_PVAR_CLASS_LEVEL;
    enum MPI_T_PVAR_CLASS_SIZE = _Anonymous_8.MPI_T_PVAR_CLASS_SIZE;
    enum MPI_T_PVAR_CLASS_PERCENTAGE = _Anonymous_8.MPI_T_PVAR_CLASS_PERCENTAGE;
    enum MPI_T_PVAR_CLASS_HIGHWATERMARK = _Anonymous_8.MPI_T_PVAR_CLASS_HIGHWATERMARK;
    enum MPI_T_PVAR_CLASS_LOWWATERMARK = _Anonymous_8.MPI_T_PVAR_CLASS_LOWWATERMARK;
    enum MPI_T_PVAR_CLASS_COUNTER = _Anonymous_8.MPI_T_PVAR_CLASS_COUNTER;
    enum MPI_T_PVAR_CLASS_AGGREGATE = _Anonymous_8.MPI_T_PVAR_CLASS_AGGREGATE;
    enum MPI_T_PVAR_CLASS_TIMER = _Anonymous_8.MPI_T_PVAR_CLASS_TIMER;
    enum MPI_T_PVAR_CLASS_GENERIC = _Anonymous_8.MPI_T_PVAR_CLASS_GENERIC;
    int PMPI_Group_incl(ompi_group_t*, int, const(int)*, ompi_group_t**) @nogc nothrow;
    int PMPI_Group_free(ompi_group_t**) @nogc nothrow;
    ompi_group_t* PMPI_Group_f2c(int) @nogc nothrow;
    int PMPI_Group_excl(ompi_group_t*, int, const(int)*, ompi_group_t**) @nogc nothrow;
    int PMPI_Group_difference(ompi_group_t*, ompi_group_t*, ompi_group_t**) @nogc nothrow;
    int PMPI_Group_compare(ompi_group_t*, ompi_group_t*, int*) @nogc nothrow;
    int PMPI_Group_c2f(ompi_group_t*) @nogc nothrow;
    int PMPI_Grequest_start(int function(void*, ompi_status_public_t*), int function(void*), int function(void*, int), void*, ompi_request_t**) @nogc nothrow;
    int PMPI_Grequest_complete(ompi_request_t*) @nogc nothrow;
    int PMPI_Graphdims_get(ompi_communicator_t*, int*, int*) @nogc nothrow;
    int PMPI_Graph_neighbors(ompi_communicator_t*, int, int, int*) @nogc nothrow;
    int PMPI_Graph_neighbors_count(ompi_communicator_t*, int, int*) @nogc nothrow;
    int PMPI_Graph_map(ompi_communicator_t*, int, const(int)*, const(int)*, int*) @nogc nothrow;
    int PMPI_Graph_get(ompi_communicator_t*, int, int, int*, int*) @nogc nothrow;
    int OMPI_C_MPI_TYPE_NULL_DELETE_FN(ompi_datatype_t*, int, void*, void*) @nogc nothrow;
    int OMPI_C_MPI_TYPE_NULL_COPY_FN(ompi_datatype_t*, int, void*, void*, void*, int*) @nogc nothrow;
    int OMPI_C_MPI_TYPE_DUP_FN(ompi_datatype_t*, int, void*, void*, void*, int*) @nogc nothrow;
    int OMPI_C_MPI_COMM_NULL_DELETE_FN(ompi_communicator_t*, int, void*, void*) @nogc nothrow;
    int OMPI_C_MPI_COMM_NULL_COPY_FN(ompi_communicator_t*, int, void*, void*, void*, int*) @nogc nothrow;
    int OMPI_C_MPI_COMM_DUP_FN(ompi_communicator_t*, int, void*, void*, void*, int*) @nogc nothrow;
    int OMPI_C_MPI_NULL_DELETE_FN(ompi_communicator_t*, int, void*, void*) @nogc nothrow;
    int OMPI_C_MPI_NULL_COPY_FN(ompi_communicator_t*, int, void*, void*, void*, int*) @nogc nothrow;
    int OMPI_C_MPI_DUP_FN(ompi_communicator_t*, int, void*, void*, void*, int*) @nogc nothrow;
    int OMPI_C_MPI_WIN_NULL_DELETE_FN(ompi_win_t*, int, void*, void*) @nogc nothrow;
    int OMPI_C_MPI_WIN_NULL_COPY_FN(ompi_win_t*, int, void*, void*, void*, int*) @nogc nothrow;
    int OMPI_C_MPI_WIN_DUP_FN(ompi_win_t*, int, void*, void*, void*, int*) @nogc nothrow;
    struct ompi_predefined_communicator_t {};
    struct ompi_predefined_group_t {};
    struct ompi_predefined_request_t {};
    struct ompi_predefined_message_t {};
    struct ompi_predefined_op_t {};
    struct ompi_predefined_datatype_t {};
    struct ompi_predefined_errhandler_t {};
    struct ompi_predefined_win_t {};
    struct ompi_predefined_file_t {};
    struct ompi_predefined_info_t {};
    extern __gshared int* MPI_F_STATUS_IGNORE;
    extern __gshared int* MPI_F_STATUSES_IGNORE;
    int PMPI_Graph_create(ompi_communicator_t*, int, const(int)*, const(int)*, int, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Get_version(int*, int*) @nogc nothrow;
    int PMPI_Get_processor_name(char*, int*) @nogc nothrow;
    int PMPI_Get_library_version(char*, int*) @nogc nothrow;
    int PMPI_Get_accumulate(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_op_t*, ompi_win_t*) @nogc nothrow;
    int PMPI_Get(void*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_win_t*) @nogc nothrow;
    int PMPI_Get_elements_x(const(ompi_status_public_t)*, ompi_datatype_t*, long*) @nogc nothrow;
    int PMPI_Get_elements(const(ompi_status_public_t)*, ompi_datatype_t*, int*) @nogc nothrow;
    int PMPI_Get_count(const(ompi_status_public_t)*, ompi_datatype_t*, int*) @nogc nothrow;
    int PMPI_Get_address(const(void)*, c_long*) @nogc nothrow;
    int PMPI_Igatherv(const(void)*, int, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Gatherv(const(void)*, int, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, int, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Igather(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Gather(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Free_mem(void*) @nogc nothrow;
    int PMPI_Finalized(int*) @nogc nothrow;
    int PMPI_Finalize() @nogc nothrow;
    int PMPI_File_sync(ompi_file_t*) @nogc nothrow;
    int PMPI_File_get_atomicity(ompi_file_t*, int*) @nogc nothrow;
    int PMPI_File_set_atomicity(ompi_file_t*, int) @nogc nothrow;
    int PMPI_File_get_type_extent(ompi_file_t*, ompi_datatype_t*, c_long*) @nogc nothrow;
    int PMPI_File_write_ordered_end(ompi_file_t*, const(void)*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_write_ordered_begin(ompi_file_t*, const(void)*, int, ompi_datatype_t*) @nogc nothrow;
    int PMPI_File_read_ordered_end(ompi_file_t*, void*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_read_ordered_begin(ompi_file_t*, void*, int, ompi_datatype_t*) @nogc nothrow;
    int PMPI_File_write_all_end(ompi_file_t*, const(void)*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_write_all_begin(ompi_file_t*, const(void)*, int, ompi_datatype_t*) @nogc nothrow;
    int PMPI_File_read_all_end(ompi_file_t*, void*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_read_all_begin(ompi_file_t*, void*, int, ompi_datatype_t*) @nogc nothrow;
    int PMPI_File_write_at_all_end(ompi_file_t*, const(void)*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_write_at_all_begin(ompi_file_t*, long, const(void)*, int, ompi_datatype_t*) @nogc nothrow;
    int PMPI_File_read_at_all_end(ompi_file_t*, void*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_read_at_all_begin(ompi_file_t*, long, void*, int, ompi_datatype_t*) @nogc nothrow;
    int PMPI_File_get_position_shared(ompi_file_t*, long*) @nogc nothrow;
    int PMPI_File_seek_shared(ompi_file_t*, long, int) @nogc nothrow;
    int PMPI_File_write_ordered(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_read_ordered(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_iwrite_shared(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_File_iread_shared(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_File_write_shared(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_read_shared(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_get_byte_offset(ompi_file_t*, long, long*) @nogc nothrow;
    int PMPI_File_get_position(ompi_file_t*, long*) @nogc nothrow;
    int PMPI_File_seek(ompi_file_t*, long, int) @nogc nothrow;
    int PMPI_File_iwrite_all(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_File_iread_all(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_File_iwrite(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_File_iread(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_File_write_all(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_write(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Abort(ompi_communicator_t*, int) @nogc nothrow;
    int MPI_Accumulate(const(void)*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_op_t*, ompi_win_t*) @nogc nothrow;
    int MPI_Add_error_class(int*) @nogc nothrow;
    int MPI_Add_error_code(int, int*) @nogc nothrow;
    int MPI_Add_error_string(int, const(char)*) @nogc nothrow;
    int MPI_Address(void*, c_long*) @nogc nothrow;
    int MPI_Allgather(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Iallgather(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Allgatherv(const(void)*, int, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Iallgatherv(const(void)*, int, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Alloc_mem(c_long, ompi_info_t*, void*) @nogc nothrow;
    int MPI_Allreduce(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Iallreduce(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Alltoall(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Ialltoall(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Alltoallv(const(void)*, const(int)*, const(int)*, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Ialltoallv(const(void)*, const(int)*, const(int)*, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Alltoallw(const(void)*, const(int)*, const(int)*, const(ompi_datatype_t*)*, void*, const(int)*, const(int)*, const(ompi_datatype_t*)*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Ialltoallw(const(void)*, const(int)*, const(int)*, const(ompi_datatype_t*)*, void*, const(int)*, const(int)*, const(ompi_datatype_t*)*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Attr_delete(ompi_communicator_t*, int) @nogc nothrow;
    int MPI_Attr_get(ompi_communicator_t*, int, void*, int*) @nogc nothrow;
    int MPI_Attr_put(ompi_communicator_t*, int, void*) @nogc nothrow;
    int MPI_Barrier(ompi_communicator_t*) @nogc nothrow;
    int MPI_Ibarrier(ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Bcast(void*, int, ompi_datatype_t*, int, ompi_communicator_t*) @nogc nothrow;
    int MPI_Bsend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*) @nogc nothrow;
    int MPI_Ibcast(void*, int, ompi_datatype_t*, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Bsend_init(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Buffer_attach(void*, int) @nogc nothrow;
    int MPI_Buffer_detach(void*, int*) @nogc nothrow;
    int MPI_Cancel(ompi_request_t**) @nogc nothrow;
    int MPI_Cart_coords(ompi_communicator_t*, int, int, int*) @nogc nothrow;
    int MPI_Cart_create(ompi_communicator_t*, int, const(int)*, const(int)*, int, ompi_communicator_t**) @nogc nothrow;
    int MPI_Cart_get(ompi_communicator_t*, int, int*, int*, int*) @nogc nothrow;
    int MPI_Cart_map(ompi_communicator_t*, int, const(int)*, const(int)*, int*) @nogc nothrow;
    int MPI_Cart_rank(ompi_communicator_t*, const(int)*, int*) @nogc nothrow;
    int MPI_Cart_shift(ompi_communicator_t*, int, int, int*, int*) @nogc nothrow;
    int MPI_Cart_sub(ompi_communicator_t*, const(int)*, ompi_communicator_t**) @nogc nothrow;
    int MPI_Cartdim_get(ompi_communicator_t*, int*) @nogc nothrow;
    int MPI_Close_port(const(char)*) @nogc nothrow;
    int MPI_Comm_accept(const(char)*, ompi_info_t*, int, ompi_communicator_t*, ompi_communicator_t**) @nogc nothrow;
    int MPI_Comm_c2f(ompi_communicator_t*) @nogc nothrow;
    int MPI_Comm_call_errhandler(ompi_communicator_t*, int) @nogc nothrow;
    int MPI_Comm_compare(ompi_communicator_t*, ompi_communicator_t*, int*) @nogc nothrow;
    int MPI_Comm_connect(const(char)*, ompi_info_t*, int, ompi_communicator_t*, ompi_communicator_t**) @nogc nothrow;
    int MPI_Comm_create_errhandler(void function(ompi_communicator_t**, int*, ...), ompi_errhandler_t**) @nogc nothrow;
    int MPI_Comm_create_keyval(int function(ompi_communicator_t*, int, void*, void*, void*, int*), int function(ompi_communicator_t*, int, void*, void*), int*, void*) @nogc nothrow;
    int MPI_Comm_create_group(ompi_communicator_t*, ompi_group_t*, int, ompi_communicator_t**) @nogc nothrow;
    int MPI_Comm_create(ompi_communicator_t*, ompi_group_t*, ompi_communicator_t**) @nogc nothrow;
    int MPI_Comm_delete_attr(ompi_communicator_t*, int) @nogc nothrow;
    int MPI_Comm_disconnect(ompi_communicator_t**) @nogc nothrow;
    int MPI_Comm_dup(ompi_communicator_t*, ompi_communicator_t**) @nogc nothrow;
    int MPI_Comm_idup(ompi_communicator_t*, ompi_communicator_t**, ompi_request_t**) @nogc nothrow;
    int MPI_Comm_dup_with_info(ompi_communicator_t*, ompi_info_t*, ompi_communicator_t**) @nogc nothrow;
    ompi_communicator_t* MPI_Comm_f2c(int) @nogc nothrow;
    int MPI_Comm_free_keyval(int*) @nogc nothrow;
    int MPI_Comm_free(ompi_communicator_t**) @nogc nothrow;
    int MPI_Comm_get_attr(ompi_communicator_t*, int, void*, int*) @nogc nothrow;
    int MPI_Dist_graph_create(ompi_communicator_t*, int, const(int)*, const(int)*, const(int)*, const(int)*, ompi_info_t*, int, ompi_communicator_t**) @nogc nothrow;
    int MPI_Dist_graph_create_adjacent(ompi_communicator_t*, int, const(int)*, const(int)*, int, const(int)*, const(int)*, ompi_info_t*, int, ompi_communicator_t**) @nogc nothrow;
    int MPI_Dist_graph_neighbors(ompi_communicator_t*, int, int*, int*, int, int*, int*) @nogc nothrow;
    int MPI_Dist_graph_neighbors_count(ompi_communicator_t*, int*, int*, int*) @nogc nothrow;
    int MPI_Comm_get_errhandler(ompi_communicator_t*, ompi_errhandler_t**) @nogc nothrow;
    int MPI_Comm_get_info(ompi_communicator_t*, ompi_info_t**) @nogc nothrow;
    int MPI_Comm_get_name(ompi_communicator_t*, char*, int*) @nogc nothrow;
    int MPI_Comm_get_parent(ompi_communicator_t**) @nogc nothrow;
    int MPI_Comm_group(ompi_communicator_t*, ompi_group_t**) @nogc nothrow;
    int MPI_Comm_join(int, ompi_communicator_t**) @nogc nothrow;
    int MPI_Comm_rank(ompi_communicator_t*, int*) @nogc nothrow;
    int MPI_Comm_remote_group(ompi_communicator_t*, ompi_group_t**) @nogc nothrow;
    int MPI_Comm_remote_size(ompi_communicator_t*, int*) @nogc nothrow;
    int MPI_Comm_set_attr(ompi_communicator_t*, int, void*) @nogc nothrow;
    int MPI_Comm_set_errhandler(ompi_communicator_t*, ompi_errhandler_t*) @nogc nothrow;
    int MPI_Comm_set_info(ompi_communicator_t*, ompi_info_t*) @nogc nothrow;
    int MPI_Comm_set_name(ompi_communicator_t*, const(char)*) @nogc nothrow;
    int MPI_Comm_size(ompi_communicator_t*, int*) @nogc nothrow;
    int MPI_Comm_spawn(const(char)*, char**, int, ompi_info_t*, int, ompi_communicator_t*, ompi_communicator_t**, int*) @nogc nothrow;
    int MPI_Comm_spawn_multiple(int, char**, char***, const(int)*, const(ompi_info_t*)*, int, ompi_communicator_t*, ompi_communicator_t**, int*) @nogc nothrow;
    int MPI_Comm_split(ompi_communicator_t*, int, int, ompi_communicator_t**) @nogc nothrow;
    int MPI_Comm_split_type(ompi_communicator_t*, int, int, ompi_info_t*, ompi_communicator_t**) @nogc nothrow;
    int MPI_Comm_test_inter(ompi_communicator_t*, int*) @nogc nothrow;
    int MPI_Compare_and_swap(const(void)*, const(void)*, void*, ompi_datatype_t*, int, c_long, ompi_win_t*) @nogc nothrow;
    int MPI_Dims_create(int, int, int*) @nogc nothrow;
    int MPI_Errhandler_c2f(ompi_errhandler_t*) @nogc nothrow;
    int MPI_Errhandler_create(void function(ompi_communicator_t**, int*, ...), ompi_errhandler_t**) @nogc nothrow;
    ompi_errhandler_t* MPI_Errhandler_f2c(int) @nogc nothrow;
    int MPI_Errhandler_free(ompi_errhandler_t**) @nogc nothrow;
    int MPI_Errhandler_get(ompi_communicator_t*, ompi_errhandler_t**) @nogc nothrow;
    int MPI_Errhandler_set(ompi_communicator_t*, ompi_errhandler_t*) @nogc nothrow;
    int MPI_Error_class(int, int*) @nogc nothrow;
    int MPI_Error_string(int, char*, int*) @nogc nothrow;
    int MPI_Exscan(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Fetch_and_op(const(void)*, void*, ompi_datatype_t*, int, c_long, ompi_op_t*, ompi_win_t*) @nogc nothrow;
    int MPI_Iexscan(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_File_c2f(ompi_file_t*) @nogc nothrow;
    ompi_file_t* MPI_File_f2c(int) @nogc nothrow;
    int MPI_File_call_errhandler(ompi_file_t*, int) @nogc nothrow;
    int MPI_File_create_errhandler(void function(ompi_file_t**, int*, ...), ompi_errhandler_t**) @nogc nothrow;
    int MPI_File_set_errhandler(ompi_file_t*, ompi_errhandler_t*) @nogc nothrow;
    int MPI_File_get_errhandler(ompi_file_t*, ompi_errhandler_t**) @nogc nothrow;
    int MPI_File_open(ompi_communicator_t*, const(char)*, int, ompi_info_t*, ompi_file_t**) @nogc nothrow;
    int MPI_File_close(ompi_file_t**) @nogc nothrow;
    int MPI_File_delete(const(char)*, ompi_info_t*) @nogc nothrow;
    int MPI_File_set_size(ompi_file_t*, long) @nogc nothrow;
    int MPI_File_preallocate(ompi_file_t*, long) @nogc nothrow;
    int MPI_File_get_size(ompi_file_t*, long*) @nogc nothrow;
    int MPI_File_get_group(ompi_file_t*, ompi_group_t**) @nogc nothrow;
    int MPI_File_get_amode(ompi_file_t*, int*) @nogc nothrow;
    int MPI_File_set_info(ompi_file_t*, ompi_info_t*) @nogc nothrow;
    int MPI_File_get_info(ompi_file_t*, ompi_info_t**) @nogc nothrow;
    int MPI_File_set_view(ompi_file_t*, long, ompi_datatype_t*, ompi_datatype_t*, const(char)*, ompi_info_t*) @nogc nothrow;
    int MPI_File_get_view(ompi_file_t*, long*, ompi_datatype_t**, ompi_datatype_t**, char*) @nogc nothrow;
    int MPI_File_read_at(ompi_file_t*, long, void*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_read_at_all(ompi_file_t*, long, void*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_write_at(ompi_file_t*, long, const(void)*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_write_at_all(ompi_file_t*, long, const(void)*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_iread_at(ompi_file_t*, long, void*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int MPI_File_iwrite_at(ompi_file_t*, long, const(void)*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int MPI_File_iread_at_all(ompi_file_t*, long, void*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int MPI_File_iwrite_at_all(ompi_file_t*, long, const(void)*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int MPI_File_read(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_read_all(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_write(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_write_all(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_iread(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int MPI_File_iwrite(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int MPI_File_iread_all(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int MPI_File_iwrite_all(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int MPI_File_seek(ompi_file_t*, long, int) @nogc nothrow;
    int MPI_File_get_position(ompi_file_t*, long*) @nogc nothrow;
    int MPI_File_get_byte_offset(ompi_file_t*, long, long*) @nogc nothrow;
    int MPI_File_read_shared(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_write_shared(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_iread_shared(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int MPI_File_iwrite_shared(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int MPI_File_read_ordered(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_write_ordered(ompi_file_t*, const(void)*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_seek_shared(ompi_file_t*, long, int) @nogc nothrow;
    int MPI_File_get_position_shared(ompi_file_t*, long*) @nogc nothrow;
    int MPI_File_read_at_all_begin(ompi_file_t*, long, void*, int, ompi_datatype_t*) @nogc nothrow;
    int MPI_File_read_at_all_end(ompi_file_t*, void*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_write_at_all_begin(ompi_file_t*, long, const(void)*, int, ompi_datatype_t*) @nogc nothrow;
    int MPI_File_write_at_all_end(ompi_file_t*, const(void)*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_read_all_begin(ompi_file_t*, void*, int, ompi_datatype_t*) @nogc nothrow;
    int MPI_File_read_all_end(ompi_file_t*, void*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_write_all_begin(ompi_file_t*, const(void)*, int, ompi_datatype_t*) @nogc nothrow;
    int MPI_File_write_all_end(ompi_file_t*, const(void)*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_read_ordered_begin(ompi_file_t*, void*, int, ompi_datatype_t*) @nogc nothrow;
    int MPI_File_read_ordered_end(ompi_file_t*, void*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_write_ordered_begin(ompi_file_t*, const(void)*, int, ompi_datatype_t*) @nogc nothrow;
    int MPI_File_write_ordered_end(ompi_file_t*, const(void)*, ompi_status_public_t*) @nogc nothrow;
    int MPI_File_get_type_extent(ompi_file_t*, ompi_datatype_t*, c_long*) @nogc nothrow;
    int MPI_File_set_atomicity(ompi_file_t*, int) @nogc nothrow;
    int MPI_File_get_atomicity(ompi_file_t*, int*) @nogc nothrow;
    int MPI_File_sync(ompi_file_t*) @nogc nothrow;
    int MPI_Finalize() @nogc nothrow;
    int MPI_Finalized(int*) @nogc nothrow;
    int MPI_Free_mem(void*) @nogc nothrow;
    int MPI_Gather(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, ompi_communicator_t*) @nogc nothrow;
    int MPI_Igather(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Gatherv(const(void)*, int, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, int, ompi_communicator_t*) @nogc nothrow;
    int MPI_Igatherv(const(void)*, int, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Get_address(const(void)*, c_long*) @nogc nothrow;
    int MPI_Get_count(const(ompi_status_public_t)*, ompi_datatype_t*, int*) @nogc nothrow;
    int MPI_Get_elements(const(ompi_status_public_t)*, ompi_datatype_t*, int*) @nogc nothrow;
    int MPI_Get_elements_x(const(ompi_status_public_t)*, ompi_datatype_t*, long*) @nogc nothrow;
    int MPI_Get(void*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_win_t*) @nogc nothrow;
    int MPI_Get_accumulate(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_op_t*, ompi_win_t*) @nogc nothrow;
    int MPI_Get_library_version(char*, int*) @nogc nothrow;
    int MPI_Get_processor_name(char*, int*) @nogc nothrow;
    int MPI_Get_version(int*, int*) @nogc nothrow;
    int MPI_Graph_create(ompi_communicator_t*, int, const(int)*, const(int)*, int, ompi_communicator_t**) @nogc nothrow;
    int MPI_Graph_get(ompi_communicator_t*, int, int, int*, int*) @nogc nothrow;
    int MPI_Graph_map(ompi_communicator_t*, int, const(int)*, const(int)*, int*) @nogc nothrow;
    int MPI_Graph_neighbors_count(ompi_communicator_t*, int, int*) @nogc nothrow;
    int MPI_Graph_neighbors(ompi_communicator_t*, int, int, int*) @nogc nothrow;
    int MPI_Graphdims_get(ompi_communicator_t*, int*, int*) @nogc nothrow;
    int MPI_Grequest_complete(ompi_request_t*) @nogc nothrow;
    int MPI_Grequest_start(int function(void*, ompi_status_public_t*), int function(void*), int function(void*, int), void*, ompi_request_t**) @nogc nothrow;
    int MPI_Group_c2f(ompi_group_t*) @nogc nothrow;
    int MPI_Group_compare(ompi_group_t*, ompi_group_t*, int*) @nogc nothrow;
    int MPI_Group_difference(ompi_group_t*, ompi_group_t*, ompi_group_t**) @nogc nothrow;
    int MPI_Group_excl(ompi_group_t*, int, const(int)*, ompi_group_t**) @nogc nothrow;
    ompi_group_t* MPI_Group_f2c(int) @nogc nothrow;
    int MPI_Group_free(ompi_group_t**) @nogc nothrow;
    int MPI_Group_incl(ompi_group_t*, int, const(int)*, ompi_group_t**) @nogc nothrow;
    int MPI_Group_intersection(ompi_group_t*, ompi_group_t*, ompi_group_t**) @nogc nothrow;
    int MPI_Group_range_excl(ompi_group_t*, int, int[3]*, ompi_group_t**) @nogc nothrow;
    int MPI_Group_range_incl(ompi_group_t*, int, int[3]*, ompi_group_t**) @nogc nothrow;
    int MPI_Group_rank(ompi_group_t*, int*) @nogc nothrow;
    int MPI_Group_size(ompi_group_t*, int*) @nogc nothrow;
    int MPI_Group_translate_ranks(ompi_group_t*, int, const(int)*, ompi_group_t*, int*) @nogc nothrow;
    int MPI_Group_union(ompi_group_t*, ompi_group_t*, ompi_group_t**) @nogc nothrow;
    int MPI_Ibsend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Improbe(int, int, ompi_communicator_t*, int*, ompi_message_t**, ompi_status_public_t*) @nogc nothrow;
    int MPI_Imrecv(void*, int, ompi_datatype_t*, ompi_message_t**, ompi_request_t**) @nogc nothrow;
    int MPI_Info_c2f(ompi_info_t*) @nogc nothrow;
    int MPI_Info_create(ompi_info_t**) @nogc nothrow;
    int MPI_Info_delete(ompi_info_t*, const(char)*) @nogc nothrow;
    int MPI_Info_dup(ompi_info_t*, ompi_info_t**) @nogc nothrow;
    ompi_info_t* MPI_Info_f2c(int) @nogc nothrow;
    int MPI_Info_free(ompi_info_t**) @nogc nothrow;
    int MPI_Info_get(ompi_info_t*, const(char)*, int, char*, int*) @nogc nothrow;
    int MPI_Info_get_nkeys(ompi_info_t*, int*) @nogc nothrow;
    int MPI_Info_get_nthkey(ompi_info_t*, int, char*) @nogc nothrow;
    int MPI_Info_get_valuelen(ompi_info_t*, const(char)*, int*, int*) @nogc nothrow;
    int MPI_Info_set(ompi_info_t*, const(char)*, const(char)*) @nogc nothrow;
    int MPI_Init(int*, char***) @nogc nothrow;
    int MPI_Initialized(int*) @nogc nothrow;
    int MPI_Init_thread(int*, char***, int, int*) @nogc nothrow;
    int MPI_Intercomm_create(ompi_communicator_t*, int, ompi_communicator_t*, int, int, ompi_communicator_t**) @nogc nothrow;
    int MPI_Intercomm_merge(ompi_communicator_t*, int, ompi_communicator_t**) @nogc nothrow;
    int MPI_Iprobe(int, int, ompi_communicator_t*, int*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Irecv(void*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Irsend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Isend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Issend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Is_thread_main(int*) @nogc nothrow;
    int MPI_Keyval_create(int function(ompi_communicator_t*, int, void*, void*, void*, int*), int function(ompi_communicator_t*, int, void*, void*), int*, void*) @nogc nothrow;
    int MPI_Keyval_free(int*) @nogc nothrow;
    int MPI_Lookup_name(const(char)*, ompi_info_t*, char*) @nogc nothrow;
    int MPI_Message_c2f(ompi_message_t*) @nogc nothrow;
    ompi_message_t* MPI_Message_f2c(int) @nogc nothrow;
    int MPI_Mprobe(int, int, ompi_communicator_t*, ompi_message_t**, ompi_status_public_t*) @nogc nothrow;
    int MPI_Mrecv(void*, int, ompi_datatype_t*, ompi_message_t**, ompi_status_public_t*) @nogc nothrow;
    int MPI_Neighbor_allgather(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Ineighbor_allgather(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Neighbor_allgatherv(const(void)*, int, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Ineighbor_allgatherv(const(void)*, int, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Neighbor_alltoall(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Ineighbor_alltoall(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Neighbor_alltoallv(const(void)*, const(int)*, const(int)*, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Ineighbor_alltoallv(const(void)*, const(int)*, const(int)*, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Neighbor_alltoallw(const(void)*, const(int)*, const(c_long)*, const(ompi_datatype_t*)*, void*, const(int)*, const(c_long)*, const(ompi_datatype_t*)*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Ineighbor_alltoallw(const(void)*, const(int)*, const(c_long)*, const(ompi_datatype_t*)*, void*, const(int)*, const(c_long)*, const(ompi_datatype_t*)*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Op_c2f(ompi_op_t*) @nogc nothrow;
    int MPI_Op_commutative(ompi_op_t*, int*) @nogc nothrow;
    int MPI_Op_create(void function(void*, void*, int*, ompi_datatype_t**), int, ompi_op_t**) @nogc nothrow;
    int MPI_Open_port(ompi_info_t*, char*) @nogc nothrow;
    ompi_op_t* MPI_Op_f2c(int) @nogc nothrow;
    int MPI_Op_free(ompi_op_t**) @nogc nothrow;
    int MPI_Pack_external(const(char)*, const(void)*, int, ompi_datatype_t*, void*, c_long, c_long*) @nogc nothrow;
    int MPI_Pack_external_size(const(char)*, int, ompi_datatype_t*, c_long*) @nogc nothrow;
    int MPI_Pack(const(void)*, int, ompi_datatype_t*, void*, int, int*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Pack_size(int, ompi_datatype_t*, ompi_communicator_t*, int*) @nogc nothrow;
    int MPI_Pcontrol(const(int), ...) @nogc nothrow;
    int MPI_Probe(int, int, ompi_communicator_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Publish_name(const(char)*, ompi_info_t*, const(char)*) @nogc nothrow;
    int MPI_Put(const(void)*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_win_t*) @nogc nothrow;
    int MPI_Query_thread(int*) @nogc nothrow;
    int MPI_Raccumulate(const(void)*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_op_t*, ompi_win_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Recv_init(void*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Recv(void*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Reduce(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, int, ompi_communicator_t*) @nogc nothrow;
    int MPI_Ireduce(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Reduce_local(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*) @nogc nothrow;
    int MPI_Reduce_scatter(const(void)*, void*, const(int)*, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Ireduce_scatter(const(void)*, void*, const(int)*, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Reduce_scatter_block(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Ireduce_scatter_block(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Register_datarep(const(char)*, int function(void*, ompi_datatype_t*, int, void*, long, void*), int function(void*, ompi_datatype_t*, int, void*, long, void*), int function(ompi_datatype_t*, c_long*, void*), void*) @nogc nothrow;
    int MPI_Request_c2f(ompi_request_t*) @nogc nothrow;
    ompi_request_t* MPI_Request_f2c(int) @nogc nothrow;
    int MPI_Request_free(ompi_request_t**) @nogc nothrow;
    int MPI_Request_get_status(ompi_request_t*, int*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Rget(void*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_win_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Rget_accumulate(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_op_t*, ompi_win_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Rput(const(void)*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_win_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Rsend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*) @nogc nothrow;
    int MPI_Rsend_init(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Scan(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Iscan(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Scatter(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, ompi_communicator_t*) @nogc nothrow;
    int MPI_Iscatter(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Scatterv(const(void)*, const(int)*, const(int)*, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, ompi_communicator_t*) @nogc nothrow;
    int MPI_Iscatterv(const(void)*, const(int)*, const(int)*, ompi_datatype_t*, void*, int, ompi_datatype_t*, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Send_init(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Send(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*) @nogc nothrow;
    int MPI_Sendrecv(const(void)*, int, ompi_datatype_t*, int, int, void*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Sendrecv_replace(void*, int, ompi_datatype_t*, int, int, int, int, ompi_communicator_t*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Ssend_init(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int MPI_Ssend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*) @nogc nothrow;
    int MPI_Start(ompi_request_t**) @nogc nothrow;
    int MPI_Startall(int, ompi_request_t**) @nogc nothrow;
    int MPI_Status_c2f(const(ompi_status_public_t)*, int*) @nogc nothrow;
    int MPI_Status_f2c(const(int)*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Status_set_cancelled(ompi_status_public_t*, int) @nogc nothrow;
    int MPI_Status_set_elements(ompi_status_public_t*, ompi_datatype_t*, int) @nogc nothrow;
    int MPI_Status_set_elements_x(ompi_status_public_t*, ompi_datatype_t*, long) @nogc nothrow;
    int MPI_Testall(int, ompi_request_t**, int*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Testany(int, ompi_request_t**, int*, int*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Test(ompi_request_t**, int*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Test_cancelled(const(ompi_status_public_t)*, int*) @nogc nothrow;
    int MPI_Testsome(int, ompi_request_t**, int*, int*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Topo_test(ompi_communicator_t*, int*) @nogc nothrow;
    int MPI_Type_c2f(ompi_datatype_t*) @nogc nothrow;
    int MPI_Type_commit(ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_contiguous(int, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_create_darray(int, int, int, const(int)*, const(int)*, const(int)*, const(int)*, int, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_create_f90_complex(int, int, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_create_f90_integer(int, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_create_f90_real(int, int, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_create_hindexed_block(int, int, const(c_long)*, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_create_hindexed(int, const(int)*, const(c_long)*, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_create_hvector(int, int, c_long, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_create_keyval(int function(ompi_datatype_t*, int, void*, void*, void*, int*), int function(ompi_datatype_t*, int, void*, void*), int*, void*) @nogc nothrow;
    int MPI_Type_create_indexed_block(int, int, const(int)*, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_create_struct(int, const(int)*, const(c_long)*, const(ompi_datatype_t*)*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_create_subarray(int, const(int)*, const(int)*, const(int)*, int, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_create_resized(ompi_datatype_t*, c_long, c_long, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_delete_attr(ompi_datatype_t*, int) @nogc nothrow;
    int MPI_Type_dup(ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_extent(ompi_datatype_t*, c_long*) @nogc nothrow;
    int MPI_Type_free(ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_free_keyval(int*) @nogc nothrow;
    ompi_datatype_t* MPI_Type_f2c(int) @nogc nothrow;
    int MPI_Type_get_attr(ompi_datatype_t*, int, void*, int*) @nogc nothrow;
    int MPI_Type_get_contents(ompi_datatype_t*, int, int, int, int*, c_long*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_get_envelope(ompi_datatype_t*, int*, int*, int*, int*) @nogc nothrow;
    int MPI_Type_get_extent(ompi_datatype_t*, c_long*, c_long*) @nogc nothrow;
    int MPI_Type_get_extent_x(ompi_datatype_t*, long*, long*) @nogc nothrow;
    int MPI_Type_get_name(ompi_datatype_t*, char*, int*) @nogc nothrow;
    int MPI_Type_get_true_extent(ompi_datatype_t*, c_long*, c_long*) @nogc nothrow;
    int MPI_Type_get_true_extent_x(ompi_datatype_t*, long*, long*) @nogc nothrow;
    int MPI_Type_hindexed(int, int*, c_long*, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_hvector(int, int, c_long, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_indexed(int, const(int)*, const(int)*, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_lb(ompi_datatype_t*, c_long*) @nogc nothrow;
    int MPI_Type_match_size(int, int, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_set_attr(ompi_datatype_t*, int, void*) @nogc nothrow;
    int MPI_Type_set_name(ompi_datatype_t*, const(char)*) @nogc nothrow;
    int MPI_Type_size(ompi_datatype_t*, int*) @nogc nothrow;
    int MPI_Type_size_x(ompi_datatype_t*, long*) @nogc nothrow;
    int MPI_Type_struct(int, int*, c_long*, ompi_datatype_t**, ompi_datatype_t**) @nogc nothrow;
    int MPI_Type_ub(ompi_datatype_t*, c_long*) @nogc nothrow;
    int MPI_Type_vector(int, int, int, ompi_datatype_t*, ompi_datatype_t**) @nogc nothrow;
    int MPI_Unpack(const(void)*, int, int*, void*, int, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int MPI_Unpublish_name(const(char)*, ompi_info_t*, const(char)*) @nogc nothrow;
    int MPI_Unpack_external(const(char)*, const(void)*, c_long, c_long*, void*, int, ompi_datatype_t*) @nogc nothrow;
    int MPI_Waitall(int, ompi_request_t**, ompi_status_public_t*) @nogc nothrow;
    int MPI_Waitany(int, ompi_request_t**, int*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Wait(ompi_request_t**, ompi_status_public_t*) @nogc nothrow;
    int MPI_Waitsome(int, ompi_request_t**, int*, int*, ompi_status_public_t*) @nogc nothrow;
    int MPI_Win_allocate(c_long, int, ompi_info_t*, ompi_communicator_t*, void*, ompi_win_t**) @nogc nothrow;
    int MPI_Win_allocate_shared(c_long, int, ompi_info_t*, ompi_communicator_t*, void*, ompi_win_t**) @nogc nothrow;
    int MPI_Win_attach(ompi_win_t*, void*, c_long) @nogc nothrow;
    int MPI_Win_c2f(ompi_win_t*) @nogc nothrow;
    int MPI_Win_call_errhandler(ompi_win_t*, int) @nogc nothrow;
    int MPI_Win_complete(ompi_win_t*) @nogc nothrow;
    int MPI_Win_create(void*, c_long, int, ompi_info_t*, ompi_communicator_t*, ompi_win_t**) @nogc nothrow;
    int MPI_Win_create_dynamic(ompi_info_t*, ompi_communicator_t*, ompi_win_t**) @nogc nothrow;
    int MPI_Win_create_errhandler(void function(ompi_win_t**, int*, ...), ompi_errhandler_t**) @nogc nothrow;
    int MPI_Win_create_keyval(int function(ompi_win_t*, int, void*, void*, void*, int*), int function(ompi_win_t*, int, void*, void*), int*, void*) @nogc nothrow;
    int MPI_Win_delete_attr(ompi_win_t*, int) @nogc nothrow;
    int MPI_Win_detach(ompi_win_t*, const(void)*) @nogc nothrow;
    ompi_win_t* MPI_Win_f2c(int) @nogc nothrow;
    int MPI_Win_fence(int, ompi_win_t*) @nogc nothrow;
    int MPI_Win_flush(int, ompi_win_t*) @nogc nothrow;
    int MPI_Win_flush_all(ompi_win_t*) @nogc nothrow;
    int MPI_Win_flush_local(int, ompi_win_t*) @nogc nothrow;
    int MPI_Win_flush_local_all(ompi_win_t*) @nogc nothrow;
    int MPI_Win_free(ompi_win_t**) @nogc nothrow;
    int MPI_Win_free_keyval(int*) @nogc nothrow;
    int MPI_Win_get_attr(ompi_win_t*, int, void*, int*) @nogc nothrow;
    int MPI_Win_get_errhandler(ompi_win_t*, ompi_errhandler_t**) @nogc nothrow;
    int MPI_Win_get_group(ompi_win_t*, ompi_group_t**) @nogc nothrow;
    int MPI_Win_get_info(ompi_win_t*, ompi_info_t**) @nogc nothrow;
    int MPI_Win_get_name(ompi_win_t*, char*, int*) @nogc nothrow;
    int MPI_Win_lock(int, int, int, ompi_win_t*) @nogc nothrow;
    int MPI_Win_lock_all(int, ompi_win_t*) @nogc nothrow;
    int MPI_Win_post(ompi_group_t*, int, ompi_win_t*) @nogc nothrow;
    int MPI_Win_set_attr(ompi_win_t*, int, void*) @nogc nothrow;
    int MPI_Win_set_errhandler(ompi_win_t*, ompi_errhandler_t*) @nogc nothrow;
    int MPI_Win_set_info(ompi_win_t*, ompi_info_t*) @nogc nothrow;
    int MPI_Win_set_name(ompi_win_t*, const(char)*) @nogc nothrow;
    int MPI_Win_shared_query(ompi_win_t*, int, c_long*, int*, void*) @nogc nothrow;
    int MPI_Win_start(ompi_group_t*, int, ompi_win_t*) @nogc nothrow;
    int MPI_Win_sync(ompi_win_t*) @nogc nothrow;
    int MPI_Win_test(ompi_win_t*, int*) @nogc nothrow;
    int MPI_Win_unlock(int, ompi_win_t*) @nogc nothrow;
    int MPI_Win_unlock_all(ompi_win_t*) @nogc nothrow;
    int MPI_Win_wait(ompi_win_t*) @nogc nothrow;
    double MPI_Wtick() @nogc nothrow;
    double MPI_Wtime() @nogc nothrow;
    int PMPI_Abort(ompi_communicator_t*, int) @nogc nothrow;
    int PMPI_Accumulate(const(void)*, int, ompi_datatype_t*, int, c_long, int, ompi_datatype_t*, ompi_op_t*, ompi_win_t*) @nogc nothrow;
    int PMPI_Add_error_class(int*) @nogc nothrow;
    int PMPI_Add_error_code(int, int*) @nogc nothrow;
    int PMPI_Add_error_string(int, const(char)*) @nogc nothrow;
    int PMPI_Address(void*, c_long*) @nogc nothrow;
    int PMPI_Allgather(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Iallgather(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Allgatherv(const(void)*, int, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Iallgatherv(const(void)*, int, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Alloc_mem(c_long, ompi_info_t*, void*) @nogc nothrow;
    int PMPI_Allreduce(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Iallreduce(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Alltoall(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Ialltoall(const(void)*, int, ompi_datatype_t*, void*, int, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Alltoallv(const(void)*, const(int)*, const(int)*, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Ialltoallv(const(void)*, const(int)*, const(int)*, ompi_datatype_t*, void*, const(int)*, const(int)*, ompi_datatype_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Alltoallw(const(void)*, const(int)*, const(int)*, const(ompi_datatype_t*)*, void*, const(int)*, const(int)*, const(ompi_datatype_t*)*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Ialltoallw(const(void)*, const(int)*, const(int)*, const(ompi_datatype_t*)*, void*, const(int)*, const(int)*, const(ompi_datatype_t*)*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Attr_delete(ompi_communicator_t*, int) @nogc nothrow;
    int PMPI_Attr_get(ompi_communicator_t*, int, void*, int*) @nogc nothrow;
    int PMPI_Dist_graph_create(ompi_communicator_t*, int, const(int)*, const(int)*, const(int)*, const(int)*, ompi_info_t*, int, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Dist_graph_create_adjacent(ompi_communicator_t*, int, const(int)*, const(int)*, int, const(int)*, const(int)*, ompi_info_t*, int, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Dist_graph_neighbors(ompi_communicator_t*, int, int*, int*, int, int*, int*) @nogc nothrow;
    int PMPI_Dist_graph_neighbors_count(ompi_communicator_t*, int*, int*, int*) @nogc nothrow;
    int PMPI_Attr_put(ompi_communicator_t*, int, void*) @nogc nothrow;
    int PMPI_Barrier(ompi_communicator_t*) @nogc nothrow;
    int PMPI_Ibarrier(ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Bcast(void*, int, ompi_datatype_t*, int, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Ibcast(void*, int, ompi_datatype_t*, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Bsend(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Bsend_init(const(void)*, int, ompi_datatype_t*, int, int, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_Buffer_attach(void*, int) @nogc nothrow;
    int PMPI_Buffer_detach(void*, int*) @nogc nothrow;
    int PMPI_Cancel(ompi_request_t**) @nogc nothrow;
    int PMPI_Cart_coords(ompi_communicator_t*, int, int, int*) @nogc nothrow;
    int PMPI_Cart_create(ompi_communicator_t*, int, const(int)*, const(int)*, int, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Cart_get(ompi_communicator_t*, int, int*, int*, int*) @nogc nothrow;
    int PMPI_Cart_map(ompi_communicator_t*, int, const(int)*, const(int)*, int*) @nogc nothrow;
    int PMPI_Cart_rank(ompi_communicator_t*, const(int)*, int*) @nogc nothrow;
    int PMPI_Cart_shift(ompi_communicator_t*, int, int, int*, int*) @nogc nothrow;
    int PMPI_Cart_sub(ompi_communicator_t*, const(int)*, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Cartdim_get(ompi_communicator_t*, int*) @nogc nothrow;
    int PMPI_Close_port(const(char)*) @nogc nothrow;
    int PMPI_Comm_accept(const(char)*, ompi_info_t*, int, ompi_communicator_t*, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Comm_c2f(ompi_communicator_t*) @nogc nothrow;
    int PMPI_Comm_call_errhandler(ompi_communicator_t*, int) @nogc nothrow;
    int PMPI_Comm_compare(ompi_communicator_t*, ompi_communicator_t*, int*) @nogc nothrow;
    int PMPI_Comm_connect(const(char)*, ompi_info_t*, int, ompi_communicator_t*, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Comm_create_errhandler(void function(ompi_communicator_t**, int*, ...), ompi_errhandler_t**) @nogc nothrow;
    int PMPI_Comm_create_keyval(int function(ompi_communicator_t*, int, void*, void*, void*, int*), int function(ompi_communicator_t*, int, void*, void*), int*, void*) @nogc nothrow;
    int PMPI_Comm_create_group(ompi_communicator_t*, ompi_group_t*, int, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Comm_create(ompi_communicator_t*, ompi_group_t*, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Comm_delete_attr(ompi_communicator_t*, int) @nogc nothrow;
    int PMPI_Comm_disconnect(ompi_communicator_t**) @nogc nothrow;
    int PMPI_Comm_dup(ompi_communicator_t*, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Comm_idup(ompi_communicator_t*, ompi_communicator_t**, ompi_request_t**) @nogc nothrow;
    int PMPI_Comm_dup_with_info(ompi_communicator_t*, ompi_info_t*, ompi_communicator_t**) @nogc nothrow;
    ompi_communicator_t* PMPI_Comm_f2c(int) @nogc nothrow;
    int PMPI_Comm_free_keyval(int*) @nogc nothrow;
    int PMPI_Comm_free(ompi_communicator_t**) @nogc nothrow;
    int PMPI_Comm_get_attr(ompi_communicator_t*, int, void*, int*) @nogc nothrow;
    int PMPI_Comm_get_errhandler(ompi_communicator_t*, ompi_errhandler_t**) @nogc nothrow;
    int PMPI_Comm_get_info(ompi_communicator_t*, ompi_info_t**) @nogc nothrow;
    int PMPI_Comm_get_name(ompi_communicator_t*, char*, int*) @nogc nothrow;
    int PMPI_Comm_get_parent(ompi_communicator_t**) @nogc nothrow;
    int PMPI_Comm_group(ompi_communicator_t*, ompi_group_t**) @nogc nothrow;
    int PMPI_Comm_join(int, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Comm_rank(ompi_communicator_t*, int*) @nogc nothrow;
    int PMPI_Comm_remote_group(ompi_communicator_t*, ompi_group_t**) @nogc nothrow;
    int PMPI_Comm_remote_size(ompi_communicator_t*, int*) @nogc nothrow;
    int PMPI_Comm_set_attr(ompi_communicator_t*, int, void*) @nogc nothrow;
    int PMPI_Comm_set_errhandler(ompi_communicator_t*, ompi_errhandler_t*) @nogc nothrow;
    int PMPI_Comm_set_info(ompi_communicator_t*, ompi_info_t*) @nogc nothrow;
    int PMPI_Comm_set_name(ompi_communicator_t*, const(char)*) @nogc nothrow;
    int PMPI_Comm_size(ompi_communicator_t*, int*) @nogc nothrow;
    int PMPI_Comm_spawn(const(char)*, char**, int, ompi_info_t*, int, ompi_communicator_t*, ompi_communicator_t**, int*) @nogc nothrow;
    int PMPI_Comm_spawn_multiple(int, char**, char***, const(int)*, const(ompi_info_t*)*, int, ompi_communicator_t*, ompi_communicator_t**, int*) @nogc nothrow;
    int PMPI_Comm_split(ompi_communicator_t*, int, int, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Comm_split_type(ompi_communicator_t*, int, int, ompi_info_t*, ompi_communicator_t**) @nogc nothrow;
    int PMPI_Comm_test_inter(ompi_communicator_t*, int*) @nogc nothrow;
    int PMPI_Compare_and_swap(const(void)*, const(void)*, void*, ompi_datatype_t*, int, c_long, ompi_win_t*) @nogc nothrow;
    int PMPI_Dims_create(int, int, int*) @nogc nothrow;
    int PMPI_Errhandler_c2f(ompi_errhandler_t*) @nogc nothrow;
    int PMPI_Errhandler_create(void function(ompi_communicator_t**, int*, ...), ompi_errhandler_t**) @nogc nothrow;
    ompi_errhandler_t* PMPI_Errhandler_f2c(int) @nogc nothrow;
    int PMPI_Errhandler_free(ompi_errhandler_t**) @nogc nothrow;
    int PMPI_Errhandler_get(ompi_communicator_t*, ompi_errhandler_t**) @nogc nothrow;
    int PMPI_Errhandler_set(ompi_communicator_t*, ompi_errhandler_t*) @nogc nothrow;
    int PMPI_Error_class(int, int*) @nogc nothrow;
    int PMPI_Error_string(int, char*, int*) @nogc nothrow;
    int PMPI_Exscan(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*) @nogc nothrow;
    int PMPI_Fetch_and_op(const(void)*, void*, ompi_datatype_t*, int, c_long, ompi_op_t*, ompi_win_t*) @nogc nothrow;
    int PMPI_Iexscan(const(void)*, void*, int, ompi_datatype_t*, ompi_op_t*, ompi_communicator_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_File_c2f(ompi_file_t*) @nogc nothrow;
    ompi_file_t* PMPI_File_f2c(int) @nogc nothrow;
    int PMPI_File_call_errhandler(ompi_file_t*, int) @nogc nothrow;
    int PMPI_File_create_errhandler(void function(ompi_file_t**, int*, ...), ompi_errhandler_t**) @nogc nothrow;
    int PMPI_File_set_errhandler(ompi_file_t*, ompi_errhandler_t*) @nogc nothrow;
    int PMPI_File_get_errhandler(ompi_file_t*, ompi_errhandler_t**) @nogc nothrow;
    int PMPI_File_open(ompi_communicator_t*, const(char)*, int, ompi_info_t*, ompi_file_t**) @nogc nothrow;
    int PMPI_File_close(ompi_file_t**) @nogc nothrow;
    int PMPI_File_delete(const(char)*, ompi_info_t*) @nogc nothrow;
    int PMPI_File_set_size(ompi_file_t*, long) @nogc nothrow;
    int PMPI_File_preallocate(ompi_file_t*, long) @nogc nothrow;
    int PMPI_File_get_size(ompi_file_t*, long*) @nogc nothrow;
    int PMPI_File_get_group(ompi_file_t*, ompi_group_t**) @nogc nothrow;
    int PMPI_File_get_amode(ompi_file_t*, int*) @nogc nothrow;
    int PMPI_File_set_info(ompi_file_t*, ompi_info_t*) @nogc nothrow;
    int PMPI_File_get_info(ompi_file_t*, ompi_info_t**) @nogc nothrow;
    int PMPI_File_set_view(ompi_file_t*, long, ompi_datatype_t*, ompi_datatype_t*, const(char)*, ompi_info_t*) @nogc nothrow;
    int PMPI_File_get_view(ompi_file_t*, long*, ompi_datatype_t**, ompi_datatype_t**, char*) @nogc nothrow;
    int PMPI_File_read_at(ompi_file_t*, long, void*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_read_at_all(ompi_file_t*, long, void*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_write_at(ompi_file_t*, long, const(void)*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_write_at_all(ompi_file_t*, long, const(void)*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_iread_at(ompi_file_t*, long, void*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_File_iwrite_at(ompi_file_t*, long, const(void)*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_File_iread_at_all(ompi_file_t*, long, void*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_File_iwrite_at_all(ompi_file_t*, long, const(void)*, int, ompi_datatype_t*, ompi_request_t**) @nogc nothrow;
    int PMPI_File_read(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    int PMPI_File_read_all(ompi_file_t*, void*, int, ompi_datatype_t*, ompi_status_public_t*) @nogc nothrow;
    static if(!is(typeof(MPI_TYPECLASS_COMPLEX))) {
        private enum enumMixinStr_MPI_TYPECLASS_COMPLEX = `enum MPI_TYPECLASS_COMPLEX = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TYPECLASS_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_TYPECLASS_COMPLEX);
        }
    }


    auto OMPI_PREDEFINED_GLOBAL(Type, alias Global)() {
        return cast(Type)&Global;
    }

    static if(!is(typeof(MPI_TYPECLASS_REAL))) {
        private enum enumMixinStr_MPI_TYPECLASS_REAL = `enum MPI_TYPECLASS_REAL = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TYPECLASS_REAL); }))) {
            mixin(enumMixinStr_MPI_TYPECLASS_REAL);
        }
    }




    static if(!is(typeof(MPI_TYPECLASS_INTEGER))) {
        private enum enumMixinStr_MPI_TYPECLASS_INTEGER = `enum MPI_TYPECLASS_INTEGER = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TYPECLASS_INTEGER); }))) {
            mixin(enumMixinStr_MPI_TYPECLASS_INTEGER);
        }
    }




    static if(!is(typeof(MPI_ERRORS_RETURN))) {
        private enum enumMixinStr_MPI_ERRORS_RETURN = `alias MPI_ERRORS_RETURN = OMPI_PREDEFINED_GLOBAL! ( MPI_Errhandler , ompi_mpi_errors_return );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERRORS_RETURN); }))) {
            mixin(enumMixinStr_MPI_ERRORS_RETURN);
        }
    }




    static if(!is(typeof(MPI_ERRORS_ARE_FATAL))) {
        private enum enumMixinStr_MPI_ERRORS_ARE_FATAL = `alias MPI_ERRORS_ARE_FATAL = OMPI_PREDEFINED_GLOBAL! ( MPI_Errhandler , ompi_mpi_errors_are_fatal );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERRORS_ARE_FATAL); }))) {
            mixin(enumMixinStr_MPI_ERRORS_ARE_FATAL);
        }
    }




    static if(!is(typeof(MPI_COUNT))) {
        private enum enumMixinStr_MPI_COUNT = `alias MPI_COUNT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_count );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COUNT); }))) {
            mixin(enumMixinStr_MPI_COUNT);
        }
    }




    static if(!is(typeof(MPI_CXX_LONG_DOUBLE_COMPLEX))) {
        private enum enumMixinStr_MPI_CXX_LONG_DOUBLE_COMPLEX = `alias MPI_CXX_LONG_DOUBLE_COMPLEX = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_cxx_ldblcplex );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CXX_LONG_DOUBLE_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_CXX_LONG_DOUBLE_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_CXX_DOUBLE_COMPLEX))) {
        private enum enumMixinStr_MPI_CXX_DOUBLE_COMPLEX = `alias MPI_CXX_DOUBLE_COMPLEX = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_cxx_dblcplex );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CXX_DOUBLE_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_CXX_DOUBLE_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_CXX_FLOAT_COMPLEX))) {
        private enum enumMixinStr_MPI_CXX_FLOAT_COMPLEX = `alias MPI_CXX_FLOAT_COMPLEX = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_cxx_cplex );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CXX_FLOAT_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_CXX_FLOAT_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_CXX_COMPLEX))) {
        private enum enumMixinStr_MPI_CXX_COMPLEX = `alias MPI_CXX_COMPLEX = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_cxx_cplex );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CXX_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_CXX_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_CXX_BOOL))) {
        private enum enumMixinStr_MPI_CXX_BOOL = `alias MPI_CXX_BOOL = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_cxx_bool );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CXX_BOOL); }))) {
            mixin(enumMixinStr_MPI_CXX_BOOL);
        }
    }




    static if(!is(typeof(MPI_C_LONG_DOUBLE_COMPLEX))) {
        private enum enumMixinStr_MPI_C_LONG_DOUBLE_COMPLEX = `alias MPI_C_LONG_DOUBLE_COMPLEX = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_c_long_double_complex );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_C_LONG_DOUBLE_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_C_LONG_DOUBLE_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_C_DOUBLE_COMPLEX))) {
        private enum enumMixinStr_MPI_C_DOUBLE_COMPLEX = `alias MPI_C_DOUBLE_COMPLEX = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_c_double_complex );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_C_DOUBLE_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_C_DOUBLE_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_C_FLOAT_COMPLEX))) {
        private enum enumMixinStr_MPI_C_FLOAT_COMPLEX = `alias MPI_C_FLOAT_COMPLEX = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_c_float_complex );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_C_FLOAT_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_C_FLOAT_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_C_COMPLEX))) {
        private enum enumMixinStr_MPI_C_COMPLEX = `alias MPI_C_COMPLEX = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_c_float_complex );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_C_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_C_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_C_BOOL))) {
        private enum enumMixinStr_MPI_C_BOOL = `alias MPI_C_BOOL = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_c_bool );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_C_BOOL); }))) {
            mixin(enumMixinStr_MPI_C_BOOL);
        }
    }




    static if(!is(typeof(MPI_OFFSET))) {
        private enum enumMixinStr_MPI_OFFSET = `alias MPI_OFFSET = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_offset );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_OFFSET); }))) {
            mixin(enumMixinStr_MPI_OFFSET);
        }
    }




    static if(!is(typeof(MPI_AINT))) {
        private enum enumMixinStr_MPI_AINT = `alias MPI_AINT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_aint );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_AINT); }))) {
            mixin(enumMixinStr_MPI_AINT);
        }
    }




    static if(!is(typeof(MPI_UINT64_T))) {
        private enum enumMixinStr_MPI_UINT64_T = `alias MPI_UINT64_T = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_uint64_t );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UINT64_T); }))) {
            mixin(enumMixinStr_MPI_UINT64_T);
        }
    }




    static if(!is(typeof(MPI_INT64_T))) {
        private enum enumMixinStr_MPI_INT64_T = `alias MPI_INT64_T = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_int64_t );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INT64_T); }))) {
            mixin(enumMixinStr_MPI_INT64_T);
        }
    }




    static if(!is(typeof(MPI_UINT32_T))) {
        private enum enumMixinStr_MPI_UINT32_T = `alias MPI_UINT32_T = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_uint32_t );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UINT32_T); }))) {
            mixin(enumMixinStr_MPI_UINT32_T);
        }
    }




    static if(!is(typeof(MPI_INT32_T))) {
        private enum enumMixinStr_MPI_INT32_T = `alias MPI_INT32_T = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_int32_t );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INT32_T); }))) {
            mixin(enumMixinStr_MPI_INT32_T);
        }
    }




    static if(!is(typeof(MPI_UINT16_T))) {
        private enum enumMixinStr_MPI_UINT16_T = `alias MPI_UINT16_T = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_uint16_t );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UINT16_T); }))) {
            mixin(enumMixinStr_MPI_UINT16_T);
        }
    }




    static if(!is(typeof(MPI_INT16_T))) {
        private enum enumMixinStr_MPI_INT16_T = `alias MPI_INT16_T = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_int16_t );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INT16_T); }))) {
            mixin(enumMixinStr_MPI_INT16_T);
        }
    }




    static if(!is(typeof(MPI_UINT8_T))) {
        private enum enumMixinStr_MPI_UINT8_T = `alias MPI_UINT8_T = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_uint8_t );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UINT8_T); }))) {
            mixin(enumMixinStr_MPI_UINT8_T);
        }
    }




    static if(!is(typeof(MPI_INT8_T))) {
        private enum enumMixinStr_MPI_INT8_T = `alias MPI_INT8_T = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_int8_t );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INT8_T); }))) {
            mixin(enumMixinStr_MPI_INT8_T);
        }
    }




    static if(!is(typeof(MPI_2INTEGER))) {
        private enum enumMixinStr_MPI_2INTEGER = `alias MPI_2INTEGER = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_2integer );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_2INTEGER); }))) {
            mixin(enumMixinStr_MPI_2INTEGER);
        }
    }




    static if(!is(typeof(MPI_2DOUBLE_PRECISION))) {
        private enum enumMixinStr_MPI_2DOUBLE_PRECISION = `alias MPI_2DOUBLE_PRECISION = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_2dblprec );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_2DOUBLE_PRECISION); }))) {
            mixin(enumMixinStr_MPI_2DOUBLE_PRECISION);
        }
    }




    static if(!is(typeof(MPI_2REAL))) {
        private enum enumMixinStr_MPI_2REAL = `alias MPI_2REAL = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_2real );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_2REAL); }))) {
            mixin(enumMixinStr_MPI_2REAL);
        }
    }




    static if(!is(typeof(MPI_DOUBLE_COMPLEX))) {
        private enum enumMixinStr_MPI_DOUBLE_COMPLEX = `alias MPI_DOUBLE_COMPLEX = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_dblcplex );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DOUBLE_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_DOUBLE_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_COMPLEX32))) {
        private enum enumMixinStr_MPI_COMPLEX32 = `alias MPI_COMPLEX32 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_complex32 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMPLEX32); }))) {
            mixin(enumMixinStr_MPI_COMPLEX32);
        }
    }




    static if(!is(typeof(MPI_COMPLEX16))) {
        private enum enumMixinStr_MPI_COMPLEX16 = `alias MPI_COMPLEX16 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_complex16 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMPLEX16); }))) {
            mixin(enumMixinStr_MPI_COMPLEX16);
        }
    }




    static if(!is(typeof(MPI_COMPLEX8))) {
        private enum enumMixinStr_MPI_COMPLEX8 = `alias MPI_COMPLEX8 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_complex8 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMPLEX8); }))) {
            mixin(enumMixinStr_MPI_COMPLEX8);
        }
    }




    static if(!is(typeof(MPI_COMPLEX))) {
        private enum enumMixinStr_MPI_COMPLEX = `alias MPI_COMPLEX = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_cplex );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_DOUBLE_PRECISION))) {
        private enum enumMixinStr_MPI_DOUBLE_PRECISION = `alias MPI_DOUBLE_PRECISION = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_dblprec );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DOUBLE_PRECISION); }))) {
            mixin(enumMixinStr_MPI_DOUBLE_PRECISION);
        }
    }




    static if(!is(typeof(MPI_REAL16))) {
        private enum enumMixinStr_MPI_REAL16 = `alias MPI_REAL16 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_real16 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_REAL16); }))) {
            mixin(enumMixinStr_MPI_REAL16);
        }
    }




    static if(!is(typeof(MPI_REAL8))) {
        private enum enumMixinStr_MPI_REAL8 = `alias MPI_REAL8 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_real8 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_REAL8); }))) {
            mixin(enumMixinStr_MPI_REAL8);
        }
    }




    static if(!is(typeof(MPI_REAL4))) {
        private enum enumMixinStr_MPI_REAL4 = `alias MPI_REAL4 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_real4 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_REAL4); }))) {
            mixin(enumMixinStr_MPI_REAL4);
        }
    }




    static if(!is(typeof(MPI_REAL))) {
        private enum enumMixinStr_MPI_REAL = `alias MPI_REAL = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_real );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_REAL); }))) {
            mixin(enumMixinStr_MPI_REAL);
        }
    }




    static if(!is(typeof(MPI_INTEGER8))) {
        private enum enumMixinStr_MPI_INTEGER8 = `alias MPI_INTEGER8 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_integer8 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INTEGER8); }))) {
            mixin(enumMixinStr_MPI_INTEGER8);
        }
    }




    static if(!is(typeof(MPI_INTEGER4))) {
        private enum enumMixinStr_MPI_INTEGER4 = `alias MPI_INTEGER4 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_integer4 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INTEGER4); }))) {
            mixin(enumMixinStr_MPI_INTEGER4);
        }
    }




    static if(!is(typeof(MPI_INTEGER2))) {
        private enum enumMixinStr_MPI_INTEGER2 = `alias MPI_INTEGER2 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_integer2 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INTEGER2); }))) {
            mixin(enumMixinStr_MPI_INTEGER2);
        }
    }




    static if(!is(typeof(MPI_INTEGER1))) {
        private enum enumMixinStr_MPI_INTEGER1 = `alias MPI_INTEGER1 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_integer1 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INTEGER1); }))) {
            mixin(enumMixinStr_MPI_INTEGER1);
        }
    }




    static if(!is(typeof(MPI_INTEGER))) {
        private enum enumMixinStr_MPI_INTEGER = `alias MPI_INTEGER = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_integer );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INTEGER); }))) {
            mixin(enumMixinStr_MPI_INTEGER);
        }
    }




    static if(!is(typeof(MPI_LOGICAL8))) {
        private enum enumMixinStr_MPI_LOGICAL8 = `alias MPI_LOGICAL8 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_logical8 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LOGICAL8); }))) {
            mixin(enumMixinStr_MPI_LOGICAL8);
        }
    }




    static if(!is(typeof(MPI_LOGICAL4))) {
        private enum enumMixinStr_MPI_LOGICAL4 = `alias MPI_LOGICAL4 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_logical4 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LOGICAL4); }))) {
            mixin(enumMixinStr_MPI_LOGICAL4);
        }
    }




    static if(!is(typeof(MPI_LOGICAL2))) {
        private enum enumMixinStr_MPI_LOGICAL2 = `alias MPI_LOGICAL2 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_logical2 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LOGICAL2); }))) {
            mixin(enumMixinStr_MPI_LOGICAL2);
        }
    }




    static if(!is(typeof(MPI_LOGICAL1))) {
        private enum enumMixinStr_MPI_LOGICAL1 = `alias MPI_LOGICAL1 = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_logical1 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LOGICAL1); }))) {
            mixin(enumMixinStr_MPI_LOGICAL1);
        }
    }




    static if(!is(typeof(MPI_LOGICAL))) {
        private enum enumMixinStr_MPI_LOGICAL = `alias MPI_LOGICAL = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_logical );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LOGICAL); }))) {
            mixin(enumMixinStr_MPI_LOGICAL);
        }
    }




    static if(!is(typeof(MPI_CHARACTER))) {
        private enum enumMixinStr_MPI_CHARACTER = `alias MPI_CHARACTER = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_character );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CHARACTER); }))) {
            mixin(enumMixinStr_MPI_CHARACTER);
        }
    }




    static if(!is(typeof(MPI_2DOUBLE_COMPLEX))) {
        private enum enumMixinStr_MPI_2DOUBLE_COMPLEX = `alias MPI_2DOUBLE_COMPLEX = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_2dblcplex );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_2DOUBLE_COMPLEX); }))) {
            mixin(enumMixinStr_MPI_2DOUBLE_COMPLEX);
        }
    }




    static if(!is(typeof(MPI_2COMPLEX))) {
        private enum enumMixinStr_MPI_2COMPLEX = `alias MPI_2COMPLEX = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_2cplex );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_2COMPLEX); }))) {
            mixin(enumMixinStr_MPI_2COMPLEX);
        }
    }




    static if(!is(typeof(MPI_UNSIGNED_LONG_LONG))) {
        private enum enumMixinStr_MPI_UNSIGNED_LONG_LONG = `alias MPI_UNSIGNED_LONG_LONG = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_unsigned_long_long );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNSIGNED_LONG_LONG); }))) {
            mixin(enumMixinStr_MPI_UNSIGNED_LONG_LONG);
        }
    }




    static if(!is(typeof(MPI_LONG_LONG))) {
        private enum enumMixinStr_MPI_LONG_LONG = `alias MPI_LONG_LONG = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_long_long_int );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LONG_LONG); }))) {
            mixin(enumMixinStr_MPI_LONG_LONG);
        }
    }




    static if(!is(typeof(MPI_LONG_LONG_INT))) {
        private enum enumMixinStr_MPI_LONG_LONG_INT = `alias MPI_LONG_LONG_INT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_long_long_int );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LONG_LONG_INT); }))) {
            mixin(enumMixinStr_MPI_LONG_LONG_INT);
        }
    }




    static if(!is(typeof(MPI_WCHAR))) {
        private enum enumMixinStr_MPI_WCHAR = `alias MPI_WCHAR = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_wchar );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WCHAR); }))) {
            mixin(enumMixinStr_MPI_WCHAR);
        }
    }




    static if(!is(typeof(MPI_LB))) {
        private enum enumMixinStr_MPI_LB = `alias MPI_LB = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_lb );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LB); }))) {
            mixin(enumMixinStr_MPI_LB);
        }
    }




    static if(!is(typeof(MPI_UB))) {
        private enum enumMixinStr_MPI_UB = `alias MPI_UB = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_ub );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UB); }))) {
            mixin(enumMixinStr_MPI_UB);
        }
    }




    static if(!is(typeof(MPI_2INT))) {
        private enum enumMixinStr_MPI_2INT = `alias MPI_2INT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_2int );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_2INT); }))) {
            mixin(enumMixinStr_MPI_2INT);
        }
    }




    static if(!is(typeof(MPI_SHORT_INT))) {
        private enum enumMixinStr_MPI_SHORT_INT = `alias MPI_SHORT_INT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_short_int );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SHORT_INT); }))) {
            mixin(enumMixinStr_MPI_SHORT_INT);
        }
    }




    static if(!is(typeof(MPI_LONG_INT))) {
        private enum enumMixinStr_MPI_LONG_INT = `alias MPI_LONG_INT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_long_int );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LONG_INT); }))) {
            mixin(enumMixinStr_MPI_LONG_INT);
        }
    }




    static if(!is(typeof(MPI_LONG_DOUBLE_INT))) {
        private enum enumMixinStr_MPI_LONG_DOUBLE_INT = `alias MPI_LONG_DOUBLE_INT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_longdbl_int );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LONG_DOUBLE_INT); }))) {
            mixin(enumMixinStr_MPI_LONG_DOUBLE_INT);
        }
    }




    static if(!is(typeof(MPI_DOUBLE_INT))) {
        private enum enumMixinStr_MPI_DOUBLE_INT = `alias MPI_DOUBLE_INT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_double_int );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DOUBLE_INT); }))) {
            mixin(enumMixinStr_MPI_DOUBLE_INT);
        }
    }




    static if(!is(typeof(MPI_FLOAT_INT))) {
        private enum enumMixinStr_MPI_FLOAT_INT = `alias MPI_FLOAT_INT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_float_int );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_FLOAT_INT); }))) {
            mixin(enumMixinStr_MPI_FLOAT_INT);
        }
    }




    static if(!is(typeof(MPI_UNSIGNED))) {
        private enum enumMixinStr_MPI_UNSIGNED = `alias MPI_UNSIGNED = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_unsigned );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNSIGNED); }))) {
            mixin(enumMixinStr_MPI_UNSIGNED);
        }
    }




    static if(!is(typeof(MPI_UNSIGNED_LONG))) {
        private enum enumMixinStr_MPI_UNSIGNED_LONG = `alias MPI_UNSIGNED_LONG = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_unsigned_long );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNSIGNED_LONG); }))) {
            mixin(enumMixinStr_MPI_UNSIGNED_LONG);
        }
    }




    static if(!is(typeof(MPI_UNSIGNED_SHORT))) {
        private enum enumMixinStr_MPI_UNSIGNED_SHORT = `alias MPI_UNSIGNED_SHORT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_unsigned_short );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNSIGNED_SHORT); }))) {
            mixin(enumMixinStr_MPI_UNSIGNED_SHORT);
        }
    }




    static if(!is(typeof(MPI_SIGNED_CHAR))) {
        private enum enumMixinStr_MPI_SIGNED_CHAR = `alias MPI_SIGNED_CHAR = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_signed_char );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SIGNED_CHAR); }))) {
            mixin(enumMixinStr_MPI_SIGNED_CHAR);
        }
    }




    static if(!is(typeof(MPI_UNSIGNED_CHAR))) {
        private enum enumMixinStr_MPI_UNSIGNED_CHAR = `alias MPI_UNSIGNED_CHAR = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_unsigned_char );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNSIGNED_CHAR); }))) {
            mixin(enumMixinStr_MPI_UNSIGNED_CHAR);
        }
    }




    static if(!is(typeof(MPI_LONG_DOUBLE))) {
        private enum enumMixinStr_MPI_LONG_DOUBLE = `alias MPI_LONG_DOUBLE = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_long_double );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LONG_DOUBLE); }))) {
            mixin(enumMixinStr_MPI_LONG_DOUBLE);
        }
    }




    static if(!is(typeof(MPI_DOUBLE))) {
        private enum enumMixinStr_MPI_DOUBLE = `alias MPI_DOUBLE = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_double );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DOUBLE); }))) {
            mixin(enumMixinStr_MPI_DOUBLE);
        }
    }




    static if(!is(typeof(MPI_FLOAT))) {
        private enum enumMixinStr_MPI_FLOAT = `alias MPI_FLOAT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_float );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_FLOAT); }))) {
            mixin(enumMixinStr_MPI_FLOAT);
        }
    }




    static if(!is(typeof(MPI_LONG))) {
        private enum enumMixinStr_MPI_LONG = `alias MPI_LONG = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_long );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LONG); }))) {
            mixin(enumMixinStr_MPI_LONG);
        }
    }




    static if(!is(typeof(MPI_INT))) {
        private enum enumMixinStr_MPI_INT = `alias MPI_INT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_int );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INT); }))) {
            mixin(enumMixinStr_MPI_INT);
        }
    }




    static if(!is(typeof(MPI_SHORT))) {
        private enum enumMixinStr_MPI_SHORT = `alias MPI_SHORT = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_short );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SHORT); }))) {
            mixin(enumMixinStr_MPI_SHORT);
        }
    }




    static if(!is(typeof(MPI_CHAR))) {
        private enum enumMixinStr_MPI_CHAR = `alias MPI_CHAR = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_char );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CHAR); }))) {
            mixin(enumMixinStr_MPI_CHAR);
        }
    }




    static if(!is(typeof(MPI_PACKED))) {
        private enum enumMixinStr_MPI_PACKED = `alias MPI_PACKED = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_packed );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_PACKED); }))) {
            mixin(enumMixinStr_MPI_PACKED);
        }
    }




    static if(!is(typeof(MPI_BYTE))) {
        private enum enumMixinStr_MPI_BYTE = `alias MPI_BYTE = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_byte );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_BYTE); }))) {
            mixin(enumMixinStr_MPI_BYTE);
        }
    }




    static if(!is(typeof(MPI_DATATYPE_NULL))) {
        private enum enumMixinStr_MPI_DATATYPE_NULL = `alias MPI_DATATYPE_NULL = OMPI_PREDEFINED_GLOBAL! ( MPI_Datatype , ompi_mpi_datatype_null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DATATYPE_NULL); }))) {
            mixin(enumMixinStr_MPI_DATATYPE_NULL);
        }
    }




    static if(!is(typeof(MPI_NO_OP))) {
        private enum enumMixinStr_MPI_NO_OP = `alias MPI_NO_OP = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_no_op );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_NO_OP); }))) {
            mixin(enumMixinStr_MPI_NO_OP);
        }
    }




    static if(!is(typeof(MPI_REPLACE))) {
        private enum enumMixinStr_MPI_REPLACE = `alias MPI_REPLACE = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_replace );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_REPLACE); }))) {
            mixin(enumMixinStr_MPI_REPLACE);
        }
    }




    static if(!is(typeof(MPI_MINLOC))) {
        private enum enumMixinStr_MPI_MINLOC = `alias MPI_MINLOC = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_minloc );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MINLOC); }))) {
            mixin(enumMixinStr_MPI_MINLOC);
        }
    }




    static if(!is(typeof(MPI_MAXLOC))) {
        private enum enumMixinStr_MPI_MAXLOC = `alias MPI_MAXLOC = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_maxloc );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAXLOC); }))) {
            mixin(enumMixinStr_MPI_MAXLOC);
        }
    }




    static if(!is(typeof(MPI_BXOR))) {
        private enum enumMixinStr_MPI_BXOR = `alias MPI_BXOR = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_bxor );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_BXOR); }))) {
            mixin(enumMixinStr_MPI_BXOR);
        }
    }




    static if(!is(typeof(MPI_LXOR))) {
        private enum enumMixinStr_MPI_LXOR = `alias MPI_LXOR = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_lxor );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LXOR); }))) {
            mixin(enumMixinStr_MPI_LXOR);
        }
    }




    static if(!is(typeof(MPI_BOR))) {
        private enum enumMixinStr_MPI_BOR = `alias MPI_BOR = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_bor );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_BOR); }))) {
            mixin(enumMixinStr_MPI_BOR);
        }
    }




    static if(!is(typeof(MPI_LOR))) {
        private enum enumMixinStr_MPI_LOR = `alias MPI_LOR = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_lor );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LOR); }))) {
            mixin(enumMixinStr_MPI_LOR);
        }
    }




    static if(!is(typeof(MPI_BAND))) {
        private enum enumMixinStr_MPI_BAND = `alias MPI_BAND = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_band );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_BAND); }))) {
            mixin(enumMixinStr_MPI_BAND);
        }
    }




    static if(!is(typeof(MPI_LAND))) {
        private enum enumMixinStr_MPI_LAND = `alias MPI_LAND = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_land );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LAND); }))) {
            mixin(enumMixinStr_MPI_LAND);
        }
    }




    static if(!is(typeof(MPI_PROD))) {
        private enum enumMixinStr_MPI_PROD = `alias MPI_PROD = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_prod );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_PROD); }))) {
            mixin(enumMixinStr_MPI_PROD);
        }
    }




    static if(!is(typeof(MPI_SUM))) {
        private enum enumMixinStr_MPI_SUM = `alias MPI_SUM = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_sum );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SUM); }))) {
            mixin(enumMixinStr_MPI_SUM);
        }
    }




    static if(!is(typeof(MPI_MIN))) {
        private enum enumMixinStr_MPI_MIN = `alias MPI_MIN = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_min );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MIN); }))) {
            mixin(enumMixinStr_MPI_MIN);
        }
    }




    static if(!is(typeof(MPI_MAX))) {
        private enum enumMixinStr_MPI_MAX = `alias MPI_MAX = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_max );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX); }))) {
            mixin(enumMixinStr_MPI_MAX);
        }
    }




    static if(!is(typeof(MPI_MESSAGE_NO_PROC))) {
        private enum enumMixinStr_MPI_MESSAGE_NO_PROC = `alias MPI_MESSAGE_NO_PROC = OMPI_PREDEFINED_GLOBAL! ( MPI_Message , ompi_message_no_proc );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MESSAGE_NO_PROC); }))) {
            mixin(enumMixinStr_MPI_MESSAGE_NO_PROC);
        }
    }




    static if(!is(typeof(MPI_GROUP_EMPTY))) {
        private enum enumMixinStr_MPI_GROUP_EMPTY = `alias MPI_GROUP_EMPTY = OMPI_PREDEFINED_GLOBAL! ( MPI_Group , ompi_mpi_group_empty );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_GROUP_EMPTY); }))) {
            mixin(enumMixinStr_MPI_GROUP_EMPTY);
        }
    }




    static if(!is(typeof(MPI_COMM_SELF))) {
        private enum enumMixinStr_MPI_COMM_SELF = `alias MPI_COMM_SELF = OMPI_PREDEFINED_GLOBAL! ( MPI_Comm , ompi_mpi_comm_self );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_SELF); }))) {
            mixin(enumMixinStr_MPI_COMM_SELF);
        }
    }




    static if(!is(typeof(MPI_COMM_WORLD))) {
        private enum enumMixinStr_MPI_COMM_WORLD = `alias MPI_COMM_WORLD = OMPI_PREDEFINED_GLOBAL! ( MPI_Comm , ompi_mpi_comm_world );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_WORLD); }))) {
            mixin(enumMixinStr_MPI_COMM_WORLD);
        }
    }




    static if(!is(typeof(MPI_CONVERSION_FN_NULL))) {
        private enum enumMixinStr_MPI_CONVERSION_FN_NULL = `enum MPI_CONVERSION_FN_NULL = ( ( MPI_Datarep_conversion_function * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CONVERSION_FN_NULL); }))) {
            mixin(enumMixinStr_MPI_CONVERSION_FN_NULL);
        }
    }




    static if(!is(typeof(MPI_WIN_DUP_FN))) {
        private enum enumMixinStr_MPI_WIN_DUP_FN = `enum MPI_WIN_DUP_FN = OMPI_C_MPI_WIN_DUP_FN;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_DUP_FN); }))) {
            mixin(enumMixinStr_MPI_WIN_DUP_FN);
        }
    }




    static if(!is(typeof(MPI_WIN_NULL_COPY_FN))) {
        private enum enumMixinStr_MPI_WIN_NULL_COPY_FN = `enum MPI_WIN_NULL_COPY_FN = OMPI_C_MPI_WIN_NULL_COPY_FN;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_NULL_COPY_FN); }))) {
            mixin(enumMixinStr_MPI_WIN_NULL_COPY_FN);
        }
    }




    static if(!is(typeof(MPI_WIN_NULL_DELETE_FN))) {
        private enum enumMixinStr_MPI_WIN_NULL_DELETE_FN = `enum MPI_WIN_NULL_DELETE_FN = OMPI_C_MPI_WIN_NULL_DELETE_FN;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_NULL_DELETE_FN); }))) {
            mixin(enumMixinStr_MPI_WIN_NULL_DELETE_FN);
        }
    }




    static if(!is(typeof(MPI_COMM_DUP_FN))) {
        private enum enumMixinStr_MPI_COMM_DUP_FN = `enum MPI_COMM_DUP_FN = OMPI_C_MPI_COMM_DUP_FN;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_DUP_FN); }))) {
            mixin(enumMixinStr_MPI_COMM_DUP_FN);
        }
    }




    static if(!is(typeof(MPI_COMM_NULL_COPY_FN))) {
        private enum enumMixinStr_MPI_COMM_NULL_COPY_FN = `enum MPI_COMM_NULL_COPY_FN = OMPI_C_MPI_COMM_NULL_COPY_FN;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_NULL_COPY_FN); }))) {
            mixin(enumMixinStr_MPI_COMM_NULL_COPY_FN);
        }
    }




    static if(!is(typeof(MPI_COMM_NULL_DELETE_FN))) {
        private enum enumMixinStr_MPI_COMM_NULL_DELETE_FN = `enum MPI_COMM_NULL_DELETE_FN = OMPI_C_MPI_COMM_NULL_DELETE_FN;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_NULL_DELETE_FN); }))) {
            mixin(enumMixinStr_MPI_COMM_NULL_DELETE_FN);
        }
    }




    static if(!is(typeof(MPI_TYPE_DUP_FN))) {
        private enum enumMixinStr_MPI_TYPE_DUP_FN = `enum MPI_TYPE_DUP_FN = OMPI_C_MPI_TYPE_DUP_FN;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TYPE_DUP_FN); }))) {
            mixin(enumMixinStr_MPI_TYPE_DUP_FN);
        }
    }




    static if(!is(typeof(MPI_TYPE_NULL_COPY_FN))) {
        private enum enumMixinStr_MPI_TYPE_NULL_COPY_FN = `enum MPI_TYPE_NULL_COPY_FN = OMPI_C_MPI_TYPE_NULL_COPY_FN;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TYPE_NULL_COPY_FN); }))) {
            mixin(enumMixinStr_MPI_TYPE_NULL_COPY_FN);
        }
    }




    static if(!is(typeof(MPI_TYPE_NULL_DELETE_FN))) {
        private enum enumMixinStr_MPI_TYPE_NULL_DELETE_FN = `enum MPI_TYPE_NULL_DELETE_FN = OMPI_C_MPI_TYPE_NULL_DELETE_FN;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_TYPE_NULL_DELETE_FN); }))) {
            mixin(enumMixinStr_MPI_TYPE_NULL_DELETE_FN);
        }
    }




    static if(!is(typeof(MPI_DUP_FN))) {
        private enum enumMixinStr_MPI_DUP_FN = `enum MPI_DUP_FN = OMPI_C_MPI_DUP_FN;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DUP_FN); }))) {
            mixin(enumMixinStr_MPI_DUP_FN);
        }
    }




    static if(!is(typeof(MPI_NULL_COPY_FN))) {
        private enum enumMixinStr_MPI_NULL_COPY_FN = `enum MPI_NULL_COPY_FN = OMPI_C_MPI_NULL_COPY_FN;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_NULL_COPY_FN); }))) {
            mixin(enumMixinStr_MPI_NULL_COPY_FN);
        }
    }




    static if(!is(typeof(MPI_NULL_DELETE_FN))) {
        private enum enumMixinStr_MPI_NULL_DELETE_FN = `enum MPI_NULL_DELETE_FN = OMPI_C_MPI_NULL_DELETE_FN;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_NULL_DELETE_FN); }))) {
            mixin(enumMixinStr_MPI_NULL_DELETE_FN);
        }
    }




    static if(!is(typeof(MPI_T_CVAR_HANDLE_NULL))) {
        private enum enumMixinStr_MPI_T_CVAR_HANDLE_NULL = `enum MPI_T_CVAR_HANDLE_NULL = ( cast( MPI_T_cvar_handle ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_CVAR_HANDLE_NULL); }))) {
            mixin(enumMixinStr_MPI_T_CVAR_HANDLE_NULL);
        }
    }




    static if(!is(typeof(MPI_T_PVAR_SESSION_NULL))) {
        private enum enumMixinStr_MPI_T_PVAR_SESSION_NULL = `enum MPI_T_PVAR_SESSION_NULL = ( cast( MPI_T_pvar_session ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_PVAR_SESSION_NULL); }))) {
            mixin(enumMixinStr_MPI_T_PVAR_SESSION_NULL);
        }
    }




    static if(!is(typeof(MPI_T_PVAR_HANDLE_NULL))) {
        private enum enumMixinStr_MPI_T_PVAR_HANDLE_NULL = `enum MPI_T_PVAR_HANDLE_NULL = ( cast( MPI_T_pvar_handle ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_PVAR_HANDLE_NULL); }))) {
            mixin(enumMixinStr_MPI_T_PVAR_HANDLE_NULL);
        }
    }




    static if(!is(typeof(MPI_T_PVAR_ALL_HANDLES))) {
        private enum enumMixinStr_MPI_T_PVAR_ALL_HANDLES = `enum MPI_T_PVAR_ALL_HANDLES = ( cast( MPI_T_pvar_handle ) - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_PVAR_ALL_HANDLES); }))) {
            mixin(enumMixinStr_MPI_T_PVAR_ALL_HANDLES);
        }
    }




    static if(!is(typeof(MPI_STATUSES_IGNORE))) {
        private enum enumMixinStr_MPI_STATUSES_IGNORE = `enum MPI_STATUSES_IGNORE = ( cast( MPI_Status * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_STATUSES_IGNORE); }))) {
            mixin(enumMixinStr_MPI_STATUSES_IGNORE);
        }
    }




    static if(!is(typeof(MPI_STATUS_IGNORE))) {
        private enum enumMixinStr_MPI_STATUS_IGNORE = `enum MPI_STATUS_IGNORE = ( cast( MPI_Status * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_STATUS_IGNORE); }))) {
            mixin(enumMixinStr_MPI_STATUS_IGNORE);
        }
    }




    static if(!is(typeof(MPI_INFO_ENV))) {
        private enum enumMixinStr_MPI_INFO_ENV = `alias MPI_INFO_ENV = OMPI_PREDEFINED_GLOBAL! ( MPI_Info , ompi_mpi_info_env );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INFO_ENV); }))) {
            mixin(enumMixinStr_MPI_INFO_ENV);
        }
    }




    static if(!is(typeof(MPI_T_ENUM_NULL))) {
        private enum enumMixinStr_MPI_T_ENUM_NULL = `enum MPI_T_ENUM_NULL = ( cast( MPI_T___dpp_aggregate__ ) null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ENUM_NULL); }))) {
            mixin(enumMixinStr_MPI_T_ENUM_NULL);
        }
    }




    static if(!is(typeof(MPI_FILE_NULL))) {
        private enum enumMixinStr_MPI_FILE_NULL = `alias MPI_FILE_NULL = OMPI_PREDEFINED_GLOBAL! ( MPI_File , ompi_mpi_file_null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_FILE_NULL); }))) {
            mixin(enumMixinStr_MPI_FILE_NULL);
        }
    }




    static if(!is(typeof(MPI_WIN_NULL))) {
        private enum enumMixinStr_MPI_WIN_NULL = `alias MPI_WIN_NULL = OMPI_PREDEFINED_GLOBAL! ( MPI_Win , ompi_mpi_win_null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_NULL); }))) {
            mixin(enumMixinStr_MPI_WIN_NULL);
        }
    }




    static if(!is(typeof(MPI_INFO_NULL))) {
        private enum enumMixinStr_MPI_INFO_NULL = `alias MPI_INFO_NULL = OMPI_PREDEFINED_GLOBAL! ( MPI_Info , ompi_mpi_info_null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_INFO_NULL); }))) {
            mixin(enumMixinStr_MPI_INFO_NULL);
        }
    }




    static if(!is(typeof(MPI_ERRHANDLER_NULL))) {
        private enum enumMixinStr_MPI_ERRHANDLER_NULL = `alias MPI_ERRHANDLER_NULL = OMPI_PREDEFINED_GLOBAL! ( MPI_Errhandler , ompi_mpi_errhandler_null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERRHANDLER_NULL); }))) {
            mixin(enumMixinStr_MPI_ERRHANDLER_NULL);
        }
    }




    static if(!is(typeof(MPI_OP_NULL))) {
        private enum enumMixinStr_MPI_OP_NULL = `alias MPI_OP_NULL = OMPI_PREDEFINED_GLOBAL! ( MPI_Op , ompi_mpi_op_null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_OP_NULL); }))) {
            mixin(enumMixinStr_MPI_OP_NULL);
        }
    }




    static if(!is(typeof(MPI_MESSAGE_NULL))) {
        private enum enumMixinStr_MPI_MESSAGE_NULL = `alias MPI_MESSAGE_NULL = OMPI_PREDEFINED_GLOBAL! ( MPI_Message , ompi_message_null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MESSAGE_NULL); }))) {
            mixin(enumMixinStr_MPI_MESSAGE_NULL);
        }
    }




    static if(!is(typeof(MPI_REQUEST_NULL))) {
        private enum enumMixinStr_MPI_REQUEST_NULL = `alias MPI_REQUEST_NULL = OMPI_PREDEFINED_GLOBAL! ( MPI_Request , ompi_request_null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_REQUEST_NULL); }))) {
            mixin(enumMixinStr_MPI_REQUEST_NULL);
        }
    }




    static if(!is(typeof(MPI_COMM_NULL))) {
        private enum enumMixinStr_MPI_COMM_NULL = `alias MPI_COMM_NULL = OMPI_PREDEFINED_GLOBAL! ( MPI_Comm , ompi_mpi_comm_null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_COMM_NULL); }))) {
            mixin(enumMixinStr_MPI_COMM_NULL);
        }
    }




    static if(!is(typeof(MPI_GROUP_NULL))) {
        private enum enumMixinStr_MPI_GROUP_NULL = `alias MPI_GROUP_NULL = OMPI_PREDEFINED_GLOBAL! ( MPI_Group , ompi_mpi_group_null );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_GROUP_NULL); }))) {
            mixin(enumMixinStr_MPI_GROUP_NULL);
        }
    }




    static if(!is(typeof(OMPI_COMM_TYPE_NODE))) {
        private enum enumMixinStr_OMPI_COMM_TYPE_NODE = `enum OMPI_COMM_TYPE_NODE = MPI_COMM_TYPE_SHARED;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_COMM_TYPE_NODE); }))) {
            mixin(enumMixinStr_OMPI_COMM_TYPE_NODE);
        }
    }




    static if(!is(typeof(MPI_ERR_LASTCODE))) {
        private enum enumMixinStr_MPI_ERR_LASTCODE = `enum MPI_ERR_LASTCODE = 92;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_LASTCODE); }))) {
            mixin(enumMixinStr_MPI_ERR_LASTCODE);
        }
    }




    static if(!is(typeof(MPI_T_ERR_INVALID_NAME))) {
        private enum enumMixinStr_MPI_T_ERR_INVALID_NAME = `enum MPI_T_ERR_INVALID_NAME = 73;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_INVALID_NAME); }))) {
            mixin(enumMixinStr_MPI_T_ERR_INVALID_NAME);
        }
    }




    static if(!is(typeof(MPI_T_ERR_INVALID))) {
        private enum enumMixinStr_MPI_T_ERR_INVALID = `enum MPI_T_ERR_INVALID = 72;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_INVALID); }))) {
            mixin(enumMixinStr_MPI_T_ERR_INVALID);
        }
    }




    static if(!is(typeof(MPI_ERR_RMA_SHARED))) {
        private enum enumMixinStr_MPI_ERR_RMA_SHARED = `enum MPI_ERR_RMA_SHARED = 71;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RMA_SHARED); }))) {
            mixin(enumMixinStr_MPI_ERR_RMA_SHARED);
        }
    }




    static if(!is(typeof(MPI_ERR_RMA_FLAVOR))) {
        private enum enumMixinStr_MPI_ERR_RMA_FLAVOR = `enum MPI_ERR_RMA_FLAVOR = 70;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RMA_FLAVOR); }))) {
            mixin(enumMixinStr_MPI_ERR_RMA_FLAVOR);
        }
    }




    static if(!is(typeof(MPI_ERR_RMA_ATTACH))) {
        private enum enumMixinStr_MPI_ERR_RMA_ATTACH = `enum MPI_ERR_RMA_ATTACH = 69;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RMA_ATTACH); }))) {
            mixin(enumMixinStr_MPI_ERR_RMA_ATTACH);
        }
    }




    static if(!is(typeof(MPI_ERR_RMA_RANGE))) {
        private enum enumMixinStr_MPI_ERR_RMA_RANGE = `enum MPI_ERR_RMA_RANGE = 68;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RMA_RANGE); }))) {
            mixin(enumMixinStr_MPI_ERR_RMA_RANGE);
        }
    }




    static if(!is(typeof(MPI_T_ERR_PVAR_NO_ATOMIC))) {
        private enum enumMixinStr_MPI_T_ERR_PVAR_NO_ATOMIC = `enum MPI_T_ERR_PVAR_NO_ATOMIC = 67;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_PVAR_NO_ATOMIC); }))) {
            mixin(enumMixinStr_MPI_T_ERR_PVAR_NO_ATOMIC);
        }
    }




    static if(!is(typeof(MPI_T_ERR_PVAR_NO_WRITE))) {
        private enum enumMixinStr_MPI_T_ERR_PVAR_NO_WRITE = `enum MPI_T_ERR_PVAR_NO_WRITE = 66;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_PVAR_NO_WRITE); }))) {
            mixin(enumMixinStr_MPI_T_ERR_PVAR_NO_WRITE);
        }
    }




    static if(!is(typeof(MPI_T_ERR_PVAR_NO_STARTSTOP))) {
        private enum enumMixinStr_MPI_T_ERR_PVAR_NO_STARTSTOP = `enum MPI_T_ERR_PVAR_NO_STARTSTOP = 65;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_PVAR_NO_STARTSTOP); }))) {
            mixin(enumMixinStr_MPI_T_ERR_PVAR_NO_STARTSTOP);
        }
    }




    static if(!is(typeof(MPI_T_ERR_CVAR_SET_NEVER))) {
        private enum enumMixinStr_MPI_T_ERR_CVAR_SET_NEVER = `enum MPI_T_ERR_CVAR_SET_NEVER = 64;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_CVAR_SET_NEVER); }))) {
            mixin(enumMixinStr_MPI_T_ERR_CVAR_SET_NEVER);
        }
    }




    static if(!is(typeof(MPI_T_ERR_CVAR_SET_NOT_NOW))) {
        private enum enumMixinStr_MPI_T_ERR_CVAR_SET_NOT_NOW = `enum MPI_T_ERR_CVAR_SET_NOT_NOW = 63;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_CVAR_SET_NOT_NOW); }))) {
            mixin(enumMixinStr_MPI_T_ERR_CVAR_SET_NOT_NOW);
        }
    }




    static if(!is(typeof(MPI_T_ERR_INVALID_SESSION))) {
        private enum enumMixinStr_MPI_T_ERR_INVALID_SESSION = `enum MPI_T_ERR_INVALID_SESSION = 62;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_INVALID_SESSION); }))) {
            mixin(enumMixinStr_MPI_T_ERR_INVALID_SESSION);
        }
    }




    static if(!is(typeof(MPI_T_ERR_OUT_OF_SESSIONS))) {
        private enum enumMixinStr_MPI_T_ERR_OUT_OF_SESSIONS = `enum MPI_T_ERR_OUT_OF_SESSIONS = 61;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_OUT_OF_SESSIONS); }))) {
            mixin(enumMixinStr_MPI_T_ERR_OUT_OF_SESSIONS);
        }
    }




    static if(!is(typeof(MPI_T_ERR_OUT_OF_HANDLES))) {
        private enum enumMixinStr_MPI_T_ERR_OUT_OF_HANDLES = `enum MPI_T_ERR_OUT_OF_HANDLES = 60;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_OUT_OF_HANDLES); }))) {
            mixin(enumMixinStr_MPI_T_ERR_OUT_OF_HANDLES);
        }
    }




    static if(!is(typeof(MPI_T_ERR_INVALID_HANDLE))) {
        private enum enumMixinStr_MPI_T_ERR_INVALID_HANDLE = `enum MPI_T_ERR_INVALID_HANDLE = 59;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_INVALID_HANDLE); }))) {
            mixin(enumMixinStr_MPI_T_ERR_INVALID_HANDLE);
        }
    }




    static if(!is(typeof(MPI_T_ERR_INVALID_ITEM))) {
        private enum enumMixinStr_MPI_T_ERR_INVALID_ITEM = `enum MPI_T_ERR_INVALID_ITEM = 58;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_INVALID_ITEM); }))) {
            mixin(enumMixinStr_MPI_T_ERR_INVALID_ITEM);
        }
    }




    static if(!is(typeof(MPI_T_ERR_INVALID_INDEX))) {
        private enum enumMixinStr_MPI_T_ERR_INVALID_INDEX = `enum MPI_T_ERR_INVALID_INDEX = 57;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_INVALID_INDEX); }))) {
            mixin(enumMixinStr_MPI_T_ERR_INVALID_INDEX);
        }
    }




    static if(!is(typeof(MPI_T_ERR_CANNOT_INIT))) {
        private enum enumMixinStr_MPI_T_ERR_CANNOT_INIT = `enum MPI_T_ERR_CANNOT_INIT = 56;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_CANNOT_INIT); }))) {
            mixin(enumMixinStr_MPI_T_ERR_CANNOT_INIT);
        }
    }




    static if(!is(typeof(MPI_T_ERR_NOT_INITIALIZED))) {
        private enum enumMixinStr_MPI_T_ERR_NOT_INITIALIZED = `enum MPI_T_ERR_NOT_INITIALIZED = 55;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_NOT_INITIALIZED); }))) {
            mixin(enumMixinStr_MPI_T_ERR_NOT_INITIALIZED);
        }
    }




    static if(!is(typeof(MPI_T_ERR_MEMORY))) {
        private enum enumMixinStr_MPI_T_ERR_MEMORY = `enum MPI_T_ERR_MEMORY = 54;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_T_ERR_MEMORY); }))) {
            mixin(enumMixinStr_MPI_T_ERR_MEMORY);
        }
    }




    static if(!is(typeof(MPI_ERR_WIN))) {
        private enum enumMixinStr_MPI_ERR_WIN = `enum MPI_ERR_WIN = 53;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_WIN); }))) {
            mixin(enumMixinStr_MPI_ERR_WIN);
        }
    }




    static if(!is(typeof(MPI_ERR_UNSUPPORTED_OPERATION))) {
        private enum enumMixinStr_MPI_ERR_UNSUPPORTED_OPERATION = `enum MPI_ERR_UNSUPPORTED_OPERATION = 52;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_UNSUPPORTED_OPERATION); }))) {
            mixin(enumMixinStr_MPI_ERR_UNSUPPORTED_OPERATION);
        }
    }




    static if(!is(typeof(MPI_ERR_UNSUPPORTED_DATAREP))) {
        private enum enumMixinStr_MPI_ERR_UNSUPPORTED_DATAREP = `enum MPI_ERR_UNSUPPORTED_DATAREP = 51;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_UNSUPPORTED_DATAREP); }))) {
            mixin(enumMixinStr_MPI_ERR_UNSUPPORTED_DATAREP);
        }
    }




    static if(!is(typeof(MPI_ERR_SPAWN))) {
        private enum enumMixinStr_MPI_ERR_SPAWN = `enum MPI_ERR_SPAWN = 50;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_SPAWN); }))) {
            mixin(enumMixinStr_MPI_ERR_SPAWN);
        }
    }




    static if(!is(typeof(MPI_ERR_SIZE))) {
        private enum enumMixinStr_MPI_ERR_SIZE = `enum MPI_ERR_SIZE = 49;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_SIZE); }))) {
            mixin(enumMixinStr_MPI_ERR_SIZE);
        }
    }




    static if(!is(typeof(MPI_ERR_SERVICE))) {
        private enum enumMixinStr_MPI_ERR_SERVICE = `enum MPI_ERR_SERVICE = 48;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_SERVICE); }))) {
            mixin(enumMixinStr_MPI_ERR_SERVICE);
        }
    }




    static if(!is(typeof(MPI_ERR_RMA_SYNC))) {
        private enum enumMixinStr_MPI_ERR_RMA_SYNC = `enum MPI_ERR_RMA_SYNC = 47;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RMA_SYNC); }))) {
            mixin(enumMixinStr_MPI_ERR_RMA_SYNC);
        }
    }




    static if(!is(typeof(MPI_ERR_RMA_CONFLICT))) {
        private enum enumMixinStr_MPI_ERR_RMA_CONFLICT = `enum MPI_ERR_RMA_CONFLICT = 46;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_RMA_CONFLICT); }))) {
            mixin(enumMixinStr_MPI_ERR_RMA_CONFLICT);
        }
    }




    static if(!is(typeof(MPI_ERR_READ_ONLY))) {
        private enum enumMixinStr_MPI_ERR_READ_ONLY = `enum MPI_ERR_READ_ONLY = 45;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_READ_ONLY); }))) {
            mixin(enumMixinStr_MPI_ERR_READ_ONLY);
        }
    }




    static if(!is(typeof(MPI_ERR_QUOTA))) {
        private enum enumMixinStr_MPI_ERR_QUOTA = `enum MPI_ERR_QUOTA = 44;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_QUOTA); }))) {
            mixin(enumMixinStr_MPI_ERR_QUOTA);
        }
    }




    static if(!is(typeof(MPI_ERR_PORT))) {
        private enum enumMixinStr_MPI_ERR_PORT = `enum MPI_ERR_PORT = 43;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_PORT); }))) {
            mixin(enumMixinStr_MPI_ERR_PORT);
        }
    }




    static if(!is(typeof(MPI_ERR_NO_SUCH_FILE))) {
        private enum enumMixinStr_MPI_ERR_NO_SUCH_FILE = `enum MPI_ERR_NO_SUCH_FILE = 42;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_NO_SUCH_FILE); }))) {
            mixin(enumMixinStr_MPI_ERR_NO_SUCH_FILE);
        }
    }




    static if(!is(typeof(MPI_ERR_NO_SPACE))) {
        private enum enumMixinStr_MPI_ERR_NO_SPACE = `enum MPI_ERR_NO_SPACE = 41;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_NO_SPACE); }))) {
            mixin(enumMixinStr_MPI_ERR_NO_SPACE);
        }
    }




    static if(!is(typeof(MPI_ERR_NOT_SAME))) {
        private enum enumMixinStr_MPI_ERR_NOT_SAME = `enum MPI_ERR_NOT_SAME = 40;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_NOT_SAME); }))) {
            mixin(enumMixinStr_MPI_ERR_NOT_SAME);
        }
    }




    static if(!is(typeof(MPI_ERR_NO_MEM))) {
        private enum enumMixinStr_MPI_ERR_NO_MEM = `enum MPI_ERR_NO_MEM = 39;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_NO_MEM); }))) {
            mixin(enumMixinStr_MPI_ERR_NO_MEM);
        }
    }




    static if(!is(typeof(MPI_ERR_NAME))) {
        private enum enumMixinStr_MPI_ERR_NAME = `enum MPI_ERR_NAME = 38;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_NAME); }))) {
            mixin(enumMixinStr_MPI_ERR_NAME);
        }
    }




    static if(!is(typeof(MPI_ERR_LOCKTYPE))) {
        private enum enumMixinStr_MPI_ERR_LOCKTYPE = `enum MPI_ERR_LOCKTYPE = 37;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_LOCKTYPE); }))) {
            mixin(enumMixinStr_MPI_ERR_LOCKTYPE);
        }
    }




    static if(!is(typeof(MPI_ERR_KEYVAL))) {
        private enum enumMixinStr_MPI_ERR_KEYVAL = `enum MPI_ERR_KEYVAL = 36;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_KEYVAL); }))) {
            mixin(enumMixinStr_MPI_ERR_KEYVAL);
        }
    }




    static if(!is(typeof(MPI_ERR_IO))) {
        private enum enumMixinStr_MPI_ERR_IO = `enum MPI_ERR_IO = 35;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_IO); }))) {
            mixin(enumMixinStr_MPI_ERR_IO);
        }
    }




    static if(!is(typeof(MPI_ERR_INFO))) {
        private enum enumMixinStr_MPI_ERR_INFO = `enum MPI_ERR_INFO = 34;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_INFO); }))) {
            mixin(enumMixinStr_MPI_ERR_INFO);
        }
    }




    static if(!is(typeof(MPI_ERR_INFO_VALUE))) {
        private enum enumMixinStr_MPI_ERR_INFO_VALUE = `enum MPI_ERR_INFO_VALUE = 33;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_INFO_VALUE); }))) {
            mixin(enumMixinStr_MPI_ERR_INFO_VALUE);
        }
    }




    static if(!is(typeof(MPI_ERR_INFO_NOKEY))) {
        private enum enumMixinStr_MPI_ERR_INFO_NOKEY = `enum MPI_ERR_INFO_NOKEY = 32;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_INFO_NOKEY); }))) {
            mixin(enumMixinStr_MPI_ERR_INFO_NOKEY);
        }
    }




    static if(!is(typeof(MPI_ERR_INFO_KEY))) {
        private enum enumMixinStr_MPI_ERR_INFO_KEY = `enum MPI_ERR_INFO_KEY = 31;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_INFO_KEY); }))) {
            mixin(enumMixinStr_MPI_ERR_INFO_KEY);
        }
    }




    static if(!is(typeof(MPI_ERR_FILE))) {
        private enum enumMixinStr_MPI_ERR_FILE = `enum MPI_ERR_FILE = 30;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_FILE); }))) {
            mixin(enumMixinStr_MPI_ERR_FILE);
        }
    }




    static if(!is(typeof(MPI_ERR_FILE_IN_USE))) {
        private enum enumMixinStr_MPI_ERR_FILE_IN_USE = `enum MPI_ERR_FILE_IN_USE = 29;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_FILE_IN_USE); }))) {
            mixin(enumMixinStr_MPI_ERR_FILE_IN_USE);
        }
    }




    static if(!is(typeof(MPI_ERR_FILE_EXISTS))) {
        private enum enumMixinStr_MPI_ERR_FILE_EXISTS = `enum MPI_ERR_FILE_EXISTS = 28;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_FILE_EXISTS); }))) {
            mixin(enumMixinStr_MPI_ERR_FILE_EXISTS);
        }
    }




    static if(!is(typeof(MPI_ERR_DUP_DATAREP))) {
        private enum enumMixinStr_MPI_ERR_DUP_DATAREP = `enum MPI_ERR_DUP_DATAREP = 27;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_DUP_DATAREP); }))) {
            mixin(enumMixinStr_MPI_ERR_DUP_DATAREP);
        }
    }




    static if(!is(typeof(MPI_ERR_DISP))) {
        private enum enumMixinStr_MPI_ERR_DISP = `enum MPI_ERR_DISP = 26;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_DISP); }))) {
            mixin(enumMixinStr_MPI_ERR_DISP);
        }
    }




    static if(!is(typeof(MPI_ERR_CONVERSION))) {
        private enum enumMixinStr_MPI_ERR_CONVERSION = `enum MPI_ERR_CONVERSION = 25;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_CONVERSION); }))) {
            mixin(enumMixinStr_MPI_ERR_CONVERSION);
        }
    }




    static if(!is(typeof(MPI_ERR_BASE))) {
        private enum enumMixinStr_MPI_ERR_BASE = `enum MPI_ERR_BASE = 24;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_BASE); }))) {
            mixin(enumMixinStr_MPI_ERR_BASE);
        }
    }




    static if(!is(typeof(MPI_ERR_BAD_FILE))) {
        private enum enumMixinStr_MPI_ERR_BAD_FILE = `enum MPI_ERR_BAD_FILE = 23;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_BAD_FILE); }))) {
            mixin(enumMixinStr_MPI_ERR_BAD_FILE);
        }
    }




    static if(!is(typeof(MPI_ERR_ASSERT))) {
        private enum enumMixinStr_MPI_ERR_ASSERT = `enum MPI_ERR_ASSERT = 22;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_ASSERT); }))) {
            mixin(enumMixinStr_MPI_ERR_ASSERT);
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
        private enum enumMixinStr_MPI_ERR_PENDING = `enum MPI_ERR_PENDING = 19;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_PENDING); }))) {
            mixin(enumMixinStr_MPI_ERR_PENDING);
        }
    }




    static if(!is(typeof(MPI_ERR_IN_STATUS))) {
        private enum enumMixinStr_MPI_ERR_IN_STATUS = `enum MPI_ERR_IN_STATUS = 18;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_IN_STATUS); }))) {
            mixin(enumMixinStr_MPI_ERR_IN_STATUS);
        }
    }




    static if(!is(typeof(MPI_ERR_INTERN))) {
        private enum enumMixinStr_MPI_ERR_INTERN = `enum MPI_ERR_INTERN = 17;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_INTERN); }))) {
            mixin(enumMixinStr_MPI_ERR_INTERN);
        }
    }




    static if(!is(typeof(MPI_ERR_OTHER))) {
        private enum enumMixinStr_MPI_ERR_OTHER = `enum MPI_ERR_OTHER = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_OTHER); }))) {
            mixin(enumMixinStr_MPI_ERR_OTHER);
        }
    }




    static if(!is(typeof(MPI_ERR_TRUNCATE))) {
        private enum enumMixinStr_MPI_ERR_TRUNCATE = `enum MPI_ERR_TRUNCATE = 15;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_TRUNCATE); }))) {
            mixin(enumMixinStr_MPI_ERR_TRUNCATE);
        }
    }




    static if(!is(typeof(MPI_ERR_UNKNOWN))) {
        private enum enumMixinStr_MPI_ERR_UNKNOWN = `enum MPI_ERR_UNKNOWN = 14;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_UNKNOWN); }))) {
            mixin(enumMixinStr_MPI_ERR_UNKNOWN);
        }
    }




    static if(!is(typeof(MPI_ERR_ARG))) {
        private enum enumMixinStr_MPI_ERR_ARG = `enum MPI_ERR_ARG = 13;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_ARG); }))) {
            mixin(enumMixinStr_MPI_ERR_ARG);
        }
    }




    static if(!is(typeof(MPI_ERR_DIMS))) {
        private enum enumMixinStr_MPI_ERR_DIMS = `enum MPI_ERR_DIMS = 12;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_DIMS); }))) {
            mixin(enumMixinStr_MPI_ERR_DIMS);
        }
    }




    static if(!is(typeof(MPI_ERR_TOPOLOGY))) {
        private enum enumMixinStr_MPI_ERR_TOPOLOGY = `enum MPI_ERR_TOPOLOGY = 11;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_TOPOLOGY); }))) {
            mixin(enumMixinStr_MPI_ERR_TOPOLOGY);
        }
    }




    static if(!is(typeof(MPI_ERR_OP))) {
        private enum enumMixinStr_MPI_ERR_OP = `enum MPI_ERR_OP = 10;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_OP); }))) {
            mixin(enumMixinStr_MPI_ERR_OP);
        }
    }




    static if(!is(typeof(MPI_ERR_GROUP))) {
        private enum enumMixinStr_MPI_ERR_GROUP = `enum MPI_ERR_GROUP = 9;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_GROUP); }))) {
            mixin(enumMixinStr_MPI_ERR_GROUP);
        }
    }




    static if(!is(typeof(MPI_ERR_ROOT))) {
        private enum enumMixinStr_MPI_ERR_ROOT = `enum MPI_ERR_ROOT = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_ROOT); }))) {
            mixin(enumMixinStr_MPI_ERR_ROOT);
        }
    }




    static if(!is(typeof(MPI_ERR_REQUEST))) {
        private enum enumMixinStr_MPI_ERR_REQUEST = `enum MPI_ERR_REQUEST = 7;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERR_REQUEST); }))) {
            mixin(enumMixinStr_MPI_ERR_REQUEST);
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




    static if(!is(typeof(MPI_WIN_SEPARATE))) {
        private enum enumMixinStr_MPI_WIN_SEPARATE = `enum MPI_WIN_SEPARATE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_SEPARATE); }))) {
            mixin(enumMixinStr_MPI_WIN_SEPARATE);
        }
    }




    static if(!is(typeof(MPI_WIN_UNIFIED))) {
        private enum enumMixinStr_MPI_WIN_UNIFIED = `enum MPI_WIN_UNIFIED = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_UNIFIED); }))) {
            mixin(enumMixinStr_MPI_WIN_UNIFIED);
        }
    }




    static if(!is(typeof(MPI_WIN_FLAVOR_SHARED))) {
        private enum enumMixinStr_MPI_WIN_FLAVOR_SHARED = `enum MPI_WIN_FLAVOR_SHARED = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_FLAVOR_SHARED); }))) {
            mixin(enumMixinStr_MPI_WIN_FLAVOR_SHARED);
        }
    }




    static if(!is(typeof(MPI_WIN_FLAVOR_DYNAMIC))) {
        private enum enumMixinStr_MPI_WIN_FLAVOR_DYNAMIC = `enum MPI_WIN_FLAVOR_DYNAMIC = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_FLAVOR_DYNAMIC); }))) {
            mixin(enumMixinStr_MPI_WIN_FLAVOR_DYNAMIC);
        }
    }




    static if(!is(typeof(MPI_WIN_FLAVOR_ALLOCATE))) {
        private enum enumMixinStr_MPI_WIN_FLAVOR_ALLOCATE = `enum MPI_WIN_FLAVOR_ALLOCATE = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_FLAVOR_ALLOCATE); }))) {
            mixin(enumMixinStr_MPI_WIN_FLAVOR_ALLOCATE);
        }
    }




    static if(!is(typeof(MPI_WIN_FLAVOR_CREATE))) {
        private enum enumMixinStr_MPI_WIN_FLAVOR_CREATE = `enum MPI_WIN_FLAVOR_CREATE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WIN_FLAVOR_CREATE); }))) {
            mixin(enumMixinStr_MPI_WIN_FLAVOR_CREATE);
        }
    }




    static if(!is(typeof(MPI_LOCK_SHARED))) {
        private enum enumMixinStr_MPI_LOCK_SHARED = `enum MPI_LOCK_SHARED = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LOCK_SHARED); }))) {
            mixin(enumMixinStr_MPI_LOCK_SHARED);
        }
    }




    static if(!is(typeof(MPI_LOCK_EXCLUSIVE))) {
        private enum enumMixinStr_MPI_LOCK_EXCLUSIVE = `enum MPI_LOCK_EXCLUSIVE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_LOCK_EXCLUSIVE); }))) {
            mixin(enumMixinStr_MPI_LOCK_EXCLUSIVE);
        }
    }




    static if(!is(typeof(MPI_MODE_NOSUCCEED))) {
        private enum enumMixinStr_MPI_MODE_NOSUCCEED = `enum MPI_MODE_NOSUCCEED = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_NOSUCCEED); }))) {
            mixin(enumMixinStr_MPI_MODE_NOSUCCEED);
        }
    }




    static if(!is(typeof(MPI_MODE_NOSTORE))) {
        private enum enumMixinStr_MPI_MODE_NOSTORE = `enum MPI_MODE_NOSTORE = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_NOSTORE); }))) {
            mixin(enumMixinStr_MPI_MODE_NOSTORE);
        }
    }




    static if(!is(typeof(MPI_MODE_NOPUT))) {
        private enum enumMixinStr_MPI_MODE_NOPUT = `enum MPI_MODE_NOPUT = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_NOPUT); }))) {
            mixin(enumMixinStr_MPI_MODE_NOPUT);
        }
    }




    static if(!is(typeof(MPI_MODE_NOPRECEDE))) {
        private enum enumMixinStr_MPI_MODE_NOPRECEDE = `enum MPI_MODE_NOPRECEDE = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_NOPRECEDE); }))) {
            mixin(enumMixinStr_MPI_MODE_NOPRECEDE);
        }
    }




    static if(!is(typeof(MPI_MODE_NOCHECK))) {
        private enum enumMixinStr_MPI_MODE_NOCHECK = `enum MPI_MODE_NOCHECK = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_NOCHECK); }))) {
            mixin(enumMixinStr_MPI_MODE_NOCHECK);
        }
    }




    static if(!is(typeof(MPI_MAX_DATAREP_STRING))) {
        private enum enumMixinStr_MPI_MAX_DATAREP_STRING = `enum MPI_MAX_DATAREP_STRING = OPAL_MAX_DATAREP_STRING;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_DATAREP_STRING); }))) {
            mixin(enumMixinStr_MPI_MAX_DATAREP_STRING);
        }
    }




    static if(!is(typeof(MPI_SEEK_END))) {
        private enum enumMixinStr_MPI_SEEK_END = `enum MPI_SEEK_END = 604;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SEEK_END); }))) {
            mixin(enumMixinStr_MPI_SEEK_END);
        }
    }




    static if(!is(typeof(MPI_SEEK_CUR))) {
        private enum enumMixinStr_MPI_SEEK_CUR = `enum MPI_SEEK_CUR = 602;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SEEK_CUR); }))) {
            mixin(enumMixinStr_MPI_SEEK_CUR);
        }
    }




    static if(!is(typeof(MPI_SEEK_SET))) {
        private enum enumMixinStr_MPI_SEEK_SET = `enum MPI_SEEK_SET = 600;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_SEEK_SET); }))) {
            mixin(enumMixinStr_MPI_SEEK_SET);
        }
    }




    static if(!is(typeof(MPI_DISPLACEMENT_CURRENT))) {
        private enum enumMixinStr_MPI_DISPLACEMENT_CURRENT = `enum MPI_DISPLACEMENT_CURRENT = - 54278278;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DISPLACEMENT_CURRENT); }))) {
            mixin(enumMixinStr_MPI_DISPLACEMENT_CURRENT);
        }
    }




    static if(!is(typeof(MPI_MODE_SEQUENTIAL))) {
        private enum enumMixinStr_MPI_MODE_SEQUENTIAL = `enum MPI_MODE_SEQUENTIAL = 256;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_SEQUENTIAL); }))) {
            mixin(enumMixinStr_MPI_MODE_SEQUENTIAL);
        }
    }




    static if(!is(typeof(MPI_MODE_APPEND))) {
        private enum enumMixinStr_MPI_MODE_APPEND = `enum MPI_MODE_APPEND = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_APPEND); }))) {
            mixin(enumMixinStr_MPI_MODE_APPEND);
        }
    }




    static if(!is(typeof(MPI_MODE_EXCL))) {
        private enum enumMixinStr_MPI_MODE_EXCL = `enum MPI_MODE_EXCL = 64;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_EXCL); }))) {
            mixin(enumMixinStr_MPI_MODE_EXCL);
        }
    }




    static if(!is(typeof(MPI_MODE_UNIQUE_OPEN))) {
        private enum enumMixinStr_MPI_MODE_UNIQUE_OPEN = `enum MPI_MODE_UNIQUE_OPEN = 32;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_UNIQUE_OPEN); }))) {
            mixin(enumMixinStr_MPI_MODE_UNIQUE_OPEN);
        }
    }




    static if(!is(typeof(MPI_MODE_DELETE_ON_CLOSE))) {
        private enum enumMixinStr_MPI_MODE_DELETE_ON_CLOSE = `enum MPI_MODE_DELETE_ON_CLOSE = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_DELETE_ON_CLOSE); }))) {
            mixin(enumMixinStr_MPI_MODE_DELETE_ON_CLOSE);
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




    static if(!is(typeof(MPI_MODE_RDONLY))) {
        private enum enumMixinStr_MPI_MODE_RDONLY = `enum MPI_MODE_RDONLY = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_RDONLY); }))) {
            mixin(enumMixinStr_MPI_MODE_RDONLY);
        }
    }




    static if(!is(typeof(MPI_MODE_CREATE))) {
        private enum enumMixinStr_MPI_MODE_CREATE = `enum MPI_MODE_CREATE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MODE_CREATE); }))) {
            mixin(enumMixinStr_MPI_MODE_CREATE);
        }
    }




    static if(!is(typeof(MPI_DISTRIBUTE_DFLT_DARG))) {
        private enum enumMixinStr_MPI_DISTRIBUTE_DFLT_DARG = `enum MPI_DISTRIBUTE_DFLT_DARG = ( - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DISTRIBUTE_DFLT_DARG); }))) {
            mixin(enumMixinStr_MPI_DISTRIBUTE_DFLT_DARG);
        }
    }




    static if(!is(typeof(MPI_DISTRIBUTE_NONE))) {
        private enum enumMixinStr_MPI_DISTRIBUTE_NONE = `enum MPI_DISTRIBUTE_NONE = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DISTRIBUTE_NONE); }))) {
            mixin(enumMixinStr_MPI_DISTRIBUTE_NONE);
        }
    }




    static if(!is(typeof(MPI_DISTRIBUTE_CYCLIC))) {
        private enum enumMixinStr_MPI_DISTRIBUTE_CYCLIC = `enum MPI_DISTRIBUTE_CYCLIC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DISTRIBUTE_CYCLIC); }))) {
            mixin(enumMixinStr_MPI_DISTRIBUTE_CYCLIC);
        }
    }




    static if(!is(typeof(MPI_DISTRIBUTE_BLOCK))) {
        private enum enumMixinStr_MPI_DISTRIBUTE_BLOCK = `enum MPI_DISTRIBUTE_BLOCK = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DISTRIBUTE_BLOCK); }))) {
            mixin(enumMixinStr_MPI_DISTRIBUTE_BLOCK);
        }
    }




    static if(!is(typeof(MPI_ORDER_FORTRAN))) {
        private enum enumMixinStr_MPI_ORDER_FORTRAN = `enum MPI_ORDER_FORTRAN = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ORDER_FORTRAN); }))) {
            mixin(enumMixinStr_MPI_ORDER_FORTRAN);
        }
    }




    static if(!is(typeof(MPI_ORDER_C))) {
        private enum enumMixinStr_MPI_ORDER_C = `enum MPI_ORDER_C = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ORDER_C); }))) {
            mixin(enumMixinStr_MPI_ORDER_C);
        }
    }




    static if(!is(typeof(MPI_MAX_PORT_NAME))) {
        private enum enumMixinStr_MPI_MAX_PORT_NAME = `enum MPI_MAX_PORT_NAME = OPAL_MAX_PORT_NAME;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_PORT_NAME); }))) {
            mixin(enumMixinStr_MPI_MAX_PORT_NAME);
        }
    }




    static if(!is(typeof(MPI_ERRCODES_IGNORE))) {
        private enum enumMixinStr_MPI_ERRCODES_IGNORE = `enum MPI_ERRCODES_IGNORE = ( cast( int * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ERRCODES_IGNORE); }))) {
            mixin(enumMixinStr_MPI_ERRCODES_IGNORE);
        }
    }




    static if(!is(typeof(MPI_ARGVS_NULL))) {
        private enum enumMixinStr_MPI_ARGVS_NULL = `enum MPI_ARGVS_NULL = ( cast( char * * * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ARGVS_NULL); }))) {
            mixin(enumMixinStr_MPI_ARGVS_NULL);
        }
    }




    static if(!is(typeof(MPI_ARGV_NULL))) {
        private enum enumMixinStr_MPI_ARGV_NULL = `enum MPI_ARGV_NULL = ( cast( char * * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ARGV_NULL); }))) {
            mixin(enumMixinStr_MPI_ARGV_NULL);
        }
    }




    static if(!is(typeof(MPI_MAX_INFO_VAL))) {
        private enum enumMixinStr_MPI_MAX_INFO_VAL = `enum MPI_MAX_INFO_VAL = OPAL_MAX_INFO_VAL;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_INFO_VAL); }))) {
            mixin(enumMixinStr_MPI_MAX_INFO_VAL);
        }
    }




    static if(!is(typeof(MPI_MAX_INFO_KEY))) {
        private enum enumMixinStr_MPI_MAX_INFO_KEY = `enum MPI_MAX_INFO_KEY = OPAL_MAX_INFO_KEY;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_INFO_KEY); }))) {
            mixin(enumMixinStr_MPI_MAX_INFO_KEY);
        }
    }




    static if(!is(typeof(MPI_BSEND_OVERHEAD))) {
        private enum enumMixinStr_MPI_BSEND_OVERHEAD = `enum MPI_BSEND_OVERHEAD = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_BSEND_OVERHEAD); }))) {
            mixin(enumMixinStr_MPI_BSEND_OVERHEAD);
        }
    }




    static if(!is(typeof(MPI_IN_PLACE))) {
        private enum enumMixinStr_MPI_IN_PLACE = `enum MPI_IN_PLACE = ( cast( void * ) 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_IN_PLACE); }))) {
            mixin(enumMixinStr_MPI_IN_PLACE);
        }
    }




    static if(!is(typeof(MPI_BOTTOM))) {
        private enum enumMixinStr_MPI_BOTTOM = `enum MPI_BOTTOM = ( cast( void * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_BOTTOM); }))) {
            mixin(enumMixinStr_MPI_BOTTOM);
        }
    }




    static if(!is(typeof(MPI_WEIGHTS_EMPTY))) {
        private enum enumMixinStr_MPI_WEIGHTS_EMPTY = `enum MPI_WEIGHTS_EMPTY = ( cast( int * ) 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_WEIGHTS_EMPTY); }))) {
            mixin(enumMixinStr_MPI_WEIGHTS_EMPTY);
        }
    }




    static if(!is(typeof(MPI_UNWEIGHTED))) {
        private enum enumMixinStr_MPI_UNWEIGHTED = `enum MPI_UNWEIGHTED = ( cast( int * ) 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNWEIGHTED); }))) {
            mixin(enumMixinStr_MPI_UNWEIGHTED);
        }
    }




    static if(!is(typeof(MPI_KEYVAL_INVALID))) {
        private enum enumMixinStr_MPI_KEYVAL_INVALID = `enum MPI_KEYVAL_INVALID = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_KEYVAL_INVALID); }))) {
            mixin(enumMixinStr_MPI_KEYVAL_INVALID);
        }
    }




    static if(!is(typeof(MPI_GRAPH))) {
        private enum enumMixinStr_MPI_GRAPH = `enum MPI_GRAPH = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_GRAPH); }))) {
            mixin(enumMixinStr_MPI_GRAPH);
        }
    }




    static if(!is(typeof(MPI_CART))) {
        private enum enumMixinStr_MPI_CART = `enum MPI_CART = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_CART); }))) {
            mixin(enumMixinStr_MPI_CART);
        }
    }




    static if(!is(typeof(MPI_DIST_GRAPH))) {
        private enum enumMixinStr_MPI_DIST_GRAPH = `enum MPI_DIST_GRAPH = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_DIST_GRAPH); }))) {
            mixin(enumMixinStr_MPI_DIST_GRAPH);
        }
    }




    static if(!is(typeof(MPI_UNDEFINED))) {
        private enum enumMixinStr_MPI_UNDEFINED = `enum MPI_UNDEFINED = - 32766;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_UNDEFINED); }))) {
            mixin(enumMixinStr_MPI_UNDEFINED);
        }
    }




    static if(!is(typeof(MPI_MAX_LIBRARY_VERSION_STRING))) {
        private enum enumMixinStr_MPI_MAX_LIBRARY_VERSION_STRING = `enum MPI_MAX_LIBRARY_VERSION_STRING = 256;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_LIBRARY_VERSION_STRING); }))) {
            mixin(enumMixinStr_MPI_MAX_LIBRARY_VERSION_STRING);
        }
    }




    static if(!is(typeof(MPI_MAX_OBJECT_NAME))) {
        private enum enumMixinStr_MPI_MAX_OBJECT_NAME = `enum MPI_MAX_OBJECT_NAME = OPAL_MAX_OBJECT_NAME;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_OBJECT_NAME); }))) {
            mixin(enumMixinStr_MPI_MAX_OBJECT_NAME);
        }
    }




    static if(!is(typeof(MPI_MAX_ERROR_STRING))) {
        private enum enumMixinStr_MPI_MAX_ERROR_STRING = `enum MPI_MAX_ERROR_STRING = OPAL_MAX_ERROR_STRING;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_ERROR_STRING); }))) {
            mixin(enumMixinStr_MPI_MAX_ERROR_STRING);
        }
    }




    static if(!is(typeof(MPI_MAX_PROCESSOR_NAME))) {
        private enum enumMixinStr_MPI_MAX_PROCESSOR_NAME = `enum MPI_MAX_PROCESSOR_NAME = OPAL_MAX_PROCESSOR_NAME;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_MAX_PROCESSOR_NAME); }))) {
            mixin(enumMixinStr_MPI_MAX_PROCESSOR_NAME);
        }
    }




    static if(!is(typeof(MPI_ANY_TAG))) {
        private enum enumMixinStr_MPI_ANY_TAG = `enum MPI_ANY_TAG = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ANY_TAG); }))) {
            mixin(enumMixinStr_MPI_ANY_TAG);
        }
    }




    static if(!is(typeof(MPI_ROOT))) {
        private enum enumMixinStr_MPI_ROOT = `enum MPI_ROOT = - 4;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ROOT); }))) {
            mixin(enumMixinStr_MPI_ROOT);
        }
    }




    static if(!is(typeof(MPI_PROC_NULL))) {
        private enum enumMixinStr_MPI_PROC_NULL = `enum MPI_PROC_NULL = - 2;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_PROC_NULL); }))) {
            mixin(enumMixinStr_MPI_PROC_NULL);
        }
    }




    static if(!is(typeof(MPI_ANY_SOURCE))) {
        private enum enumMixinStr_MPI_ANY_SOURCE = `enum MPI_ANY_SOURCE = - 1;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_ANY_SOURCE); }))) {
            mixin(enumMixinStr_MPI_ANY_SOURCE);
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




    static if(!is(typeof(MPIO_Request))) {
        private enum enumMixinStr_MPIO_Request = `enum MPIO_Request = MPI_Request;`;
        static if(is(typeof({ mixin(enumMixinStr_MPIO_Request); }))) {
            mixin(enumMixinStr_MPIO_Request);
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




    static if(!is(typeof(OPEN_MPI))) {
        private enum enumMixinStr_OPEN_MPI = `enum OPEN_MPI = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OPEN_MPI); }))) {
            mixin(enumMixinStr_OPEN_MPI);
        }
    }




    static if(!is(typeof(OMPI_BUILDING))) {
        private enum enumMixinStr_OMPI_BUILDING = `enum OMPI_BUILDING = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_BUILDING); }))) {
            mixin(enumMixinStr_OMPI_BUILDING);
        }
    }




    static if(!is(typeof(MPI_Fint))) {
        private enum enumMixinStr_MPI_Fint = `enum MPI_Fint = ompi_fortran_integer_t;`;
        static if(is(typeof({ mixin(enumMixinStr_MPI_Fint); }))) {
            mixin(enumMixinStr_MPI_Fint);
        }
    }




    static if(!is(typeof(OMPI_DECLSPEC))) {
        private enum enumMixinStr_OMPI_DECLSPEC = `enum OMPI_DECLSPEC = __attribute__ ( ( visibility ( "default" ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_DECLSPEC); }))) {
            mixin(enumMixinStr_OMPI_DECLSPEC);
        }
    }




    static if(!is(typeof(OPAL_C_HAVE_VISIBILITY))) {
        private enum enumMixinStr_OPAL_C_HAVE_VISIBILITY = `enum OPAL_C_HAVE_VISIBILITY = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_C_HAVE_VISIBILITY); }))) {
            mixin(enumMixinStr_OPAL_C_HAVE_VISIBILITY);
        }
    }




    static if(!is(typeof(ompi_fortran_integer_t))) {
        private enum enumMixinStr_ompi_fortran_integer_t = `enum ompi_fortran_integer_t = int;`;
        static if(is(typeof({ mixin(enumMixinStr_ompi_fortran_integer_t); }))) {
            mixin(enumMixinStr_ompi_fortran_integer_t);
        }
    }




    static if(!is(typeof(ompi_fortran_bogus_type_t))) {
        private enum enumMixinStr_ompi_fortran_bogus_type_t = `enum ompi_fortran_bogus_type_t = int;`;
        static if(is(typeof({ mixin(enumMixinStr_ompi_fortran_bogus_type_t); }))) {
            mixin(enumMixinStr_ompi_fortran_bogus_type_t);
        }
    }




    static if(!is(typeof(OMPI_RELEASE_VERSION))) {
        private enum enumMixinStr_OMPI_RELEASE_VERSION = `enum OMPI_RELEASE_VERSION = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_RELEASE_VERSION); }))) {
            mixin(enumMixinStr_OMPI_RELEASE_VERSION);
        }
    }




    static if(!is(typeof(OMPI_MINOR_VERSION))) {
        private enum enumMixinStr_OMPI_MINOR_VERSION = `enum OMPI_MINOR_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_MINOR_VERSION); }))) {
            mixin(enumMixinStr_OMPI_MINOR_VERSION);
        }
    }




    static if(!is(typeof(OMPI_MAJOR_VERSION))) {
        private enum enumMixinStr_OMPI_MAJOR_VERSION = `enum OMPI_MAJOR_VERSION = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_MAJOR_VERSION); }))) {
            mixin(enumMixinStr_OMPI_MAJOR_VERSION);
        }
    }




    static if(!is(typeof(OMPI_HAVE_CXX_EXCEPTION_SUPPORT))) {
        private enum enumMixinStr_OMPI_HAVE_CXX_EXCEPTION_SUPPORT = `enum OMPI_HAVE_CXX_EXCEPTION_SUPPORT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_CXX_EXCEPTION_SUPPORT); }))) {
            mixin(enumMixinStr_OMPI_HAVE_CXX_EXCEPTION_SUPPORT);
        }
    }




    static if(!is(typeof(OMPI_WANT_MPI_INTERFACE_WARNING))) {
        private enum enumMixinStr_OMPI_WANT_MPI_INTERFACE_WARNING = `enum OMPI_WANT_MPI_INTERFACE_WARNING = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_WANT_MPI_INTERFACE_WARNING); }))) {
            mixin(enumMixinStr_OMPI_WANT_MPI_INTERFACE_WARNING);
        }
    }




    static if(!is(typeof(OMPI_PARAM_CHECK))) {
        private enum enumMixinStr_OMPI_PARAM_CHECK = `enum OMPI_PARAM_CHECK = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_PARAM_CHECK); }))) {
            mixin(enumMixinStr_OMPI_PARAM_CHECK);
        }
    }




    static if(!is(typeof(OMPI_CXX_SUPPORTS_2D_CONST_CAST))) {
        private enum enumMixinStr_OMPI_CXX_SUPPORTS_2D_CONST_CAST = `enum OMPI_CXX_SUPPORTS_2D_CONST_CAST = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_CXX_SUPPORTS_2D_CONST_CAST); }))) {
            mixin(enumMixinStr_OMPI_CXX_SUPPORTS_2D_CONST_CAST);
        }
    }




    static if(!is(typeof(OMPI_WANT_MPI_CXX_SEEK))) {
        private enum enumMixinStr_OMPI_WANT_MPI_CXX_SEEK = `enum OMPI_WANT_MPI_CXX_SEEK = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_WANT_MPI_CXX_SEEK); }))) {
            mixin(enumMixinStr_OMPI_WANT_MPI_CXX_SEEK);
        }
    }




    static if(!is(typeof(OMPI_BUILD_CXX_BINDINGS))) {
        private enum enumMixinStr_OMPI_BUILD_CXX_BINDINGS = `enum OMPI_BUILD_CXX_BINDINGS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_BUILD_CXX_BINDINGS); }))) {
            mixin(enumMixinStr_OMPI_BUILD_CXX_BINDINGS);
        }
    }




    static if(!is(typeof(OMPI_MPI_COUNT_TYPE))) {
        private enum enumMixinStr_OMPI_MPI_COUNT_TYPE = `enum OMPI_MPI_COUNT_TYPE = long long;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_MPI_COUNT_TYPE); }))) {
            mixin(enumMixinStr_OMPI_MPI_COUNT_TYPE);
        }
    }




    static if(!is(typeof(OMPI_MPI_OFFSET_SIZE))) {
        private enum enumMixinStr_OMPI_MPI_OFFSET_SIZE = `enum OMPI_MPI_OFFSET_SIZE = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_MPI_OFFSET_SIZE); }))) {
            mixin(enumMixinStr_OMPI_MPI_OFFSET_SIZE);
        }
    }




    static if(!is(typeof(OMPI_OFFSET_DATATYPE))) {
        private enum enumMixinStr_OMPI_OFFSET_DATATYPE = `enum OMPI_OFFSET_DATATYPE = ( ( MPI_Datatype ) ( cast( void * ) & ( ompi_mpi_long_long_int ) ) );`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_OFFSET_DATATYPE); }))) {
            mixin(enumMixinStr_OMPI_OFFSET_DATATYPE);
        }
    }




    static if(!is(typeof(OMPI_MPI_OFFSET_TYPE))) {
        private enum enumMixinStr_OMPI_MPI_OFFSET_TYPE = `enum OMPI_MPI_OFFSET_TYPE = long long;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_MPI_OFFSET_TYPE); }))) {
            mixin(enumMixinStr_OMPI_MPI_OFFSET_TYPE);
        }
    }




    static if(!is(typeof(OMPI_MPI_AINT_TYPE))) {
        private enum enumMixinStr_OMPI_MPI_AINT_TYPE = `enum OMPI_MPI_AINT_TYPE = ptrdiff_t;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_MPI_AINT_TYPE); }))) {
            mixin(enumMixinStr_OMPI_MPI_AINT_TYPE);
        }
    }




    static if(!is(typeof(HAVE_LONG_DOUBLE__COMPLEX))) {
        private enum enumMixinStr_HAVE_LONG_DOUBLE__COMPLEX = `enum HAVE_LONG_DOUBLE__COMPLEX = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_HAVE_LONG_DOUBLE__COMPLEX); }))) {
            mixin(enumMixinStr_HAVE_LONG_DOUBLE__COMPLEX);
        }
    }




    static if(!is(typeof(HAVE_DOUBLE__COMPLEX))) {
        private enum enumMixinStr_HAVE_DOUBLE__COMPLEX = `enum HAVE_DOUBLE__COMPLEX = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_HAVE_DOUBLE__COMPLEX); }))) {
            mixin(enumMixinStr_HAVE_DOUBLE__COMPLEX);
        }
    }




    static if(!is(typeof(HAVE_FLOAT__COMPLEX))) {
        private enum enumMixinStr_HAVE_FLOAT__COMPLEX = `enum HAVE_FLOAT__COMPLEX = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_HAVE_FLOAT__COMPLEX); }))) {
            mixin(enumMixinStr_HAVE_FLOAT__COMPLEX);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_REAL8))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_REAL8 = `enum OMPI_HAVE_FORTRAN_REAL8 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_REAL8); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_REAL8);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_REAL4))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_REAL4 = `enum OMPI_HAVE_FORTRAN_REAL4 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_REAL4); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_REAL4);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_REAL2))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_REAL2 = `enum OMPI_HAVE_FORTRAN_REAL2 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_REAL2); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_REAL2);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_REAL16))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_REAL16 = `enum OMPI_HAVE_FORTRAN_REAL16 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_REAL16); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_REAL16);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_INTEGER8))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER8 = `enum OMPI_HAVE_FORTRAN_INTEGER8 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER8); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER8);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_INTEGER4))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER4 = `enum OMPI_HAVE_FORTRAN_INTEGER4 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER4); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER4);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_INTEGER2))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER2 = `enum OMPI_HAVE_FORTRAN_INTEGER2 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER2); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER2);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_INTEGER16))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER16 = `enum OMPI_HAVE_FORTRAN_INTEGER16 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER16); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER16);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_INTEGER1))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER1 = `enum OMPI_HAVE_FORTRAN_INTEGER1 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER1); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_INTEGER1);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_LOGICAL8))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_LOGICAL8 = `enum OMPI_HAVE_FORTRAN_LOGICAL8 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_LOGICAL8); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_LOGICAL8);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_LOGICAL4))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_LOGICAL4 = `enum OMPI_HAVE_FORTRAN_LOGICAL4 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_LOGICAL4); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_LOGICAL4);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_LOGICAL2))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_LOGICAL2 = `enum OMPI_HAVE_FORTRAN_LOGICAL2 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_LOGICAL2); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_LOGICAL2);
        }
    }




    static if(!is(typeof(OMPI_HAVE_FORTRAN_LOGICAL1))) {
        private enum enumMixinStr_OMPI_HAVE_FORTRAN_LOGICAL1 = `enum OMPI_HAVE_FORTRAN_LOGICAL1 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OMPI_HAVE_FORTRAN_LOGICAL1); }))) {
            mixin(enumMixinStr_OMPI_HAVE_FORTRAN_LOGICAL1);
        }
    }




    static if(!is(typeof(OPAL_MAX_PROCESSOR_NAME))) {
        private enum enumMixinStr_OPAL_MAX_PROCESSOR_NAME = `enum OPAL_MAX_PROCESSOR_NAME = 256;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_MAX_PROCESSOR_NAME); }))) {
            mixin(enumMixinStr_OPAL_MAX_PROCESSOR_NAME);
        }
    }




    static if(!is(typeof(OPAL_MAX_PORT_NAME))) {
        private enum enumMixinStr_OPAL_MAX_PORT_NAME = `enum OPAL_MAX_PORT_NAME = 1024;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_MAX_PORT_NAME); }))) {
            mixin(enumMixinStr_OPAL_MAX_PORT_NAME);
        }
    }




    static if(!is(typeof(OPAL_MAX_OBJECT_NAME))) {
        private enum enumMixinStr_OPAL_MAX_OBJECT_NAME = `enum OPAL_MAX_OBJECT_NAME = 64;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_MAX_OBJECT_NAME); }))) {
            mixin(enumMixinStr_OPAL_MAX_OBJECT_NAME);
        }
    }




    static if(!is(typeof(OPAL_MAX_INFO_VAL))) {
        private enum enumMixinStr_OPAL_MAX_INFO_VAL = `enum OPAL_MAX_INFO_VAL = 256;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_MAX_INFO_VAL); }))) {
            mixin(enumMixinStr_OPAL_MAX_INFO_VAL);
        }
    }




    static if(!is(typeof(OPAL_MAX_INFO_KEY))) {
        private enum enumMixinStr_OPAL_MAX_INFO_KEY = `enum OPAL_MAX_INFO_KEY = 36;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_MAX_INFO_KEY); }))) {
            mixin(enumMixinStr_OPAL_MAX_INFO_KEY);
        }
    }




    static if(!is(typeof(OPAL_MAX_ERROR_STRING))) {
        private enum enumMixinStr_OPAL_MAX_ERROR_STRING = `enum OPAL_MAX_ERROR_STRING = 256;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_MAX_ERROR_STRING); }))) {
            mixin(enumMixinStr_OPAL_MAX_ERROR_STRING);
        }
    }




    static if(!is(typeof(OPAL_MAX_DATAREP_STRING))) {
        private enum enumMixinStr_OPAL_MAX_DATAREP_STRING = `enum OPAL_MAX_DATAREP_STRING = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_MAX_DATAREP_STRING); }))) {
            mixin(enumMixinStr_OPAL_MAX_DATAREP_STRING);
        }
    }




    static if(!is(typeof(OPAL_HAVE_LONG_LONG))) {
        private enum enumMixinStr_OPAL_HAVE_LONG_LONG = `enum OPAL_HAVE_LONG_LONG = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_HAVE_LONG_LONG); }))) {
            mixin(enumMixinStr_OPAL_HAVE_LONG_LONG);
        }
    }




    static if(!is(typeof(OPAL_HAVE_SYS_TIME_H))) {
        private enum enumMixinStr_OPAL_HAVE_SYS_TIME_H = `enum OPAL_HAVE_SYS_TIME_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_HAVE_SYS_TIME_H); }))) {
            mixin(enumMixinStr_OPAL_HAVE_SYS_TIME_H);
        }
    }




    static if(!is(typeof(OPAL_HAVE_ATTRIBUTE_DEPRECATED_ARGUMENT))) {
        private enum enumMixinStr_OPAL_HAVE_ATTRIBUTE_DEPRECATED_ARGUMENT = `enum OPAL_HAVE_ATTRIBUTE_DEPRECATED_ARGUMENT = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_HAVE_ATTRIBUTE_DEPRECATED_ARGUMENT); }))) {
            mixin(enumMixinStr_OPAL_HAVE_ATTRIBUTE_DEPRECATED_ARGUMENT);
        }
    }




    static if(!is(typeof(OPAL_HAVE_ATTRIBUTE_DEPRECATED))) {
        private enum enumMixinStr_OPAL_HAVE_ATTRIBUTE_DEPRECATED = `enum OPAL_HAVE_ATTRIBUTE_DEPRECATED = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_HAVE_ATTRIBUTE_DEPRECATED); }))) {
            mixin(enumMixinStr_OPAL_HAVE_ATTRIBUTE_DEPRECATED);
        }
    }




    static if(!is(typeof(OPAL_STDC_HEADERS))) {
        private enum enumMixinStr_OPAL_STDC_HEADERS = `enum OPAL_STDC_HEADERS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_STDC_HEADERS); }))) {
            mixin(enumMixinStr_OPAL_STDC_HEADERS);
        }
    }




    static if(!is(typeof(OPAL_BUILD_PLATFORM_COMPILER_VERSION))) {
        private enum enumMixinStr_OPAL_BUILD_PLATFORM_COMPILER_VERSION = `enum OPAL_BUILD_PLATFORM_COMPILER_VERSION = 590337;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_BUILD_PLATFORM_COMPILER_VERSION); }))) {
            mixin(enumMixinStr_OPAL_BUILD_PLATFORM_COMPILER_VERSION);
        }
    }




    static if(!is(typeof(OPAL_BUILD_PLATFORM_COMPILER_FAMILYID))) {
        private enum enumMixinStr_OPAL_BUILD_PLATFORM_COMPILER_FAMILYID = `enum OPAL_BUILD_PLATFORM_COMPILER_FAMILYID = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_OPAL_BUILD_PLATFORM_COMPILER_FAMILYID); }))) {
            mixin(enumMixinStr_OPAL_BUILD_PLATFORM_COMPILER_FAMILYID);
        }
    }
    static if(!is(typeof(NULL))) {
        private enum enumMixinStr_NULL = `enum NULL = ( cast( void * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_NULL); }))) {
            mixin(enumMixinStr_NULL);
        }
    }
    static if(!is(typeof(PLATFORM_COMPILER_UNKNOWN))) {
        private enum enumMixinStr_PLATFORM_COMPILER_UNKNOWN = `enum PLATFORM_COMPILER_UNKNOWN = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_PLATFORM_COMPILER_UNKNOWN); }))) {
            mixin(enumMixinStr_PLATFORM_COMPILER_UNKNOWN);
        }
    }




    static if(!is(typeof(PLATFORM_COMPILER_GNU))) {
        private enum enumMixinStr_PLATFORM_COMPILER_GNU = `enum PLATFORM_COMPILER_GNU = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_PLATFORM_COMPILER_GNU); }))) {
            mixin(enumMixinStr_PLATFORM_COMPILER_GNU);
        }
    }




    static if(!is(typeof(PLATFORM_COMPILER_FAMILYNAME))) {
        private enum enumMixinStr_PLATFORM_COMPILER_FAMILYNAME = `enum PLATFORM_COMPILER_FAMILYNAME = GNU;`;
        static if(is(typeof({ mixin(enumMixinStr_PLATFORM_COMPILER_FAMILYNAME); }))) {
            mixin(enumMixinStr_PLATFORM_COMPILER_FAMILYNAME);
        }
    }




    static if(!is(typeof(PLATFORM_COMPILER_FAMILYID))) {
        private enum enumMixinStr_PLATFORM_COMPILER_FAMILYID = `enum PLATFORM_COMPILER_FAMILYID = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_PLATFORM_COMPILER_FAMILYID); }))) {
            mixin(enumMixinStr_PLATFORM_COMPILER_FAMILYID);
        }
    }




    static if(!is(typeof(PLATFORM_COMPILER_GNU_C))) {
        private enum enumMixinStr_PLATFORM_COMPILER_GNU_C = `enum PLATFORM_COMPILER_GNU_C = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_PLATFORM_COMPILER_GNU_C); }))) {
            mixin(enumMixinStr_PLATFORM_COMPILER_GNU_C);
        }
    }




    static if(!is(typeof(PLATFORM_COMPILER_VERSION))) {
        private enum enumMixinStr_PLATFORM_COMPILER_VERSION = `enum PLATFORM_COMPILER_VERSION = PLATFORM_COMPILER_VERSION_INT ( 9 , 2 , 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_PLATFORM_COMPILER_VERSION); }))) {
            mixin(enumMixinStr_PLATFORM_COMPILER_VERSION);
        }
    }




    static if(!is(typeof(PLATFORM_COMPILER_VERSION_STR))) {
        private enum enumMixinStr_PLATFORM_COMPILER_VERSION_STR = `enum PLATFORM_COMPILER_VERSION_STR = __PLATFORM_COMPILER_GNU_VERSION_STR;`;
        static if(is(typeof({ mixin(enumMixinStr_PLATFORM_COMPILER_VERSION_STR); }))) {
            mixin(enumMixinStr_PLATFORM_COMPILER_VERSION_STR);
        }
    }




    static if(!is(typeof(__PLATFORM_COMPILER_GNU_VERSION_STR))) {
        private enum enumMixinStr___PLATFORM_COMPILER_GNU_VERSION_STR = `enum __PLATFORM_COMPILER_GNU_VERSION_STR = "9" "." "2" "." "1";`;
        static if(is(typeof({ mixin(enumMixinStr___PLATFORM_COMPILER_GNU_VERSION_STR); }))) {
            mixin(enumMixinStr___PLATFORM_COMPILER_GNU_VERSION_STR);
        }
    }



}
}
module mpid.nogcassert;

/++
 +/
@nogc nogc_assert(bool condition, string error_string, int error_code) {
	
	import core.stdc.stdio : printf;
	import core.stdc.string : memcpy;

	if(!condition) {
		enum err_buff_size = 256;
		static char[err_buff_size] c_err_buff = '\0';

		if(error_string.length < err_buff_size - 1) {
			memcpy(&c_err_buff[0], error_string.ptr, error_string.length);
		} else {
			memcpy(&c_err_buff[0], error_string.ptr, err_buff_size - 1);
		}
		printf("%s with error %d\n", c_err_buff.ptr, error_code);
		assert(false, error_string);
	}
}

#returns true if the the val is a function string or a function file
function(is_function result val)

	is_function_string(is_func "${val}")
	if(is_func)
		return_value(true)
	endif()
	is_function_cmake(is_func "${val}")
	if(is_func)
		return_value(true)
	endif()
	
	if(is_function_called)
		return_value(false)
	endif()
	is_function_file(is_func "${val}")
	if(is_func)
		return_value(true)
	endif()
	set(is_function_called true)
	is_function_ref(is_func "${val}")
	if(is_func)
		return_value(true)
	endif()
	return_value(false)
endfunction()
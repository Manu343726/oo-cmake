function(obj_istype  ref result typename)
	obj_gettype( ${ref} actual)
	if("${actual}" STREQUAL "${typename}")
		return_value(true)
	 else()
	 	return_value(false)
	endif()
endfunction()
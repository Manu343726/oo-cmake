#creates a map and returns the reference in result
function(map_create result)
	ref_new(res TYPE map ${ARGN})
	return_value(${res})
	
endfunction()
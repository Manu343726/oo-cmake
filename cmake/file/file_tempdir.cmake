# creates a temporary directory and returns its path
function(file_tempdir )
	oocmake_config(temp_dir)
	ans(temp_dir)
	#string(MAKE_C_IDENTIFIER id "${ARGN}")
	string_normalize( "${ARGN}")
	ans(id)
	set(tempdir "${temp_dir}/file_tempdir/${id}")
	set(i 0)
	while(true)
		if(NOT EXISTS "${tempdir}_${i}")
			set(tmp_dir "${tempdir}_${i}" PARENT_SCOPE)

			file(MAKE_DIRECTORY "${tempdir}_${i}")
			return("${tempdir}_${i}")
		endif()
		math(EXPR i "${i} + 1")
	endwhile()
endfunction()
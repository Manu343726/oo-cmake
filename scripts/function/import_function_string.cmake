
function(import_function_string function_string)
#	parse_function(func "${function_string}")
	random_file(file_name "${cutil_temp_dir}/_{{id}}.cmake")
	#message("fn ${file_name} end ${cutil_temp_dir}/_{{id}}.cmake")
	save_function("${file_name}" "${function_string}")

	#message("import_function_string ${file_name} ${function_string}")
	include("${file_name}")
	if(NOT cutil_keep_export)
		file(REMOVE "${file_name}")
	endif()
endfunction()
function(test)

	foreach(i RANGE 1000)

		map_new()
    ans(map)
		map_set(${map} key "value1")
		map_get(${map}  key )
    ans(res)
		map_delete(${map})
	endforeach()
endfunction()
function(obj_typecheck this typename)
  obj_istype(${this}  ${typename})
  ans(res)
  if(NOT res)
    obj_gettype(${this} )
    ans(actual)
  	message(FATAL_ERROR "type exception expected '${typename} but got '${actual}'")

  endif()
endfunction()
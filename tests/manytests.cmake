function(test)

ref_new(ref)
ref_set(${ref} "function(fuuu result) \n return_value(\${ARGN}) \n endfunction()")
ref_get(${ref} res)
assert( "${res}" STREQUAL "function(fuuu result) \n return_value(\${ARGN}) \n endfunction()")

ref_new(ref)
ref_set(${ref} "function(fuuu result) \n return_value(\${ARGN}) \n endfunction()")
is_function_ref(res ${ref})
assert(res)


ref_new(ref)
ref_set(${ref} "function(fuuu result) \n return_value(\${ARGN}) \n endfunction()")
is_function(res ${ref})
assert(res)

ref_new(ref)
ref_set(${ref} "function(fuuu result) \n return_value(\${ARGN}) \n endfunction()")
get_function_string(res ${ref})
assert("${res}" STREQUAL "function(fuuu result) \n return_value(\${ARGN}) \n endfunction()")


ref_new(ref)
ref_set(${ref} "function(fuuu result) \n return_value(\${ARGN}) \n endfunction()")
call_function("${ref}" res a b c d)
assert(EQUALS a b c d ${res})


obj_exists("asd" res)
assert(NOT res)

obj_create(res)
assert(res)
obj_exists(${res} res)
assert(res)

obj_create(res)
obj_getownkeys(${res} keys)
assert(EQUALS ${keys} "")

obj_create(res)
is_member(is_mem ${res})
assert(is_mem)


obj_create(res)
obj_setownproperty(${res} "k1" "v1")
obj_getownkeys(${res} keys)
assert(EQUALS ${keys} "k1")

obj_create(res)
obj_setownproperty(${res} "k1" "v1")
obj_hasownproperty(${res} hasprop "k1")
assert(hasprop)
obj_hasownproperty(${res} hasprop "k2")
assert(NOT hasprop)


obj_create(res)
obj_setownproperty(${res} "k1" "v1")
obj_setownproperty(${res} "k2" "v2")
obj_getownkeys(${res} keys)
assert(EQUALS ${keys} "k1" "k2")

obj_create(res)
obj_setownproperty(${res} "k1" "v1")
obj_getownproperty(${res} res "k1")
assert("${res}" STREQUAL "v1")

obj_create(res)
obj_setownproperty(${res} "k1" "v1")
obj_getownref(${res} ref "k1")
assert(ref)
map_navigate(val ${ref})
assert("${val}" STREQUAL "v1")

obj_create(res)
obj_setownproperty(${res} "k1" "v1")
obj_getownref(${res} ref "k1")
is_member(is_member ${ref} )
assert(is_member)
obj_getrefvalue(${ref} res)
assert("${res}" STREQUAL "v1")

obj_create(res)
obj_set(${res} "k1" "v1")
obj_get(${res} val "k1")
assert("${val}" STREQUAL "v1")

obj_create(res)
obj_create(proto)
obj_setprototype(${res} ${proto})
obj_getprototype(${res} prot)
assert(${proto} STREQUAL ${prot})

obj_create(res)
obj_create(proto)
obj_setprototype(${res} ${proto})
obj_set(${res} "k2" "v2")
obj_set(${proto} "k1" "v1")
obj_getkeys(${res} keys)
assert(EQUALS "__proto__" "k2" "k1" ${keys})

obj_create(res)
obj_create(proto)
obj_setprototype(${res} ${proto})
obj_set(${res} "k2" "v2")
obj_set(${proto} "k1" "v1")
obj_get(${res} val2 k2)
obj_get(${res} val1 k1)
assert(EQUALS "${val2}" "v2")
assert(EQUALS "${val1}" "v1")

# check handling of special symbols
obj_create(res)
obj_set(${res} k1 "\${ARGN} \${name} \"\" ; \;") 
obj_get(${res} val "k1")
assert(EQUALS "${val}"  "\${ARGN} \${name} \"\" ; \;")


obj_create(res)
obj_setfunction(${res} "function(myfunc result) \n return_value(\${ARGN}) \n endfunction()") 
obj_get(${res} fu1 myfunc)
map_get(${res} fu myfunc)
assert("${fu}" STREQUAL "function(myfunc result) \n return_value(\${ARGN}) \n endfunction()")


obj_create(res)
obj_setfunction(${res} "function(myfunc result) \n return_value(\${ARGN}) \n endfunction()")
obj_callmember(${res} "myfunc" res a b c 1 2 3)
assert(EQUALS a b c 1 2 3 ${res})

obj_create(res)
ref_new(ref)
ref_set(${ref} "function(myfunc result) \n return_value(\${ARGN}) \n endfunction()")
obj_pushcontext(${res})
import_function(${ref} as bound_function)
bound_function(val a b c)
obj_popcontext()
assert(EQUALS ${val} a b c)


set(func "function(myfunc result) \n return_value(\${ARGN}) \n endfunction()")
ref_setnew(funcref "${func}")
file(WRITE "${cutil_temp_dir}/tmp.cmake" "${func}")

is_function(res ${funcref})
assert(res)
is_function(res "${func}")
assert(res)
is_function(res "${cutil_temp_dir}/tmp.cmake")
assert(res)
is_function(res "function(myfunc result) \n return_value(\${ARGN}) \n endfunction()")
assert(res)

get_function_string(res "${func}")
assert(${res} STREQUAL "${func}")
get_function_string(res "function(myfunc result) \n return_value(\${ARGN}) \n endfunction()")
assert(${res} STREQUAL "${func}")
get_function_string(res "${cutil_temp_dir}/tmp.cmake")
assert(${res} STREQUAL "${func}")
function(testme)
endfunction()
get_function_string(res testme)
assert(res)

# create and call functor
function(FunctorMethod result)
	set(${result} ${ARGN} PARENT_SCOPE)
endfunction()
obj_newfunctor(res FunctorMethod)
assert(res)
obj_callmember(${res} __call__  val 1 2 3)
assert(EQUALS 1 2 3 ${val})

# call functor
function(Constr)
	obj_declarefunction(${__proto__} __call__)
	function(${__call__} result)
		set(${result} ${ARGN} PARENT_SCOPE)
	endfunction()

	obj_declarefunction(${__proto__} test)
	function(${test} result)
		set(${result} ${ARGN} PARENT_SCOPE)
	endfunction()
endfunction()
obj_new(res Constr)
obj_callmember(${res} __call__ val a b c)
assert(EQUALS a b c ${val})
obj_callobject(${res} val I II III)
assert(EQUALS I II III ${val})

obj_get(${res} funcy test)
obj_bind(boundfu ${res} "${funcy}")
call_function(${boundfu} val o i u)
assert(EQUALS o i u ${val})

obj_bindmember(boundfu2 ${res} test)
call_function(${boundfu2} val q w e)
assert(EQUALS ${val} q w e)

obj_bindfunctor(boundfu3 ${res})
call_function(${boundfu3} val m n o)
assert(EQUALS ${val} m n o)

endfunction()
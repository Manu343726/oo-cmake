
function(qm_deserialize quick_map_string)
  set_ans("")
  eval("${quick_map_string}")
  ans(res)
  map_tryget(${res} data)
  return_ans()
endfunction()


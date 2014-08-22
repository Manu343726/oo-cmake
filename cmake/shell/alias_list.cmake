
function(alias_list)

  path("${CMAKE_CURRENT_LIST_DIR}/../bin")
  ans(path)
  
  if(WIN32)
  file_extended_glob("${path}" "*.bat" "!cps.*" "!cutil.*")
  ans(cmds)
  set(theRegex "([^\\/])+\\.bat")
  list_select(cmds "(it)-> regex_search($it $theRegex 1)")
  ans(cmds)
  string(REPLACE ".bat" "" cmds "${cmds}")

  return_ref(cmds)
else()
  message(FATAL_ERROR "only implemented for windows")
endif()

endfunction()



## combines the list of command line args into a string which separates and escapes them correctly
  function(command_line_args_combine)
    command_line_args_escape(${ARGN})
    ans(args)
    string_combine(" " ${args})
    ans(res)
    return_ref(res)
  endfunction()

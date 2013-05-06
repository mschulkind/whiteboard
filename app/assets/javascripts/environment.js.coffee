@puts =
  if typeof console != "undefined" && typeof console.log != "undefined"
    if typeof console.log.apply != "undefined"
      -> console.log.apply(console, arguments)
    else
      console.log
  else
    ->

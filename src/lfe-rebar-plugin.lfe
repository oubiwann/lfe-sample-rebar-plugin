(defmodule lfe-rebar-plugin
  (export all))

(defun foo (config app-file)
  ;(: rebar_log log 'log '"foo!~n" ())
  (: io format '"foo!~n")
  )

(defun run ()
    (quote noop))

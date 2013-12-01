(defmodule lfe-rebar-plugin
  (export all))


(defrecord config
  dir
  opts
  globals
  ;envs
  ;skip-dirs
  ;xconf
  )


(defun debug-data-structure (config-data)
  (: io format '"~n~n" ())
  (: io format '"Element 1:~n~p~n" (list (element 1 config-data)))
  (: io format '"Element 2:~n~p~n" (list (element 2 config-data)))
  (: io format '"Element 3:~n~p~n" (list (element 3 config-data)))
  (: io format '"Element 4:~n~p~n" (list (element 4 config-data)))
  ;(: io format '"Element 5:~n~p~n" (list (element 5 config-data)))
  ;(: io format '"Element 6:~n~p~n" (list (element 6 config-data)))
  ;(: io format '"Element 7:~n~p~n" (list (element 7 config-data)))
  (: io format '"~n~n" ()))

(defun debug-data-structure (config-data type)
  (: io format '"~n~n" ())
  (: io format '"~n~p~n" (list config-data))
  (: io format '"~n~n" ()))

(defun get-base-dir (config-data)
  ;(debug-data-structure config-data 'simple)
  (case (: dict find 'base_dir (config-globals config-data))
    ((tuple 'ok dir) dir)
    ('error "")))

(defun base-dir? (config-data)
  (==
    (: rebar_utils get_cwd)
    (get-base-dir config-data)))

(defun foo (config app-file)
  "We only want to execute this plugin when it's in this directory."
 (: file write_file '"data.erl" config)
 (: io format '"~nWorking directory: ~p~n" (list (: rebar_utils get_cwd)))
 (case (base-dir? config)
   ('true (: io format '"foo!~n"))
   ; the following will only print with "rebard foo -v"
   ;('true (: rebar_log log 'warn '"foo!~n" ()))
   ('false 'ok)))

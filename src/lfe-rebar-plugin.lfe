(defmodule lfe-rebar-plugin
  (export all))


(defrecord config
  dir
  opts
  globals
  envs
  skip-dirs
  xconf)

(defun get-base-dir (config-data)
  (case (: dict find 'base_dir (config-xconf config-data))
    ((tuple 'ok dir) dir)
    ('error "")))

(defun base-dirp (config-data)
  (==
    (: rebar_utils get_cwd)
    (get-base-dir config-data)))

(defun foo (config app-file)
  "We only want to execute this plugin when it's in this directory."
 (case (base-dirp config)
   ;('true (: io format '"foo!~n"))
   ('true (: rebar_log log 'warn '"foo!~n" ()))
   ('false 'ok)))

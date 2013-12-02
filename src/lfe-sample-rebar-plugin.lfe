(defmodule lfe-sample-rebar-plugin
  (export all))


(defrecord config
  dir
  opts
  globals
  envs
  skip-dirs
  xconf)

(defun get-base-dir (config-data)
  "Get the top-level directory for the project."
  (case (: dict find 'base_dir (config-xconf config-data))
    ((tuple 'ok dir) dir)
    ('error "")))

(defun base-dir? (config-data)
  "Useful as a predicate for checks."
  (==
    (: rebar_utils get_cwd)
    (get-base-dir config-data)))

(defun run-in-basedir (config app-file)
  "We only want to execute this function when the plugin is running in the
  base directory."
 (: lfe-utils dump-data '"debug-config-data.erl" config)
 (case (base-dir? config)
   ('true (: io format '"Just ran the 'run-in-basedir' plugin command!~n"))
   ('false 'ok)))

(defun run-in-other-dirs (config app-file)
  "We want to execute this function whenever the plugin is not running in the
  base directory."
 ;(: lfe-utils dump-data '"debug-config-data.erl" config)
 (case (not (base-dir? config))
   ('true (: io format '"Just ran the 'run-in-other-dirs' plugin command!~n"))
   ('false 'ok)))

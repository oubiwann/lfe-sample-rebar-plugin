(defmodule lfe-sample-rebar-plugin
  (export all)
  (import
    (from lists
      (filter 2)
      (flatten 1)
      (map 2))
    (from lfe-utils
      (tuple? 1))))

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

(defun run-in-basedir (config app-file func)
  "We only want to execute this function when the plugin is running in the
  base directory."
  ;(: lfe-utils dump-data '"debug-config-data.erl" config)
  (case (base-dir? config)
    ('true (funcall func))
    ('false 'ok)))

(defun run-in-other-dirs (config app-file func)
  "We want to execute this function whenever the plugin is not running in the
  base directory."
  ;(: lfe-utils dump-data '"debug-config-data.erl" config)
  (case (not (base-dir? config))
    ('true (funcall func))
    ('false 'ok)))

(defun demo-run-in-basedir (config app-file)
  (run-in-basedir
    config
    app-file
    (lambda ()
      (: io format '"Just ran the 'demo-run-in-basedir' plugin command!~n"))))

(defun demo-run-in-other-dirs (config app-file)
  (run-in-other-dirs
    config
    app-file
    (lambda ()
      (: io format
        '"Just ran the 'demo-run-in-other-dirs' plugin command!~n"))))

(defun filter-plugins (option)
  ""
  (if (tuple? option)
    (if (== (element 1 option) 'plugins)
      (element 2 option))))

(defun not-false? (expr)
  (=/= expr 'false))

(defun get-plugins (options)
  (flatten
    (filter
      #'not-false?/1
      (map #'filter-plugins/1 options))))

(defun list-plugins (config app-file)
  ""
  (case (base-dir? config)
    ('true
      (progn
        (let* ((opts (config-opts config))
               (plugins (get-plugins opts)))
          (: io format '"~p~n" (list plugins)))))
    ('false 'ok)))

(defun help (parent-config commands)
  (: io format '"~p~n" commands))

(defun print-default-commands ()
  (: rebar_utils sh
    '"rebar -c"
    '(#(use_stdout true) return_on_error)))

(defun get-commands-help ()
  (print-default-commands)
  (: io format '"
Commands for the '~s` rebar plugin:

  demo-run-in-basedir\t\t     Display a demo message while processing the current dir
  demo-run-in-other-dirs\t     Displa a demo message while processing deps dirs
  list-plugins\t\t\t     List all the plugins defined for the current dir
  commands\t\t\t     List both the default commands and those for the plugins
  ~n" (list (MODULE))))

(defun call-commands-help (plugin)
  (eval `(: ,plugin get-commands-help)))

(defun commands (config app-file)
  (run-in-basedir
    config
    app-file
    (lambda ()
      (let ((plugins (get-plugins (config-opts config))))
        (map #'call-commands-help/1 plugins))))
  'ok)

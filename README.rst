#######################
lfe-sample-rebar-plugin
#######################

A sample rebar plugin, written in LFE


Introduction
============

This is a sample ``rebar`` plugin written in LFE. It's provided in order to
encourage folks to create ``rebar`` plugins using LFE.


Dependencies
------------

This project assumes that you have `rebar`_ installed somwhere in your
``$PATH``.

This project depends upon the following, which installed to the ``deps``
directory of this project when you run ``make deps``:

* `LFE`_ (Lisp Flavored Erlang; needed only to compile)

* `lfeunit`_ (needed only to run the unit tests)


Installation
============

Installation assumes you have created your LFE ``rebar`` plugin project
using `lfe-skeleton`_.

In order to use this plugin, you will need to do the following:

* Update your project's ``rebar.config`` to add the following:

.. code:: erlang

    {plugins, ['lfe-sample-rebar-plugin']}.

* Update the ``deps`` section of your project's ``rebar.config`` to add the
  following:

.. code:: erlang

    {'lfe-sample-rebar-plugin',
        ".*",
        {git, "git://github.com/oubiwann/lfe-sample-rebar-plugin.git",
              "master"}}

After that, you'll need to ``make compile``, and you should be all set to use
it.


Usage
=====

Once you've got the sample plugin compiled, you can run the plugin's functions.
This sample plugin provides two functions which both only print output in the
terminal, they don't perform any changes to the system. The two functions are:

* ``run-in-basedir``

* ``run-in-other-dirs``

Here they are in action:

.. code:: bash

    $ rebar run-in-basedir
    ==> lfe (run-in-basedir)
    ==> lfeunit (run-in-basedir)
    ==> lfe-utils (run-in-basedir)
    ==> rebar (run-in-basedir)
    ==> lfe-sample-rebar-plugin (run-in-basedir)
    Just ran the 'run-in-basedir' plugin command!

All plugins will iterate through the set of deps and base directories, calling
the given plugin function. In this case, the function called only operates on
the base directory.

.. code:: bash

    $ rebar run-in-other-dirs
    ==> lfe (run-in-other-dirs)
    Just ran the 'run-in-other-dirs' plugin command!
    ==> lfeunit (run-in-other-dirs)
    Just ran the 'run-in-other-dirs' plugin command!
    ==> lfe-utils (run-in-other-dirs)
    Just ran the 'run-in-other-dirs' plugin command!
    ==> rebar (run-in-other-dirs)
    Just ran the 'run-in-other-dirs' plugin command!
    ==> lfe-sample-rebar-plugin (run-in-other-dirs)

As you can see, this plugin function does just the opposite: it executes on
every directory other than the base directory.


.. Links
.. =====
.. _rebar: https://github.com/rebar/rebar
.. _LFE: https://github.com/rvirding/lfe
.. _lfeunit: https://github.com/lfe/lfeunit
.. _lfe-skeleton: https://github.com/lfe/skeleton-project

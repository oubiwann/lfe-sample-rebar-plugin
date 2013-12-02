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

Once you've got the sample plugin in your ``deps`` directory, it's as simple as
this:

.. code:: bash

    $ rebar foo

The plugin will iterate through the set of deps and base directories, calling
the plugin function ``foo`` in the process. ``foo`` will only print a result
if your installation of ``rebar`` can access the global data structure.


.. Links
.. =====
.. _rebar: https://github.com/rebar/rebar
.. _LFE: https://github.com/rvirding/lfe
.. _lfeunit: https://github.com/lfe/lfeunit
.. _lfe-skeleton: https://github.com/lfe/skeleton-project

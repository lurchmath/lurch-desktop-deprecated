
# Example Lurch Applications

The webLurch project is attempting to rewrite [the desktop application
Lurch](http://www.lurchmath.org/) for the web.  It is not yet complete, but
the foundational technology is progressing, and can be used in other
projects as well.  This page lists several example applications built using
the webLurch foundation.
[(See here for full developer info.)](developer.md)

## Beginner examples

These applications truly serve no purpose except to show very small example
applictaions built on the *Lurch Web Platform.*

### Simple example

Developers who want to build their own apps on the webLurch platform should
start here, because it's highly documented and extremely simple.

 * [Launch the app](https://lurchmath.github.io/lwp-example-simple)
 * [View source code](https://github.com/lurchmath/lwp-example-simple)

### "Complex" Example

(Actually just a tiny step more complex than the simple example.)

Developers who want to build their own apps on the webLurch platform should
start with the Simple Example, then move to this one.

It defines two group types rather than one, and shows how to
add context menus and do lengthy background computations,
among other things.

 * [Launch the app](https://lurchmath.github.io/lwp-example-complex)
 * [View source code](https://github.com/lurchmath/lwp-example-complex)

## Intermediate examples

These applications actually have some useful functionaly, however small.
Be sure you've started with the
[beginner examples above](#beginner-examples), first.

### Math Evaluator

This one lets users wrap any typeset mathematical expression in a bubble and
ask the app to evaluate it or show its internal structure.

 * [Launch the app](https://lurchmath.github.io/lwp-example-math)
 * [View source code](https://github.com/lurchmath/lwp-example-math)

### OMCD Editor

This app that lets you write an [OpenMath Content
Dictionary](http://www.openmath.org/cd/) in a user-friendly word processor,
then export its raw XML for use elsewhere. This is a specific example of an
entire category of apps for editing hierarchically structured meanings.

 * [Launch the app](https://lurchmath.github.io/lwp-example-openmath)
 * [View source code](https://github.com/lurchmath/lwp-example-openmath)

### Code Editor

This app lets users insert boilerplate code from a simple programming
language (with only one kind of if and one kind of loop, and a few other
statements) using groups and text within them as comments.  Thus the user
"codes" in their own native language, and the app translates it into one of
a few sample languages in a sidebar.  JavaScript code can then be executed
if the user desires.

 * [Launch the app](https://lurchmath.github.io/lwp-example-sidebar)
 * [View source code](https://github.com/lurchmath/lwp-example-sidebar)

### Lean UI

This is the most complex demo; try one of the others to start.

It lets users interact with the theorem prover
[Lean](https://leanprover.github.io) in a word-processing environment with
nice visual feedback.

 * [Launch the app](https://lurchmath.github.io/lwp-example-lean)
 * [Read the tutorial](https://lurchmath.github.io/lwp-example-lean/site)
 * [View source code](https://github.com/lurchmath/lwp-example-lean)

## Main App

### Lurch

The ongoing implementation of Lurch for the web is kept here.  It is still
in the beginning phases of development.  For software that will check the
steps of students' work, [see the desktop
version](http://www.lurchmath.org).

 * No live version yet, because it is being redesigned.
 * The most recent [source code is here](https://github.com/lurchmath/lurch/tree/master/source/main-app)

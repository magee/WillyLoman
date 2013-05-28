Travelling Salesman-type project
===============================

Stack:
  1.  language:  Ruby 1.9.3p392
  2.  test framework:  rSpec
  3.  pry: debugging

Problem
----------------------------

Create a travel network consisting of a number of towns with one way paths between them -- a directed graph.  Identify shortest routes, number of routes, number of hops (towns) to get from point A to point B), etc.

Data Structure: I could use an adjacency matrix or an adjacency list to manage the graph data.  I chose to use an adjacency matrix to record the connections between vertices (towns) and the relative weights (distances) between them.

Assumptions
-----------------
  1. Towns are named with a single alpha character (e.g. A-Z, a-z)
  2. Graph input data is a comma delimited text file consisting of strings in the form AB1 where A is the name of the first town, B is the name of the connected town and 1 is the distance between both.
  3. Towns that have two-way connections are listed twice (e.g. CD8, DC8) to indicate

  example: BA1, CD4, AB2, EA5, CE3, AE5, BE2, DA6, DA3

Installing the App
-----------------

Check to make sure Ruby is installed on your system.  Type :

    $ ruby -v

If the system returns a value rather than an error you already have it installed.  (e.g. ruby 1.9.3p392 (2013-02-22 revision 39386) [x86_64-darwin12.2.1])  Otherwise, download Ruby from www.ruby-lang.org.

To validate that the code works, you can run the included tests.  To do so, the following gems should be installed for this project:

rSpec

    gem install rSpec

Then to run the tests, from the WillyLoman root folder type:

    rspec


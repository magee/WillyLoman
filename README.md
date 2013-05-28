Thoughtworks Coding Exercise
===============================

Stack:
  1.  language:  Ruby 1.9.3p392
  2.  test framework:  rSpec
  3.  pry: debugging

Problem One: Trains
----------------------------

For this exercise I am using an adjacency matrix to record the connections between vertices and the relative weights (distances) between them.

Assumptions
-----------------
  1. Towns are named with a single alpha character (e.g. A-Z, a-z)
  2. Graph input data is a comma delimited text file consisting of strings in the form AB1 where A is the name of the first town, B is the name of the connected town and 1 is the distance between both.
  3. Towns that have two-way connections are listed twice (e.g. CD8, DC8) to indicate

  example: AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7

Installing the App
-----------------

Check to make sure Ruby is installed on your system.  Type :  
    $ ruby -v
If the system returns a value rather than an error you already have it installed.  (e.g. ruby 1.9.3p392 (2013-02-22 revision 39386) [x86_64-darwin12.2.1])  Otherwise, download Ruby from www.ruby-lang.org.

To validate that the code works, you can run the included tests.  To do so, the following gems should be installed for this project:

*  rSpec
    $ gem install rSpec
*

Then to run the tests, from the graph_problem folder type:
    rake rspec


<!-- Graph Inputs
-----------------

Graph data should be provided in a YAML text file named graph_data.yml in the 'tests/fixtures' folder.  Use the existing './tests/fixtures/template.yml' file as a model for formatting that data.

Note: the record IDs ("one:, two:, three:,...") are arbitrary and can be any unique value you choose.  The body of each record, however, must be formatted as shown.  Quotes are not required for any values.
 -->
 
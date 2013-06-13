Pathfinding Exercise
===============================

Stack:
  1.  language:  Ruby 1.9.3p392
  2.  test framework:  rSpec
  3.  pry: debugging

Problem One: Trains
----------------------------

For this exercise I am using an adjacency matrix to record the connections between vertices and the relative weights (distances) between them.  I used Depth-first-search to find all paths between towns and Dykstra algorithm to find shortest distance paths between town.  Path distances are calculated simply by alculating distance while travelling the specified path.

Where possible I used Hashes as part of the data structures in order to exploit key uniqueness and ordering.  Because not all browsers handle these the same way, run this code a in Chrome browser.

Assumptions
-----------------
  1. Towns are named with a single alpha character (e.g. A-Z, a-z)
  2. Graph input data is a comma delimited text file consisting of strings in the form AB1 where A is the name of the first town, B is the name of the connected town and 1 is the distance between both.
  3. Towns that have two-way connections are listed twice (e.g. CD8, DC8) to indicate bidirectional path

  example: AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7

  4. Instructions specify not writing to 'gold' standard.  As a result, I have documented where errors will be thrown but have not implemented error handling other than to leave a comment or log error to the console.

Installing the App
-----------------

Check to make sure Ruby 1.9.3 is installed on your system.  Type :
    $ ruby -v
If the system returns a value rather than an error you already have it installed.  (e.g. ruby 1.9.3p392 (2013-02-22 revision 39386) [x86_64-darwin12.2.1])  Otherwise, download Ruby from www.ruby-lang.org.

To validate that the code works, you can run the included tests.  To do so, make sure the application is correction installed by...

1.  Open a terminal application and change to the directory where you the app installed.
2.  Clone the git repository by entering the following on the command line:

    $ git clone https://github.com/magee/WillyLoman.git

    -- or --

    if you have a zip file with the source code, instead you can create a new folder, (e.g., Mooney_Trains), and unzip the files into that folder.

3.  Finish installation by running Bundler:

    $ bundle install

Running the App
-----------------

To run the tests, change to the project folder and type:

    $ rspec spec

To run the application: type the following and follow the onscreen instructions for running the application.

    $ ruby app.rb




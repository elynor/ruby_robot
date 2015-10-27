# ruby_robot

Simple robot walking script.

This is my test project, my sandbox. I will try to add as many features to my robot script as I could. Yeah, including
the Mega Lazorr for sure it is in the top of my features list :)


To launch execute the /bin/robot_runner.rb

Main representation of robot is file /lib/robot.rb - it is main object that will be filled with parts I would make :)
Most of the robot parts will be in /lib/robot/parts directory.

At first you should place a robot to some tile on the map by
`PLACE X Y FACING` command.
Where facing can be:
* north
* west
* east
* south

After that you can change the direction of moving by typing `LEFT` or `RIGHT`

You can move robot by typing `MOVE` command

Robot will send a response with it's parameters, such as position and facing, after each action.

Ruby version - 2.1.5
Dependencies:
* [Rspec](http://rspec.info)

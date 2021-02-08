# Counting Stroop Task

This project was created for a course at the University of Passau by Jonas Poxleitner.

## Fundamentals
The experiment is based on a [paper](https://www.researchgate.net/publication/6416195_The_counting_Stroop_A_cognitive_interference_task) by George Bush, Paul J Whalen, Lisa M Shin and Scott L Rauch and uses the instructions from this paper.

## Implementation
This project was realized with a HTTP server in Dart to serve files and save user data and the jsPsych JavaScript library for the webpage.

## Usage
- Install Dart
- Run stroop_task.dart
- Make sure you have the jsPsych library in the web/ directory.
- The HTTP server now listens to requests and also saves the submitted user data in the data/ directory.
- If you want to use this experiment yourself, please update the privacy information in web/index.html.

## Contributors
I conducted this experiment with help from [Pritesh Gunjan](https://github.com/pritesh001).
# Stick2It

A clean approach to goal setting and routine tracking. Increase your productivity and mindfulness with simple tools that promote progress and reflection. Coded in Swift using Apple's SwiftUI, designed for iPhone and iPad devices.

## Features To Be Implemented

### Basics:
 - Simple interface to create new tasks and goals
 - Daily view of today's goals
 - Easy checklist systems to mark completion
 - Intuitive color-coded display of completion of tasks

### Enhanced Experience:
 - Display of day's goals and routine as a linear calendar
 - Outline of day adjustable through simple touch interactions
 - Easy navigation to weekly, monthly, perhaps yearly views
 - Area for notes and reflection

### Beyond:
 - Integration with iCal and Google Cal
 - Regular notifications for timely check-ins
 - In-app analysis of goals to give feedback about adjustments to make


## App Structure
This is the future outline, not yet implemented. Each goal is set into a `struct Goal: Hashable` which contains `var id, var goalName: String, var done: Bool`. These goals are used by `struct Day: Hashable` which contains `var id, var date: String, var goals: [goals], var reflection: String`. The goals are displayed in `struct goalBox` which is then displayed as a `struct dayView`.
 

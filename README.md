# Just Books
A sample that shows how to use the Flutter Router API to handle nested navigation.

# Bug
For some reason, `RouteState.go()` causes the path to change first to whatever
was passed and then always goes back to `/popular`. This seems to be ignored,
but it can be seen in the Debug Console in either case.

![](readme/double-go-to-popular.png)]
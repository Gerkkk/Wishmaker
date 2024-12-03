#  Answers for quesions

## Question 1: What issues prevent us from using storyboards in real projects?

There are several reasons why it is difficult to use storyboards. Firstly, the file with storyboard constraints is an XML-file, so it is less readable than swift code. Secondly, storyboards require more resources, so Xcode works worse. Moreover, it is hard to understand and debug storyboard constraints when there are many labels and constraints. 

## Question 2: What does the code on lines 25 and 29 do?

25. title.translatesAutoresizingMaskIntoConstraints = false -- if this flag is true, UIKit will generate constraints automatically;

29. view.addSubview(title) -- after this command title will have view as its superview and view will have title as its subview, and title will be added to set of view's subviews. 

## Question 3: What is a safe area layout guide?

Safe area layout guide is a part of screen that is free of weird IPhone panel in which frontal camera is located. So it is guaranteed that views in safe area layout guide will be visible.

## Question 4: What is [weak self] on line 23 and why it is important?

23. sliderRed.valueChanged = { [weak self] value in

This is a weak reference. We need it here because we are not sure that WishMakerViewController is allocated and we can change background color. If we did not have weak reference, the program would crash. With weak ref. it will not.

## Question 5: What does clipsToBounds mean?

If this flag is true, subviews will be clipped to bounds of the view. If this flag is false, subviews may be located outside the view and may be not visible.

## Question 6: What is the valueChanged type? What is Void and what is Double?

This is a closure. Closure is kind of anonymous function which can be (will be in our case) implemented later. Void and Double describe signature of function. Double is an argument, void is a return value. 

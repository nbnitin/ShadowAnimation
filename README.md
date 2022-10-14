# ShadowAnimation

lblWelcomeText.layer.shadowOffset = CGSize(width: 10, height: 0)

Replace // add shadow offset here with your shadow offset. In this example, we want our shadow to be completely on the right, so I will set its x value to 10 and its y value to 0 like so:

lblWelcomeText.layer.shadowOffset = CGSize(width: 10, height: 0)
Where zero represents the centre of the label and any other value would measure the distance from it.

If you’re not too familiar with the way this works and you’re still a bit confused, I’ll try to represent it in a few images.

Imagine that we have an object, in this case, a label:

![image](https://user-images.githubusercontent.com/5785670/195553226-561bd129-c76f-430d-91a9-3be1435484c8.png)

Its centre would be the green dot in the image:

![image](https://user-images.githubusercontent.com/5785670/195553305-0619b287-e994-4064-a443-7cb476598e7d.png)


Now, if we add a shadow to it:

![image](https://user-images.githubusercontent.com/5785670/195553353-9375d2dd-766a-4894-98c2-5198480c7813.png)


And we consider the centre of the shadow this time, and not the label’s centre, we will notice that it is slightly more towards the right side of the label. The centre of the shadow is represented by the pink dot in the image:


And the difference between the centre of the shadow and the centre of our label would be, in our code, the 10 in the x-axis and 0 in the y-axis:


Makes sense?

In conclusion, the shadow offset defines the difference between the centre of the object (our label) and the centre of the shadow itself.

#Make the Shadow Move

we will need to change our shadow’s offset points soon in order to make it move in a half-circle motion towards the left. Since we can only set the shadow’s offset horizontally and vertically, we will use trigonometry to set the x and y value to our shape.

The motion will be similar to this:


The pink dot, namely the centre of the shadow, moves in a circular motion around the centre of the label, represented with a green circle.
Now, we know that the current distance from the centre of the label to the centre of the shadow is 10, meaning that the radius of the imaginary circle would also be 10.

The centre of the shadow will move down like this:

![image](https://user-images.githubusercontent.com/5785670/195554060-01f9def5-5044-4d80-b27a-291c6dc418e6.png)





The centre of the shadow moves following the red line and stops at the blue circle.
If we build a triangle using that segment as our hypotenuse and the x-axis as our adjacent segment, we can use trigonometry to find the x and y values to move the centre of our shadow as we like around our circle!

![image](https://user-images.githubusercontent.com/5785670/195554118-8170da93-6250-492b-93a2-3831410c92c1.png)



All you need to do is define the length of one of the segments (in this case, our hypotenuse, which is always the radius of the circle), its length (in our case it would be 10), and the degrees of the angle that it forms against our x-axis (the one close to the green circle).



So, right now our imaginary triangle in our imaginary circle (wow, that’s a lot to imagine) has an angle of… zero degrees. Because it’s flat. That’s why the x segment equals 10 (as would our hypotenuse, since the triangle is flat) and the y segment equals 0. But that will change if we move our view a little lower and also a little more to the left.

We know that the distance from the centre of the circle to any point inside the circle is always the same, so that would be 10, our radius. While the x value can change, our hypotenuse, namely our radius, won’t change size. That means we already have two parameters of our function: the segment and the size. So, what about our angle?



![image](https://user-images.githubusercontent.com/5785670/195554433-0ab7dea9-17fe-40e3-82e9-474b7c4e3edb.png)

I created 7 points over 135 degrees to define a circular motion for my shadow.

So, right now our imaginary triangle in our imaginary circle (wow, that’s a lot to imagine) has an angle of… zero degrees. Because it’s flat. That’s why the x segment equals 10 (as would our hypotenuse, since the triangle is flat) and the y segment equals 0. But that will change if we move our view a little lower and also a little more to the left.


Depending on how you want to move the shadow around, I suggest you create as many points around the circle as possible, to avoid the animation taking sharp turns and the motion looking less circular. What worked for me was to add a point for every 22.5°, so I’d have four points in the first quarter of the circle (degree 22.5, 45, 67.5, 90) and two on the other, because I made my animation stop at degree 135.


#Expalantion of trignometery function

Basically, in a right-angled triangle, you can calculate the length of the sides of your triangle provided that you have at least:
- the degrees of one angle (in our case, the one I highlighted in yellow),
- and the size of one of the three sides (in our case, blue dotted line).
As you can tell from the picture, this logic can be applied to an invisible circle around our middle button to define the position of the three buttons (green) by calculating x and y values with the formulas in the picture.
![image](https://user-images.githubusercontent.com/5785670/195842433-8637a63f-6c92-4887-b28b-f7230529be0d.png)



This theory can be useful for any architecture involving circles. In that tutorial, for example, I was explaining how to determine the position of the green dots in the picture using the centre of the circle as the starting point, so that I could use them as the centre of the position of three UIButtons.

Trigonometry teaches that:

sin θ = Opposite / Hypotenuse
cos θ = Adjacent / Hypotenuse
tan θ = Opposite / Adjacent Side
If you look at the picture above, “θ” would be the yellow angle, “x” would be the adjacent side and “y” would be the opposite, which makes the remaining side, the radius if you will, the hypotenuse.

Assuming that we already know the degrees of our angle and at least one of the three sides, usually the hypotenuse, we can invert the formulas to find the sides of the remaining sides, usually x and y.

All we need to do is invert our formulas:

y = sin θ * h

y = tan θ * x

x = cos θ * h

x = y / tan θ

h = x / cos θ

h = y / sin θ

And replace θ with our degrees in radians, using the following formula:

θ * π / 180


creating segment enum
enum segment {
case x
case y
case h
}

above formula in swift
y = tan(angle * .pi/180) * x
y = sin(angle * .pi/180) * h
x = cos(angle * .pi/180) * h
x = y / tan(angle * .pi/180)
h = x / cos(angle * .pi/180)
h = y / sin(angle * .pi/180)

The parameters I would send to the function are:

segment, where I define whether the segment I have is x, y or h;
size, where I declare how long the given segment is;
angle, which is the degrees of my angle.
The function will return [segment : CGFloat].

Using a switch statement, I can define which formulas to use:

switch segment {
   case .x: (...)
   case .y: (...)
   case .h: (...)
}





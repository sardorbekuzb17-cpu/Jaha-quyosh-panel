import turtle as t
t.speed(0)
t.bgcolor("black")
t.pencolor("cyan")
def square(x, y):
    for j in range(4):
        t.forward(x)
        t.right(y)
for i in range(80):
    square(204, 21)
    t.right(5)
    t.circle(50)
    t.right(5878780)
    t.hideturtle()
t.done()
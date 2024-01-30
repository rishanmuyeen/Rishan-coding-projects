import turtle

#functions
def paddle_a_up():
    y = paddle_a.ycor() #returns the y cordinate
    y += speed1
    paddle_a.sety(y)

def paddle_a_down():
    y = paddle_a.ycor()
    y -= speed1
    paddle_a.sety(y)

def paddle_b_up():
    y = paddle_b.ycor() 
    y += speed1
    paddle_b.sety(y)

def paddle_b_down():
    y = paddle_b.ycor()
    y -= speed1
    paddle_b.sety(y)

def winner():
    if score_a > score_b:
        return(player_1)
    elif score_a < score_b :
        return(player_2)
    else:
        return(tie_message)

def quit_game():
    win.clear()
    pen.clear()
    pen1.clear()
    score_dis = turtle.Screen()
    score_dis.title("The winner!")
    score_dis.bgcolor("black")
    score_dis.setup(width=400, height=100)
    
    text = turtle.Turtle()
    text.hideturtle()
    text.penup()
    text.color("red")
    font_size = 25
    font_style = ("Arial", font_size, "normal")
    text.write(f"The winner is ,{winner()}", align="center",font=("courier"))
    turtle.exitonclick()



#open a window to get the player names
win1 = turtle.Screen()
win1.title("Pong by Rishan")
win1.bgcolor("black")
win1.setup(width=400, height=300)

player_1 = turtle.textinput("Player 1", "Enter player 1's name: ")
player_2 = turtle.textinput("Player 2", "Enter player 2's name: ")
score =  turtle.textinput("score", "Enter the score to win the game: ")
score_to_win = int(score)
difficulty = turtle.textinput("difficulty","""Difficulty level press the nummber :
1.Easy
2.Medium
3.Hard""")
if difficulty == "1":
    level=int(4)
    speed1=int(40)
elif difficulty == "2":
    level=int(6)
    speed1=int(60)
elif difficulty == "3":
    level=int(8)
    speed1=int(100)

tie_message="Its a Tie!"

#open a window for th egame to be displayed    
win = turtle.Screen()
win.title("Pong by Rishan")
win.bgcolor("black")
win.setup(width=800, height=600)
win.tracer(0) #stops the window from updating it has to be done manualy
score_a=0
score_b=0
 
#paddle a
paddle_a = turtle.Turtle()
paddle_a.speed(2) #speed of animation
paddle_a.shape("square")
paddle_a.color("white")
paddle_a.shapesize(stretch_wid=5, stretch_len=1)
paddle_a.penup() #
paddle_a.goto(-350,0)


#paddle b
paddle_b = turtle.Turtle()
paddle_b.speed(2)
paddle_b.shape("square")
paddle_b.color("white")
paddle_b.shapesize(stretch_wid=5, stretch_len=1)
paddle_b.penup()
paddle_b.goto(350,0)


#ball
ball = turtle.Turtle()
ball.speed(2)
ball.shape("circle")
ball.color("white")
ball.penup()
ball.goto(0,0)
ball.dx = level
ball.dy = level


#keyboard binding
win.listen()
win.onkeypress(paddle_a_up, "w")
win.onkeypress(paddle_a_down, "s")
win.onkeypress(paddle_b_up, "Up")
win.onkeypress(paddle_b_down, "Down")

#pen header
pen = turtle.Turtle()
pen.speed(0)
pen.color("red")
pen.penup()
pen.hideturtle()
pen.goto(0,260)
font_size = 18
font_style = ("Arial", font_size, "normal")
pen.write(f"{player_1}: 0   {player_2}: 0", align="center",font=("courier"))

#pen quit
pen1 = turtle.Turtle()
pen1.speed(0)
pen1.color("red")
pen1.penup()
pen1.hideturtle()
pen1.goto(0, -280)
font_size = 20
font_style = ("Arial", font_size, "normal")
pen1.write(f"Press Q to quit the game",align="center", font=font_style)
turtle.listen()
turtle.onkey(quit_game, "q")




#main game
while True:
    win.update() #update the window

    #move the ball
    ball.setx(ball.xcor() + ball.dx)
    ball.sety(ball.ycor() + ball.dy)

    #border top and bottom
    if ball.ycor() > 290:
        ball.sety(290)
        ball.dy *= -1

    if ball.ycor() < -290:
        ball.sety(-290)
        ball.dy *= -1

    if ball.xcor() > 390:
        ball.goto(0,0)
        ball.dx *= -1
        score_a += 1
        pen.clear()
        font_size = 18
        font_style = ("Arial", font_size, "normal")
        pen.write(f"{player_1}:{score_a}   {player_2}:{score_b}", align="center",font=("courier"))

    if ball.xcor() < -390:
        ball.goto(0,0)
        ball.dx *= -1
        score_b += 1
        pen.clear()
        font_size = 18
        font_style = ("Arial", font_size, "normal")        
        pen.write(f"{player_1}:{score_a}   {player_2}:{score_b}", align="center",font=("courier"))


    #collusion
    if (ball.xcor() > 340 and ball.xcor() <350 and (ball.ycor() < paddle_b.ycor() + 40 and ball.ycor() > paddle_b.ycor()- 50)):
        ball.setx(340)
        ball.dx *= -1

        
    if (ball.xcor() < -340 and ball.xcor() >-350 and (ball.ycor() < paddle_a.ycor() + 40 and ball.ycor() > paddle_a.ycor()- 50)):
        ball.setx(-340)
        ball.dx *= -1


    if (score_a == score_to_win) or (score_b == score_to_win):  
        quit_game() 











        

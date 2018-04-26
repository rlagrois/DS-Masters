#Remy Lagrois
#09/15/2015
#MSDS 7330 402

#tic_tac_toe.py

#Prints tic-tac-toe board


#Vertical and horizontal componants of the board
vert = "    |     |    "
horiz = "----------"

#Creates a blank board
def blankboard():
    for i in range(1, 6):
        if i % 2 == 0:
            print horiz
        else:
            print vert
            


#List of available spaces
spaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]


#prints current board
def print_board():
    print spaces[0], "|", spaces[1], "|", spaces[2]
    print horiz
    print spaces[3], "|", spaces[4], "|", spaces[5]
    print horiz
    print spaces[6], "|", spaces[7], "|", spaces[8]
 
 
#Board printing and win condition ideas came from
#https://inventwithpython.com/chapter10.html 
 
 #Checks if the game has been won
 #compares characters on rows, columns, and the diagnols 
import sys
def check_win():
    if ((spaces[0] == spaces[1] and spaces[0] == spaces[2]) or 
    (spaces[3] == spaces[4] and spaces[3] == spaces[5]) or
    (spaces[6] == spaces[7] and spaces[6] == spaces[8]) or
    (spaces[0] == spaces[3] and spaces[0] == spaces[6]) or
    (spaces[1] == spaces[4] and spaces[1] == spaces[7]) or
    (spaces[2] == spaces[5] and spaces[2] == spaces[8]) or
    (spaces[0] == spaces[4] and spaces[0] == spaces[8]) or
    (spaces[2] == spaces[4] and spaces[2] == spaces[6])):
        return True
        
            


   
def the_game():
    for i in range(2, 11): #sets number of turns and is used to determine players move
        print_board()
        #places X for player 1
        if i % 2 == 0:
            player1 = int(input("Player One what is your move?"))
            move = player1 - 1
            spaces[move] = "X"
            if check_win() is True:
                print "Player 1 wins!"
                print_board()
                sys.exit()
            #places O for player 2
        elif i % 2 != 0:
            player2 = int(input("Player Two what is your move?"))
            move = player2 - 1
            spaces[move] = "O"
            if check_win() is True:
                print "Player 2 Wins!"
                print_board()
                sys.exit()
                
the_game()
            

          
  



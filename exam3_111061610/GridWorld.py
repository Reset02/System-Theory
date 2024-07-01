import numpy as np
import matplotlib.pyplot as plt
import numpy.random as rd
class GridWorld:
#10%
    def __init__(self):
    # Initializes the grid world by defining the grid layout,
    # including blocked cells and the goal cell.
        s0 = [0, 0]
        st = [4, 0]
        q_value = rd.random([5,5,4])
        q_value[st[0]][st[1]] = 0 
        q_value[1][1] = 0 
        q_value[3][0] = 0
        q_value[3][1] = 0  
        q_value[0][3] = 0 
        q_value[2][3] = 0 
        q_value[4][2] = 0 
    
    def get_actions(self):
    # Returns the available actions in a given state.
        ACTIONS =np.array([[-1,0],[0,1],[1,0],[0,-1]])#左上右下
        return ACTIONS
    
    def step(self, state, action):
        state_n = (np.array(state) + action).tolist()
        
        if state_n[0] >= 5 or state_n[0] < 0 or state_n[1] < 0 or state_n[1] >= 5:
            state_n = state
        if state_n[0] == 1 and state_n[1] == 1 or state_n[0] == 0 and state_n[1] == 3 or state_n[0] == 1 and state_n[1] == 3 or state_n[0] == 3 and state_n[1] == 0 or state_n[0] == 3 and state_n[1] == 2 or state_n[0] == 2 and state_n[1] == 4:
            state_n = state
        
        if state_n[0] == 0 and state_n == 4:
            reward = 10
        else:
            reward = -1
        
        return state_n, reward
import numpy as np
import matplotlib.pyplot as plt
import numpy.random as rd

class SarsaAgent:
#10%
    def __init__(self, epsilon, alpha, gamma):
    # Initializes the agent with the given epsilon (exploration rate),
    # alpha (learning rate), and gamma (discount factor).
        self.gamma = gamma
        self.alpha = alpha
        self.epsilon = epsilon
    
    def select_action(self, state, q_value):
    # Selects an action for the given state based on the SARSA algorithm.
    # Returns the selected action.
        if rd.random() < self.epsilon:
            action = rd.randint(0,4)
        else: 
            action = np.argmax(q_value[state[0]][state[1]])
        return action
   
    def update_q_table(self, state, action, reward, next_state, next_action, q_value):
    # Updates the agent's Q-table based on the SARSA update rule
    # using the received reward, next state, and next action.
        q_value[state[0]][state[1]][action] += self.alpha * (reward + self.gamma *q_value[next_state[0]][next_state[1]][next_action] - q_value[state[0]][state[1]][action])
        return q_value
    
    def reset(self):
    # Resets the agent's internal state at the beginning of each episode.
      gain = 0
      state = [0, 0]
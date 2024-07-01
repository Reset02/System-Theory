import numpy as np
import matplotlib.pyplot as plt
import numpy.random as rd
from GridWorld import GridWorld
from SarsaAgent import SarsaAgent

def step(state, action):
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
def main():
    ACTIONS =np.array([[-1,0],[0,1],[1,0],[0,-1]])#左上右下
    returns = []
    gamma = 1
    alpha = 0.1
    epsilon = 0.3
    simulate = 2000
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
    sarsa = SarsaAgent(epsilon, alpha, gamma)
    environment = GridWorld()
    while simulate != 0 :
      gain = 0
      state = s0
      while state != st:
        action = -1
        action = sarsa.select_action(state, q_value)
        next_state, reward = environment.step(state, ACTIONS[action])
        next_action = -1
        next_action = sarsa.select_action(next_state, q_value)
        q_value = sarsa.update_q_table(state, action, reward, next_state, next_action, q_value)
        state = next_state
        gain += reward
      returns.append(gain)
      simulate -= 1
    return returns, q_value
def averages(a):
  return np.array([np.average(a[:i+1]) for i in range(len(a))])

sarsa_reward_all = []
print('start')
for simulate in range(1):
  sarsa_reward,sarsa_q_value = main()
  sarsa_reward = averages(sarsa_reward)
  sarsa_reward_all.append(sarsa_reward)
print('end')
plt.plot(np.average(sarsa_reward_all,axis=0),label='sarsa')
plt.ylim(-200, 10)
plt.legend()
plt.show()
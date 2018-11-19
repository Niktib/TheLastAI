/* NIKOLAS MAIER 500461990
MOHANNAD ALSAIDI 500521856
DANIEL LODGE 500727538 */
:- discontiguous(pathClear/2).
:- discontiguous(hasBall/1).

/* Knowledge Base */
hasBall(r3).
pathClear(r1,goal).
pathClear(r2,r1).
pathClear(r3,r2).
pathClear(r3,goal).
pathClear(r3,r1).

/*Rules*/
canScore(R) :- open(R), hasBall(R).
canScore(R) :- open(R), hasBall(X), canAssist(X,R).
canAssist(R1,R2) :- pathClear(R1, R2), not R1=goal, not R2=goal.
canAssist(R1,R2) :- pathClear(R1, R3), not R1=goal, not R2=goal, not R3=goal, canAssist(R3, R2).
open(R) :- pathClear(R, goal).



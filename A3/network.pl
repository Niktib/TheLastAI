/*  NIKOLAS MAIER 500461990
DANIEL LODGE 500727538 */

%Person, LastName, Address, Position
solve(SystemList):-
%By having all different predicate appear frequently the goal was to have things better set up for the constraints
SystemList = [S1,S2,S3,S4,S5,S6],
systeminfo(S1), 
systeminfo(S2), all_difStart([S1,S2]), 
constraint2([S1,S2]), 
systeminfo(S3), 
all_difStart([S1,S2,S3]),
systeminfo(S4),
all_difStart([S1,S2,S3,S4]),
systeminfo(S5),
all_difStart([S1,S2,S3,S4,S5]),
systeminfo(S6), 
all_difStart([S1,S2,S3,S4,S5,S6]),
%constraint1([S1,S2,S3,S4]),
%constraint3(SystemList),
%constraint4(SystemList),

%constraint5(SystemList),
%constraint7(SystemList),
constraint8(SystemList),
writeSolution(SystemList).

systeminfo(info(Person, LastName, Address, Position)):- person(Person), lastName(LastName), compSystem(Address), position(Position).

writeSolution([]).
writeSolution([info(P1,L1,A1,U1)|T]):-
	write(P1), write(' '),write(L1),write(' '),write(A1),write(' '),write(U1),nl,
	writeSolution(T).


constraint1(SystemList):- 
	memberOf(info(lizzie,L1,A1,U1), SystemList), 
	memberOf(info(F2,osbourne,A2,U2), SystemList),
	memberOf(info(F3,L3,"pricenet.com",U3), SystemList),
	trip(U1,U2,Path), memberOf(U3, Path), 
	not U1 = U2, not U1 = U3, not U3 = U2,
	not F2 = lizzie, not F3 = lizzie, 
	not L1 = osbourne, not L3 = osbourne, 
	not A1 = "pricenet.com", not A2 = "pricenet.com".

constraint2(SystemList):-
	memberOf(info(mona,L1,_,U1), SystemList), 
	memberOf(info(F2,wolverton,_,U2), SystemList),
	trip(U1,U2,_), not U1 = U2,
	not F2 = mona, 	not L1 = wolverton.
	
constraint3(SystemList):-
	memberOf(info(anthony,L1,_,U1), SystemList), 
	memberOf(info(jamie,L2,_,U2), SystemList),
	memberOf(info(F3,elby,_,U3), SystemList),
	trip(U1,U2,Path), memberOf(U3, Path),
	not U1 = U2, not U1 = U3, not U3 = U2,
	not L1 = elby, not L2 = elby, 
	not F3 = anthony, not F3 = jamie.

constraint4(SystemList):-
	memberOf(info(mona,_,A1,U1), SystemList), 
	memberOf(info(F2,_,"sysworld.com",U2), SystemList),
	trip(U1,U2,_), 
	not U1 = U2, not F2 = mona,	not A1 = "sysworld.com".
	
constraint5(SystemList):-
	memberOf(info(daniel,L1,A1,U1), SystemList), 
	memberOf(info(F2,tsuji,A2,U2), SystemList),
	memberOf(info(F3,L3,"univmoose.edu",U3), SystemList),
	trip(U1,U2,Path), memberOf(U3, Path), 
	not U1 = U2, not U1 = U3, not U3 = U2,
	not F2 = daniel, not F3 = daniel, 
	not L1 = tsuji, not L3 = tsuji, 
	not A1 = "univmoose.edu", not A2 = "univmoose.edu".

constraint7(SystemList):-
	memberOf(info(anthony,_,A1,U1), SystemList), 
	memberOf(info(F2,_,"firstbank.com",U3), SystemList),
	trip(U1,out,Path), memberOf(U3, Path),
	not F2 = anthony,	not A1 = "firstbank.com".
	
constraint8(SystemList):-
	memberOf(info(catarina,L1,A1,U1), SystemList), 
	memberOf(info(F2,L2,"netvue.com",U2), SystemList),
	memberOf(info(F3,zinkerman,A3,U3), SystemList),
	trip(U1,U2,Path), memberOf(U3, Path), 
	not U1 = U2, not U1 = U3, not U3 = U2,
	not F2 = catarina, not F3 = catarina, 
	not L1 = zinkerman, not L2 = osbourne, 
	not A1 = "netvue.com", not A3 = "netvue.com".


trip(O, O, [O]).
trip(O, D, [O, D]):- directLink(O, D).
trip(O, D, [O, I|Path]):- directLink(O, I), trip(I, D, [I|Path]).
trip(O, D, Path):- reverseTrip(D, O, Path).

reverseTrip(O, O, [O]).
reverseTrip(O, D, [O, D]):- directLink(O, D).
reverseTrip(O, D, [O, I|Path]):- directLink(O, I), reverseTrip(I, D, [I|Path]).


person(catarina). person(lizzie). person(mona). 
person(anthony). person(daniel). person(jaime).

lastName(elby). lastName(kim). lastName(osbourne). 
lastName(tsuji). lastName(wolverton). lastName(zickerman).
 
male(anthony). male(daniel). male(jaime). 
female(lizzie). female(catarina). female(mona).

compSystem('bananas.com'). compSystem('firstbank.com'). compSystem('netvue.com').
compSystem('pricenet.com'). compSystem('sysworld.com'). compSystem('univmoose.com').

position(1). position(2). position(3). position(4). position(5). position(6). 

directLink(6, 5). directLink(5, 3). directLink(3, 4). 
directLink(3, 2). directLink(2, 1). directLink(1, out).

termsToList([], []).
termsToList([info(P,L,A,U)|[]], [P,L,A,U]).
termsToList([info(P,L,A,U)|T], [P,L,A,U|List]):- termsToList(T, List).

all_diff([]).
all_diff([N|L]) :- not memberOf(N,L), all_diff(L).
all_difStart(SystemList):- termsToList(SystemList, List), all_diff(List).

appendTo([],L,L).
appendTo([X|L1],L2,[X|L3]):- appendTo(L1,L2,L3).

memberOf(X, L):- appendTo(_,[X|_],L).

/* NIKOLAS MAIER 500461990
DANIEL LODGE 500727538 */

print_solution([S,A,Y,M,T,L,N,E]) :-
	solve([S,A,Y,M,T,L,N,E]),
	%generateAndTestMethod([S,A,Y,M,T,L,N,E]),
	write('    '), write(S),write(A),write(Y),nl,
	write('*    '), write(M),write(Y),nl,
	write('_______'),nl,
	write('   '), write(N),write(A),write(M),write(E),nl,
	write('+ '), write(A),write(M),write(N),write(E),write('0'),nl,
	write('_______'),nl,
	write(' '), write(S),write(T),write(Y),write(L),write(E),nl.
	
	
	
	

solve([S,A,Y,M,T,L,N,E]) :-
	%A dependency graph was created and the order in which the constraints were picked was based on how many reliances the specific variable had vs how many it required.
	%For example, Y relies on A and N, but is used in E, A and M. Those three that it helps produce are themselves dependencies for a great deal of the rest of the varibles.
	dig(Y),
	%E is barely used but will produce C1 as a byproduct which can help
	E is (Y*Y) mod 10, C1 is (Y*Y)//10,
	dig(S), S > 0, dig(C10),
	A is (Y*S + C10) mod 10, N is (Y*S + C10) //10,
	car(E100),
	S is (A+E100) mod 10,
	M is (Y*A + C1) mod 10, C10 is (Y*A+C1)//10,
	E is (M*Y) mod 10, D1 is (M*Y) //10,
	N is (M*A+D1) mod 10, D10 is (M*A+D1) //10,
	M is (M*S+D10) mod 10, A is (M*S+D10)//10,
	L is (M+E) mod 10, E1 is (M+E) //10,
	Y is (A+N+E1) mod 10, E10 is (A+N+E1) //10,
	T is (N+M+E10) mod 10, E100 is (N+M+E10) //10,
	all_diff([S,A,Y,M,T,L,N,E]).


all_diff([]).
all_diff([N|L]) :- not memberOf(N,L), all_diff(L).

memberOf(N,[N|L]).
memberOf(N,[M|L]) :- memberOf(N, L).

car(0). car(1).
dig(0). dig(1). dig(2). dig(3). dig(4). 
dig(5). dig(6). dig(7). dig(8). dig(9).



	/*
generateAndTestMethod([S,A,Y,M,T,L,N,E]) :-
	dig(S), dig(A), dig(Y), dig(M), dig(N), dig(E), dig(T), dig(L), 
	S > 0, M > 0,
	
	E is (Y*Y) mod 10, C1 is (Y*Y) // 10,
	M is (A*Y+C1) mod 10, C10 is (A*Y+C1) // 10,
	A is (S*Y+C10) mod 10, C100 is (S*Y+C10) // 10,
	N is C100,

	
	E is (M*Y) mod 10, D1 is (M*Y) //10,
	N is (M*A+D1) mod 10, D10 is (M*A+D1) //10,
	M is (M*S+D10) mod 10, D100 is (M*S+D10) //10,
	A is D100,
	
	L is (E+M) mod 10, F1 is (E+M) //10,
	Y is (N+A+F1) mod 10, F10 is (N+A+F1) //10,
	T is (N+M+F10) mod 10, F100 is (N+M+F10) //10,
	S is (A + F100) mod 10,
	all_diff([S,A,Y,M,T,L,N,E]).
*/
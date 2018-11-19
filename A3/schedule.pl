/*  NIKOLAS MAIER 500461990
DANIEL LODGE 500727538 */

print_solution(Exam_List) :-
	solve(Exam_List).
	
solve(Exam_List):-
	Exam_List = [T1, T2, T3, T4, T5, T6, T7],
	exam_time(T1), philFirst(T1), 
	exam_time(T2), Exam_List=[T1,T2], not smallestFirst(Exam_List), 
	exam_time(T3), 
	exam_time(T4), 
	exam_time(T5), 
	exam_time(T6), 
	exam_time(T7), 
	
	writeSolution(Exam_List).
	%sameDayDifferentClass(Exam_List), smallestFirst(Exam_List)

writeSolution([]).
writeSolution([eInfo(Day, Class)|T]):-
	write(Day), write(' '),write(Class),nl,
	writeSolution(T).

smallestFirst([eInfo(Day, [Prog, Letters, Code])|Exam_List]):-
	memberOf([Day, [Prog2, Letters, Code2]], Exam_List), Code2 > Code.

philFirst(eInfo(Day, [Prog|_])):- Prog = phl250, Day = 11.

sameDayDifDept([_|[]]).
sameDayDifDept([eInfo(Day, [Prog|_])|Exam_List]):-
	program(Prog, Dept),
	checkAllDept(Day, Dept, Exam_List),
	sameDayDifDept(Exam_List).

	
checkAllDept(_, _, []).
checkAllDept(Day, Dept, [eInfo(Day,[Prog|_])|Exam_List]):-
	program(Prog, Dept2), not Dept = Dept2, checkAllDept(Day, Dept, Exam_List).
checkAllDept(Day, Dept, [eInfo(Day1,_)|Exam_List]):- not Day = Day1, checkAllDept(Day, Dept, Exam_List).

	
sameDayDifferentClass([]).
sameDayDifferentClass([eInfo(_, [Prog|_])|Exam_List]):-
	not memberOf(eInfo(_, [Prog|_]), Exam_List),
	sameDayDifferentClass(Exam_List).

	
	
exam_time(eInfo(Day, Class)):- 
		member(Day,[11,12,13,14]),
		member(Class,[[csc108, csc, 108],[csc148, csc, 148],
						[csc199, csc, 199],[mat101, mat, 101],
						[mat120, mat, 120],[mat140, mat, 140],
						[phl250, phl, 250]]).


appendTo([],L,L).
appendTo([X|L1],L2,[X|L3]):- appendTo(L1,L2,L3).

memberOf(X, L):- appendTo(_,[X|_],L).

program(csc108, ai). program(csc148, ai). program(csc199, philo). program(csc199, cog). program(csc199, ai).
program(mat101, philo). program(mat120, cog). program(mat140, cog). program(mat140, ai).
program(phl250, philo).
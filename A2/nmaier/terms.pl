/*
%Nikolas Maier 	500 461 990
%Daniel Lodge 	500 727 538
*/
/* List2Term */
list2term([],nil).
list2term([E|[]], next(E, nil)):- atom(E).
list2term([E|[]], next(Term, nil)):- list2term(E, Term).
list2term([E|List], next(E, Term)):- atom(E), list2term(List, Term).
list2term([E|List], next(Term1, Term2)):- list2term(E, Term1), list2term(List, Term2).


%appendT
appendTo([],L,L).
appendTo([H|L1],L2,[H|L]) :- appendTo(L1,L2,L).

appendT(nil, next(E, Term), next(E, Term)).
appendT(next(E1, Term1),Term2,next(E1, Term3)) :- appendT(Term1,Term2,Term3).

%flat
flat(nil, nil).
flat(next(E, nil), next(E, nil)):- atom(E).
flat(next(Term1, nil), Term3):- flat(Term1,Term3).
flat(next(E, Term1), next(E, Term3)):- atom(E), flat(Term1,Term3).
flat(next(Term1, Term2), Term4):- flat(Term1, TempTerm), 
									appendT(TempTerm,Term2, Term3), 
									flat(Term3,Term4).
									
									
/*
Nikolas Maier 	500 461 990
Daniel Lodge 	500 727 538
*/

memberOf(E,L) :- appendTo(_,[E|_],L).
/*   appendTo adds two lists together  */
appendTo([],L,L).
appendTo([H|L1],L2,[H|L]) :- appendTo(L1,L2,L).
/*Only every other item from list1 should be in list2*/
everyOther([],[]).
everyOther([X|[]], [X|List2]).
everyOther([X|[Y|T]], [X|List2]) :- everyOther(T,List2).

/* All duplicates should be removed (If it appears later the first occurence is removed)*/
removeDups([],[]). /*Base case*/
removeDups([X|T],List2) :- memberOf(X,T), removeDups(T,List2). /*Removes the head*/
removeDups([X|T], [X|List2]) :- removeDups(T,List2). /*Keeps the head*/

sameFirstLast(List) :- appendTo([E],_,List), appendTo(_,[E],List).

/*  NIKOLAS MAIER 	500461990	
DANIEL LODGE 	500727539 */

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%Database%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hasBook(amazon,levesque,thinking_as_computation,75).
hasBook(amazon,rowling,harry_potter,110).
hasBook(amazon,tolkien,lotr,10).
hasBook(amazon,levesque,common_sense_the_turing_test,30).
hasBook(amazon,rand,atlas_shrugged,200).
hasBook(amazon,russell,more_AI,200).
hasBook(indigo,levesque,thinking_as_computation,100).
hasBook(indigo,rowling,harry_potter,25).
hasBook(indigo,russell,artificial_intelligence_a_modern_approach,200).
hasBook(indigo,poole,computational_intelligence,50).
hasBook(indigo,the_test_before_the_fall,qa_person,10).
hasBook(book_city,tolkein,lotr,10).
hasBook(book_city,poole,computational_intelligence,10).

lives(levesque,toronto).
lives(trenton,newYork).
lives(rowling,london).
lives(tolkien,los_angeles).
lives(the_man,toronto).
lives(poole,newYork).
lives(rand,ussr).
lives(russell,vancouver).
lives(qa_person,los_angeles).
lives(once_more_with_feeling,bancroft).

shipping(indigo,toronto,1).
shipping(indigo,newYork,10).
shipping(indigo,los_angeles,15).
shipping(indigo,london,50).
shipping(amazon,toronto,3).
shipping(amazon,newYork,1).
shipping(amazon,los_angeles,10).
shipping(amazon,london,0).
shipping(book_city,toronto,20).
shipping(book_city,newYork,20).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Lexicon % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
article(a).
article(the).
article(an).

common_noun(city,X) :- lives(_,X).
common_noun(person,X) :- lives(X,_).
common_noun(author,X) :- hasBook(_,X,_,_).
common_noun(bookstore, X) :- hasBook(X,_,_,_).
common_noun(book,X) :- hasBook(_,_,X,_).
common_noun(title,X) :- hasBook(_,_,X,_).
common_noun(shipping,X) :- shipping(_, _, X).
common_noun(price, X) :- hasBook(_,_,_,X).

adjective(expensive, X):- hasBook(_,_,X,Y), Y > 100.
adjective(high, X):- hasBook(_,_,X,Y), Y > 100.
adjective(expensive, Y):- hasBook(_,_,_,Y), Y > 100.
adjective(high, Y):- hasBook(_,_,_,Y), Y > 100.
adjective(expensive, X):- shipping(_, _, X), X > 6.
adjective(high, X):- shipping(_, _, X), X > 6.
adjective(cheap, X):-  hasBook(_,_,X,Y), Y < 51.
adjective(low, X):-  hasBook(_,_,X,Y), Y < 51.
adjective(cheap, Y):-  hasBook(_,_,_,Y), Y < 51.
adjective(low, Y):-  hasBook(_,_,_,Y), Y < 51.
adjective(cheap, X):-  shipping(_, _, X), X < 2.
adjective(low, X):-  shipping(_, _, X), X < 2.
adjective(moderate, X):- hasBook(_,_,X,Y), Y > 50, Y < 101.
adjective(moderate, Y):- hasBook(_,_,_,Y), Y > 50, Y < 101.
adjective(moderate, X):- shipping(_, _, X), X > 2, X < 6.

preposition(from, X, Y) :- hasBook(X, _, Y, _).
preposition(from, X, Y) :- hasBook(Y, _, X, _).
preposition(from, X, Y) :- lives(X, Y).
preposition(from, X, Y) :- shipping(X, Y, _).
preposition(from, X, Y) :- shipping(Y, X, _).
preposition(from, X, Y) :- shipping(X, _, Y).
preposition(from, X, Y) :- shipping(Y, _, X).

preposition(lives, X, Y) :- lives(X, Y).
preposition(for, X, Y) :- hasBook(_, X, Y, _).
preposition(for, X, Y) :- hasBook(_, Y, X, _).
preposition(for, X, Y) :- hasBook(_, _, Y, X).
preposition(for, X, Y) :- hasBook(_, _, X, Y).
preposition(to, X, Y) :- shipping(_, Y, X).
preposition(to, X, Y) :- shipping(Y,_, X).
preposition(by, X, Y) :- hasBook(_, X, Y, _).
preposition(by, X, Y) :- hasBook(_, Y, X, _).

preposition(of, X, Y) :- hasBook(_, _, X, Y).
preposition(of, X, Y) :- hasBook(_, _, Y, X).
preposition(of, X, Y) :- hasBook(_, X, Y, _).


preposition(at, X, Y) :- hasBook(X, Y, _, _).
preposition(at, X, Y) :- hasBook(Y, X, _, _).
preposition(at, X, Y) :- hasBook(X, _, Y, _).
preposition(at, X, Y) :- hasBook(Y, _, X, _).


preposition(with, X, Y) :- hasBook(X, _, Y, _).
preposition(with, X, Y) :- hasBook(Y, _, X, _).
preposition(with, X, Y) :- hasBook(_, X, Y, _).
preposition(with, X, Y) :- hasBook(_, Y,X, _).
preposition(with, X, Y) :- hasBook(X, Y, _, _).
preposition(with, X, Y) :- hasBook(Y, X, _, _).
preposition(with, X, Y) :- hasBook(_, _, X, Y).
preposition(with, X, Y) :- hasBook(_, _, Y, X).
preposition(with, X, Y) :- hasBook(X, _, _, Y).
preposition(with, X, Y) :- hasBook(Y, _, _, X).

preposition(with, X, Y) :- shipping(X, Y, _).
preposition(with, X, Y) :- shipping(X, _, Y).

proper_noun(X) :- 
	not article(X), not common_noun(X,_),
	not adjective(X,_), not preposition(X,_,_).




%%%%%%%%%%%%%%%%%%%%%%%%%%% parser %%%%%%%%%%%%%%%%%%%%%%%%%

who(Words, Ref) :- np(Words, Ref), person(Ref).
what(Words, Ref) :- np(Words,Ref).

np([Name],Name) :- proper_noun(Name).
np([Art|Rest], Who) :- article(Art), np2(Rest, Who).

np2([Adj|Rest],Who) :- adjective(Adj,Who), np2(Rest, Who).
np2([Noun|Rest], Who) :- common_noun(Noun, Who), mods(Rest,Who).
mods([], _).
mods(Words, Who) :-
	appendLists(Start, End, Words),
	prepPhrase(Start, Who),	mods(End, Who).

prepPhrase([Prep|Rest], Who) :-
	preposition(Prep, Who, Ref), np(Rest, Ref).

appendLists([], L, L).
appendLists([H|L1], L2, [H|L3]) :-  appendLists(L1, L2, L3).





/* 	
	Nikolas Maier	500 461 900
	Daniel Lodge 	500 727 539
*/
/* I don't believe this is how the prof wanted it done exactly, but its last minute and I got this working */
avl(void).
avl(tree(Root,Left,Right)) :- avlHeight(Left, Hleft), avlHeight(Right, Hright), Hleft - Hright < 2, Hright - Hleft < 2.
avlHeight(void, 0).
avlHeight(tree(Root,Left,Right), H) :- avlHeight(Left, Hleft), avlHeight(Right, Hright), H is Hleft+Hright + 2/2, Hleft - Hright < 2, Hright - Hleft < 2.

printCenterLine(N):-
	K is N-1,
	size(N,D1),
	size(K,D2),
	DN is D1-D2,
	HALFDN is DN/2,
	M is HALFDN+1,
	Z is HALFDN-1,
	D22=D2+1,
	CENTER=D22/2,
	
	write(*),
	tab(Z),
	lace(K,CENTER),
	tab(Z),
	write('*').



start(1):-
write('*'),write('*'),write('*'),nl,
write('*'),tab(1),write('*'),nl,
write('*'),write('*'),write('*'),nl.

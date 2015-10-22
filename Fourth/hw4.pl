%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% SAHIL JAIN
%%%%%%%%%%%% 110281300
%%%%%%%%%%%% COMPUTER SCIENCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% BASICS FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rev([],[]).
rev([H|T],L):-
	rev(T,L1),
	append(L1,[H],L).

append([],L,L).
append([H|T],X,[H|Y]):-
	append(T,X,Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% HELPER FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%% Load a file of Prolog terms into a List.
%%
file_to_list(FILE,LIST) :- 
   see(FILE), 
   inquire([],R), % gather terms from file
   rev(R,LIST),
   seen.

inquire(IN,OUT):-
   read(Data), 
   (Data == end_of_file ->   % done
      OUT = IN 
        ;    % more
      inquire([Data|IN],OUT) ) .
%%
%% Write to a file from a List
%%
write_list_to_file(Filename,List) :-
    tell(Filename),     % open file to be written 
    loop_through_list(List),
    told.               % flush buffer   

loop_through_list([]).
loop_through_list([Head|Tail]) :-
    write(Head),
    nl,
    loop_through_list(Tail).

%%
%%	Changes the query element of list to clause with a negation sign
%%	Change the head of list
%%
convert_query_to_clause([H|T],L1):-
	H=myQuery(X,Y),
	A=myClause(X,Y),
	L1=[A|T].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hw4(INPUTFILE,OUTPUTFILE):-
	file_to_list(INPUTFILE,List),
	rev(L,RevL),
	convert_query_to_clause(RevL,L1),
	rev(L1,L2),
	%%
	%%	More Work to do with L2
	%%
	write_list_to_file(OUTPUTFILE,L2).








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TEST CASES
%%%%%% [sudoku].
%%%%%% test(2,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(N) :- 
	getInput(N,INPUTFILE),
	getOutput(N,OUTPUTFILE),
	file_to_list(INPUTFILE,L), 
	rev(L,RevL),
	convert_query_to_clause(RevL,L1),
	rev(L1,L2),
	write_list_to_file(OUTPUTFILE,L2).

getInput(1,INPUTFILE):-
	INPUTFILE='/Users/sahiljain/Dropbox/SBU/Academics/Fall_15/ComputingWithLogic/Assignments/Prolog/Fourth/input.txt'.

getOutput(1,OUTPUTFILE):-
	OUTPUTFILE='/Users/sahiljain/Dropbox/SBU/Academics/Fall_15/ComputingWithLogic/Assignments/Prolog/Fourth/output.txt'.	
















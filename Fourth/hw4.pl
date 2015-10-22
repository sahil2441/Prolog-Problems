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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hw4(INPUTFILE,OUTPUTFILE):-
	file_to_list(INPUTFILE,List),
	write_list_to_file(OUTPUTFILE,List).








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TEST CASES
%%%%%% [sudoku].
%%%%%% test(2,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(N) :- 
	getInput(N,FILE),
	getOutput(N,OUTPUTFILE),
	file_to_list(FILE,L), 
	write_list_to_file(OUTPUTFILE,L).

getInput(1,FILE):-
	FILE='/Users/sahiljain/Dropbox/SBU/Academics/Fall_15/ComputingWithLogic/Assignments/Prolog/Fourth/input.txt'.

getOutput(1,OUTPUTFILE):-
	OUTPUTFILE='/Users/sahiljain/Dropbox/SBU/Academics/Fall_15/ComputingWithLogic/Assignments/Prolog/Fourth/output.txt'.	
















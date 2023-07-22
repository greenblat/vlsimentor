
Posts on speeding up verification - for example, using intelligent coverage tests generation. But will it pays off any significant speedup? ... suppose AI , in seconds, creates suite of tests that cover 100% of the design. The purpose of tests is to find bugs. It makes sense that this glorious test collection catches bugs (otherwise why bother running regression?) Now it will take hours and hours to fix those bugs. And rerun. And get fresh batch of bugs. And fix, And rerun And regenerate tests (changes in architecture?) And sleep and eat and...
Making test generation efficient may reduce 20% of effort to 1% of effort, but the bugs still snore (or take smoke breaks **) comfortably in other 80%.
I don't know the answer. But I do know, what happens when I run verification of my own designs - I get mad at myself for all the clever solutions and features that constitute my RTL. The only thing I can do is : DFD and DFV. Design-for-Debug and Design-for-Verification.
Not sure what it actually means- except: Simplicity/Simplicity/Simplicity , no tricks, never use AHB, stay away from IPs....
perhaps I need give it more thought, But am I basically wrong?

** I don't condone smoking, except that I wish bugs would choke and die. #servingTheNextBug #AdHaBugHaBa  #HattaJaJa

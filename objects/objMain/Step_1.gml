{
	//update timers (count in seconds, not frames)
	g.time += DeltaTimeSeconds();
	
	//Get real fps
	while (floor(g.time) > seconds) {
		seconds ++;
		realfps = fps_real;
	}
	
	//Fixed step update
	fixedStepOffset += DeltaTimeSeconds();
	
	while(fixedStepOffset > 1/fixedTimeStep) {
		FixedUpdate();
		fixedStepOffset -= 1/fixedTimeStep;
	}
	
	
}
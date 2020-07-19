#include "timed_execution.as"
#include "delayed_execution_job.as"

TimedExecution timer;

void Update(){
    if(GetInputPressed(0, "t")){
        timer.Add(DelayedExecutionJob(5.0f, function(){
            Log(info, "5 Second Delay (Single)");
            return false; // Stop here
        }));

        timer.Add(DelayedExecutionJob(5.0f, function(){
            Log(info, "5 Second Delay (Repeating)");
            return true; // Do it again
        }));
    }

    timer.Update();
}

void Init(string str){}

void DrawGUI(){}

void Draw(){}

bool HasFocus(){
    return false;
}
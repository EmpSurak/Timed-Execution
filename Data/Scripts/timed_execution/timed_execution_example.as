#include "timed_execution/timed_execution.as"
#include "timed_execution/simple_delayed_job.as"
#include "timed_execution/repeating_delayed_job.as"
#include "timed_execution/repeating_dynamic_delayed_job.as"

TimedExecution timer;

bool toggle = false;
float counter = 5.0f;

void Update(int is_paused){
    if(GetInputPressed(0, "t")){
        timer.Add(SimpleDelayedJob(1.0f, function(){
            Log(info, "1 Second Delay (Simple)");
        }));

        timer.Add(RepeatingDelayedJob(2.0f, function(){
            Log(info, "2 Second Delay (Boolean Repeat)");
            return (toggle = !toggle);
        }));

        timer.Add(RepeatingDynamicDelayedJob(counter, function(){
            Log(info, counter + " Second Delay (Dynamic Repeat)");
            return (counter -= 1.0f);
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
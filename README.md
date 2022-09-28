Timed Execution
===============

Event-driven scripting for [Overgrowth](https://www.wolfire.com/overgrowth).

## Example

```cpp
#include "timed_execution/timed_execution.as"
#include "timed_execution/after_init_job.as"

TimedExecution timer;

void Init(string str){
    timer.Add(AfterInitJob(function(){
        Log(info, "Execute once after initialization is finished");
    }));
}

void Update(int is_paused){
    timer.Update();
}

void ReceiveMessage(string msg){
    timer.AddLevelEvent(msg);
}

void PreScriptReload(){
    timer.DeleteAll();
}

void PostScriptReload(){
    Init("");
}
```

For the full list of job examples see [timed_execution_example.as](Data/Scripts/timed_execution/timed_execution_example.as).

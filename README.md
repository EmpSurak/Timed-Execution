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
        Log(info, "Event-driven scripting");
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

### Showcase

 * [Fever Dreams](https://steamcommunity.com/sharedfiles/filedetails/?id=2722111191)
 * [2FAST4U](https://steamcommunity.com/sharedfiles/filedetails/?id=2549924740)
 * [Stronghold](https://steamcommunity.com/sharedfiles/filedetails/?id=2265321842)
 * [Ronin](https://steamcommunity.com/sharedfiles/filedetails/?id=2245979944)
 * [Suraks Playground 2](https://steamcommunity.com/sharedfiles/filedetails/?id=2184235918)
 * [FatBoy!](https://steamcommunity.com/sharedfiles/filedetails/?id=2194617361)
 * [BigHead!](https://steamcommunity.com/sharedfiles/filedetails/?id=2198302203)
 * [Bouncy!](https://steamcommunity.com/sharedfiles/filedetails/?id=2241016679)

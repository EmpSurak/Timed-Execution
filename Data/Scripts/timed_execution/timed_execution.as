#include "timed_execution/execution_job_interface.as"

funcdef bool TIMED_EXECUTION_DELETE_SPECIFIC(ExecutionJobInterface@);

class TimedExecution {
    float time;
    array<ExecutionJobInterface@> jobs;
    array<string> events;

    TimedExecution(){}

    void Update(){
        time += time_step;
        bool expired_jobs = ExecuteExpired();
        
        if(expired_jobs){
            RemoveExpired();
        }
    }
    
    bool ExecuteExpired(){
        bool expired_jobs = false;
    
        for(uint i = 0; i < jobs.length(); i++){
            ExecutionJobInterface @job = jobs[i];

            if(job.IsExpired(time)){
                job.Execute();
                expired_jobs = true;
            }
            
            for(uint j = 0; j < events.length(); j++){
                array<string> parsed_event = ParseEvent(events[j]);
                if(job.IsEvent(parsed_event[0])){
                    job.Execute(parsed_event);
                    expired_jobs = true;
                }
            }
        }
        
        // All events were processed, so we have to clear the stack.
        events.resize(0);
        
        return expired_jobs;
    }
    
    array<string> ParseEvent(string _event){
        array<string> result;
    
        TokenIterator token_iter;
        token_iter.Init();
        while(true){
            if(!token_iter.FindNextToken(_event)){
                break;
            }
            string token = token_iter.GetToken(_event);
            result.insertLast(token);
        }
        
        return result;            
    }
    
    void RemoveExpired(){
        array<ExecutionJobInterface@> _jobs;
        
        for(uint i = 0; i < jobs.length(); i++){
            ExecutionJobInterface @job = jobs[i];

            if(!job.IsExpired(time)){
                _jobs.insertLast(job);
            }else if(job.IsRepeating()){
                job.SetStarted(time);
                _jobs.insertLast(job);
            }
        }
        
        jobs = _jobs;
    }
    
    void Add(ExecutionJobInterface &job){
        job.SetStarted(time);
        jobs.insertLast(job);
    }

    void DeleteAll(){
        jobs.resize(0);
        events.resize(0);
    }
    
    void DeleteSpecific(TIMED_EXECUTION_DELETE_SPECIFIC @_callback){
        array<ExecutionJobInterface@> _jobs;
        
        for(uint i = 0; i < jobs.length(); i++){
            ExecutionJobInterface @job = jobs[i];
            if(!_callback(job)){
                _jobs.insertLast(job);
            }
        }
        
        jobs = _jobs;
    }
    
    void AddEvent(string _event){
        events.insertLast(_event);
    }
}
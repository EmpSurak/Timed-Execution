#include "timed_execution/execution_job_interface.as"

class TimedExecution {
    float time;
    array<ExecutionJobInterface@> jobs;

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
        }
        
        return expired_jobs;
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
}

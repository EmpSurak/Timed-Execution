#include "timed_execution/basic_job_interface.as"
#include "timed_execution/timer_job_interface.as"
#include "timed_execution/event_job_interface.as"

class TimedExecution{
    float time;
    array<BasicJobInterface@> basic_jobs;
    array<TimerJobInterface@> timer_jobs;
    array<EventJobInterface@> event_jobs;
    array<string> events;

    TimedExecution(){}

    void Update(){
        time += time_step;
        ProcessBasicJobs();
        ProcessTimerJobs();
        ProcessEventJobs();
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

    void ProcessBasicJobs(){
        array<BasicJobInterface@> _jobs;
        for(uint i = 0; i < basic_jobs.length(); i++){
            BasicJobInterface @job = basic_jobs[i];
            if(job.IsExpired()){
                job.ExecuteExpired();
                if(job.IsRepeating()){
                    _jobs.insertLast(job);
                }
            }else{
                _jobs.insertLast(job);
            }
        }
        if(basic_jobs.length() != _jobs.length()){
            basic_jobs = _jobs;
        }
    }

    void ProcessTimerJobs(){
        array<TimerJobInterface@> _jobs;
        for(uint i = 0; i < timer_jobs.length(); i++){
            TimerJobInterface @job = timer_jobs[i];

            if(job.IsExpired(time)){
                job.ExecuteExpired();

                if(job.IsRepeating()){
                    job.SetStarted(time);
                    _jobs.insertLast(job);
                }
            }else{
                _jobs.insertLast(job);
            }
        }

        if(timer_jobs.length() != _jobs.length()){
            timer_jobs = _jobs;
        }
    }

    void ProcessEventJobs(){
        array<EventJobInterface@> _jobs;
        for(uint j = 0; j < event_jobs.length(); j++){
            EventJobInterface @job = event_jobs[j];
            bool has_event = false;

            for(uint i = 0; i < events.length(); i++){
                array<string> parsed_event = ParseEvent(events[i]);

                if(job.IsEvent(parsed_event)){
                    job.ExecuteEvent(parsed_event);
                    has_event = true;
                }
            }

            if(has_event){
                if(job.IsRepeating()){
                    _jobs.insertLast(job);
                }
            }else{
                _jobs.insertLast(job);
            }
        }
        if(event_jobs.length() != _jobs.length()){
            event_jobs = _jobs;
        }
        events.resize(0);
    }

    void Add(BasicJobInterface &job){
        basic_jobs.insertLast(job);
    }

    void Add(TimerJobInterface &job){
        job.SetStarted(time);
        timer_jobs.insertLast(job);
    }

    void Add(EventJobInterface &job){
        event_jobs.insertLast(job);
    }

    void DeleteAll(){
        basic_jobs.resize(0);
        timer_jobs.resize(0);
        event_jobs.resize(0);
        events.resize(0);
    }

    void AddEvent(string _event){
        events.insertLast(_event);
    }

    void AddLevelEvent(string _event){
        AddEvent("level_event " + _event);
    }
}

#include "timed_execution/execution_job_interface.as"

funcdef void AFTER_CHAR_CALLBACK(int);

class AfterCharInitJob : ExecutionJobInterface {
    AfterCharInitJob(){}

    AfterCharInitJob(int _id, AFTER_CHAR_CALLBACK @_callback){
        id = _id;
        @callback = @_callback;
    }

    int id;
    AFTER_CHAR_CALLBACK @callback;
    float started;
    
    void Execute(){
        callback(id);
    }
    
    bool IsRepeating(){
        return false;
    }
    
    bool IsExpired(float time){
        if(!MovementObjectExists(id)){
            return false;
        }
    
        MovementObject @char = ReadCharacter(id);
        return char.GetIntVar("updated") > 0;
    }
    
    void SetStarted(float time){
        started = time;
    }
    
    void Execute(array<string> _props){}
    
    bool IsEvent(string _event){
        return false;
    }
}
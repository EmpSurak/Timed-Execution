#include "timed_execution/execution_job_interface.as"

funcdef void AFTER_CHAR_CALLBACK(int);

class AfterCharInitJob : ExecutionJobInterface {
    int id;
    AFTER_CHAR_CALLBACK @callback;
    float started;

    AfterCharInitJob(){}

    AfterCharInitJob(int _id, AFTER_CHAR_CALLBACK @_callback){
        id = _id;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        callback(id);
    }
    
    void ExecuteEvent(array<string> _props){}

    bool IsExpired(float time){
        if(!MovementObjectExists(id)){
            return false;
        }
    
        MovementObject @char = ReadCharacterID(id);
        return char.GetIntVar("updated") > 0;
    }
    
    bool IsEvent(array<string> _event){
        return false;
    }
    
    bool IsRepeating(){
        return false;
    }
    
    void SetStarted(float time){
        started = time;
    }
}

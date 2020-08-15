#include "timed_execution/basic_job_interface.as"

funcdef void AFTER_CHAR_CALLBACK(MovementObject@);

class AfterCharInitJob : BasicJobInterface {
    protected int id;
    protected AFTER_CHAR_CALLBACK @callback;

    AfterCharInitJob(){}

    AfterCharInitJob(int _id, AFTER_CHAR_CALLBACK @_callback){
        id = _id;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        if(!MovementObjectExists(id)){
            return;
        }
        MovementObject @char = ReadCharacterID(id);

        callback(char);
    }

    bool IsExpired(){
        if(!MovementObjectExists(id)){
            return false;
        }
        MovementObject @char = ReadCharacterID(id);

        return char.GetIntVar("updated") > 0;
    }

    bool IsRepeating(){
        return false;
    }
}

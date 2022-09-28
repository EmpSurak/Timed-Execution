#include "timed_execution/basic_job_interface.as"

funcdef bool CHAR_DEATH_CALLBACK(MovementObject@);

class CharDeathJob : BasicJobInterface {
    protected int id;
    protected CHAR_DEATH_CALLBACK @callback;
    protected bool repeat;

    CharDeathJob(){}

    CharDeathJob(int _id, CHAR_DEATH_CALLBACK @_callback){
        id = _id;
        @callback = @_callback;
        
        MovementObject @char = ReadCharacterID(id);
    }

    void ExecuteExpired(){
        if(!MovementObjectExists(id)){
            return;
        }
        MovementObject @char = ReadCharacterID(id);

        repeat = callback(char);
    }

    bool IsExpired(){
        if(!MovementObjectExists(id)){
            return true;
        }
        MovementObject @char = ReadCharacterID(id);

        return char.GetIntVar("knocked_out") != _awake;
    }

    bool IsRepeating(){
        return repeat;
    }
}

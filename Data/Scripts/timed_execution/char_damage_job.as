#include "timed_execution/basic_job_interface.as"

funcdef bool CHAR_DAMAGE_CALLBACK(MovementObject@, float, float);

class CharDamageJob : BasicJobInterface {
    protected int id;
    protected float initial_blood_health;
    protected float initial_permanent_health;
    protected CHAR_DAMAGE_CALLBACK @callback;
    protected bool repeat;

    CharDamageJob(){}

    CharDamageJob(int _id, CHAR_DAMAGE_CALLBACK @_callback){
        id = _id;
        @callback = @_callback;
        
        MovementObject @char = ReadCharacterID(id);
        SetInitialValues(char);
    }

    void ExecuteExpired(){
        if(!MovementObjectExists(id)){
            return;
        }
        MovementObject @char = ReadCharacterID(id);

        repeat = callback(char, initial_blood_health, initial_permanent_health);
    }

    bool IsExpired(){
        if(!MovementObjectExists(id)){
            return true;
        }
        MovementObject @char = ReadCharacterID(id);

        if(initial_blood_health != char.GetFloatVar("blood_health")){
            return true;
        }
        if(initial_permanent_health != char.GetFloatVar("permanent_health")){
            return true;
        }

        return false;
    }

    bool IsRepeating(){
        if(!MovementObjectExists(id)){
            return false;
        }
        MovementObject @char = ReadCharacterID(id);

        if(repeat){
            SetInitialValues(char);
        }

        return repeat;
    }
    
    private void SetInitialValues(MovementObject @_char){
        initial_blood_health = _char.GetFloatVar("blood_health");
        initial_permanent_health = _char.GetFloatVar("permanent_health");
    }
}

#include "timed_execution/basic_job_interface.as"

funcdef bool CHAR_DAMAGE_CALLBACK(MovementObject@, float, float);

class CharDamageJob : BasicJobInterface {
    protected int char_id;
    protected float initial_blood_health;
    protected float initial_permanent_health;
    protected CHAR_DAMAGE_CALLBACK @callback;
    protected bool repeat = false;

    CharDamageJob(){}

    CharDamageJob(int _char_id, CHAR_DAMAGE_CALLBACK @_callback){
        char_id = _char_id;
        @callback = @_callback;
        if(MovementObjectExists(char_id)){
            MovementObject @char = ReadCharacterID(char_id);
            SetInitialValues(char);
        }
    }

    void ExecuteExpired(){
        if(!MovementObjectExists(char_id)){
            return;
        }
        MovementObject @char = ReadCharacterID(char_id);

        repeat = callback(char, initial_blood_health, initial_permanent_health);
    }

    bool IsExpired(){
        if(!MovementObjectExists(char_id)){
            return true;
        }
        MovementObject @char = ReadCharacterID(char_id);

        if(initial_blood_health != char.GetFloatVar("blood_health")){
            return true;
        }
        if(initial_permanent_health != char.GetFloatVar("permanent_health")){
            return true;
        }

        return false;
    }

    bool IsRepeating(){
        if(!MovementObjectExists(char_id)){
            return false;
        }
        MovementObject @char = ReadCharacterID(char_id);

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

#include "timed_execution/basic_job_interface.as"

funcdef bool CHAR_DAMAGE_CALLBACK(MovementObject@, float, float);

class CharDamageJob : BasicJobInterface {
    protected MovementObject @char;
    protected float initial_blood_health;
    protected float initial_permanent_health;
    protected CHAR_DAMAGE_CALLBACK @callback;
    protected bool repeat;

    CharDamageJob(){}

    CharDamageJob(MovementObject @_char, CHAR_DAMAGE_CALLBACK @_callback){
        @char = @_char;
        @callback = @_callback;
        SetInitialValues(_char);
    }

    void ExecuteExpired(){
        repeat = callback(char, initial_blood_health, initial_permanent_health);
    }

    bool IsExpired(){
        if(initial_blood_health != char.GetFloatVar("blood_health")){
            return true;
        }
        if(initial_permanent_health != char.GetFloatVar("permanent_health")){
            return true;
        }

        return false;
    }

    bool IsRepeating(){
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

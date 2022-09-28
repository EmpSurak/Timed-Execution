#include "timed_execution/basic_job_interface.as"

funcdef bool INPUT_DOWN_CALLBACK();

class OnInputDownJob : BasicJobInterface {
    protected int controller_id;
    protected string input_label;
    protected INPUT_DOWN_CALLBACK @callback;
    protected bool repeat = false;

    OnInputDownJob(){}

    OnInputDownJob(int _controller_id, string _input_label, INPUT_DOWN_CALLBACK @_callback){
        controller_id = _controller_id;
        input_label = _input_label;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        repeat = callback();
    }

    bool IsExpired(){
        return GetInputDown(controller_id, input_label);
    }

    bool IsRepeating(){
        return repeat;
    }
}

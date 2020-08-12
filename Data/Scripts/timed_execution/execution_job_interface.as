interface ExecutionJobInterface{
    void ExecuteExpired();
    void ExecuteEvent(array<string> _props);
    bool IsExpired(float _time);
    bool IsEvent(array<string> _event);
    bool IsRepeating();
    void SetStarted(float _time);
}

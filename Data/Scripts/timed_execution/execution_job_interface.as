interface ExecutionJobInterface{
    void Execute();
    void Execute(array<string> _props);
    bool IsExpired(float _time);
    bool IsEvent(string _event);
    bool IsRepeating();
    void SetStarted(float _time);
}
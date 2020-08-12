interface ExecutionJobInterface{
    void ExecuteExpired(); // Executed when IsExpired is true
    void ExecuteEvent(array<string> _props); // Executed when IsEvent is true
    bool IsExpired(float _time);
    bool IsEvent(array<string> _event);
    bool IsRepeating();
    void SetStarted(float _time);
}

interface EventJobInterface{
    void ExecuteEvent(array<string> _props);
    bool IsEvent(array<string> _event);
    bool IsRepeating();
}

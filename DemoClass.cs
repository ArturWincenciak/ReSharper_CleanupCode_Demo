namespace ReSharperCleanupCodeDemo;

internal class DemoClass
{
    public int PublicProperty { get; set; }

    private readonly int _privateProperty;

    public DemoClass(int privateProperty)
    {
        _privateProperty = privateProperty;
    }

    public int PublicMethod()
    {
        return _privateProperty;
    }

    private int PrivateMethod()
    {
        return _privateProperty;
    }
}
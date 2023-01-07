namespace ReSharperCleanupCodeDemo;

internal class DemoClass : IDemoInterface
{
    private int PrivateMethod()
    {
        return _privateProperty;
    }

    public string InterfaceProperty { get; set; }

    public DemoClass(int privateProperty)
    {
        _privateProperty = privateProperty;
    }

    public int PublicProperty { get; set; }

    public int PublicMethod()
    {
        return _privateProperty;
    }

    public void InterfaceMethod()
    {
        Console.WriteLine(nameof(InterfaceMethod));
    }

    private readonly int _privateProperty;
}
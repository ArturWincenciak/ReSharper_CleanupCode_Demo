namespace ReSharperCleanupCodeDemo;

internal class DemoClass : IDemoInterface
{
    private readonly int _privateProperty;
    public int PublicProperty { get; set; }

    public string InterfaceProperty { get; set; }

    public DemoClass(int privateProperty) =>
        _privateProperty = privateProperty;

    public void InterfaceMethod() =>
        Console.WriteLine(nameof(InterfaceMethod));

    public int PublicMethod() =>
        _privateProperty;

    private int PrivateMethod() =>
        _privateProperty;
}
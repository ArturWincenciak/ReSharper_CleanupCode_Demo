namespace ReSharperCleanupCodeDemo;

internal class DemoClass : IDemoInterface
{
    private readonly int _privateProperty;

    public string InterfaceProperty { get; set; }

    public int PublicProperty { get; set; }
    public int _someFoo;

    public DemoClass(int privateProperty) =>
        _privateProperty = privateProperty;

    public void InterfaceMethod() =>
        Console.WriteLine(nameof(InterfaceMethod));

    private int PrivateMethod() =>
        _privateProperty;

    public int PublicMethod() =>
        _privateProperty;
}
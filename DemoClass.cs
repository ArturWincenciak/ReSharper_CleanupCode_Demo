namespace ReSharperCleanupCodeDemo;

internal class DemoClass
{
    private const string Graham = "2G";
    private readonly int _privateProperty;
    public int PublicProperty { get; set; }

    public DemoClass(int privateProperty) =>
        _privateProperty = privateProperty;

    public int PublicMethod() =>
        _privateProperty;

    private int PrivateMethod() =>
        _privateProperty;
}
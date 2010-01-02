package mockolate
{
    import mockolate.ingredients.MockolatierMaster;
    
    /**
     * Creates an instance of the given Class that will behave as a 'nice' mock. 
     * 
     * @param klass Class to create a nice mock for.
     * @param name Name for the mock instance.
     * 
     * @example
     * <listing version="3.0">
     *  var flavour:Flavour = nice(Flavour);
     * </listing>
     */
    public function nice(klass:Class, name:String=null, constructorArgs:Array=null):*
    {
        return MockolatierMaster.nice(klass, name, constructorArgs);
    }
}

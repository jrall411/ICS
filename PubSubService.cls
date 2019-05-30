/**
 * @description A simple Pub/Sub pattern implementation
 */
public with sharing class PubSubService {
   
    public List<IHandleMessages> ImplementedClasses;
    
    private PubSubService() { 
         ImplementedClasses = new List<IHandleMessages>();
    	
    }

    /**
     * @description A singleton for service interaction.
     */
    public static PubSubService Instance {
        get {
            if (Instance == null) {
                Instance = new PubSubService();
               
            }

            return Instance;
        }

        private set;
    }

    
    private string getObjName(IHandleMessages obj)
    {
       return (String.valueof(obj).substring(0,String.valueOf(obj).indexOf(':')));
    }    
	
    
    /**
     * @description Subscribes a given IHandleMessages implementation to the channels it returns.
     * @param implementation An instance of IHandleMessages.
     * @throws ArgumentNullException if implementation is null.
     */
    public void subscribe(IHandleMessages implementation) {
        ImplementedClasses.add(implementation);
    }

    /**
     * @description Un-subscribes a given IHandleMessages implementation to the channels it returns.
     * @param implementation An instance of IHandleMessages.
     * @throws ArgumentNullException if implementation is null.
     */
    public void unsubscribe(IHandleMessages implementation) {
      	ImplementedClasses.remove(ImplementedClasses.indexOf(implementation));
    }

    /**
     * @description Emits a message to a given channel containing the specified data.
     * @param channel The channel to emit a message on.
     * @param data The data to emit.
     * @throws ArgumentNullException if channel is null.
     */
    public void emit(String channel, Object data) {
        for (IHandleMessages theHandler : ImplementedClasses)
        {
            theHandler.handleMessage(channel,data);
        }
    }
}
/**
 * @description An implementation of IHandleMessages which validates the passed in Lead and inserts it.
 */
public with sharing class IncomingLeadHandler implements IHandleMessages {
    @testVisible private static final String INCOMING_LEAD_CHANNEL = 'IncomingLeads';

   	public List<string> SubscribedChannels;
    
    /**
     * @description Constructs an instance of IncomingLeadHandler.
     */
    public IncomingLeadHandler() {
		SubscribedChannels = new List<string>();
        if (INCOMING_LEAD_CHANNEL != null)
        {
            AddChannel(INCOMING_LEAD_CHANNEL);
        }
    }

    public void AddChannel(String channel)
    {
         SubscribedChannels.add(channel);
    }

    public void RemoveChannel(String channel)
    {
        SubscribedChannels.remove(SubscribedChannels.indexOf(channel));
    }
    
    /**
     * @description Handles a message on a subscribed channel.
     * @param channel The channel emitting the message.
     * @param data The accompanying data for the message.
     * @throws ArgumentNullException if channel is null.
     * @throws ArgumentException if the lead is missing a FirstName.
     */
    public void handleMessage(String channel, Object data) {
           
            if (channel == null)
            {
                ArgumentNullException.throwIfNull(channel, INCOMING_LEAD_CHANNEL);

            }
			
            Lead newLead = (Lead)data;
            
            if (newLead.FirstName == null)
                {
                  throw new ArgumentException();
                }
            if (getSubscribedChannels().contains(channel))
            {
                {
                    newLead.Company = newLead.FirstName + ' ' + newLead.LastName; //  validation rull on org i am using
                    Lead[] leads = new List<Lead>();
                    leads.add(newLead);
                   	insert leads;
                }
            }
    }

    /**
     * @description Gets a list of channels an implementation subscribes to.
     * @return A List<String> of channel names this implementation is subscribed to.
     */
    public List<String> getSubscribedChannels() {
        //return null;
        return SubscribedChannels;
    }
}
# Bitcoin price App Project - EPIC 1
Bitcoin price display

## Stories:
Realtime price update for today  
Historical price display in EUR  
Multi-currency history bpi display for a spcific day  

## Components List:
**V**:  
MainView, TodayView, OtherdaysTableView, OtherdayTableViewCell, DetailsView  
**VC**:  
NavigationVC, MainVC, DetailsVC, Network, HistoricalBPIManager  
**M**:  
BitCoinRecord, HistoricalBPIRecord  
**Util + Helper**:  
RealtimeCoordinator, etc.  
**Third party Library**:  
ObjectMapper, Alamofire  
**Service**:  
Coindesk API  

## Development timeline:  
Alamofire + Coindesk API + ObjectMapper  
Unit test: network, util  
RealtimeCoordinator + MainView + TodayView  
Unit test: util  
Test: today bitcoin price realtime display  
OtherdaysTableView + OtherdayTableViewCell  
Test: history bitcoin price display  
DetailsView, HistoricalBPIManager  
Test: detailsView other ther currencies display  
Test: ServiceError  


# Bitcoin price App Project - EPIC 2
Some native features

## Stories:
Historical price can be viewed as a chart
Historical price can be viewed offline once it's been downloaded
Introduce paging for Historical price display
There should be more details about Bitcoin if user left swipe a cell swipe to see more
There should be a tutorial for swipe to see more

## Components List:
**V**:  
**VC**:  
**M**:  
**Util + Helper**:  
**Third party Library**:  
**Service**:  

## Development timeline:  


# Bitcoin price App Project - EPIC 3
Monitor Ethereum as well


# Bitcoin price App Project - EPIC 4
Siri integration

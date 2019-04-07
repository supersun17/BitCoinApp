# Bitcoin price App Project

Due to the simplicity of this project, MVC is chosen to be the architecture.  

## Core features:
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


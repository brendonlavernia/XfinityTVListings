# XFinityTV Listings App

## Assumptions
### User Experience
- There was a ton of data available in the XFinityTV API, but I chose to focus on episode specific information for the programs listed. 
- This app only shows the episodes available on XFinityTV. It does not link to them. 

### Data
- Assumed there would be a network name, show name, and episode name for each item in the JSON object. 
- Provided a little flexibility if no image was available by drawing a placeholder image. 

## Improvements
### Code Improvements
- AFNetworking: I have heard that this framework handles more edge cases and allows for more flexibility without having to reinvent the wheel. I would replace all of the calls to NSURLConnection with this framework. 
- String Literals: Literals are littered throughout my code. I would move these to constant files (i.e. XFYTVJSONConstants) to allow for easier updating.
- Refactoring the processing of JSON data into model data. 
- Organize files into MVC folders. 

### Documentation Improvements
- I focused on the MVP here, so there is absolutely no documentation. I wouldn't ship without at least class description comments. 

### Layout Improvements
- This experience is optimized for the iPhone. Ideally, there would be an unique view for the iPad in landscape mode that would display episode details to the right of the UITableView. 
- Include a small thumbnail of the show in the Listing UITableView cells. 
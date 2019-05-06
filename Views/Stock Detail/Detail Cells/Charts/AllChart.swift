//
//  CustomUnitsExample.swift
//  SwiftCharts
//
//  Created by ischuetz on 05/05/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit
import SwiftCharts

class AllChart: UIViewController {
    var symbol : String?
    var range : Int?
    var weekhigh : Float = 15.0
    var weeklow : Float = 1.0
    
    var chartdetails = [ChartDetailsMore]()
    fileprivate var chart: Chart? // arc
    var chartPoints = [ChartPoint]()
    var chartPoints2 = [ChartPoint]()
    var xValues = [ChartAxisValue]()
    var yValues = [ChartAxisValue]()
    let temppoints: [ChartPoint] = [(1, 1)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ChartDetailsMore.allChart(range: range!, symbol: symbol!, completionHandler: { (chartdetails,error)  in
            if let error = error {
                // got an error in getting the data
                print(error)
                return
            }
            guard let temp = chartdetails else {
                print("error getting all todos: result is nil")
                return
            }
            self.chartdetails = temp
            self.chartsetup()
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        self.displayChart()
    }
    func displayChart() {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        var readFormatter = DateFormatter()
        readFormatter.dateFormat = "yyyy-MM-dd"
        
        var displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = {(str: String) -> Date in
            return readFormatter.date(from: str)!
        }
        
        let calendar = Calendar.current
        
        let dateWithComponents = {(year: Int, month: Int, day: Int) -> Date in
            var components = DateComponents()
            components.year = year
            components.month = month
            components.day = day
            return calendar.date(from: components)!
        }
        
        func filler(_ date: Date) -> ChartAxisValueDate {
            let filler = ChartAxisValueDate(date: date, formatter: displayFormatter)
            filler.hidden = true
            return filler
        }
        
        if (chartPoints.isEmpty) {
            chartPoints.append(createChartPoint(dateStr: "1010-10-10", percent: 0, readFormatter: readFormatter, displayFormatter: displayFormatter))
        }
        if (chartPoints2.isEmpty) {
            chartPoints2.append(createChartPoint(dateStr: "1010-10-10", percent: 0, readFormatter: readFormatter, displayFormatter: displayFormatter))
        }
        if (xValues.isEmpty) {
            xValues.append(createDateAxisValue("1010-10-10", readFormatter: readFormatter, displayFormatter: displayFormatter))
        }
        
        yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints2, minSegmentCount: 1, maxSegmentCount: 500, multiple: Double((weekhigh-weeklow)/10), axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Date", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Highs (red) Lows (blue)", settings: labelSettings.defaultVertical()))
        let chartFrame = ExamplesDefaults.chartFrame(view.bounds)
        var chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        chartSettings.trailing = 80
        
        // Set a fixed (horizontal) scrollable area 2x than the original width, with zooming disabled.
        chartSettings.zoomPan.maxZoomX = 2
        chartSettings.zoomPan.minZoomX = 2
        chartSettings.zoomPan.minZoomY = 1
        chartSettings.zoomPan.maxZoomY = 1
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.red, lineWidth: 2, animDuration: 1, animDelay: 0)
        let lineModel2 = ChartLineModel(chartPoints: chartPoints2, lineColor: UIColor.blue, lineWidth: 2, animDuration: 1, animDelay: 0)
        
        // delayInit parameter is needed by some layers for initial zoom level to work correctly. Setting it to true allows to trigger drawing of layer manually (in this case, after the chart is initialized). This obviously needs improvement. For now it's necessary.
        let thumbSettings = ChartPointsLineTrackerLayerThumbSettings(thumbSize: Env.iPad ? 20 : 10, thumbBorderWidth: Env.iPad ? 4 : 2)
        let trackerLayerSettings = ChartPointsLineTrackerLayerSettings(thumbSettings: thumbSettings)
        var currentPositionLabels: [UILabel] = []
        
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel,lineModel2], delayInit: true)
        
        let guidelinesLayerSettings = ChartGuideLinesLayerSettings(linesColor: UIColor.black, linesWidth: 0.3)
        let guidelinesLayer = ChartGuideLinesLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: guidelinesLayerSettings)
        
        let chartPointsTrackerLayer = ChartPointsLineTrackerLayer<ChartPoint, Any>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lines: [chartPoints, chartPoints2], lineColor: UIColor.black, animDuration: 1, animDelay: 2, settings: trackerLayerSettings) {chartPointsWithScreenLoc in
            
            currentPositionLabels.forEach{$0.removeFromSuperview()}
            
            for (index, chartPointWithScreenLoc) in chartPointsWithScreenLoc.enumerated() {
                
                let label = UILabel()
                label.text = chartPointWithScreenLoc.chartPoint.description
                label.sizeToFit()
                label.center = CGPoint(x: chartPointWithScreenLoc.screenLoc.x + label.frame.width / 2, y: chartPointWithScreenLoc.screenLoc.y + chartFrame.minY - label.frame.height / 2)
                
                label.backgroundColor = index == 0 ? UIColor.red : UIColor.blue
                label.textColor = UIColor.white
                
                currentPositionLabels.append(label)
                self.view.addSubview(label)
            }
        }
        //let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        //let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLineLayer,
                chartPointsTrackerLayer
            ]
        )
        view.addSubview(chart.view)
        
        
        // Set scrollable area 2x than the original width, with zooming enabled. This can also be combined with e.g. minZoomX to allow only larger zooming levels.
        //        chart.zoom(scaleX: 2, scaleY: 1, centerX: 0, centerY: 0)
        
        // Now that the chart is zoomed (either with minZoom setting or programmatic zooming), trigger drawing of the line layer. Important: This requires delayInit paramter in line layer to be set to true.
        chartPointsLineLayer.initScreenLines(chart)
        
        
        self.chart = chart
    }
    func createChartPoint(dateStr: String, percent: Double, readFormatter: DateFormatter, displayFormatter: DateFormatter) -> ChartPoint {
        return ChartPoint(x: createDateAxisValue(dateStr, readFormatter: readFormatter, displayFormatter: displayFormatter), y: ChartAxisValuePercent(percent))
    }
    
    func createDateAxisValue(_ dateStr: String, readFormatter: DateFormatter, displayFormatter: DateFormatter) -> ChartAxisValue {
        let date = readFormatter.date(from: dateStr)!
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont, rotation: 45, rotationKeep: .top)
        return ChartAxisValueDate(date: date, formatter: displayFormatter, labelSettings: labelSettings)
    }
    
    func chartsetup() {
        let readFormatter = DateFormatter()
        readFormatter.dateFormat = "yyyy-MM-dd"
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy-MM-dd"
        var num = 0
        for counter in chartdetails {
            if (counter.high != -1) {
                chartPoints.append(createChartPoint(dateStr: counter.date, percent: Double(counter.high), readFormatter: readFormatter, displayFormatter: displayFormatter))
            }
            if (counter.low != -1) {
                chartPoints2.append(createChartPoint(dateStr: counter.date, percent: Double(counter.low), readFormatter: readFormatter, displayFormatter: displayFormatter))
            }
            switch(range!){
            case 1: //1 month
                if ((num%3) == 0) {
                    xValues.append(createDateAxisValue(counter.date, readFormatter: readFormatter, displayFormatter: displayFormatter))
                }
            case 2: //3 month
                if ((num%4) == 0) {
                    xValues.append(createDateAxisValue(counter.date, readFormatter: readFormatter, displayFormatter: displayFormatter))
                }
            case 3: //6 month
                if ((num%10) == 0) {
                    xValues.append(createDateAxisValue(counter.date, readFormatter: readFormatter, displayFormatter: displayFormatter))
                }
            case 4: //year to day
                if ((num%18) == 0) {
                    xValues.append(createDateAxisValue(counter.date, readFormatter: readFormatter, displayFormatter: displayFormatter))
                }
            case 5: //1 year
                if ((num%18) == 0) {
                    xValues.append(createDateAxisValue(counter.date, readFormatter: readFormatter, displayFormatter: displayFormatter))
                }
            case 6: //2 year
                if ((num%36) == 0) {
                    xValues.append(createDateAxisValue(counter.date, readFormatter: readFormatter, displayFormatter: displayFormatter))
                }
            case 7: //5 year
                if ((num%90) == 0) {
                    xValues.append(createDateAxisValue(counter.date, readFormatter: readFormatter, displayFormatter: displayFormatter))
                }
            default:
                print("all chart default")
                if ((num%5) == 0) {
                    xValues.append(createDateAxisValue(counter.date, readFormatter: readFormatter, displayFormatter: displayFormatter))
                }
            }
            
            num+=1
        }
        if (chartPoints.isEmpty) {
            chartPoints = temppoints
        }
        if (chartPoints2.isEmpty) {
            chartPoints2 = temppoints
        }
    }
    class ChartAxisValuePercent: ChartAxisValueDouble {
        override var description: String {
            return "\(formatter.string(from: NSNumber(value: scalar))!)"
        }
    }
}


//
//  CustomUnitsExample.swift
//  SwiftCharts
//
//  Created by ischuetz on 05/05/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit
import SwiftCharts

class Day1Chart: UIViewController {
    var symbol : String?
    var range : Int?
    var weekhigh : Float = 15.0
    var weeklow : Float = 1.0
    var chartdetails = [ChartDetails]()
    fileprivate var chart: Chart? // arc
    var chartPoints = [ChartPoint]()
    var chartPoints2 = [ChartPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ChartDetails.allChart(range: range!, symbol: symbol!, completionHandler: { (chartdetails,error)  in
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
            self.day1setup()
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        self.displayChart()
    }
    func displayChart() {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        var readFormatter = DateFormatter()
        readFormatter.dateFormat = "HH:mm"
        
        var displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "HH:mm"
        
        let date = {(str: String) -> Date in
            return readFormatter.date(from: str)!
        }
        
        let calendar = Calendar.current
        
        let dateWithComponents = {(hour: Int, minute: Int) -> Date in
            var components = DateComponents()
            components.hour = hour
            components.minute = minute
            return calendar.date(from: components)!
        }
        
        func filler(_ date: Date) -> ChartAxisValueDate {
            let filler = ChartAxisValueDate(date: date, formatter: displayFormatter)
            filler.hidden = true
            return filler
        }
        if (chartPoints.isEmpty) {
            chartPoints.append(createChartPoint(dateStr: "9:30", percent: 1.0, readFormatter: readFormatter, displayFormatter: displayFormatter))
        }
        if (chartPoints2.isEmpty) {
            chartPoints2.append(createChartPoint(dateStr: "9:30", percent: 1.0, readFormatter: readFormatter, displayFormatter: displayFormatter))
        }
        
        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 1, maxSegmentCount: 100, multiple: Double((weekhigh-weeklow)/20), axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
        let xValues = [
            createDateAxisValue("9:30", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("10:00", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("10:30", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("11:00", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("11:30", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("12:00", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("12:30", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("13:00", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("13:30", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("14:00", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("14:30", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("15:00", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("15:30", readFormatter: readFormatter, displayFormatter: displayFormatter),
            createDateAxisValue("16:00", readFormatter: readFormatter, displayFormatter: displayFormatter)
        ]
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Minutes", settings: labelSettings))
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
    
    func day1setup() {
        for counter in chartdetails {
            let readFormatter = DateFormatter()
            readFormatter.dateFormat = "HH:mm"
            
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "HH:mm"
            if (counter.high != -1) {
            chartPoints.append(createChartPoint(dateStr: counter.minute, percent: Double(counter.high), readFormatter: readFormatter, displayFormatter: displayFormatter))
            }
            if (counter.low != -1) {
                chartPoints2.append(createChartPoint(dateStr: counter.minute, percent: Double(counter.low), readFormatter: readFormatter, displayFormatter: displayFormatter))
            }
        }
    }
    class ChartAxisValuePercent: ChartAxisValueDouble {
        override var description: String {
            return "\(formatter.string(from: NSNumber(value: scalar))!)"
        }
    }
}


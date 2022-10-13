import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ReportViewModel extends BaseViewModel{


  ReportViewModel(){}




  getBarData(){

  }
}

class ChartData {
        ChartData(this.x, this.y, this.color);
        final String x;
        final double y;
        final Color color;
    }
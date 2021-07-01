using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace MRPApp.View.Report
{
    /// <summary>
    /// MyAccount.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class ReportView : Page
    {
        public ReportView()
        {
            InitializeComponent();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                InitControls();
                // DisplayChart();
            }
            catch (Exception ex)
            {
                Commons.LOGGER.Error($"예외발생 MyAccount Loaded : {ex}");
                throw ex;
            }
        }

        private void DisplayChart()
        {
            double[] ys1 = new double[] { 10.4, 34.6, 22.1, 15.4, 40.0 };
            double[] ys2 = new double[] { 9.7, 8.3, 2.6, 3.4, 7.7 };

            var series1 = new LiveCharts.Wpf.ColumnSeries
            {
                Title = "First Val",
                Values = new LiveCharts.ChartValues<double>(ys1)
            };
            var series2 = new LiveCharts.Wpf.ColumnSeries
            {
                Title = "Second Val",
                Values = new LiveCharts.ChartValues<double>(ys2)
            };

            // 차트 할당
            ChtReport.Series.Clear(); // 초기화(지우기)
            ChtReport.Series.Add(series1);
            ChtReport.Series.Add(series2);

        }

        private void InitControls()
        {
            DtpSearchStartDate.SelectedDate = DateTime.Now.AddDays(-7);
            DtpSearchEndDate.SelectedDate = DateTime.Now;
        }

        private void BtnEditMyAccount_Click(object sender, RoutedEventArgs e)
        {
            // NavigationService.Navigate(new EditAccount()); // 계정정보 수정 화면으로 변경
        }

        private void BtnSearch_Click(object sender, RoutedEventArgs e)
        {
            if (IsValidInputs())
            {
                var startDate = ((DateTime)DtpSearchStartDate.SelectedDate).ToString("yyyy-MM-dd");
                var endDate = ((DateTime)DtpSearchEndDate.SelectedDate).ToString("yyyy-MM-dd");
                var searchResult = Logic.DataAccess.GetReportDatas(startDate, endDate, Commons.PLANTCODE);

                DisplayChart(searchResult);
            }
        }

        private void DisplayChart(List<Model.Report> list)
        {
            int[] schAmount = list.Select(a => (int)a.SchAmount).ToArray();
            int[] prcOkAmounts = list.Select(a => (int)a.PrcOKAmount).ToArray();
            int[] prcFailAmounts = list.Select(a => (int)a.PrcFailAmount).ToArray();

            var series1 = new LiveCharts.Wpf.ColumnSeries
            {
                Title = "계획수량",
                Fill = new SolidColorBrush(Colors.BurlyWood),
                Values = new LiveCharts.ChartValues<int>(schAmount)
            };
            var series2 = new LiveCharts.Wpf.ColumnSeries
            {
                Title = "성공수량",
                Fill = new SolidColorBrush(Colors.Blue),
                Values = new LiveCharts.ChartValues<int>(prcOkAmounts)
            };
            var series3 = new LiveCharts.Wpf.ColumnSeries
            {
                Title = "실패수량",
                Fill = new SolidColorBrush(Colors.Red),
                Values = new LiveCharts.ChartValues<int>(prcFailAmounts)
            };
            // 차트 할당
            ChtReport.Series.Clear(); // 초기화(지우기)
            ChtReport.Series.Add(series1);
            ChtReport.Series.Add(series2);
            ChtReport.Series.Add(series3);
            // X축 레이블 달기 (해당 날짜)
            ChtReport.AxisX.First().Labels = list.Select(a => a.PrcDate.ToString("yyyy-MM-dd")).ToList();
        }

        private bool IsValidInputs()
        {
            var result = true;

            // 날짜 검증 (날짜가 빠져 있거나, StartDate가 EndDate보다 최신이면 검색하면 안됨)
            if (DtpSearchStartDate.SelectedDate == null || DtpSearchEndDate.SelectedDate == null)
            {
                Commons.ShowMessageAsync("검색", "검색할 일자를 선택하세요.");
                result = false;
            }

            if(DtpSearchStartDate.SelectedDate > DtpSearchEndDate.SelectedDate)
            {
                Commons.ShowMessageAsync("검색", "시작 일자가 종료 일자보다 최신일 수 없습니다.");
                // return false;
            }

            return result;
        }
    }
}

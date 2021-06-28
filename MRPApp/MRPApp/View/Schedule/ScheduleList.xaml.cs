using iTextSharp.text;
using iTextSharp.text.pdf;
using Microsoft.Win32;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace MRPApp.View.Schedule
{
    /// <summary>
    /// MyAccount.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class ScheduleList : Page
    {
        public ScheduleList()
        {
            InitializeComponent();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                LoadControlData(); // 콤보박스 데이터 로딩
                LoadGridData(); // 테이블 그리드 표시
                InitErrorMessages();

                /*
                // Store 테이블 데이터 읽어와야 함
                List<Model.Store> stores = new List<Model.Store>();
                List<Model.StockStore> stockStores = new List<Model.StockStore>();
                stores = Logic.DataAccess.GetStores(); // 수영1 ...

                // TODO : stores 데이터를 stockStores로 복사
                foreach (Model.Store item in stores)
                {
                    var store = new Model.StockStore()
                    {
                        StoreID = item.StoreID,
                        StoreName = item.StoreName,
                        StoreLocation = item.StoreLocation,
                        ItemStatus = item.ItemStatus,
                        TagID = item.TagID,
                        BarcodeID = item.BarcodeID,
                        StockQuantity = 0
                    };
                    // 
                    store.StockQuantity = Logic.DataAccess.GetStocks().Where(t => t.StoreID.Equals(store.StoreID)).Count();

                    stockStores.Add(store);
                }

                this.DataContext = stockStores;*/
            }
            catch (Exception ex)
            {
                Commons.LOGGER.Error($"예외발생 StoreList Loaded : {ex}");
                throw ex;
            }
        }

        private void LoadControlData()
        {
            // 콤보 박스 바인딩 방법 1. 받아온 리스트에서 SELECT로 추출
            // var plantCodes = Logic.DataAccess.GetSettings().Where(c => c.BasicCode.Contains("PC01")).ToList();
            // CboPlantCode.ItemsSource = plantCodes.Select(c => c.CodeName).ToList();

            var plantCodes = Logic.DataAccess.GetSettings().Where(c => c.BasicCode.Contains("PC01")).ToList();
            CboPlantCode.ItemsSource = plantCodes;
            CboGrdPlantCode.ItemsSource = plantCodes;

            // 콤보 박스 바인딩 방법 2. 받아온 리스트에서 xaml 내부 바인딩 설정
            var facilityIds = Logic.DataAccess.GetSettings().Where(c => c.BasicCode.Contains("FAC1")).ToList();
            CboSchFacilityID.ItemsSource = facilityIds;
        }

        private void InitErrorMessages()
        {
            // LblBasicCode.Visibility = LblCodeName.Visibility = LblCodeDesc.Visibility = Visibility.Hidden;
            LblPlantCode.Visibility = LblSchDate.Visibility = LblSchEndTime.Visibility = LblSchLoadTime.Visibility =
                LblSchStartTime.Visibility = LblSchAmount.Visibility = LblSchFacilityID.Visibility = Visibility.Hidden;
        }

        private void LoadGridData()
        {
            List<Model.Schedules> schedules = Logic.DataAccess.GetSchedules();
            this.DataContext = schedules;
        }

        private void BtnEditUser_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                //NavigationService.Navigate(new EditUser());
            }
            catch (Exception ex)
            {
                Commons.LOGGER.Error($"예외발생 BtnEditUser_Click : {ex}");
                throw ex;
            }
        }

        private void BtnAddStore_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // NavigationService.Navigate(new AddStore());
            }
            catch (Exception ex)
            {
                Commons.LOGGER.Error($"예외발생 BtnAddStore_Click : {ex}");
                throw ex;
            }
        }

        private void BtnNew_Click(object sender, RoutedEventArgs e)
        {
            ClearInputs();
        }

        private async void BtnInsert_Click(object sender, RoutedEventArgs e)
        {
            if (!IsValidInputs())
                return;

            var schedule = new Model.Schedules();

            schedule.PlantCode = CboPlantCode.SelectedValue.ToString();
            schedule.SchDate = DateTime.Parse(DtpSchDate.Text);
            schedule.SchLoadTime = int.Parse(TxtSchLoadTime.Text);
            if (TmpSchStartTime.SelectedDateTime != null)
                schedule.SchStartTime = TmpSchStartTime.SelectedDateTime.Value.TimeOfDay;
            if (TmpSchEndTime.SelectedDateTime != null)
                schedule.SchEndTime = TmpSchEndTime.SelectedDateTime.Value.TimeOfDay;
            schedule.SchFacilityID = CboSchFacilityID.SelectedValue.ToString();
            schedule.SchAmount = (int)NudSchAmount.Value;

            schedule.RegDate = DateTime.Now;
            schedule.RegID = "MRP";

            try
            {
                int result = Logic.DataAccess.SetSchedules(schedule);
                if (result == 0)
                {
                    Commons.LOGGER.Error("데이터 입력 시 오류 발생");
                    await Commons.ShowMessageAsync("오류", "데이터 입력 실패");
                }
                else
                {
                    Commons.LOGGER.Info($"데이터 입력 성공 : {schedule.SchIdx}");
                    ClearInputs();
                    LoadGridData();
                }
            }
            catch (Exception ex)
            {
                Commons.LOGGER.Error($"예외 발생 {ex.Message}");
            }
        }

        // 입력 데이터 검증 메서드
        public bool IsValidInputs()
        {
            var isValid = true;
            InitErrorMessages();

            if(CboPlantCode.SelectedValue == null)
            {
                LblPlantCode.Visibility = Visibility.Visible;
                LblPlantCode.Text = "공장을 선택하세요";
                isValid = false;
                return isValid;
            }

            if(string.IsNullOrEmpty(DtpSchDate.Text))
            {
                LblSchDate.Visibility = Visibility.Visible;
                LblSchDate.Text = "공정일을 입력하세요";
                isValid = false;
                return isValid;
            }

            // 공장별로 공정일일 DB값이 있으면 입력되면 안됨
            // PC01001 (수원) 2021-06-24

            var result = Logic.DataAccess.GetSchedules().Where(s => s.PlantCode.Equals(CboPlantCode.SelectedValue.ToString())).Where
                (d => d.SchDate.Equals(DateTime.Parse(DtpSchDate.Text))).Count();

            if (result > 0)
            {
                LblSchDate.Visibility = Visibility.Visible;
                LblSchDate.Text = "해당 공장 공정일에 계획이 이미 있습니다.";
                isValid = false;
            }

            if(string.IsNullOrEmpty(TxtSchLoadTime.Text))
            {
                LblSchLoadTime.Visibility = Visibility.Visible;
                LblSchLoadTime.Text = "로드타임를 선택하세요";
            }

            if (TmpSchStartTime.SelectedDateTime is null)
            {
                LblSchStartTime.Visibility = Visibility.Visible;
                LblSchStartTime.Text = "시작시간을 입력하세요";
                isValid = false;
            }

            if (TmpSchEndTime.SelectedDateTime is null)
            {
                LblSchEndTime.Visibility = Visibility.Visible;
                LblSchEndTime.Text = "종료시간을 입력하세요";
                isValid = false;
            }

            if (CboSchFacilityID.SelectedValue == null)
            {
                LblSchFacilityID.Visibility = Visibility.Visible;
                LblSchFacilityID.Text = "공장설비를 선택하세요";
                isValid = false;
                return isValid;
            }

            if ((int) NudSchAmount.Value < 0)
            {
                LblSchAmount.Visibility = Visibility.Visible;
                LblSchAmount.Text = "계획수량을 입력하세요";
                isValid = false;
            }

            /*
            if (string.IsNullOrEmpty(TxtBasicCode.Text))
            {
                LblBasicCode.Visibility = Visibility.Visible;
                LblBasicCode.Text = "코드를 입력하세요.";
                isValid = false;
            }
            else if(Logic.DataAccess.GetSettings().Where(s => s.BasicCode.Equals(TxtBasicCode.Text)).Count() > 0)
            {
                LblBasicCode.Visibility = Visibility.Visible;
                LblBasicCode.Text = "중복 코드가 존재합니다.";
                isValid = false;
            }

            if (string.IsNullOrEmpty(TxtCodeName.Text))
            {
                LblCodeName.Visibility = Visibility.Visible;
                LblCodeName.Text = "코드명을 입력하세요.";
                isValid = false;
            }
            */
            return isValid;
        }

        private async void BtnUpdate_Click(object sender, RoutedEventArgs e)
        {
            var schedule = GrdData.SelectedItem as Model.Schedules;
            if (schedule is null || CboPlantCode.SelectedValue is null || CboSchFacilityID.SelectedValue is null)
            {
                await Commons.ShowMessageAsync("수정 오류", "데이터를 선택하세요.");
                return;
            }

            var result2 = Logic.DataAccess.GetSchedules().Where(s => s.PlantCode.Equals(CboPlantCode.SelectedValue.ToString()) && s.SchIdx != schedule.SchIdx).Where
                (d => d.SchDate.Equals(DateTime.Parse(DtpSchDate.Text))).Count();

            if (result2 > 0)
            {
                LblSchDate.Visibility = Visibility.Visible;
                LblSchDate.Text = "해당 공장 공정일에 계획이 이미 있습니다.";
                return;
            }

            schedule.PlantCode = CboPlantCode.SelectedValue.ToString();
            schedule.SchDate = DateTime.Parse(DtpSchDate.Text);
            schedule.SchLoadTime = int.Parse(TxtSchLoadTime.Text);
            schedule.SchStartTime = TmpSchStartTime.SelectedDateTime.Value.TimeOfDay;
            schedule.SchEndTime = TmpSchEndTime.SelectedDateTime.Value.TimeOfDay;
            schedule.SchFacilityID = CboSchFacilityID.SelectedValue.ToString();
            schedule.SchAmount = (int) NudSchAmount.Value;

            schedule.ModDate = DateTime.Now;
            schedule.ModID = "MRP";

            try
            {
                int result = Logic.DataAccess.SetSchedules(schedule);
                if(result == 0)
                {
                    Commons.LOGGER.Error("데이터 수정 시 오류 발생");
                    await Commons.ShowMessageAsync("오류", "데이터 수정 실패");
                }
                else
                {
                    Commons.LOGGER.Info($"데이터 수정 성공 : {schedule.SchIdx}");
                    ClearInputs();
                    LoadGridData();
                }
            }
            catch(Exception ex)
            {
                Commons.LOGGER.Error($"예외 발생 {ex.Message}");
            }
        }

        private void ClearInputs()
        {
            TxtSchIdx.Text = "";

            CboPlantCode.SelectedItem = null;
            CboPlantCode.Focus();

            DtpSchDate.Text = "";
            TxtSchLoadTime.Text = "";

            TmpSchStartTime.SelectedDateTime = null;
            TmpSchEndTime.SelectedDateTime = null;
            CboSchFacilityID.SelectedItem = null;

            NudSchAmount.Value = 0;
        }

        private void BtnSearch_Click(object sender, RoutedEventArgs e)
        {
            // 다시 쿼리에 질의하여 검색 (Bad)
            var search = DtpSearchDate.Text;
            /*
            var schedules = Logic.DataAccess.GetSchedules().Where(s => s.SchDate.ToString("yyyy-MM-dd").Equals(search.Trim())).ToList();
            this.DataContext = schedules;
            */

            // 이미 받아온 값들을 재활용 & 검색 (Good)
            for (int i = 0; i < GrdData.Items.Count; ++i)
            {
                DataGridRow row = (DataGridRow) GrdData.ItemContainerGenerator
                                                           .ContainerFromIndex(i);
                
                string str = ((Model.Schedules) row.Item).SchDate.ToString("yyyy-MM-dd");

                if (!str.Equals(search.Trim()))
                    row.Visibility = Visibility.Collapsed;
                else
                    row.Visibility = Visibility.Visible;
            }
        }

        private void GrdData_SelectedCellsChanged(object sender, SelectedCellsChangedEventArgs e)
        {
            try
            {
                /*
                var setting = GrdData.SelectedItem as Model.Settings;
                TxtBasicCode.Text = setting.BasicCode;
                TxtBasicCode.IsReadOnly = true;
                TxtBasicCode.Background = new SolidColorBrush(Colors.LightGray);

                TxtCodeName.Text = setting.CodeName;
                TxtCodeDesc.Text = setting.CodeDesc;
                */
                var item = GrdData.SelectedItem as Model.Schedules;
                TxtSchIdx.Text = item.SchIdx.ToString();
                CboPlantCode.SelectedValue = item.PlantCode;
                DtpSchDate.Text = item.SchDate.ToString();
                TxtSchLoadTime.Text = item.SchLoadTime.ToString();
                TmpSchStartTime.SelectedDateTime = new DateTime(item.SchStartTime.Value.Ticks); // == new DateTime() + item.SchStartTime;
                TmpSchEndTime.SelectedDateTime = new DateTime(item.SchEndTime.Value.Ticks);
                CboSchFacilityID.SelectedValue = item.SchFacilityID;
                NudSchAmount.Value = item.SchAmount;
            }
            catch(Exception ex)
            {
                Commons.LOGGER.Error($"예외발생 {ex.Message}");
                ClearInputs();
            }
        }

        private async void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            var setting = GrdData.SelectedItem as Model.Settings;
            if (setting is null)
            {
                await Commons.ShowMessageAsync("삭제 오류", "데이터를 선택하세요.");
                return;
            }

            try
            {
                int result = Logic.DataAccess.DelSettings(setting);
                if (result == 0)
                {
                    Commons.LOGGER.Error("데이터 삭제 시 오류 발생");
                    await Commons.ShowMessageAsync("오류", "데이터 삭제 실패");
                }
                else
                {
                    Commons.LOGGER.Info($"데이터 삭제 성공 : {setting.BasicCode}");
                    ClearInputs();
                    LoadGridData();
                }
            }
            catch (Exception ex)
            {
                Commons.LOGGER.Error($"예외 발생 {ex.Message}");
            }
        }
    }
}

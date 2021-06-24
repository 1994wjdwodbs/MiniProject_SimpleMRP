using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using uPLibrary.Networking.M2Mqtt;
using uPLibrary.Networking.M2Mqtt.Messages;

namespace DeviceSubApp
{
    public partial class FrmMain : Form
    {
        MqttClient client;
        string connectionString; // DB 연결 문자열 | MQTT Broker Address
        ulong lineCount = 0;

        delegate void UpdateTextCallback(string message); // 스레드 상에서 윈폼 RichTextBox에 Text를 출력할 때 필요

        Stopwatch sw = new Stopwatch(); // 스탑워치

        List<Dictionary<string, string>> iotData = new List<Dictionary<string, string>>();

        public FrmMain()
        {
            InitializeComponent();
            InitializeAllData();
        }

        private void InitializeAllData()
        {
            // Data Source = 210.119.12.78; Initial Catalog = MRP; Persist Security Info = True; User ID = sa
            connectionString = "Data Source=" + TxtConnectionString.Text + ";Initial Catalog = MRP; Persist Security Info = True; " +
                "User ID=sa;Password=mssql_p@ssw0rd!";
            lineCount = 0;
            BtnConnect.Enabled = true;
            BtnDisconnect.Enabled = false;

            IPAddress BrokerAddress;

            try
            {
                // MQTT 연결
                BrokerAddress = IPAddress.Parse(TxtConnectionString.Text);
                client = new MqttClient(BrokerAddress);

                client.MqttMsgPublishReceived += Client_MqttMsgPublishReceived; // 대리자 함수 추가
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }

            Timer.Enabled = true;
            Timer.Interval = 1000; // 1000ms
            Timer.Tick += Timer_Tick;
        }

        private void Timer_Tick(object sender, EventArgs e)
        {
            LblResult.Text = sw.Elapsed.Seconds.ToString();

            if(sw.Elapsed.Seconds >= 3)
            {
                sw.Stop();
                sw.Reset();
                // TODO
                // UpdateText("처리!!");
                PrcCorrectDataToDB();
                // ClearData()
            }

        }

        // 최종 데이터만 DB에 입력처리 메서드
        private void PrcCorrectDataToDB()
        {
            if(iotData.Count > 0)
            {
                var correctData = iotData[iotData.Count - 1];
                // DB에 입력
                // ...
                // UpdateText("DB처리");
                using (var conn = new SqlConnection(connectionString))
                {
                    string strUpQry = $"UPDATE Process_DEV " +
                                       $"SET PrcEndTime = '{DateTime.Now.ToString("HH:mm:ss")}' " +
                                          $", PrcResult = '{((correctData["prc_msg"] == "OK") ? 1 : 0)}' " + 
                                          $", ModDate = '{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}' " + 
                                          $", ModID = '{"SYS"}' " + 
                                       $"WHERE PrcIdx = (SELECT TOP 1 PrcIdx FROM Process_DEV ORDER BY PrcIdx DESC)";

                    try
                    {
                        conn.Open();
                        SqlCommand cmd = new SqlCommand(strUpQry, conn);

                        if (cmd.ExecuteNonQuery() == 1)
                            UpdateText("[DB] 센싱값 Update 성공");
                        else
                            UpdateText("[DB] 센싱값 Update 실패");
                    }
                    catch (Exception ex)
                    {
                        UpdateText($">>>>>> DB ERROR !! : {ex.Message}\n");
                    }
                }
            }

            iotData.Clear(); // 데이터 모두 삭제
        }

        private void Client_MqttMsgPublishReceived(object sender, MqttMsgPublishEventArgs e)
        {
            try
            {
                var message = Encoding.UTF8.GetString(e.Message);
                UpdateText($">>>>>> Received Message : {message}\n");
                // message(json) -> C# string
                Dictionary<string, string> currentData = JsonConvert.DeserializeObject<Dictionary<string, string>>(message);

                PrcInputDataToList(currentData);

                // 스탑워치 초기화
                sw.Stop(); 
                sw.Reset();
                sw.Start();
            }
            catch (Exception ex)
            {
                UpdateText($">>>>>> ERROR !! : {ex.Message}\n");
            }
        }

        // 라즈베리파이에서 들어온 메시지를 전역리스트에 입력하는 메서드
        private void PrcInputDataToList(Dictionary<string, string> currentData)
        {
            if (currentData["prc_msg"] == "OK" || currentData["prc_msg"] == "FAIL")
                iotData.Add(currentData);
        }

        private void BtnConnect_Click(object sender, EventArgs e)
        {
            client.Connect(TxtClientId.Text); // 클라이언트 ID로 Connect
            UpdateText(">>>>>> Client Connected\n");

            client.Subscribe(new string[] { TxtSubscriptionTopic.Text }, new byte[] { MqttMsgBase.QOS_LEVEL_AT_MOST_ONCE });
            UpdateText(">>>>>> Subscribing to : " + TxtSubscriptionTopic.Text + "\n");

            BtnConnect.Enabled = false;
            BtnDisconnect.Enabled = true;

        }

        private void BtnDisconnect_Click(object sender, EventArgs e)
        {
            client.Disconnect();
            UpdateText(">>>>>> Client Disconnected\n");

            BtnConnect.Enabled = true;
            BtnDisconnect.Enabled = false;
        }

        private void UpdateText(string message)
        {
            if (RtbSubscr.InvokeRequired)
            {
                UpdateTextCallback callback = new UpdateTextCallback(UpdateText);
                this.Invoke(callback, new object[] {message});
            }
            else
            {
                lineCount++;
                RtbSubscr.AppendText($"{lineCount} : {message}\n");
                RtbSubscr.ScrollToCaret();
            }
        }
    }
}

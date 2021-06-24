using Microsoft.VisualStudio.TestTools.UnitTesting;
using MRPApp.View.Setting;
using System;
using System.Linq;

namespace MRPApp.Test
{
    [TestClass]
    public class SettingsTest
    {
        // 참조 -> 참조 추가 -> 테스트해야 되는 프로젝트를 추가 (MRPApp, EntityFramework, DBConnectionString(App.config))
        // 테스트 실행(T)
        
        // Database에 중복된 데이터 있는지 테스트
        [TestMethod]
        public void IsDuplicateDataTest()
        {
            // SettingList settingList = new SettingList();
            var expectVal = true;
            var inputCode = "PC010001";

            var code = Logic.DataAccess.GetSettings().Where(d => d.BasicCode.Contains(inputCode)).FirstOrDefault();
            var realVal = (code != null ? true : false);

            Assert.AreEqual(expectVal, realVal); // 값이 같으면 Pass, 다르면 Fail
        }
    }
}

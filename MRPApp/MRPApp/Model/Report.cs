using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MRPApp.Model
{
    // 리포트를 위한 JOIN 테이블 클래스 생성 (DTO)
    public class Report
    {
        public int SchIdx { get; set; }
        public string PlantCode { get; set; }
        public int SchAmount { get; set; }
        public System.DateTime PrcDate { get; set; }

        public int PrcOKAmount { get; set; }
        public int PrcFailAmount { get; set; }
    }
}

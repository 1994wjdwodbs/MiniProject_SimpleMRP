using MRPApp.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Migrations;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
// using MRPApp.Model;

namespace MRPApp.Logic
{
    public class DataAccess
    {
        /*
        public static List<User> GetUsers()
        {
            List<User> users;
            using (var ctx = new SMSEntities())
            {
                users = ctx.User.ToList(); // = SELECT * FROM user
            }
            return users;
        }

        /// <summary>
        /// 입력, 수정 동시에...
        /// </summary>
        /// <param name="user"></param>
        /// <returns>0또는 1이상</returns>
        public static int SetUser(User user)
        {
            using (var ctx = new SMSEntities())
            {
                ctx.User.AddOrUpdate(user);
                return ctx.SaveChanges(); // commit
            }
        }

        public static List<Stock> GetStocks()
        {
            List<Stock> stocks;
            using (var ctx = new SMSEntities())
            {
                stocks = ctx.Stock.ToList();
            }
            return stocks;
        }

        public static List<Store> GetStores()
        {
            List<Store> stores;
            using (var ctx = new SMSEntities())
            {
                stores = ctx.Store.ToList();
            }
            return stores;
        }

        public static int SetStore(Store store)
        {
            using (var ctx = new SMSEntities())
            {
                ctx.Store.AddOrUpdate(store);
                return ctx.SaveChanges();
            }
        }
        */

        // Setting 테이블에서 데이터 가져오기
        public static List<Settings> GetSettings()
        {
            List<Model.Settings> settings;
            using (var ctx = new MRPEntities()) // ctx : context
            {
                settings = ctx.Settings.ToList(); // = SELECT * FROM Settings
            }

            return settings;
        }

        internal static int SetSettings(Settings setting)
        {
            using (var ctx = new MRPEntities())
            {
                ctx.Settings.AddOrUpdate(setting);
                return ctx.SaveChanges();
            }
        }

        internal static List<Report> GetReportDatas(string startDate, string endDate, string plantCode)
        {
            var connString = ConfigurationManager.ConnectionStrings["MRPConnString"].ToString();
            var list = new List<Model.Report>();

            using (var conn = new SqlConnection(connString))
            {
                conn.Open();
                var sqlQuery =   $@"SELECT sch.SchIdx, sch.PlantCode, sch.SchAmount, prc.PrcDate
	                               , prc.PrcOKAmount, prc.PrcFailAmount
                                    FROM Schedules AS sch
                                    INNER JOIN (
				                                    SELECT smr.SchIdx, smr.PrcDate, sum(smr.PrcOK) as PrcOKAmount, sum(smr.PrcFail) as PrcFailAmount
				                                    FROM (
						                                    SELECT p.SchIdx, p.PrcDate, 
							                                    CASE p.PrcResult WHEN 1 THEN 1 ELSE 0 END AS PrcOK,
							                                    CASE p.PrcResult WHEN 0 THEN 1 ELSE 0 END AS PrcFail
						                                    FROM Process AS p
					                                     ) AS smr
			                                        GROUP BY smr.SchIdx, smr.PrcDate
			                                    ) AS prc
                                    ON sch.SchIdx = prc.SchIdx
                                    WHERE sch.PlantCode = '{plantCode}' AND prc.PrcDate BETWEEN '{startDate}' AND '{endDate}';";

                var cmd = new SqlCommand(sqlQuery, conn);
                var reader = cmd.ExecuteReader();

                while(reader.Read())
                {
                    list.Add(new Report
                    {
                        SchIdx = (int)reader["SchIdx"],
                        PlantCode = reader["PlantCode"].ToString(),
                        SchAmount = (int)reader["SchAmount"],
                        PrcDate = DateTime.Parse(reader["PrcDate"].ToString()),
                        PrcOKAmount = (int)reader["PrcOKAmount"],
                        PrcFailAmount = (int)reader["PrcFailAmount"]
                    });
                }

                return list;
            }
        }

        internal static int DelSettings(Settings setting)
        {
            using (var ctx = new MRPEntities())
            {
                var obj = ctx.Settings.Find(setting.BasicCode);
                // 요약:
                //     Finds an entity with the given primary key values. If an entity with the given
                //     primary key values exists in the context, then it is returned immediately without
                //     making a request to the store. Otherwise, a request is made to the store for
                //     an entity with the given primary key values and this entity, if found, is attached
                //     to the context and returned. If no entity is found in the context or the store,
                //     then null is returned.
                ctx.Settings.Remove(obj);
                return ctx.SaveChanges(); // commit
            }
        }

        internal static List<Process> GetProcess()
        {
            List<Model.Process> list;

            using (var ctx = new MRPEntities())
                list = ctx.Process.ToList(); // SELECT

            return list;
        }

        internal static int SetProcess(Process item)
        {
            using (var ctx = new MRPEntities())
            {
                ctx.Process.AddOrUpdate(item); // INSERT or UPDATE
                return ctx.SaveChanges(); // COMMIT
            }
        }

        internal static List<Schedules> GetSchedules()
        {
            List<Model.Schedules> schedules;
            using (var ctx = new MRPEntities()) // ctx : context
            {
                schedules = ctx.Schedules.ToList(); // = SELECT * FROM Settings
            }

            return schedules;
        }

        internal static int SetSchedules(Schedules schedule)
        {
            using (var ctx = new MRPEntities())
            {
                ctx.Schedules.AddOrUpdate(schedule);
                return ctx.SaveChanges();
            }
        }
    }
}

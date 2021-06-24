using MRPApp.Model;
using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
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
        internal static List<Settings> GetSettings()
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
    }
}

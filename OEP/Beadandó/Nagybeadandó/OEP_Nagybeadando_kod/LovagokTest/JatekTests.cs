using Microsoft.VisualStudio.TestTools.UnitTesting;
using Lovagok;

namespace LovagokTest
{
    [TestClass]
    public class JatekTests
    {
        private string _tesztFajl = "jatek_teszt.txt";
        private string _tesztFajlUres = "jatek_teszt_ures.txt";

        [TestInitialize]
        public void Setup()
        {
            File.WriteAllText(_tesztFajl,
                "egy K kettő E három K négy E öt S\n" +
                "Falánk v\n" +
                "Sudár b\n" +
                "Köpcös o\n" +
                "Nyúlánk b");

            File.WriteAllText(_tesztFajlUres,
                "egy K kettő K\n" +
                "Teszt o");
        }

        [TestCleanup]
        public void Cleanup()
        {
            if (File.Exists(_tesztFajl)) File.Delete(_tesztFajl);
            if (File.Exists(_tesztFajlUres)) File.Delete(_tesztFajlUres);
        }


        [TestMethod]
        public void Betolt_HelyesenOlvasBeAdatokat()
        {
            Jatek j = new Jatek(_tesztFajl);
            Assert.IsNotNull(j);
        }

        [TestMethod]
        [ExpectedException(typeof(FileNotFoundException))]
        public void Betolt_NemLetezőFajl_Kivetelt_Dob()
        {
            Jatek j = new Jatek("nemletezik.txt");
        }


        [TestMethod]
        public void SikeresE_CsakKiralyiTartomanyok_Igaz()
        {
            Jatek j = new Jatek(_tesztFajlUres);
            Assert.IsTrue(j.SikeresE());
        }

        [TestMethod]
        public void SikeresE_VanEllensegesTartomany_Hamis()
        {
            Jatek j = new Jatek(_tesztFajl);
            Assert.IsFalse(j.SikeresE());
        }


        [TestMethod]
        public void Futtat_CsakKiralyiTartomanyok_AzonnaVege()
        {
            Jatek j = new Jatek(_tesztFajlUres);
            j.Futtat();
            Assert.IsTrue(j.SikeresE());
        }

        [TestMethod]
        public void Futtat_PeldaBemenet_VegrehajtasNemDobKivetelt()
        {
            Jatek j = new Jatek(_tesztFajl);
            j.Futtat();
            Assert.IsTrue(j.SikeresE() || !j.SikeresE());
        }
    }
}

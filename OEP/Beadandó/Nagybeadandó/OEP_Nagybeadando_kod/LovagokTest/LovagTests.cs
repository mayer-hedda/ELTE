using Microsoft.VisualStudio.TestTools.UnitTesting;
using Lovagok;

namespace LovagokTest
{
    [TestClass]
    public class LovagTests
    {

        [TestMethod]
        public void Ovatos_Konstruktor_HelyesErtekek()
        {
            Ovatos o = new Ovatos("Teszt");
            Assert.AreEqual("Teszt", o.Nev);
            Assert.AreEqual(100, o.Eletero);
            Assert.IsTrue(o.IsElo());
        }

        [TestMethod]
        public void Bator_Konstruktor_HelyesErtekek()
        {
            Bator b = new Bator("Teszt");
            Assert.AreEqual("Teszt", b.Nev);
            Assert.AreEqual(100, b.Eletero);
            Assert.IsTrue(b.IsElo());
        }

        [TestMethod]
        public void Vakmero_Konstruktor_HelyesErtekek()
        {
            Vakmero v = new Vakmero("Teszt");
            Assert.AreEqual("Teszt", v.Nev);
            Assert.AreEqual(100, v.Eletero);
            Assert.IsTrue(v.IsElo());
        }


        [TestMethod]
        public void Ovatos_IsSerult_90EletoroAlatt_Igaz()
        {
            Ovatos o = new Ovatos("Teszt");
            o.Harcol(10);
            Assert.IsTrue(o.IsSerult());
        }

        [TestMethod]
        public void Ovatos_IsSerult_100Eletero_Igaz()
        {
            Ovatos o = new Ovatos("Teszt");
            Assert.IsFalse(o.IsSerult());
        }

        [TestMethod]
        public void Bator_IsSerult_40EletoroAlatt_Igaz()
        {
            Bator b = new Bator("Teszt");
            b.Harcol(60);
            Assert.IsTrue(b.IsSerult());
        }

        [TestMethod]
        public void Bator_IsSerult_41Eletero_Hamis()
        {
            Bator b = new Bator("Teszt");
            b.Harcol(59);
            Assert.IsFalse(b.IsSerult());
        }

        [TestMethod]
        public void Vakmero_IsSerult_MindigHamis()
        {
            Vakmero v = new Vakmero("Teszt");
            v.Harcol(99);
            Assert.IsFalse(v.IsSerult());
        }


        [TestMethod]
        public void Harcol_CsokkentiAzEletorot()
        {
            Ovatos o = new Ovatos("Teszt");
            o.Harcol(30);
            Assert.AreEqual(70, o.Eletero);
        }

        [TestMethod]
        public void Harcol_EletoroNullaAlatt_IsEloHamis()
        {
            Bator b = new Bator("Teszt");
            b.Harcol(100);
            Assert.IsFalse(b.IsElo());
        }

        [TestMethod]
        public void Harcol_EletoroNullan_IsEloHamis()
        {
            Vakmero v = new Vakmero("Teszt");
            v.Harcol(100);
            Assert.AreEqual(0, v.Eletero);
            Assert.IsFalse(v.IsElo());
        }


        [TestMethod]
        public void Gyogyul_NovekszikAzEletero()
        {
            Ovatos o = new Ovatos("Teszt");
            o.Harcol(50);
            int elotte = o.Eletero;
            o.Gyogyul();
            Assert.IsTrue(o.Eletero >= elotte);
        }

        [TestMethod]
        public void Gyogyul_NemLepiFelA100at()
        {
            Ovatos o = new Ovatos("Teszt");
            o.Harcol(1); 
            o.Gyogyul();
            Assert.IsTrue(o.Eletero <= 100);
        }

        [TestMethod]
        public void Gyogyul_100HpNalNemNovekszik()
        {
            Bator b = new Bator("Teszt");
            b.Gyogyul();
            Assert.AreEqual(100, b.Eletero);
        }


        [TestMethod]
        public void Visszavonul_LegkozelebbiKiralyihoz()
        {
            List<Tartomany> tartomanyok = new List<Tartomany>
            {
                new Kiralyi("egy"),
                new Ellenseges("kettő"),
                new Ellenseges("három")
            };
            Ovatos o = new Ovatos("Teszt");
            o.Harcol(15);
            o.Kor(tartomanyok);
            o.Kor(tartomanyok);
            Assert.IsTrue(tartomanyok[0].IsKiralyi());
        }


        [TestMethod]
        public void Kor_SerultLovag_Visszavonul()
        {
            List<Tartomany> tartomanyok = new List<Tartomany>
            {
                new Kiralyi("egy"),
                new Kiralyi("kettő")
            };
            Ovatos o = new Ovatos("Teszt");
            o.Harcol(15); 
            int eloEletero = o.Eletero;
            o.Kor(tartomanyok); 
            Assert.IsTrue(o.Eletero >= eloEletero);
        }

        [TestMethod]
        public void Kor_EgeszsgesLovag_TovabbLep()
        {
            List<Tartomany> tartomanyok = new List<Tartomany>
            {
                new Kiralyi("egy"),
                new Kiralyi("kettő")
            };
            Bator b = new Bator("Teszt");
            b.Kor(tartomanyok);
            Assert.IsTrue(tartomanyok[1].IsKiralyi());
        }
    }
}

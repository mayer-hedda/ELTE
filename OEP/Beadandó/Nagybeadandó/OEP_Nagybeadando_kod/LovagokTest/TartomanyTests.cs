using Microsoft.VisualStudio.TestTools.UnitTesting;
using Lovagok;

namespace LovagokTest
{
    [TestClass]
    public class TartomanyTests
    {

        [TestMethod]
        public void Kiralyi_Konstruktor_IsKiralyiIgaz()
        {
            Kiralyi k = new Kiralyi("egy");
            Assert.AreEqual("egy", k.Nev);
            Assert.IsTrue(k.IsKiralyi());
            Assert.IsFalse(k.IsSemleges());
            Assert.IsFalse(k.IsEllenseges());
        }

        [TestMethod]
        public void Semleges_Konstruktor_IsSemlegesIgaz()
        {
            Semleges s = new Semleges("kettő");
            Assert.AreEqual("kettő", s.Nev);
            Assert.IsFalse(s.IsKiralyi());
            Assert.IsTrue(s.IsSemleges());
            Assert.IsFalse(s.IsEllenseges());
        }

        [TestMethod]
        public void Ellenseges_Konstruktor_IsEllensegesIgaz()
        {
            Ellenseges e = new Ellenseges("három");
            Assert.AreEqual("három", e.Nev);
            Assert.IsFalse(e.IsKiralyi());
            Assert.IsFalse(e.IsSemleges());
            Assert.IsTrue(e.IsEllenseges());
        }

        [TestMethod]
        public void Ellenseges_Konstruktor_EllenségEletero100()
        {
            Ellenseges e = new Ellenseges("három");
            Assert.AreEqual(100, e.EllenségEletero);
        }


        [TestMethod]
        public void Kiralyi_FogadOvatost_Gyogyul()
        {
            Kiralyi k = new Kiralyi("egy");
            Ovatos o = new Ovatos("Teszt");
            o.Harcol(30);
            int elotte = o.Eletero;
            k.FogadOvatost(o);
            Assert.IsTrue(o.Eletero >= elotte);
        }

        [TestMethod]
        public void Kiralyi_FogadBatort_NemGyogyul()
        {
            Kiralyi k = new Kiralyi("egy");
            Bator b = new Bator("Teszt");
            b.Harcol(10); 
            int elotte = b.Eletero;
            k.FogadBatort(b);
            Assert.AreEqual(elotte, b.Eletero);
        }

        [TestMethod]
        public void Kiralyi_FogadVakmerot_NemGyogyul()
        {
            Kiralyi k = new Kiralyi("egy");
            Vakmero v = new Vakmero("Teszt");
            v.Harcol(10); 
            int elotte = v.Eletero;
            k.FogadVakmerot(v);
            Assert.AreEqual(elotte, v.Eletero);
        }


        [TestMethod]
        public void Semleges_FogadOvatost_NemValtozik()
        {
            Semleges s = new Semleges("kettő");
            Ovatos o = new Ovatos("Teszt");
            s.FogadOvatost(o);
            Assert.IsTrue(s.IsSemleges());
        }

        [TestMethod]
        public void Semleges_FogadBatort_KiralyivaValtozik()
        {
            Semleges s = new Semleges("kettő");
            Bator b = new Bator("Teszt");
            s.FogadBatort(b);
            Assert.IsTrue(s.IsKiralyi());
        }

        [TestMethod]
        public void Semleges_FogadVakmerot_KiralyivaValtozik()
        {
            Semleges s = new Semleges("kettő");
            Vakmero v = new Vakmero("Teszt");
            s.FogadVakmerot(v);
            Assert.IsTrue(s.IsKiralyi());
        }


        [TestMethod]
        public void Ellenseges_FogadOvatost_EgyetlenCsata()
        {
            Ellenseges e = new Ellenseges("három");
            Ovatos o = new Ovatos("Teszt");
            e.FogadOvatost(o);
            Assert.IsTrue(e.EllenségEletero < 100 || e.IsSemleges());
        }

        [TestMethod]
        public void Ellenseges_FogadOvatost_LovagEleteroCSokkent()
        {
            Ellenseges e = new Ellenseges("három");
            Ovatos o = new Ovatos("Teszt");
            e.FogadOvatost(o);
            Assert.IsTrue(o.Eletero < 100);
        }

        [TestMethod]
        public void Ellenseges_EllenségMeghal_SemlegesseValtozik()
        {
            bool semlegesseLett = false;
            for (int i = 0; i < 50; i++)
            {
                Ellenseges e = new Ellenseges("három");
                Vakmero v = new Vakmero("Teszt");
                e.FogadVakmerot(v);
                if (e.IsSemleges())
                {
                    semlegesseLett = true;
                    break;
                }
            }
            Assert.IsTrue(semlegesseLett);
        }

        [TestMethod]
        public void Ellenseges_FogadBatort_MaxKetCsata()
        {
            Ellenseges e = new Ellenseges("három");
            Bator b = new Bator("Teszt");
            e.FogadBatort(b);
            Assert.IsTrue(e.EllenségEletero <= 100);
            Assert.IsTrue(e.IsSemleges() || e.IsEllenseges());
        }


        [TestMethod]
        public void Tartomany_IsKiralyi_DelegalAllapotnak()
        {
            Tartomany t = new Semleges("kettő");
            Assert.IsFalse(t.IsKiralyi());
            Bator b = new Bator("Teszt");
            t.FogadBatort(b);
            Assert.IsTrue(t.IsKiralyi()); 
        }

        [TestMethod]
        public void Tartomany_Allapot_ObjektumNemCserelodik()
        {
            Semleges s = new Semleges("kettő");
            Tartomany referencia = s; 
            Bator b = new Bator("Teszt");
            s.FogadBatort(b);
            Assert.IsTrue(object.ReferenceEquals(s, referencia)); 
            Assert.IsTrue(referencia.IsKiralyi()); 
        }
    }
}

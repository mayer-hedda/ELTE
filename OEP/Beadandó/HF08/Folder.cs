using System.Collections.Generic;

namespace HF08
{
    public class Folder : Registration
    {
        private List<Registration> items;

        public Folder()
        {
            items = new List<Registration>();
            size = 0;
        }

        public void Add(Registration r)
        {
            items.Add(r);
        }

        public void Remove(Registration r)
        {
            items.Remove(r);
        }

        public override int GetSize()
        {
            int sum = size;

            foreach (Registration e in items)
            {
                sum += e.GetSize();
            }

            return sum;
        }
    }
}
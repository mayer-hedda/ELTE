namespace HF08
{
    public class File : Registration
    {
        public File(int size)
        {
            this.size = size;
        }

        public override int GetSize()
        {
            return size;
        }
    }
}
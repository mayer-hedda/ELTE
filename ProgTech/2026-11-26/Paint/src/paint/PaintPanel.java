package paint;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;
import javax.swing.JPanel;

/**
 *
 * @author mayerhedda
 */
public class PaintPanel extends JPanel {
    private int x, y;
    public Color color;
    public int size;

    public Color getColor() {
        return color;
    }

    public void setColor(Color color) {
        this.color = color;
    }

    public int getBSize() {
        return size;
    }

    public void setBSize(int size) {
        this.size = size;
    }
    
    
    
    public PaintPanel(int defaultSize) {
        setBSize(defaultSize);
        setBackground(Color.BLACK);
        
        addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) {
                x = e.getX();
                y = e.getY();
            }
        });
        
        addMouseMotionListener(new MouseMotionAdapter() {
            public void mouseDragged(MouseEvent e) {
                Graphics g = getGraphics();
                
                g.setColor(color);
                g.fillOval(x, y, getBSize(), getBSize());
                g.dispose();
                
                x = e.getX();
                y = e.getY();
            }
        });
    }
    
    public void clear() {
        repaint();
    }
    
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
    }
}

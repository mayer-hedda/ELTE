package paint;

import java.awt.BorderLayout;
import java.awt.Color;
import javax.swing.JButton;
import javax.swing.JColorChooser;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JSlider;

/**
 *
 * @author mayerhedda
 */
public class Paint extends JFrame {
    public Paint() {
        setTitle("Paint#");
        setSize(700, 700);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        
        JPanel mainPanel = new JPanel();
        JPanel toolbar = new JPanel();
        toolbar.setBackground(Color.WHITE);
        PaintPanel canvas = new PaintPanel(5);
        canvas.setBackground(Color.DARK_GRAY);
        
        JButton brush = new JButton("Brush");
        JSlider sizeSlider = new JSlider(1, 30, 5);
        sizeSlider.addChangeListener(e -> {
            canvas.setBSize(sizeSlider.getValue());
            System.out.println(canvas.getBSize());
        });
        
        JButton colorPicker = new JButton("ColorPicker");
        colorPicker.addActionListener(e -> {
            Color c = JColorChooser.showDialog(this, "CHOOSE", Color.RED);
            if(c != null) canvas.setColor(c);
        });
        
        JButton clear = new JButton("Clear");
        clear.addActionListener(e -> canvas.clear());
        toolbar.add(brush);
        toolbar.add(sizeSlider);
        toolbar.add(colorPicker);
        toolbar.add(clear);
        
        mainPanel.setLayout(new BorderLayout());
        mainPanel.add(toolbar, BorderLayout.NORTH);
        mainPanel.add(canvas, BorderLayout.CENTER);
        add(mainPanel, BorderLayout.CENTER);
        setLocationRelativeTo(null);
    }
    
    public static void main(String[] args) {
        Paint paint = new Paint();
        paint.setVisible(true);
    }
}

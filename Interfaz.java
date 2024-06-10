package Interfaz;
    
import Conexion.Conexion;
import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.image.BufferedImage;
import java.io.*;
import java.math.BigDecimal;
import java.sql.*;

public class Interfaz {
    private JTextField codigoField;
    private JTextField apellido1Field;
    private JTextField apellido2Field;
    private JTextField nombre1Field;
    private JTextField nombre2Field;
    private JTextField fechaNacimientoField;
    private JComboBox<String> sexoField;
    private JTextField emailField;
    private JTextField direccionField;
    private JComboBox<String> tipoSangreField;
    private JTextField sueldoField;
    private JComboBox<String> bancoField;
    private JTextField cuentaField;
    private JComboBox<String> statusField;
    private JLabel fotoLabel;
    private File fotoFile;
    private DefaultTableModel tableModel;
    private JTable table;

    public Interfaz() {
        JFrame frame = new JFrame("Gestión de Empleados");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(1000, 600);
        frame.setLocationRelativeTo(null);

        JPanel mainPanel = new JPanel(new BorderLayout());
        JPanel formPanel = new JPanel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(5, 5, 5, 5);
        gbc.fill = GridBagConstraints.HORIZONTAL;

        JLabel titulo = new JLabel("GESTIÓN DE EMPLEADOS", JLabel.CENTER);
        titulo.setFont(new Font("Arial", Font.BOLD, 24));
        mainPanel.add(titulo, BorderLayout.NORTH);

        gbc.gridx = 0;
        gbc.gridy = 0;
        formPanel.add(new JLabel("Código:"), gbc);
        gbc.gridx = 1;
        codigoField = new JTextField(7);
        codigoField.setPreferredSize(new Dimension(200, 25));
        formPanel.add(codigoField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 3;
        formPanel.add(new JLabel("Primer Apellido:"), gbc);
        gbc.gridx = 1;
        apellido1Field = new JTextField(30);
        apellido1Field.setPreferredSize(new Dimension(200, 25));
        formPanel.add(apellido1Field, gbc);

        gbc.gridx = 0;
        gbc.gridy = 4;
        formPanel.add(new JLabel("Segundo Apellido:"), gbc);
        gbc.gridx = 1;
        apellido2Field = new JTextField(30);
        apellido2Field.setPreferredSize(new Dimension(200, 25));
        formPanel.add(apellido2Field, gbc);

        gbc.gridx = 0;
        gbc.gridy = 1;
        formPanel.add(new JLabel("Primer Nombre:"), gbc);
        gbc.gridx = 1;
        nombre1Field = new JTextField(30);
        nombre1Field.setPreferredSize(new Dimension(200, 25));
        formPanel.add(nombre1Field, gbc);

        gbc.gridx = 0;
        gbc.gridy = 2;
        formPanel.add(new JLabel("Segundo Nombre:"), gbc);
        gbc.gridx = 1;
        nombre2Field = new JTextField(30);
        nombre2Field.setPreferredSize(new Dimension(200, 25));
        formPanel.add(nombre2Field, gbc);

        gbc.gridx = 0;
        gbc.gridy = 5;
        formPanel.add(new JLabel("Fecha de Nacimiento:"), gbc);
        gbc.gridx = 1;
        fechaNacimientoField = new JTextField(10);
        fechaNacimientoField.setPreferredSize(new Dimension(200, 25));
        formPanel.add(fechaNacimientoField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 6;
        formPanel.add(new JLabel("Sexo (M/F):"), gbc);
        gbc.gridx = 1;
        sexoField = new JComboBox<>(new String[]{"M", "F"});
        sexoField.setPreferredSize(new Dimension(50, 25));
        formPanel.add(sexoField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 7;
        formPanel.add(new JLabel("Email:"), gbc);
        gbc.gridx = 1;
        emailField = new JTextField(60);
        emailField.setPreferredSize(new Dimension(200, 25));
        formPanel.add(emailField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 8;
        formPanel.add(new JLabel("Dirección:"), gbc);
        gbc.gridx = 1;
        direccionField = new JTextField(60);
        direccionField.setPreferredSize(new Dimension(200, 25));
        formPanel.add(direccionField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 9;
        formPanel.add(new JLabel("Tipo de Sangre:"), gbc);
        gbc.gridx = 1;
        tipoSangreField = new JComboBox<>(new String[]{"A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"});
        tipoSangreField.setPreferredSize(new Dimension(60, 25));
        formPanel.add(tipoSangreField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 10;
        formPanel.add(new JLabel("Sueldo:"), gbc);
        gbc.gridx = 1;
        sueldoField = new JTextField(10);
        sueldoField.setPreferredSize(new Dimension(200, 25));
        formPanel.add(sueldoField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 11;
        formPanel.add(new JLabel("Banco:"), gbc);
        gbc.gridx = 1;
        bancoField = new JComboBox<>(new String[]{
            "BANCO DEL PACÍFICO", "BANCO PICHINCHA", "BANCO GUAYAQUIL", "BANCO DE LOJA",
            "BANCO DEL AUSTRO", "BANCO INTERNACIONAL", "BANCO BOLIVARIANO", "BANCO PRODUBANCO",
            "BANCO DE MACHALA", "BANCO SOLIDARIO", "BANCO DE FOMENTO", "BANCO PROCREDIT",
            "BANCO AMAZONAS", "BANCO DE GUAYAQUIL", "BANCO DEL LITORAL", "BANCO PROCREDIT"
        });
        bancoField.setPreferredSize(new Dimension(100, 25));
        formPanel.add(bancoField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 12;
        formPanel.add(new JLabel("Cuenta:"), gbc);
        gbc.gridx = 1;
        cuentaField = new JTextField(20);
        cuentaField.setPreferredSize(new Dimension(200, 25));
        formPanel.add(cuentaField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 13;
        formPanel.add(new JLabel("Status:"), gbc);
        gbc.gridx = 1;
        statusField = new JComboBox<>(new String[]{"ACT"});
        statusField.setPreferredSize(new Dimension(60, 25));
        formPanel.add(statusField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 14;
        formPanel.add(new JLabel("Foto:"), gbc);
        gbc.gridx = 1;
        fotoLabel = new JLabel();
        formPanel.add(fotoLabel, gbc);

        gbc.gridx = 1;
        gbc.gridy = 15;
        JButton añadirFotoButton = new JButton("Seleccionar Foto");
        añadirFotoButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                añadirFoto();
            }
        });
        formPanel.add(añadirFotoButton, gbc);

        gbc.gridx = 1;
        gbc.gridy = 16;
        JButton borrarFotoButton = new JButton("Borrar Foto");
        borrarFotoButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                confirmarBorrarFoto();
            }
        });
        formPanel.add(borrarFotoButton, gbc);

        JPanel buttonPanel = new JPanel(new GridBagLayout());
        GridBagConstraints gbcButton = new GridBagConstraints();
        gbcButton.insets = new Insets(5, 5, 5, 5);
        gbcButton.fill = GridBagConstraints.HORIZONTAL;

        JButton insertarButton = new JButton("Insertar");
        insertarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (validarCampos()) {
                    guardarDatos();
                }
            }
        });
        gbcButton.gridx = 0;
        gbcButton.gridy = 0;
        buttonPanel.add(insertarButton, gbcButton);

        JButton buscarButton = new JButton("Buscar");
        buscarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                leerDatos();
            }
        });
        gbcButton.gridx = 0;
        gbcButton.gridy = 1;
        buttonPanel.add(buscarButton, gbcButton);

        JButton actualizarButton = new JButton("Actualizar");
        actualizarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (validarCampos()) {
                    actualizarDatos();
                }
            }
        });
        gbcButton.gridx = 0;
        gbcButton.gridy = 2;
        buttonPanel.add(actualizarButton, gbcButton);

        JButton eliminarButton = new JButton("Eliminar");
        eliminarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                confirmarEliminarDatos();
            }
        });
        gbcButton.gridx = 0;
        gbcButton.gridy = 3;
        buttonPanel.add(eliminarButton, gbcButton);

        JButton verTodosButton = new JButton("Ver Todos");
        verTodosButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                mostrarTodosRegistros();
            }
        });
        gbcButton.gridx = 0;
        gbcButton.gridy = 4;
        buttonPanel.add(verTodosButton, gbcButton);

        gbc.gridx = 2;
        gbc.gridy = 0;
        gbc.gridheight = 17;
        gbc.fill = GridBagConstraints.VERTICAL;
        formPanel.add(buttonPanel, gbc);

        mainPanel.add(formPanel, BorderLayout.CENTER);

        frame.add(mainPanel);
        frame.setVisible(true);
    }

    private void mostrarTodosRegistros() {
        JFrame frame = new JFrame("Todos los Registros");
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setSize(1000, 600);
        frame.setLocationRelativeTo(null);

        String[] columnNames = {"Código", "Primer Apellido", "Segundo Apellido", "Primer Nombre", "Segundo Nombre", "Fecha Nacimiento", "Sexo", "Email", "Dirección", "Tipo Sangre", "Sueldo", "Banco", "Cuenta", "Status", "Foto"};
        tableModel = new DefaultTableModel(columnNames, 0) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false; // Hacer que todas las celdas no sean editables
            }
        };
        table = new JTable(tableModel);

        table.setRowHeight(100); // Aumentar la altura de la fila para mostrar la imagen completa
        table.getColumnModel().getColumn(14).setCellRenderer(new ImageRenderer());

        // Establecer el renderizador de celda para colorear filas alternas
        AlternateRowColorRenderer renderer = new AlternateRowColorRenderer();
        for (int i = 0; i < table.getColumnCount(); i++) {
            if (i != 14) {
                table.getColumnModel().getColumn(i).setCellRenderer(renderer);
            }
        }

        table.setShowHorizontalLines(false); // Eliminar las líneas horizontales
        table.setGridColor(Color.LIGHT_GRAY); // Opcional: cambiar el color de las líneas verticales

        JScrollPane scrollPane = new JScrollPane(table);

        table.addMouseListener(new MouseAdapter() {
            public void mouseClicked(MouseEvent e) {
                if (e.getClickCount() == 2 && table.getSelectedRow() != -1) {
                    cargarDatosEnFormulario();
                }
            }
        });

        actualizarTabla();

        frame.add(scrollPane);
        frame.setVisible(true);
    }

    private void actualizarTabla() {
        tableModel.setRowCount(0); // Clear existing rows

        try (Connection conn = new Conexion().getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM EMPLEADOS");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                byte[] fotoBytes = rs.getBytes("EMPFOTO");
                ImageIcon fotoIcon = null;
                if (fotoBytes != null) {
                    Image img = Toolkit.getDefaultToolkit().createImage(fotoBytes);
                    fotoIcon = new ImageIcon(img.getScaledInstance(100, 100, Image.SCALE_SMOOTH)); // Aumentar el tamaño de la imagen
                }
                Object[] row = {
                    rs.getString("EMPCODIGO"),
                    rs.getString("EMPAPELLIDO1"),
                    rs.getString("EMPAPELLIDO2"),
                    rs.getString("EMPNOMBRE1"),
                    rs.getString("EMPNOMBRE2"),
                    rs.getDate("EMPFECHANACIMIENTO"),
                    rs.getString("EMPSEXO"),
                    rs.getString("EMPEMAIL"),
                    rs.getString("EMPDIRECCION"),
                    rs.getString("EMPTIPOSANGRE"),
                    rs.getBigDecimal("EMPSUELDO"),
                    rs.getString("EMPBANCO"),
                    rs.getString("EMPCUENTA"),
                    rs.getString("EMPSTATUS"),
                    fotoIcon
                };
                tableModel.addRow(row);
            }
        } catch (SQLException ex) {
            mostrarMensajeError(ex);
        }
    }

    private void cargarDatosEnFormulario() {
        int selectedRow = table.getSelectedRow();
        if (selectedRow != -1) {
            codigoField.setText(tableModel.getValueAt(selectedRow, 0).toString());
            apellido1Field.setText(tableModel.getValueAt(selectedRow, 1).toString());
            apellido2Field.setText(tableModel.getValueAt(selectedRow, 2).toString());
            nombre1Field.setText(tableModel.getValueAt(selectedRow, 3).toString());
            nombre2Field.setText(tableModel.getValueAt(selectedRow, 4).toString());
            fechaNacimientoField.setText(tableModel.getValueAt(selectedRow, 5).toString());
            sexoField.setSelectedItem(tableModel.getValueAt(selectedRow, 6).toString());
            emailField.setText(tableModel.getValueAt(selectedRow, 7).toString());
            direccionField.setText(tableModel.getValueAt(selectedRow, 8).toString());
            tipoSangreField.setSelectedItem(tableModel.getValueAt(selectedRow, 9).toString());
            sueldoField.setText(tableModel.getValueAt(selectedRow, 10).toString());
            bancoField.setSelectedItem(tableModel.getValueAt(selectedRow, 11).toString());
            cuentaField.setText(tableModel.getValueAt(selectedRow, 12).toString());
            statusField.setSelectedItem(tableModel.getValueAt(selectedRow, 13).toString());

            ImageIcon icon = (ImageIcon) tableModel.getValueAt(selectedRow, 14);
            if (icon != null) {
                fotoLabel.setIcon(new ImageIcon(icon.getImage().getScaledInstance(150, 150, Image.SCALE_SMOOTH)));
            } else {
                fotoLabel.setIcon(null);
            }
        }
    }

    private void guardarDatos() {
        String codigo = codigoField.getText();
        String apellido1 = apellido1Field.getText();
        String apellido2 = apellido2Field.getText();
        String nombre1 = nombre1Field.getText();
        String nombre2 = nombre2Field.getText();
        String fechaNacimiento = fechaNacimientoField.getText();
        String sexo = (String) sexoField.getSelectedItem();
        String email = emailField.getText();
        String direccion = direccionField.getText();
        String tipoSangre = (String) tipoSangreField.getSelectedItem();
        String sueldo = sueldoField.getText();
        String banco = (String) bancoField.getSelectedItem();
        String cuenta = cuentaField.getText();
        String status = (String) statusField.getSelectedItem();

        String sql = "INSERT INTO EMPLEADOS (EMPCODIGO, EMPAPELLIDO1, EMPAPELLIDO2, EMPNOMBRE1, EMPNOMBRE2, EMPFECHANACIMIENTO, EMPSEXO, EMPEMAIL, EMPDIRECCION, EMPTIPOSANGRE, EMPSUELDO, EMPBANCO, EMPCUENTA, EMPSTATUS, EMPFOTO) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = new Conexion().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, codigo);
            stmt.setString(2, apellido1);
            stmt.setString(3, apellido2);
            stmt.setString(4, nombre1);
            stmt.setString(5, nombre2);
            stmt.setDate(6, java.sql.Date.valueOf(fechaNacimiento));
            stmt.setString(7, sexo);
            stmt.setString(8, email);
            stmt.setString(9, direccion);
            stmt.setString(10, tipoSangre);
            stmt.setBigDecimal(11, new BigDecimal(sueldo));
            stmt.setString(12, banco);
            stmt.setString(13, cuenta);
            stmt.setString(14, status);

            if (fotoFile != null && fotoFile.exists() && fotoFile.canRead()) {
                try (FileInputStream inputStream = new FileInputStream(fotoFile)) {
                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    BufferedImage image = ImageIO.read(inputStream);
                    ImageIO.write(image, "jpg", baos); // Convertir a un formato manejable
                    byte[] imageBytes = baos.toByteArray();
                    stmt.setBytes(15, imageBytes);
                } catch (IOException e) {
                    JOptionPane.showMessageDialog(null, "Error al leer el archivo de foto.");
                    e.printStackTrace();
                    return;
                }
            } else {
                stmt.setNull(15, Types.BLOB);
            }

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                JOptionPane.showMessageDialog(null, "Datos guardados exitosamente.");
                actualizarTabla(); // Actualizar la tabla después de insertar
            }
        } catch (SQLException ex) {
            mostrarMensajeError(ex);
        }
    }

    private void leerDatos() {
        String codigo = codigoField.getText();
        String sql = "SELECT * FROM EMPLEADOS WHERE EMPCODIGO = ?";

        try (Connection conn = new Conexion().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, codigo);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                apellido1Field.setText(rs.getString("EMPAPELLIDO1"));
                apellido2Field.setText(rs.getString("EMPAPELLIDO2"));
                nombre1Field.setText(rs.getString("EMPNOMBRE1"));
                nombre2Field.setText(rs.getString("EMPNOMBRE2"));
                fechaNacimientoField.setText(rs.getString("EMPFECHANACIMIENTO"));
                sexoField.setSelectedItem(rs.getString("EMPSEXO"));
                emailField.setText(rs.getString("EMPEMAIL"));
                direccionField.setText(rs.getString("EMPDIRECCION"));
                tipoSangreField.setSelectedItem(rs.getString("EMPTIPOSANGRE"));
                sueldoField.setText(rs.getString("EMPSUELDO"));
                bancoField.setSelectedItem(rs.getString("EMPBANCO"));
                cuentaField.setText(rs.getString("EMPCUENTA"));
                statusField.setSelectedItem(rs.getString("EMPSTATUS"));

                Blob blob = rs.getBlob("EMPFOTO");
                if (blob != null) {
                    try (InputStream inputStream = blob.getBinaryStream()) {
                        ImageIcon imageIcon = new ImageIcon(new ImageIcon(inputStream.readAllBytes()).getImage().getScaledInstance(150, 150, Image.SCALE_DEFAULT));
                        fotoLabel.setIcon(imageIcon);
                    } catch (IOException e) {
                        JOptionPane.showMessageDialog(null, "Error al leer el blob de la base de datos.");
                        e.printStackTrace();
                    }
                } else {
                    fotoLabel.setIcon(null);
                }
            } else {
                JOptionPane.showMessageDialog(null, "Empleado no encontrado.");
            }
        } catch (SQLException ex) {
            mostrarMensajeError(ex);
        }
    }

    private void actualizarDatos() {
        String codigo = codigoField.getText();
        String apellido1 = apellido1Field.getText();
        String apellido2 = apellido2Field.getText();
        String nombre1 = nombre1Field.getText();
        String nombre2 = nombre2Field.getText();
        String fechaNacimiento = fechaNacimientoField.getText();
        String sexo = (String) sexoField.getSelectedItem();
        String email = emailField.getText();
        String direccion = direccionField.getText();
        String tipoSangre = (String) tipoSangreField.getSelectedItem();
        String sueldo = sueldoField.getText();
        String banco = (String) bancoField.getSelectedItem();
        String cuenta = cuentaField.getText();
        String status = (String) statusField.getSelectedItem();

        String sql = "UPDATE EMPLEADOS SET EMPAPELLIDO1 = ?, EMPAPELLIDO2 = ?, EMPNOMBRE1 = ?, EMPNOMBRE2 = ?, EMPFECHANACIMIENTO = ?, EMPSEXO = ?, EMPEMAIL = ?, EMPDIRECCION = ?, EMPTIPOSANGRE = ?, EMPSUELDO = ?, EMPBANCO = ?, EMPCUENTA = ?, EMPSTATUS = ?, EMPFOTO = ? WHERE EMPCODIGO = ?";

        try (Connection conn = new Conexion().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, apellido1);
            stmt.setString(2, apellido2);
            stmt.setString(3, nombre1);
            stmt.setString(4, nombre2);
            stmt.setDate(5, java.sql.Date.valueOf(fechaNacimiento));
            stmt.setString(6, sexo);
            stmt.setString(7, email);
            stmt.setString(8, direccion);
            stmt.setString(9, tipoSangre);
            stmt.setBigDecimal(10, new BigDecimal(sueldo));
            stmt.setString(11, banco);
            stmt.setString(12, cuenta);
            stmt.setString(13, status);

            if (fotoFile != null && fotoFile.exists() && fotoFile.canRead()) {
                try (FileInputStream inputStream = new FileInputStream(fotoFile)) {
                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    BufferedImage image = ImageIO.read(inputStream);
                    ImageIO.write(image, "jpg", baos); // Convertir a un formato manejable
                    byte[] imageBytes = baos.toByteArray();
                    stmt.setBytes(14, imageBytes);
                } catch (IOException e) {
                    JOptionPane.showMessageDialog(null, "Error al leer el archivo de foto.");
                    e.printStackTrace();
                    return;
                }
            } else {
                stmt.setNull(14, Types.BLOB);
            }

            stmt.setString(15, codigo);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                JOptionPane.showMessageDialog(null, "Datos actualizados exitosamente.");
                actualizarTabla(); // Actualizar la tabla después de actualizar
            } else {
                JOptionPane.showMessageDialog(null, "Empleado no encontrado.");
            }
        } catch (SQLException ex) {
            mostrarMensajeError(ex);
        }
    }

    private void eliminarDatos() {
        String codigo = codigoField.getText();
        String sql = "DELETE FROM EMPLEADOS WHERE EMPCODIGO = ?";

        try (Connection conn = new Conexion().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, codigo);

            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                JOptionPane.showMessageDialog(null, "Datos eliminados exitosamente.");
                clearFields();
                actualizarTabla(); // Actualizar la tabla después de eliminar
            } else {
                JOptionPane.showMessageDialog(null, "Empleado no encontrado.");
            }
        } catch (SQLException ex) {
            mostrarMensajeError(ex);
        }
    }

    private void confirmarEliminarDatos() {
        int confirmed = JOptionPane.showConfirmDialog(null, "¿Está seguro de eliminar este registro?", "Confirmar eliminación", JOptionPane.YES_NO_OPTION);
        if (confirmed == JOptionPane.YES_OPTION) {
            eliminarDatos();
        }
    }

    private void confirmarBorrarFoto() {
        int confirmed = JOptionPane.showConfirmDialog(null, "¿Está seguro de eliminar la foto?", "Confirmar eliminación", JOptionPane.YES_NO_OPTION);
        if (confirmed == JOptionPane.YES_OPTION) {
            fotoLabel.setIcon(null);
            fotoFile = null;
        }
    }

    private void clearFields() {
        codigoField.setText("");
        apellido1Field.setText("");
        apellido2Field.setText("");
        nombre1Field.setText("");
        nombre2Field.setText("");
        fechaNacimientoField.setText("");
        sexoField.setSelectedIndex(0);
        emailField.setText("");
        direccionField.setText("");
        tipoSangreField.setSelectedIndex(0);
        sueldoField.setText("");
        bancoField.setSelectedIndex(0);
        cuentaField.setText("");
        statusField.setSelectedIndex(0);
        fotoLabel.setIcon(null);
        fotoFile = null;
    }

    private void añadirFoto() {
        JFileChooser fileChooser = new JFileChooser();
        int returnValue = fileChooser.showOpenDialog(null);
        if (returnValue == JFileChooser.APPROVE_OPTION) {
            fotoFile = fileChooser.getSelectedFile();
            ImageIcon imageIcon = new ImageIcon(new ImageIcon(fotoFile.getAbsolutePath()).getImage().getScaledInstance(150, 150, Image.SCALE_DEFAULT));
            fotoLabel.setIcon(imageIcon);
        }
    }

    private boolean validarCampos() {
        if (codigoField.getText().isEmpty() || apellido1Field.getText().isEmpty() || nombre1Field.getText().isEmpty() ||
                fechaNacimientoField.getText().isEmpty() || emailField.getText().isEmpty() || direccionField.getText().isEmpty() ||
                sueldoField.getText().isEmpty() || cuentaField.getText().isEmpty()) {
            JOptionPane.showMessageDialog(null, "Por favor llenar todos los campos.");
            return false;
        }
        return true;
    }

    private void mostrarMensajeError(SQLException ex) {
        String mensaje = ex.getMessage().toLowerCase();
        if (mensaje.contains("ck_")) {
            if (mensaje.contains("ck_empprimer_apellido") || mensaje.contains("ck_empsegundo_apellido") ||
                    mensaje.contains("ck_empprimer_nombre") || mensaje.contains("ck_empsegundo_nombre")) {
                JOptionPane.showMessageDialog(null, "No se aceptan números en los campos de nombre o apellido.", "Error en la base de datos", JOptionPane.ERROR_MESSAGE);
            } else if (mensaje.contains("ck_empsueldo_positivo")) {
                JOptionPane.showMessageDialog(null, "El sueldo debe ser un valor positivo.", "Error en la base de datos", JOptionPane.ERROR_MESSAGE);
            } else if (mensaje.contains("ck_empemail_arroba")) {
                JOptionPane.showMessageDialog(null, "El correo electrónico debe contener una '@puce.edu.ec'", "Error en la base de datos", JOptionPane.ERROR_MESSAGE);
            } else if (mensaje.contains("ck_empbanco_valido")) {
                JOptionPane.showMessageDialog(null, "El banco seleccionado no es válido.", "Error en la base de datos", JOptionPane.ERROR_MESSAGE);
            } else if (mensaje.contains("ck_empcuenta_caracteres")) {
                JOptionPane.showMessageDialog(null, "La cuenta bancaria solo puede contener caracteres alfanuméricos.", "Error en la base de datos", JOptionPane.ERROR_MESSAGE);
            } else if (mensaje.contains("ck_empstatus_valido")) {
                JOptionPane.showMessageDialog(null, "El status debe ser 'INA' o 'ACT'.", "Error en la base de datos", JOptionPane.ERROR_MESSAGE);
            }
        } else {
            JOptionPane.showMessageDialog(null, "Error en la base de datos: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new Interfaz();
            }
        });
    }
}

class ImageRenderer extends DefaultTableCellRenderer {
    @Override
    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
        if (value instanceof ImageIcon) {
            return new JLabel((ImageIcon) value);
        } else {
            return super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
        }
    }
}

class AlternateRowColorRenderer extends DefaultTableCellRenderer {
    private static final Color ALTERNATE_COLOR = new Color(252, 243, 207);
    private static final Color WHITE_COLOR = Color.WHITE;

    @Override
    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
        Component c = super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
        if (!isSelected) {
            c.setBackground(row % 2 == 0 ? ALTERNATE_COLOR : WHITE_COLOR);
        }
        return c;
    }
}

import io
from reportlab.lib.pagesizes import letter
from reportlab.lib import colors
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch

def generate_invoice_pdf(order):
    buffer = io.BytesIO()
    
    # Page setup - letter size, 0.5 inch margins for clean spacing
    doc = SimpleDocTemplate(
        buffer,
        pagesize=letter,
        rightMargin=36,
        leftMargin=36,
        topMargin=36,
        bottomMargin=36
    )
    
    styles = getSampleStyleSheet()
    
    # Custom styles to fit the premium look
    title_style = ParagraphStyle(
        'InvoiceTitle',
        parent=styles['Heading1'],
        fontName='Helvetica-Bold',
        fontSize=24,
        leading=28,
        textColor=colors.HexColor('#1f2937'),
        spaceAfter=6
    )
    
    subtitle_style = ParagraphStyle(
        'InvoiceSubtitle',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=10,
        leading=14,
        textColor=colors.HexColor('#4b5563')
    )
    
    section_title = ParagraphStyle(
        'SectionTitle',
        parent=styles['Heading2'],
        fontName='Helvetica-Bold',
        fontSize=12,
        leading=16,
        textColor=colors.HexColor('#111827'),
        spaceBefore=12,
        spaceAfter=6
    )
    
    body_style = ParagraphStyle(
        'InvoiceBody',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=10,
        leading=14,
        textColor=colors.HexColor('#374151')
    )
    
    body_bold = ParagraphStyle(
        'InvoiceBodyBold',
        parent=body_style,
        fontName='Helvetica-Bold'
    )
    
    table_header_style = ParagraphStyle(
        'TableHeader',
        parent=styles['Normal'],
        fontName='Helvetica-Bold',
        fontSize=10,
        leading=14,
        textColor=colors.white
    )
    
    table_cell_style = ParagraphStyle(
        'TableCell',
        parent=styles['Normal'],
        fontName='Helvetica',
        fontSize=9,
        leading=13,
        textColor=colors.HexColor('#1f2937')
    )
    
    table_cell_right = ParagraphStyle(
        'TableCellRight',
        parent=table_cell_style,
        alignment=2 # Right align
    )
    
    table_header_right = ParagraphStyle(
        'TableHeaderRight',
        parent=table_header_style,
        alignment=2 # Right align
    )

    story = []
    
    # Header block: Company Info on left, Invoice Details on right
    header_data = [
        [
            Paragraph("<b>VARIETY E-COMMERCE</b><br/>Purwokerto, Jawa Tengah<br/>Email: support@variety.com", subtitle_style),
            Paragraph(f"<font size=16><b>INVOICE</b></font><br/><b>Invoice ID:</b> {order.tracking_code}<br/><b>Tanggal:</b> {order.created_at.strftime('%d %b %Y %H:%M')}", table_cell_right)
        ]
    ]
    header_table = Table(header_data, colWidths=[3.5*inch, 4.0*inch])
    header_table.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('BOTTOMPADDING', (0,0), (-1,-1), 10),
    ]))
    story.append(header_table)
    
    # Divider line
    story.append(Spacer(1, 10))
    divider = Table([[""]], colWidths=[7.5*inch])
    divider.setStyle(TableStyle([
        ('LINEBELOW', (0,0), (-1,-1), 1.5, colors.HexColor('#e5e7eb')),
        ('BOTTOMPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 0),
    ]))
    story.append(divider)
    story.append(Spacer(1, 15))
    
    # Customer Details Block
    profile = getattr(order.user, 'profile', None)
    phone = profile.phone_number if profile else ""
    address = ""
    if profile:
        address = f"{profile.address_line}, {profile.regency}, {profile.province} {profile.postal_code}"
    
    customer_info_html = (
        f"<b>Nama Pelanggan:</b> {order.user.first_name or order.user.username}<br/>"
        f"<b>Email:</b> {order.user.email}<br/>"
        f"<b>Telepon:</b> {phone or '-'}<br/>"
        f"<b>Alamat Pengiriman:</b> {address or '-'}"
    )
    
    shipping_details_html = (
        f"<b>Kurir:</b> {order.get_courier_display()}<br/>"
        f"<b>Metode Pembayaran:</b> {order.get_payment_method_display()}<br/>"
        f"<b>Status Pembayaran:</b> {order.payment_status_display}"
    )
    
    info_data = [
        [
            Paragraph("<b>INFORMASI PELANGGAN</b>", section_title),
            Paragraph("<b>METODE & PENGIRIMAN</b>", section_title)
        ],
        [
            Paragraph(customer_info_html, body_style),
            Paragraph(shipping_details_html, body_style)
        ]
    ]
    info_table = Table(info_data, colWidths=[3.75*inch, 3.75*inch])
    info_table.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('BOTTOMPADDING', (0,0), (-1,-1), 10),
    ]))
    story.append(info_table)
    story.append(Spacer(1, 15))
    
    # Order Items Table
    # Widths: Item Name (3.8 inch), Price (1.2 inch), Qty (0.7 inch), Total (1.8 inch)
    items_data = [[
        Paragraph("Nama Produk", table_header_style),
        Paragraph("Harga Satuan", table_header_right),
        Paragraph("Jumlah", table_header_right),
        Paragraph("Total", table_header_right)
    ]]
    
    subtotal = 0
    for item in order.items.all():
        item_total = item.price * item.quantity
        subtotal += item_total
        items_data.append([
            Paragraph(item.product.name if item.product else "Produk tidak ditemukan", table_cell_style),
            Paragraph(f"Rp {int(item.price):,}".replace(",", "."), table_cell_right),
            Paragraph(str(item.quantity), table_cell_right),
            Paragraph(f"Rp {int(item_total):,}".replace(",", "."), table_cell_right)
        ])
        
    items_table = Table(items_data, colWidths=[3.8*inch, 1.2*inch, 0.7*inch, 1.8*inch])
    items_table.setStyle(TableStyle([
        ('BACKGROUND', (0,0), (-1,0), colors.HexColor('#1f2937')), # Dark gray header
        ('ALIGN', (0,0), (-1,0), 'LEFT'),
        ('ALIGN', (1,0), (-1,-1), 'RIGHT'),
        ('VALIGN', (0,0), (-1,-1), 'MIDDLE'),
        ('TOPPADDING', (0,0), (-1,-1), 6),
        ('BOTTOMPADDING', (0,0), (-1,-1), 6),
        ('ROWBACKGROUNDS', (0,1), (-1,-1), [colors.HexColor('#f9fafb'), colors.white]),
        ('GRID', (0,0), (-1,-1), 0.5, colors.HexColor('#e5e7eb')),
    ]))
    story.append(items_table)
    story.append(Spacer(1, 15))
    
    # Totals Section (aligned to the right)
    # We create a 2-column table to place it nicely on the right side
    points_discount = order.points_used
    total_tagihan = order.total_price + order.unique_code
    
    totals_data = [
        [Paragraph("Subtotal Produk", body_style), Paragraph(f"Rp {int(subtotal):,}".replace(",", "."), table_cell_right)],
        [Paragraph("Store Points Terpakai", body_style), Paragraph(f"- Rp {int(points_discount):,}".replace(",", "."), table_cell_right)],
        [Paragraph("Biaya Kirim", body_style), Paragraph(f"Rp {int(order.shipping_cost):,}".replace(",", "."), table_cell_right)],
        [Paragraph("Kode Unik", body_style), Paragraph(f"Rp {int(order.unique_code):,}".replace(",", "."), table_cell_right)],
        [Paragraph("<b>Total Tagihan</b>", body_bold), Paragraph(f"<b>Rp {int(total_tagihan):,}</b>".replace(",", "."), table_cell_right)],
    ]
    
    # Put empty spacer on the left to push the totals table to the right
    outer_table_data = [
        ["", Table(totals_data, colWidths=[1.8*inch, 1.7*inch])]
    ]
    outer_table = Table(outer_table_data, colWidths=[4.0*inch, 3.5*inch])
    outer_table.setStyle(TableStyle([
        ('VALIGN', (0,0), (-1,-1), 'TOP'),
        ('ALIGN', (1,0), (1,0), 'RIGHT'),
        ('BOTTOMPADDING', (0,0), (-1,-1), 0),
        ('TOPPADDING', (0,0), (-1,-1), 0),
    ]))
    story.append(outer_table)
    
    # Footer Note
    story.append(Spacer(1, 40))
    footer_data = [
        [Paragraph("<center>Terima kasih telah berbelanja di Variety!<br/>Simpan invoice ini sebagai bukti pembelian resmi.</center>", subtitle_style)]
    ]
    footer_table = Table(footer_data, colWidths=[7.5*inch])
    story.append(footer_table)
    
    doc.build(story)
    
    pdf = buffer.getvalue()
    buffer.close()
    return pdf

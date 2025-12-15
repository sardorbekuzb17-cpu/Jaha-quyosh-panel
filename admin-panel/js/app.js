// Global state
let orders = [];
let currentFilter = 'all';

// Initialize app
document.addEventListener('DOMContentLoaded', () => {
    initNavigation();
    initFilters();
    loadData();

    // Auto refresh every 30 seconds
    setInterval(loadData, 30000);
});

// Navigation
function initNavigation() {
    const navItems = document.querySelectorAll('.nav-item');
    const menuToggle = document.getElementById('menuToggle');
    const sidebar = document.getElementById('sidebar');

    navItems.forEach(item => {
        item.addEventListener('click', (e) => {
            e.preventDefault();
            const page = item.dataset.page;

            // Update active nav
            navItems.forEach(n => n.classList.remove('active'));
            item.classList.add('active');

            // Show page
            document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
            document.getElementById(`${page}Page`).classList.add('active');

            // Update title
            document.getElementById('pageTitle').textContent =
                page === 'dashboard' ? 'Dashboard' : 'Buyurtmalar';

            // Close sidebar on mobile
            sidebar.classList.remove('active');
        });
    });

    menuToggle.addEventListener('click', () => {
        sidebar.classList.toggle('active');
    });
}

// Filters
function initFilters() {
    const filterBtns = document.querySelectorAll('.filter-btn');

    filterBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            filterBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentFilter = btn.dataset.status;
            renderOrders();
        });
    });
}

// Load data
async function loadData() {
    orders = await api.getOrders();
    updateStats();
    renderOrders();
    renderRecentOrders();
}

// Refresh data
function refreshData() {
    loadData();
}

// Update statistics
function updateStats() {
    const total = orders.length;
    const pending = orders.filter(o => o.status === 'pending').length;
    const completed = orders.filter(o => o.status === 'completed').length;
    const totalRevenue = orders
        .filter(o => o.status === 'completed')
        .reduce((sum, o) => sum + (o.totalPrice || 0), 0);

    document.getElementById('totalOrders').textContent = total;
    document.getElementById('pendingOrders').textContent = pending;
    document.getElementById('completedOrders').textContent = completed;
    document.getElementById('totalRevenue').textContent = formatPrice(totalRevenue);
    document.getElementById('ordersBadge').textContent = pending;
}

// Render orders list
function renderOrders() {
    const container = document.getElementById('allOrdersList');
    let filteredOrders = orders;

    if (currentFilter !== 'all') {
        filteredOrders = orders.filter(o => o.status === currentFilter);
    }

    if (filteredOrders.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-inbox"></i>
                <p>Buyurtmalar topilmadi</p>
            </div>
        `;
        return;
    }

    container.innerHTML = filteredOrders.map(order => createOrderCard(order)).join('');
}

// Render recent orders (last 5)
function renderRecentOrders() {
    const container = document.getElementById('recentOrdersList');
    const recentOrders = orders.slice(0, 5);

    if (recentOrders.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-inbox"></i>
                <p>Hali buyurtmalar yo'q</p>
            </div>
        `;
        return;
    }

    container.innerHTML = recentOrders.map(order => createOrderCard(order)).join('');
}

// Create order card HTML
function createOrderCard(order) {
    const statusText = {
        'pending': 'Kutilmoqda',
        'confirmed': 'Tasdiqlangan',
        'completed': 'Bajarilgan',
        'cancelled': 'Bekor qilingan'
    };

    const date = new Date(order.createdAt).toLocaleDateString('uz-UZ', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });

    const itemsCount = order.items ? order.items.length : 0;

    return `
        <div class="order-card" onclick="showOrderDetail('${order.id}')">
            <div class="order-header">
                <span class="order-id">#${order.id.slice(-6)}</span>
                <span class="order-status status-${order.status}">${statusText[order.status] || order.status}</span>
            </div>
            <div class="order-info">
                <div class="order-info-item">
                    <label>Mijoz</label>
                    <span>${order.customerName || 'Noma\'lum'}</span>
                </div>
                <div class="order-info-item">
                    <label>Telefon</label>
                    <span>${order.customerPhone || '-'}</span>
                </div>
                <div class="order-info-item">
                    <label>Mahsulotlar</label>
                    <span>${itemsCount} ta</span>
                </div>
                <div class="order-info-item">
                    <label>Summa</label>
                    <span>${formatPrice(order.totalPrice)} so'm</span>
                </div>
                <div class="order-info-item">
                    <label>Sana</label>
                    <span>${date}</span>
                </div>
            </div>
        </div>
    `;
}

// Show order detail modal
function showOrderDetail(orderId) {
    const order = orders.find(o => o.id === orderId);
    if (!order) return;

    const statusText = {
        'pending': 'Kutilmoqda',
        'confirmed': 'Tasdiqlangan',
        'completed': 'Bajarilgan',
        'cancelled': 'Bekor qilingan'
    };

    const date = new Date(order.createdAt).toLocaleDateString('uz-UZ', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });

    let itemsHtml = '';
    if (order.items && order.items.length > 0) {
        itemsHtml = order.items.map(item => `
            <div class="item-row">
                <span>${item.name} (${item.quantity}x)</span>
                <span>${formatPrice(item.price * item.quantity)} so'm</span>
            </div>
        `).join('');
    }

    const modalBody = document.getElementById('orderModalBody');
    modalBody.innerHTML = `
        <div class="detail-section">
            <h3>Buyurtma ma'lumotlari</h3>
            <div class="detail-row">
                <label>Buyurtma ID</label>
                <span>#${order.id}</span>
            </div>
            <div class="detail-row">
                <label>Status</label>
                <span class="order-status status-${order.status}">${statusText[order.status] || order.status}</span>
            </div>
            <div class="detail-row">
                <label>Sana</label>
                <span>${date}</span>
            </div>
        </div>
        
        <div class="detail-section">
            <h3>Mijoz ma'lumotlari</h3>
            <div class="detail-row">
                <label>Ism</label>
                <span>${order.customerName || '-'}</span>
            </div>
            <div class="detail-row">
                <label>Telefon</label>
                <span>${order.customerPhone || '-'}</span>
            </div>
            <div class="detail-row">
                <label>Manzil</label>
                <span>${order.customerAddress || '-'}</span>
            </div>
        </div>
        
        <div class="detail-section">
            <h3>Mahsulotlar</h3>
            <div class="item-list">
                ${itemsHtml || '<p>Mahsulotlar yo\'q</p>'}
            </div>
            <div class="detail-row" style="margin-top: 12px; font-weight: bold;">
                <label>Jami summa</label>
                <span>${formatPrice(order.totalPrice)} so'm</span>
            </div>
        </div>
        
        <div class="status-actions">
            ${order.status === 'pending' ? `
                <button class="status-btn confirm" onclick="updateStatus('${order.id}', 'confirmed')">
                    <i class="fas fa-check"></i> Tasdiqlash
                </button>
            ` : ''}
            ${order.status === 'confirmed' ? `
                <button class="status-btn complete" onclick="updateStatus('${order.id}', 'completed')">
                    <i class="fas fa-check-double"></i> Bajarildi
                </button>
            ` : ''}
            ${order.status !== 'cancelled' && order.status !== 'completed' ? `
                <button class="status-btn cancel" onclick="updateStatus('${order.id}', 'cancelled')">
                    <i class="fas fa-times"></i> Bekor qilish
                </button>
            ` : ''}
        </div>
    `;

    document.getElementById('orderModal').classList.add('active');
}

// Close modal
function closeModal() {
    document.getElementById('orderModal').classList.remove('active');
}

// Update order status
async function updateStatus(orderId, status) {
    try {
        await api.updateOrderStatus(orderId, status);
        closeModal();
        loadData();
    } catch (error) {
        alert('Xatolik yuz berdi: ' + error.message);
    }
}

// Format price
function formatPrice(price) {
    if (!price) return '0';
    if (price >= 1000000) {
        return (price / 1000000).toFixed(1) + ' mln';
    }
    return price.toLocaleString('uz-UZ');
}

// Close modal on outside click
document.getElementById('orderModal').addEventListener('click', (e) => {
    if (e.target.id === 'orderModal') {
        closeModal();
    }
});

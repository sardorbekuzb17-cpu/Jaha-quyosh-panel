// API Configuration - Production Server
const API_URL = 'https://server-4pvxwb66p-jaha-quyosh-panellaris-projects.vercel.app/api';

// API Service
const api = {
    // Get all orders
    async getOrders() {
        try {
            const response = await fetch(`${API_URL}/orders`);
            const data = await response.json();
            return data.data || [];
        } catch (error) {
            console.error('Error fetching orders:', error);
            return [];
        }
    },

    // Update order status
    async updateOrderStatus(orderId, status) {
        try {
            const response = await fetch(`${API_URL}/orders/${orderId}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ status }),
            });
            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error updating order:', error);
            throw error;
        }
    },

    // Delete order
    async deleteOrder(orderId) {
        try {
            const response = await fetch(`${API_URL}/orders/${orderId}`, {
                method: 'DELETE',
            });
            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error deleting order:', error);
            throw error;
        }
    },

    // Health check
    async checkHealth() {
        try {
            const response = await fetch(`${API_URL}/health`);
            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Server health check failed:', error);
            return null;
        }
    }
};

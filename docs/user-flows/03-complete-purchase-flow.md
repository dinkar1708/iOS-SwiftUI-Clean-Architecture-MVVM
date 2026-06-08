# Flow 03: Complete Purchase Flow

## What to Test
User completes a full purchase from cart to order confirmation.

## Steps
1. Add 2-3 products to cart from Home tab
2. Navigate to Cart tab
3. Review items and total amount
4. Tap "Proceed to Checkout" button at bottom
5. Verify checkout opens in full screen (no tabs visible)
6. Review Order Summary section (items, quantities, subtotal)
7. Check Delivery Address: "Home, 123 Main Street, Bangalore, Karnataka 560001"
8. Verify Payment Method: "Cash on Delivery"
9. Check delivery shows "FREE"
10. Verify total amount matches cart total
11. Tap green "Place Order" button at bottom
12. Watch success screen with checkmark and order number
13. Wait 2 seconds for auto-close
14. App navigates to Orders tab automatically
15. Toast notification appears: "Order #ORD-XXXXX placed successfully!"
16. Toast disappears after 3 seconds
17. Verify cart is now empty (badge gone)
18. See placed order in Orders tab

## Expected Results
- Checkout opens as full screen modal
- All order details display correctly
- Place Order button is visible at bottom
- Success screen shows order number (ORD-12345 format)
- Auto-navigation to Orders tab works
- Toast notification displays and auto-dismisses
- Cart clears after order placement
- Order appears in Order History
- Order shows: order number, date/time, items, total, status "Processing"

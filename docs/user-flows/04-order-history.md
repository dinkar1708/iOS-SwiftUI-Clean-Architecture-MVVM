# Flow 04: Order History

## What to Test
User views and verifies their order history.

## Steps
1. Place 2-3 orders using Flow 03
2. Navigate to Orders tab
3. Verify orders are listed (newest first)
4. Check each order card shows:
   - Order number (ORD-XXXXX)
   - Date and time
   - Status badge ("Processing" in yellow/orange)
   - First 2 items with quantities
   - Total item count
   - Total amount in rupees
5. If order has more than 2 items, check "+ X more items" text
6. Verify orders persist when switching tabs

## Expected Results
- Orders display in reverse chronological order
- Each order card is clearly formatted
- Status badge shows "Processing" with proper color
- Date format: "MMM dd, yyyy 'at' hh:mm a"
- All order details are accurate
- Order data persists during app session
- Empty state shows when no orders exist

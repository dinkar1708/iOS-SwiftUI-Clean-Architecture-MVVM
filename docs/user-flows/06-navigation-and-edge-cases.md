# Flow 06: Navigation and Edge Cases

## What to Test
User navigates through the app and tests edge cases.

## Steps

### Empty States
1. Launch fresh app (no orders, no cart)
2. Check Cart tab shows "Your Cart is Empty"
3. Check Orders tab shows "No Orders Yet"
4. Verify no "Proceed to Checkout" button when cart is empty

### Tab Navigation
5. Tap each tab: Home -> Orders -> Cart -> Profile -> Home
6. Verify smooth transitions (under 50ms)
7. Check tab bar remains at bottom
8. Verify selected tab highlights in purple
9. Check unselected tabs show in gray

### Back Navigation
10. Add items to cart
11. Tap "Proceed to Checkout"
12. Tap back button in navigation bar
13. Verify returns to Cart tab
14. Check items still in cart (unchanged)
15. Verify no order was placed

### Cart Badge
16. Start with empty cart (badge hidden)
17. Add 1 item - badge shows "1"
18. Add 2 more items - badge shows "3"
19. Increase quantity in cart - badge updates
20. Remove all items - badge disappears

### Tab Bar Spacing
21. Check tab bar sits flush at bottom
22. No gap above home indicator area
23. Rounded corners visible at top of tab bar

## Expected Results
- Empty states display proper icons and messages
- Tab switching is instant and smooth
- Back navigation works without losing data
- Cart badge updates correctly in real-time
- Badge disappears when cart is empty
- Checkout can be cancelled without placing order
- Tab bar has no bottom spacing issues
- All animations are smooth
- No crashes or freezes during navigation

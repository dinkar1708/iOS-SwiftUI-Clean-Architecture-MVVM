# Flow 02: Shopping and Cart Management

## What to Test
User adds products to cart and manages quantities.

## Steps
1. Open the app on Home tab
2. Tap "+" button on Google Pixel 4
3. Notice button turns green with checkmark
4. Check cart badge appears with "1"
5. Add iPhone 15 Pro to cart
6. Check cart badge updates to "2"
7. Navigate to Cart tab
8. Verify both products are listed
9. Tap "+" on Google Pixel to increase quantity to 2
10. Check total updates (90,000 x 2 = 180,000 + 45,000 = 225,000)
11. Tap "-" on iPhone to decrease quantity
12. Verify it removes from cart
13. Add Samsung Galaxy S24 to cart from Home
14. Go back to Cart and verify it appears

## Expected Results
- Add button animation works (green checkmark)
- Cart badge shows correct item count
- Cart displays all added items
- Quantity controls (+/-) work properly
- Total amount updates correctly
- Can add items from Home tab
- Items persist when switching tabs
- Each item shows: name, price, quantity, item total

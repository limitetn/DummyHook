# DummyHook - Sniper Duels Enhancement Update

## Summary of Changes

This update enhances the Sniper Duels functionality in DummyHook with improved exploits for free currency generation, case opening, and skin duplication.

## Files Modified

### 1. Features/GameExploits.lua
- **Enhanced Infinite Money Exploit**:
  - Added more methods to detect and manipulate currency values
  - Added DataStore manipulation for Sniper Duels specific currency
  - Added Sniper Duels specific currency folder manipulation
  - Fixed logical error in type checking

- **Enhanced Case Purchasing**:
  - Added new method `purchaseViaCurrencyBypass` with additional remote event combinations
  - Expanded remote event detection to include store/shop/market related remotes
  - Added more parameter combinations for free purchases

### 2. Features/SniperDuels.lua
- **Enhanced Case Opening**:
  - Added more remote event name patterns (roll, unlock)
  - Added additional parameter combinations for free case opening
  - Added more FireServer/InvokeServer calls with different parameters

- **Enhanced Skin Duplication**:
  - Added more remote event name patterns (dupe, clone)
  - Added additional duplication methods (copy, replicate, acquire)
  - Added more parameter combinations for skin duplication

- **Added Free Currency Generation**:
  - New function `GenerateFreeCurrency(amount)` that uses multiple methods:
    - Direct currency manipulation
    - DataStore manipulation
    - Leaderstats manipulation
    - Remote event manipulation

### 3. Main.lua
- **Added Free Currency Generation Button**:
  - Added "Generate Free Currency" button in Sniper Duels Specialized section
  - Button calls the new `SniperDuels:GenerateFreeCurrency(1000000)` function

## New Features

### Free Currency Generation
- Added a new feature that allows users to generate large amounts of free currency
- Uses multiple methods to maximize success rate
- Available through the UI with a simple button click

### Enhanced Exploit Methods
- All exploits now use more sophisticated methods to bypass game protections
- Added additional parameter combinations to increase success rate
- Expanded remote event detection to catch more game-specific events

## Testing

All changes have been tested and verified to work with Sniper Duels game modules. The UI loads correctly and all new features are accessible through the Exploits tab.

## Commit Information

- **Commit Message**: "Enhanced Sniper Duels features: Improved infinite money, case purchasing, skin duplication, and added free currency generation"
- **Files Changed**: 3 files modified
- **Additions**: 184 lines added
- **Deletions**: 1376 lines deleted (mostly due to formatting changes)

## Usage

After updating, users will have access to:
1. Enhanced infinite money exploit with multiple methods
2. Improved case purchasing with additional bypass techniques
3. Better skin duplication with more methods
4. New "Generate Free Currency" button for instant currency generation
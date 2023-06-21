# Add this line to your ox_inventory/data/items.lua
```
	['headbag'] = {
		label = 'Headbag',
		weight = 150,
		stack = true,
		description = "Bag that you can put on other people's heads",
		client = {
			export = 'wx_headbag.headbag',
		},
	},
```

# WARNING!
## If you rename the resource, make sure to also rename the export in items.lua!

# Example:
```
	client = {
		export = 'newresourcename.headbag',
	},
```
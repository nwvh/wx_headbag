# wx_headbag
Simple OX based headbag script for FiveM

![oKzQGvuuKuKS](https://github.com/nwvh/wx_headbag/assets/76164598/fc3e603f-a368-41d8-91be-bde2f104e8a5)
![UUKd3H7W40Ri](https://github.com/nwvh/wx_headbag/assets/76164598/4ee0af00-9bf1-458b-a4b0-bde64121590a)
![FWFF3wZw7N0X](https://github.com/nwvh/wx_headbag/assets/76164598/8802c7fd-9399-4ec7-af8e-d225ef697cc7)
![32JDrK9vKz4L](https://github.com/nwvh/wx_headbag/assets/76164598/d3965757-34c4-4118-8992-cc8beb9d4f90)
![MyNJTlQV2xTO](https://github.com/nwvh/wx_headbag/assets/76164598/d1a4dacf-8e5d-4bd5-9780-1ef2d1ce66d0)
![0OB1NFIUzPWh](https://github.com/nwvh/wx_headbag/assets/76164598/56169265-3e78-45b9-b2a3-f6a76351e254)


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

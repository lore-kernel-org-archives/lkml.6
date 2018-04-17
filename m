Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeDQSd7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 14:33:59 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35102 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeDQSd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 14:33:57 -0400
X-Google-Smtp-Source: AIpwx4/fmtMnCopOeScBBujkPGT7/pl5DXANM8IFXN66ymfUtS1mgYFa4cQg3EWYxksQ3w+OPW6Zdw==
Subject: Re: [PATCH net-next 3/3] net: phy: Enable C45 PHYs with vendor
 specific address space
To: vicentiu.galanopulo@nxp.com, andrew@lunn.ch, robh@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, marcel@holtmann.org,
        devicetree@vger.kernel.org
Cc: alexandru.marginean@nxp.com, madalin.bucur@nxp.com
References: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
 <20180417090233.21548-4-vicentiu.galanopulo@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <b62735bd-d411-2d21-16a2-f6cf7e5d7e4d@gmail.com>
Date: Tue, 17 Apr 2018 11:27:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417090233.21548-4-vicentiu.galanopulo@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 02:02 AM, Vicentiu Galanopulo wrote:
> A search of the dev-addr property is done in of_mdiobus_register.
> If the property is found in the PHY node, of_mdiobus_register_vend_spec_phy()
> is called. This is a wrapper function for of_mdiobus_register_phy()
> which finds the device in package based on dev-addr, and fills
> devices_addrs, which is a new field added to phy_c45_device_ids.
> This new field will store the dev-addr property on the same index
> where the device in package has been found.
> 
> The of_mdiobus_register_phy() now contains an extra parameter,
> which is struct phy_c45_device_ids *c45_ids.
> If c45_ids is not NULL, get_vend_spec_addr_phy_device() is called
> and c45_ids are propagated all the way to get_phy_c45_ids().
> 
> Having dev-addr stored in devices_addrs, in get_phy_c45_ids(),
> when probing the identifiers, dev-addr can be extracted from
> devices_addrs and probed if devices_addrs[current_identifier] is not 0.

I must clearly be missing something, but why are you introducing all
these conditionals instead of updating the existing code to be able to
operate against an arbitrary dev-addr value, and then just making sure
the first thing you do is fetch that property from Device Tree? There is
no way someone is going to be testing with your specific use case in the
future (except yourselves) so unless you make supporting an arbitrary
"dev-addr" value become part of how the code works, this is going to be
breaking badly.

And please, can you keep me copied for next submissions?

> 
> Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
> ---
>  drivers/net/phy/phy_device.c |  49 +++++++++++++++++--
>  drivers/of/of_mdio.c         | 113 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/phy.h          |  14 ++++++
>  3 files changed, 169 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index ac23322..5c79fd8 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -457,7 +457,7 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
>  static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
>  			   struct phy_c45_device_ids *c45_ids) {
>  	int phy_reg;
> -	int i, reg_addr;
> +	int i, reg_addr, dev_addr;
>  	const int num_ids = ARRAY_SIZE(c45_ids->device_ids);
>  	u32 *devs = &c45_ids->devices_in_package;
>  
> @@ -493,13 +493,23 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
>  		if (!(c45_ids->devices_in_package & (1 << i)))
>  			continue;
>  
> -		reg_addr = MII_ADDR_C45 | i << 16 | MII_PHYSID1;
> +		/* if c45_ids->devices_addrs for the current id is not 0,
> +		 * then dev-addr was defined in the PHY device tree node,
> +		 * and the PHY has been seen as a valid device, and added
> +		 * in the package. In this case we can use the
> +		 * dev-addr(c45_ids->devices_addrs[i]) to do the MDIO
> +		 * reading of the PHY ID.
> +		 */
> +		dev_addr = !!c45_ids->devices_addrs[i] ?
> +					c45_ids->devices_addrs[i] : i;
> +
> +		reg_addr = MII_ADDR_C45 | dev_addr << 16 | MII_PHYSID1;
>  		phy_reg = mdiobus_read(bus, addr, reg_addr);
>  		if (phy_reg < 0)
>  			return -EIO;
>  		c45_ids->device_ids[i] = (phy_reg & 0xffff) << 16;
>  
> -		reg_addr = MII_ADDR_C45 | i << 16 | MII_PHYSID2;
> +		reg_addr = MII_ADDR_C45 | dev_addr << 16 | MII_PHYSID2;
>  		phy_reg = mdiobus_read(bus, addr, reg_addr);
>  		if (phy_reg < 0)
>  			return -EIO;
> @@ -551,6 +561,39 @@ static int get_phy_id(struct mii_bus *bus, int addr, u32 *phy_id,
>  }
>  
>  /**
> + * get_vend_spec_addr_phy_device - reads the specified PHY device
> + *				   and returns its @phy_device struct
> + * @bus: the target MII bus
> + * @addr: PHY address on the MII bus
> + * @is_c45: If true the PHY uses the 802.3 clause 45 protocol
> + * @c45_ids: Query the c45_ids to see if a PHY with a vendor specific
> + *           register address space was defined in the PHY device tree
> + *           node by adding the "dev-addr" property to the node.
> + *           Store the c45 ID information about the rest of the PHYs
> + *           found PHYs on the MDIO bus during probing.
> + *
> + * Description: Reads the ID registers of the PHY at @addr on the
> + *   @bus, then allocates and returns the phy_device to represent it.
> + */
> +struct phy_device *get_vend_spec_addr_phy_device(struct mii_bus *bus,
> +						 int addr, bool is_c45,
> +						 struct phy_c45_device_ids *c45_ids)
> +{
> +	u32 phy_id = 0;
> +	int r;
> +
> +	r = get_phy_id(bus, addr, &phy_id, is_c45, c45_ids);
> +	if (r)
> +		return ERR_PTR(r);
> +
> +	/* If the phy_id is mostly Fs, there is no device there */
> +	if ((phy_id & 0x1fffffff) == 0x1fffffff)
> +		return ERR_PTR(-ENODEV);
> +
> +	return phy_device_create(bus, addr, phy_id, is_c45, c45_ids);
> +}
> +
> +/**
>   * get_phy_device - reads the specified PHY device and returns its @phy_device
>   *		    struct
>   * @bus: the target MII bus
> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
> index 8c0c927..52e8bfb 100644
> --- a/drivers/of/of_mdio.c
> +++ b/drivers/of/of_mdio.c
> @@ -45,7 +45,8 @@ static int of_get_phy_id(struct device_node *device, u32 *phy_id)
>  }
>  
>  static int of_mdiobus_register_phy(struct mii_bus *mdio,
> -				    struct device_node *child, u32 addr)
> +				   struct device_node *child, u32 addr,
> +				   struct phy_c45_device_ids *c45_ids)
>  {
>  	struct phy_device *phy;
>  	bool is_c45;
> @@ -58,7 +59,12 @@ static int of_mdiobus_register_phy(struct mii_bus *mdio,
>  	if (!is_c45 && !of_get_phy_id(child, &phy_id))
>  		phy = phy_device_create(mdio, addr, phy_id, 0, NULL);
>  	else
> -		phy = get_phy_device(mdio, addr, is_c45);
> +		if (c45_ids)
> +			phy = get_vend_spec_addr_phy_device(mdio,
> +							    addr, is_c45,
> +							    c45_ids);
> +		else
> +			phy = get_phy_device(mdio, addr, is_c45);
>  	if (IS_ERR(phy))
>  		return PTR_ERR(phy);
>  
> @@ -190,6 +196,72 @@ static bool of_mdiobus_child_is_phy(struct device_node *child)
>  	return false;
>  }
>  
> +static void of_fill_c45_devices_addrs(u32 dev_addr,
> +				      struct phy_c45_device_ids *c45_ids)
> +{
> +	int i;
> +	const int num_ids = ARRAY_SIZE(c45_ids->device_ids);
> +
> +	/* Search through all Device Identifiers
> +	 * and set dev_addr in c45_ids->devices_addrs,
> +	 * if the device bit is set in
> +	 * c45_ids->devices_in_package
> +	 */
> +	for (i = 1; i < num_ids; i++) {
> +		if (!(c45_ids->devices_in_package & (1 << i)))
> +			continue;
> +
> +		c45_ids->devices_addrs[i] = dev_addr;
> +	}
> +}
> +
> +static int of_find_devaddr_in_pkg(struct mii_bus *bus, u32 addr, u32 dev_addr,
> +				  struct phy_c45_device_ids *c45_ids)
> +{
> +	u32 *devs = &c45_ids->devices_in_package;
> +	int phy_reg, reg_addr;
> +
> +	reg_addr = MII_ADDR_C45 | dev_addr << 16 | MDIO_DEVS2;
> +	phy_reg = mdiobus_read(bus, addr, reg_addr);
> +	if (phy_reg < 0)
> +		return -EIO;
> +
> +	*devs = (phy_reg & 0xffff) << 16;
> +
> +	reg_addr = MII_ADDR_C45 | dev_addr << 16 | MDIO_DEVS1;
> +	phy_reg = mdiobus_read(bus, addr, reg_addr);
> +	if (phy_reg < 0)
> +		return -EIO;
> +
> +	*devs |= (phy_reg & 0xffff);
> +
> +	return 0;
> +}
> +
> +/*
> + * Finds the device in package and populates the c45_ids
> + * if any device is found at dev_addr address. After this
> + * the PHY is registered
> + */
> +static int of_mdiobus_register_vend_spec_phy(struct mii_bus *mdio,
> +					     struct device_node *child,
> +					     u32 addr, u32 dev_addr)
> +{
> +	struct phy_c45_device_ids c45_ids = {0};
> +	int dev_err = 0;
> +
> +	if (!dev_addr)
> +		goto register_phy;
> +
> +	dev_err = of_find_devaddr_in_pkg(mdio, addr, dev_addr, &c45_ids);
> +
> +	if (!dev_err)
> +		of_fill_c45_devices_addrs(dev_addr, &c45_ids);
> +
> +register_phy:
> +	return of_mdiobus_register_phy(mdio, child, addr, &c45_ids);
> +}
> +
>  /**
>   * of_mdiobus_register - Register mii_bus and create PHYs from the device tree
>   * @mdio: pointer to mii_bus structure
> @@ -202,7 +274,10 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>  {
>  	struct device_node *child;
>  	bool scanphys = false;
> +	bool dev_addr_found = true;
>  	int addr, rc;
> +	int dev_addr = 0;
> +	int ret;
>  
>  	/* Do not continue if the node is disabled */
>  	if (!of_device_is_available(np))
> @@ -226,6 +301,14 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>  
>  	/* Loop over the child nodes and register a phy_device for each phy */
>  	for_each_available_child_of_node(np, child) {
> +		/* Check if dev-addr is set in the PHY node */
> +		ret = of_property_read_u32(child, "dev-addr", &dev_addr);
> +
> +		if (ret < 0) {
> +			/* either not set or invalid */
> +			dev_addr_found = false;
> +		}
> +
>  		addr = of_mdio_parse_addr(&mdio->dev, child);
>  		if (addr < 0) {
>  			scanphys = true;
> @@ -233,7 +316,14 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>  		}
>  
>  		if (of_mdiobus_child_is_phy(child))
> -			rc = of_mdiobus_register_phy(mdio, child, addr);
> +			if (dev_addr_found)
> +				rc = of_mdiobus_register_vend_spec_phy(mdio,
> +								       child,
> +								       addr,
> +								       dev_addr);
> +			else
> +				rc = of_mdiobus_register_phy(mdio, child,
> +							     addr, NULL);
>  		else
>  			rc = of_mdiobus_register_device(mdio, child, addr);
>  
> @@ -248,8 +338,16 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>  	if (!scanphys)
>  		return 0;
>  
> +	/* reset device found variable */
> +	dev_addr_found = true;
> +
>  	/* auto scan for PHYs with empty reg property */
>  	for_each_available_child_of_node(np, child) {
> +		/* Check if dev-addr is set in the PHY node,
> +		 * for PHYs which don't have reg property set
> +		 */
> +		ret = of_property_read_u32(child, "dev-addr", &dev_addr);
> +
>  		/* Skip PHYs with reg property set */
>  		if (of_find_property(child, "reg", NULL))
>  			continue;
> @@ -264,7 +362,14 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>  				 child->name, addr);
>  
>  			if (of_mdiobus_child_is_phy(child)) {
> -				rc = of_mdiobus_register_phy(mdio, child, addr);
> +				if (dev_addr_found)
> +					rc = of_mdiobus_register_vend_spec_phy(mdio,
> +									       child,
> +									       addr,
> +									       dev_addr);
> +				else
> +					rc = of_mdiobus_register_phy(mdio, child,
> +								     addr, NULL);
>  				if (rc && rc != -ENODEV)
>  					goto unregister;
>  			}
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 26aa320..889d85e 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -357,10 +357,13 @@ enum phy_state {
>   * struct phy_c45_device_ids - 802.3-c45 Device Identifiers
>   * @devices_in_package: Bit vector of devices present.
>   * @device_ids: The device identifer for each present device.
> + * @devices_addrs: The devices addresses from the device tree
> + *		   for each present device.
>   */
>  struct phy_c45_device_ids {
>  	u32 devices_in_package;
>  	u32 device_ids[32];
> +	u32 devices_addrs[32];
>  };
>  
>  /* phy_device: An instance of a PHY
> @@ -904,6 +907,9 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, int phy_id,
>  				     struct phy_c45_device_ids *c45_ids);
>  #if IS_ENABLED(CONFIG_PHYLIB)
>  struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45);
> +struct phy_device *get_vend_spec_addr_phy_device(struct mii_bus *bus, int addr,
> +						 bool is_c45,
> +						 struct phy_c45_device_ids *c45_ids);
>  int phy_device_register(struct phy_device *phy);
>  void phy_device_free(struct phy_device *phydev);
>  #else
> @@ -913,6 +919,14 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
>  	return NULL;
>  }
>  
> +static inline
> +struct phy_device *get_vend_spec_addr_phy_device(struct mii_bus *bus, int addr,
> +						 bool is_c45,
> +						 struct phy_c45_device_ids *c45_ids)
> +{
> +	return NULL;
> +}
> +
>  static inline int phy_device_register(struct phy_device *phy)
>  {
>  	return 0;
> 


-- 
Florian

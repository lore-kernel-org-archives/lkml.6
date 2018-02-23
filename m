Return-Path: <Vitor.Soares@synopsys.com>
X-Google-Smtp-Source: AH8x226H1bZZaMbtK/Vk1ku/XBc3MiI2nyO0GOGzNvnTgbvnF38XO2YdtmxC2QmjAktsfHu2a7fm
ARC-Seal: i=1; a=rsa-sha256; t=1519403337; cv=none;
        d=google.com; s=arc-20160816;
        b=cPqSsB9dM3JvAdi7tvMHVjOKA43GCbwP95X510oKeYlkpF7x6a209OxOoeP9th8zi5
         zTgIPz5QThs63w9PuYbbFIauGKKrRZuGU1CZWITxVjPGnwmmOUXOKCf8J8nYDiQ5YGE0
         oSkXo+3lQXr+7fpFVHaSVJZFJmjxb1jiKnIhDvpgb9ZfsPmxozQU9hKUaCzqRCDJ6Y1M
         vVFDyYEmIJeX0EliIbh7KspDufnqdI09Gf1To1dranCliJBx489IcDqyasbvgx2k7bYi
         GR6c08B5a8IDtZo6nYV6H93aWOEOBCbUP1cf4au7pJAwlSPnWtAo+pgQUxIEA+P6YN4Z
         JBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:in-reply-to:mime-version:user-agent:date
         :message-id:references:cc:to:subject:from:arc-authentication-results;
        bh=rqf/MpqjaqXG7vp77aN6DvzsDlQfTlPnz8xOjKjFcuI=;
        b=lzOvohcCacw9Pwjnd+dvt/LAwCnHDvORdr90nY/IKEKh+C33wQsGPuis1IMC7mdgt0
         sgD4TpWRHWebb2EZLL6vuQLd7bV4XAMA1vkE9NA2gJUvIEMYimS4k7KfjnWOJpfLcpjU
         EAY4jhT2hCOE26K2oR6y2F1RI21grttxo95EK7JuWAYkvd49juPsVbwn6YIFLg4xQ21X
         GMO12oqS5AdGSnDsem/frVaUzk6aXWek6BiBzcSR6QwUXPR2Az+Dy7oq7+neOH6kU0cd
         JP6gMoF+K3X8+rV58fZmBZ198oStg4XTx/xXDuoJLloVv2/tBqA7AamfJ7paj5Xn1TCb
         F/6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of vitor.soares@synopsys.com designates 198.182.47.9 as permitted sender) smtp.mailfrom=Vitor.Soares@synopsys.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of vitor.soares@synopsys.com designates 198.182.47.9 as permitted sender) smtp.mailfrom=Vitor.Soares@synopsys.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
From: Vitor Soares <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Wolfram Sang
	<wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
CC: Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec
	<agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta
	<bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak
	<alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose
	<sureshp@cadence.com>, Thomas Petazzoni
	<thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, "Rob
 Herring" <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "Kumar
 Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij
	<linus.walleij@linaro.org>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
 <20171214151610.19153-3-boris.brezillon@free-electrons.com>
Message-ID: <03c24385-26bb-4284-cc05-92397e0325e4@synopsys.com>
Date: Fri, 23 Feb 2018 16:28:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20171214151610.19153-3-boris.brezillon@free-electrons.com>
Content-Type: multipart/alternative;
	boundary="------------A0BB601FD83C89E4F6A1B8E3"
Content-Language: pt-PT
X-Originating-IP: [10.107.19.86]
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586772916728163872?=
X-GMAIL-MSGID: =?utf-8?q?1593209873912756054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--------------A0BB601FD83C89E4F6A1B8E3
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Boris,


Às 3:16 PM de 12/14/2017, Boris Brezillon escreveu:
> +
> +enum i3c_addr_slot_status i3c_bus_get_addr_slot_status(struct i3c_bus *bus,
> +						       u16 addr)
> +{
> +	int status, bitpos = addr * 2;
> +
> +	if (addr > I2C_MAX_ADDR)
> +		return I3C_ADDR_SLOT_RSVD;
> +
> +	status = bus->addrslots[bitpos / BITS_PER_LONG];
> +	status >>= bitpos % BITS_PER_LONG;
> +
> +	return status & I3C_ADDR_SLOT_STATUS_MASK;
> +}
I don't understand the size of addr. The I3C only allow 7-bit addresses.

Is the addrslots used to store the addresses and its status?
> +
> +void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
> +				  enum i3c_addr_slot_status status)
> +{
> +	int bitpos = addr * 2;
> +	unsigned long *ptr;
> +
> +	if (addr > I2C_MAX_ADDR)
> +		return;
> +
> +	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
> +	*ptr &= ~(I3C_ADDR_SLOT_STATUS_MASK << (bitpos % BITS_PER_LONG));
> +	*ptr |= status << (bitpos % BITS_PER_LONG);
> +}
> +
> +bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
> +{
> +	enum i3c_addr_slot_status status;
> +
> +	status = i3c_bus_get_addr_slot_status(bus, addr);
> +
> +	return status == I3C_ADDR_SLOT_FREE;
> +}
> +
> +int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
> +{
> +	enum i3c_addr_slot_status status;
> +	u8 addr;
> +
> +	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
> +		status = i3c_bus_get_addr_slot_status(bus, addr);
> +		if (status == I3C_ADDR_SLOT_FREE)
> +			return addr;
> +	}
> +
> +	return -ENOMEM;
> +}
> +
> +static void i3c_bus_init_addrslots(struct i3c_bus *bus)
> +{
> +	int i;
> +
> +	/* Addresses 0 to 7 are reserved. */
> +	for (i = 0; i < 8; i++)
> +		i3c_bus_set_addr_slot_status(bus, i, I3C_ADDR_SLOT_RSVD);
> +
> +	/*
> +	 * Reserve broadcast address and all addresses that might collide
> +	 * with the broadcast address when facing a single bit error.
> +	 */
> +	i3c_bus_set_addr_slot_status(bus, I3C_BROADCAST_ADDR,
> +				     I3C_ADDR_SLOT_RSVD);
> +	for (i = 0; i < 7; i++)
> +		i3c_bus_set_addr_slot_status(bus, I3C_BROADCAST_ADDR ^ BIT(i),
> +					     I3C_ADDR_SLOT_RSVD);
> +}
> +
> +static const char * const i3c_bus_mode_strings[] = {
> +	[I3C_BUS_MODE_PURE] = "pure",
> +	[I3C_BUS_MODE_MIXED_FAST] = "mixed-fast",
> +	[I3C_BUS_MODE_MIXED_SLOW] = "mixed-slow",
> +};
> +
> +static ssize_t mode_show(struct device *dev,
> +			 struct device_attribute *da,
> +			 char *buf)
> +{
> +	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(i3cbus);
> +	if (i3cbus->mode < 0 ||
> +	    i3cbus->mode > ARRAY_SIZE(i3c_bus_mode_strings) ||
> +	    !i3c_bus_mode_strings[i3cbus->mode])
> +		ret = sprintf(buf, "unknown\n");
> +	else
> +		ret = sprintf(buf, "%s\n", i3c_bus_mode_strings[i3cbus->mode]);
> +	i3c_bus_normaluse_unlock(i3cbus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(mode);
> +
> +static ssize_t current_master_show(struct device *dev,
> +				   struct device_attribute *da,
> +				   char *buf)
> +{
> +	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(i3cbus);
> +	ret = sprintf(buf, "%s\n", dev_name(&i3cbus->cur_master->dev));
> +	i3c_bus_normaluse_unlock(i3cbus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(current_master);
> +
> +static ssize_t i3c_scl_frequency_show(struct device *dev,
> +				      struct device_attribute *da,
> +				      char *buf)
> +{
> +	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(i3cbus);
> +	ret = sprintf(buf, "%ld\n", i3cbus->scl_rate.i3c);
> +	i3c_bus_normaluse_unlock(i3cbus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(i3c_scl_frequency);
> +
> +static ssize_t i2c_scl_frequency_show(struct device *dev,
> +				      struct device_attribute *da,
> +				      char *buf)
> +{
> +	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
> +	ssize_t ret;
> +
> +	i3c_bus_normaluse_lock(i3cbus);
> +	ret = sprintf(buf, "%ld\n", i3cbus->scl_rate.i2c);
> +	i3c_bus_normaluse_unlock(i3cbus);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(i2c_scl_frequency);
> +
> +static struct attribute *i3c_busdev_attrs[] = {
> +	&dev_attr_mode.attr,
> +	&dev_attr_current_master.attr,
> +	&dev_attr_i3c_scl_frequency.attr,
> +	&dev_attr_i2c_scl_frequency.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(i3c_busdev);
> +
> +static void i3c_busdev_release(struct device *dev)
> +{
> +	struct i3c_bus *bus = container_of(dev, struct i3c_bus, dev);
> +
> +	while (!list_empty(&bus->devs.i2c)) {
> +		struct i2c_device *i2cdev;
> +
> +		i2cdev = list_first_entry(&bus->devs.i2c, struct i2c_device,
> +					  common.node);
> +		list_del(&i2cdev->common.node);
> +		of_node_put(i2cdev->info.of_node);
> +		kfree(i2cdev);
> +	}
> +
> +	while (!list_empty(&bus->devs.i3c)) {
> +		struct i3c_device *i3cdev;
> +
> +		i3cdev = list_first_entry(&bus->devs.i3c, struct i3c_device,
> +					  common.node);
> +		list_del(&i3cdev->common.node);
> +		put_device(&i3cdev->dev);
> +	}
> +
> +	mutex_lock(&i3c_core_lock);
> +	idr_remove(&i3c_bus_idr, bus->id);
> +	mutex_unlock(&i3c_core_lock);
> +
> +	of_node_put(bus->dev.of_node);
> +	kfree(bus);
> +}
> +
> +static const struct device_type i3c_busdev_type = {
> +	.groups	= i3c_busdev_groups,
> +};
> +
> +void i3c_bus_unref(struct i3c_bus *bus)
> +{
> +	put_device(&bus->dev);
> +}
> +
> +struct i3c_bus *i3c_bus_create(struct device *parent)
> +{
> +	struct i3c_bus *i3cbus;
> +	int ret;
> +
> +	i3cbus = kzalloc(sizeof(*i3cbus), GFP_KERNEL);
> +	if (!i3cbus)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init_rwsem(&i3cbus->lock);
> +	INIT_LIST_HEAD(&i3cbus->devs.i2c);
> +	INIT_LIST_HEAD(&i3cbus->devs.i3c);
> +	i3c_bus_init_addrslots(i3cbus);
> +	i3cbus->mode = I3C_BUS_MODE_PURE;
> +	i3cbus->dev.parent = parent;
> +	i3cbus->dev.of_node = of_node_get(parent->of_node);
> +	i3cbus->dev.bus = &i3c_bus_type;
> +	i3cbus->dev.type = &i3c_busdev_type;
> +	i3cbus->dev.release = i3c_busdev_release;
> +
> +	mutex_lock(&i3c_core_lock);
> +	ret = idr_alloc(&i3c_bus_idr, i3cbus, 0, 0, GFP_KERNEL);
> +	mutex_unlock(&i3c_core_lock);
> +	if (ret < 0)
> +		goto err_free_bus;
> +
> +	i3cbus->id = ret;
> +	device_initialize(&i3cbus->dev);
> +
> +	return i3cbus;
> +
> +err_free_bus:
> +	kfree(i3cbus);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +void i3c_bus_unregister(struct i3c_bus *bus)
> +{
> +	device_unregister(&bus->dev);
> +}
> +
> +int i3c_bus_register(struct i3c_bus *i3cbus)
> +{
> +	struct i2c_device *i2cdev;
> +
> +	i3c_bus_for_each_i2cdev(i3cbus, i2cdev) {
> +		switch (i2cdev->lvr & I3C_LVR_I2C_INDEX_MASK) {
> +		case I3C_LVR_I2C_INDEX(0):
> +			if (i3cbus->mode < I3C_BUS_MODE_MIXED_FAST)
> +				i3cbus->mode = I3C_BUS_MODE_MIXED_FAST;
> +			break;
> +
> +		case I3C_LVR_I2C_INDEX(1):
> +		case I3C_LVR_I2C_INDEX(2):
> +			if (i3cbus->mode < I3C_BUS_MODE_MIXED_SLOW)
> +				i3cbus->mode = I3C_BUS_MODE_MIXED_SLOW;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!i3cbus->scl_rate.i3c)
> +		i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
> +
> +	if (!i3cbus->scl_rate.i2c) {
> +		if (i3cbus->mode == I3C_BUS_MODE_MIXED_SLOW)
> +			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
> +		else
> +			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
> +	}
> +
> +	/*
> +	 * I3C/I2C frequency may have been overridden, check that user-provided
> +	 * values are not exceeding max possible frequency.
> +	 */
> +	if (i3cbus->scl_rate.i3c > I3C_BUS_MAX_I3C_SCL_RATE ||
> +	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_RATE) {
> +		return -EINVAL;
> +	}
> +
> +	dev_set_name(&i3cbus->dev, "i3c-%d", i3cbus->id);
> +
> +	return device_add(&i3cbus->dev);
> +}
> +
> +static int __init i3c_init(void)
> +{
> +	return bus_register(&i3c_bus_type);
> +}
> +subsys_initcall(i3c_init);
> +
> +static void __exit i3c_exit(void)
> +{
> +	idr_destroy(&i3c_bus_idr);
> +	bus_unregister(&i3c_bus_type);
> +}
> +module_exit(i3c_exit);
> +
> +MODULE_AUTHOR("Boris Brezillon<boris.brezillon@free-electrons.com>");
> +MODULE_DESCRIPTION("I3C core");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> new file mode 100644
> index 000000000000..dcf51150b7cb
> --- /dev/null
> +++ b/drivers/i3c/device.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017 Cadence Design Systems Inc.
> + *
> + * Author: Boris Brezillon<boris.brezillon@free-electrons.com>
> + */
> +
> +#include <linux/slab.h>
> +
> +#include "internals.h"
> +
> +/**
> + * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
> + *				specific device
> + *
> + * @dev: device with which the transfers should be done
> + * @xfers: array of transfers
> + * @nxfers: number of transfers
> + *
> + * Initiate one or several private SDR transfers with @dev.
> + *
> + * This function can sleep and thus cannot be called in atomic context.
> + *
> + * Return: 0 in case of success, a negative error core otherwise.
> + */
> +int i3c_device_do_priv_xfers(struct i3c_device *dev,
> +			     struct i3c_priv_xfer *xfers,
> +			     int nxfers)
> +{
> +	struct i3c_master_controller *master;
> +	int i, ret;
> +
> +	master = i3c_device_get_master(dev);
> +	if (!master)
> +		return -EINVAL;
> +
> +	i3c_bus_normaluse_lock(master->bus);
> +	for (i = 0; i < nxfers; i++)
> +		xfers[i].addr = dev->info.dyn_addr;
> +
> +	ret = i3c_master_do_priv_xfers_locked(master, xfers, nxfers);
> +	i3c_bus_normaluse_unlock(master->bus);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
The controller should know the speed mode for each xfer. The SDR0 mode 
is used by default but if any device have read or write speed 
limitations the controller can use SDRx.

This could be also applied to i2c transfers.
> +#endif /* I3C_INTERNAL_H */
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> new file mode 100644
> index 000000000000..1c85abac08d5
> --- /dev/null
> +++ b/drivers/i3c/master.c
> @@ -0,0 +1,1433 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017 Cadence Design Systems Inc.
> + *
> + * Author: Boris Brezillon<boris.brezillon@free-electrons.com>
> + */
> +
> +#include <linux/slab.h>
> +
> +#include "internals.h"
> +
> +/**
> + * i3c_master_entdaa_locked() - start a DAA (Dynamic Address Assignment)
> + *				procedure
> + * @master: master used to send frames on the bus
> + *
> + * Send a ENTDAA CCC command to start a DAA procedure.
> + *
> + * Note that this function only sends the ENTDAA CCC command, all the logic
> + * behind dynamic address assignment has to be handled in the I3C master
> + * driver.
> + *
> + * This function must be called with the bus lock held in write mode.
> + *
> + * Return: 0 in case of success, a negative error code otherwise.
> + */
> +int i3c_master_entdaa_locked(struct i3c_master_controller *master)
> +{
> +	struct i3c_ccc_cmd_dest dest = { };
> +	struct i3c_ccc_cmd cmd = { };
> +	int ret;
> +
> +	dest.addr = I3C_BROADCAST_ADDR;
> +	cmd.dests = &dest;
> +	cmd.ndests = 1;
> +	cmd.rnw = false;
> +	cmd.id = I3C_CCC_ENTDAA;
> +
> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_entdaa_locked);
can you explain the process?  the command is only execute once, what if 
there is more devices on the bus?
> +
> +/**
> + * i3c_master_defslvs_locked() - send a DEFSLVS CCC command
> + * @master: master used to send frames on the bus
> + *
> + * Send a DEFSLVS CCC command containing all the devices known to the @master.
> + * This is useful when you have secondary masters on the bus to propagate
> + * device information.
> + *
> + * This should be called after all I3C devices have been discovered (in other
> + * words, after the DAA procedure has finished) and instantiated in
> + * i3c_master_controller_ops->bus_init().
> + * It should also be called if a master ACKed an Hot-Join request and assigned
> + * a dynamic address to the device joining the bus.
> + *
> + * This function must be called with the bus lock held in write mode.
> + *
> + * Return: 0 in case of success, a negative error code otherwise.
> + */
> +int i3c_master_defslvs_locked(struct i3c_master_controller *master)
> +{
> +	struct i3c_ccc_cmd_dest dest = {
> +		.addr = I3C_BROADCAST_ADDR,
> +	};
> +	struct i3c_ccc_cmd cmd = {
> +		.id = I3C_CCC_DEFSLVS,
> +		.dests = &dest,
> +		.ndests = 1,
> +	};
> +	struct i3c_ccc_defslvs *defslvs;
> +	struct i3c_ccc_dev_desc *desc;
> +	struct i3c_device *i3cdev;
> +	struct i2c_device *i2cdev;
> +	struct i3c_bus *bus;
> +	bool send = false;
> +	int ndevs = 0, ret;
> +
> +	if (!master)
> +		return -EINVAL;
> +
> +	bus = i3c_master_get_bus(master);
> +	i3c_bus_for_each_i3cdev(bus, i3cdev) {
> +		ndevs++;
> +		if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) == I3C_BCR_I3C_MASTER)
> +			send = true;
> +	}
> +
> +	/* No other master on the bus, skip DEFSLVS. */
> +	if (!send)
> +		return 0;
> +
> +	i3c_bus_for_each_i2cdev(bus, i2cdev)
> +		ndevs++;
> +
> +	dest.payload.len = sizeof(*defslvs) +
> +			   ((ndevs - 1) * sizeof(struct i3c_ccc_dev_desc));
> +	defslvs = kzalloc(dest.payload.len, GFP_KERNEL);
> +	if (!defslvs)
> +		return -ENOMEM;
> +
> +	dest.payload.data = defslvs;
> +
> +	defslvs->count = ndevs;
> +	defslvs->master.bcr = master->this->info.bcr;
> +	defslvs->master.dcr = master->this->info.dcr;
> +	defslvs->master.dyn_addr = master->this->info.dyn_addr;
> +	defslvs->master.static_addr = I3C_BROADCAST_ADDR;
Why defslvs->master.static_addr = I3C_BROADCAST_ADDR?
> +
> +	desc = defslvs->slaves;
> +	i3c_bus_for_each_i2cdev(bus, i2cdev) {
> +		desc->lvr = i2cdev->lvr;
> +		desc->static_addr = i2cdev->info.addr;
> +		desc++;
> +	}
> +
> +	i3c_bus_for_each_i3cdev(bus, i3cdev) {
> +		/* Skip the I3C dev representing this master. */
> +		if (i3cdev == master->this)
> +			continue;
> +
> +		desc->bcr = i3cdev->info.bcr;
> +		desc->dcr = i3cdev->info.dcr;
> +		desc->dyn_addr = i3cdev->info.dyn_addr;
> +		desc->static_addr = i3cdev->info.static_addr;
> +		desc++;
> +	}
> +
> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	kfree(defslvs);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_defslvs_locked);
> +
>
>
>
>
> +
> +static int i3c_master_i2c_adapter_xfer(struct i2c_adapter *adap,
> +				       struct i2c_msg *xfers, int nxfers)
> +{
> +	struct i3c_master_controller *master = i2c_adapter_to_i3c_master(adap);
> +	int i, ret;
> +
> +	for (i = 0; i < nxfers; i++) {
> +		enum i3c_addr_slot_status status;
> +
> +		status = i3c_bus_get_addr_slot_status(master->bus,
> +						      xfers[i].addr);
> +		if (status != I3C_ADDR_SLOT_I2C_DEV)
> +			return -EINVAL;
> +	}
> +
> +	ret = i3c_master_do_i2c_xfers(master, xfers, nxfers);
> +	if (ret)
> +		return ret;
> +
> +	return nxfers;
> +}
> +
> +static u32 i3c_master_i2c_functionalities(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
> +}
Is I2C_FUNC_10BIT_ADDR allowed ?
> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
> new file mode 100644
> index 000000000000..ff3e1a3e2c4c
> --- /dev/null
> +++ b/include/linux/i3c/ccc.h
> @@ -0,0 +1,380 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2017 Cadence Design Systems Inc.
> + *
> + * Author: Boris Brezillon<boris.brezillon@free-electrons.com>
> + */
> +
> +
> +/**
> + * enum i3c_ccc_test_mode - enum listing all available test modes
> + *
> + * @I3C_CCC_EXIT_TEST_MODE: exit test mode
> + * @I3C_CCC_VENDOR_TEST_MODE: enter vendor test mode
> + */
> +enum i3c_ccc_test_mode {
> +	I3C_CCC_EXIT_TEST_MODE,
> +	I3C_CCC_VENDOR_TEST_MODE,
> +};
> +
> +/**
> + * struct i3c_ccc_enttm - payload passed to ENTTM CCC
> + *
> + * @mode: one of the &enum i3c_ccc_test_mode modes
> + *
> + * Information passed to the ENTTM CCC to instruct an I3C device to enter a
> + * specific test mode.
> + */
> +struct i3c_ccc_enttm {
> +	u8 mode;
> +} __packed;
> +
> +/**
> + * struct i3c_ccc_setda - payload passed to ENTTM CCC
> + *
> + * @mode: one of the &enum i3c_ccc_test_mode modes
> + *
> + * Information passed to the ENTTM CCC to instruct an I3C device to enter a
> + * specific test mode.
> + */
> +struct i3c_ccc_setda {
> +	u8 addr;
> +} __packed;
what do you mean with struct? Maybe setdasa? if so, what is the addr?
> +/**
> + * enum i3c_sdr_max_data_rate - max data rate values for private SDR transfers
> + */
> +enum i3c_sdr_max_data_rate {
> +	I3C_SDR_DR_FSCL_MAX,
> +	I3C_SDR_DR_FSCL_8MHZ,
> +	I3C_SDR_DR_FSCL_6MHZ,
> +	I3C_SDR_DR_FSCL_4MHZ,
> +	I3C_SDR_DR_FSCL_2MHZ,
> +};
Can you change the names to:

I3C_SDR0_FSCL_MAX,
I3C_SDR1_FSCL_8MHZ,
I3C_SDR2_FSCL_6MHZ,
I3C_SDR3_FSCL_4MHZ,
I3C_SDR4_FSCL_2MHZ,

thus the data rate isn't repeated.

> +
> +/**
> + * enum i3c_tsco - clock to data turn-around
> + */
> +enum i3c_tsco {
> +	I3C_TSCO_LT_8NS,
> +	I3C_TSCO_LT_9NS,
> +	I3C_TSCO_LT_10NS,
> +	I3C_TSCO_LT_11NS,
> +	I3C_TSCO_LT_12NS,
> +};
what's the meaning of _LT_ ?
> +
> +#endif /* I3C_CCC_H */
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> new file mode 100644
> index 000000000000..83958d3a02e2
> --- /dev/null
> +++ b/include/linux/i3c/device.h
> @@ -0,0 +1,321 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2017 Cadence Design Systems Inc.
> + *
> + * Author: Boris Brezillon<boris.brezillon@free-electrons.com>
> + */
> +
> +#ifndef I3C_DEV_H
> +#define I3C_DEV_H
> +
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +
> +/**
> + * enum i3c_hdr_mode - HDR mode ids
> + * @I3C_HDR_DDR: DDR mode
> + * @I3C_HDR_TSP: TSP mode
> + * @I3C_HDR_TSL: TSL mode
> + */
> +enum i3c_hdr_mode {
> +	I3C_HDR_DDR,
> +	I3C_HDR_TSP,
> +	I3C_HDR_TSL,
> +};
> +
> +/**
> + * struct i3c_hdr_cmd - I3C HDR command
> + * @mode: HDR mode selected for this command
> + * @code: command opcode
> + * @addr: I3C dynamic address
> + * @ndatawords: number of data words (a word is 16bits wide)
> + * @data: input/output buffer
> + */
> +struct i3c_hdr_cmd {
> +	enum i3c_hdr_mode mode;
> +	u8 code;
> +	u8 addr;
> +	int ndatawords;
> +	union {
> +		u16 *in;
> +		const u16 *out;
> +	} data;
> +};
> +
> +/* Private SDR read transfer */
> +#define I3C_PRIV_XFER_READ		BIT(0)
> +/*
> + * Instruct the controller to issue a STOP after a specific transfer instead
> + * of a REPEATED START.
> + */
> +#define I3C_PRIV_XFER_STOP		BIT(1)
> +
> +/**
> + * struct i3c_priv_xfer - I3C SDR private transfer
> + * @addr: I3C dynamic address
> + * @len: transfer length in bytes of the transfer
> + * @flags: combination of I3C_PRIV_XFER_xxx flags
> + * @data: input/output buffer
> + */
> +struct i3c_priv_xfer {
> +	u8 addr;
> +	u16 len;
> +	u32 flags;
> +	struct {
> +		void *in;
> +		const void *out;
> +	} data;
> +};
Same as above, i3c_sdr_max_data_rate to change the bus scl.
> +
> +/**
> + * enum i3c_dcr - I3C DCR values
> + * @I3C_DCR_GENERIC_DEVICE: generic I3C device
> + */
> +enum i3c_dcr {
> +	I3C_DCR_GENERIC_DEVICE = 0,
> +};
> +
> +#define I3C_PID_MANUF_ID(pid)		(((pid) & GENMASK_ULL(47, 33)) >> 33)
> +#define I3C_PID_RND_LOWER_32BITS(pid)	(!!((pid) & BIT_ULL(32)))
> +#define I3C_PID_RND_VAL(pid)		((pid) & GENMASK_ULL(31, 0))
> +#define I3C_PID_PART_ID(pid)		(((pid) & GENMASK_ULL(31, 16)) >> 16)
> +#define I3C_PID_INSTANCE_ID(pid)	(((pid) & GENMASK_ULL(15, 12)) >> 12)
> +#define I3C_PID_EXTRA_INFO(pid)		((pid) & GENMASK_ULL(11, 0))
> +
> +#define I3C_BCR_DEVICE_ROLE(bcr)	((bcr) & GENMASK(7, 6))
> +#define I3C_BCR_I3C_SLAVE		(0 << 6)
> +#define I3C_BCR_I3C_MASTER		(1 << 6)
> +#define I3C_BCR_HDR_CAP			BIT(5)
> +#define I3C_BCR_BRIDGE			BIT(4)
> +#define I3C_BCR_OFFLINE_CAP		BIT(3)
> +#define I3C_BCR_IBI_PAYLOAD		BIT(2)
> +#define I3C_BCR_IBI_REQ_CAP		BIT(1)
> +#define I3C_BCR_MAX_DATA_SPEED_LIM	BIT(0)
> +
> +/**
> + * struct i3c_device_info - I3C device information
> + * @pid: Provisional ID
> + * @bcr: Bus Characteristic Register
> + * @dcr: Device Characteristic Register
> + * @static_addr: static/I2C address
> + * @dyn_addr: dynamic address
> + * @hdr_cap: supported HDR modes
> + * @max_read_ds: max read speed information
> + * @max_write_ds: max write speed information
> + * @max_ibi_len: max IBI payload length
> + * @max_read_turnaround: max read turn-around time in micro-seconds
> + * @max_read_len: max private SDR read length in bytes
> + * @max_write_len: max private SDR write length in bytes
> + *
> + * These are all basic information that should be advertised by an I3C device.
> + * Some of them are optional depending on the device type and device
> + * capabilities.
> + * For each I3C slave attached to a master with
> + * i3c_master_add_i3c_dev_locked(), the core will send the relevant CCC command
> + * to retrieve these data.
> + */
> +struct i3c_device_info {
> +	u64 pid;
> +	u8 bcr;
> +	u8 dcr;
> +	u8 static_addr;
> +	u8 dyn_addr;
> +	u8 hdr_cap;
> +	u8 max_read_ds;
> +	u8 max_write_ds;
> +	u8 max_ibi_len;
> +	u32 max_read_turnaround;
> +	u16 max_read_len;
> +	u16 max_write_len;
> +};
> +
is this information filled with data provided from CCC commands?
> +
> +#endif /* I3C_DEV_H */
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> new file mode 100644
> index 000000000000..7ec9a4821bac
> --- /dev/null
> +++ b/include/linux/i3c/master.h
> @@ -0,0 +1,564 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2017 Cadence Design Systems Inc.
> + *
> + * Author: Boris Brezillon<boris.brezillon@free-electrons.com>
> + */
> +
> +#ifndef I3C_MASTER_H
> +#define I3C_MASTER_H
> +
> +#include <linux/i2c.h>
> +#include <linux/i3c/ccc.h>
> +#include <linux/i3c/device.h>
> +#include <linux/spinlock.h>
> +
> +#define I3C_HOT_JOIN_ADDR		0x2
> +#define I3C_BROADCAST_ADDR		0x7e
> +#define I3C_MAX_ADDR			GENMASK(6, 0)
> +
> +struct i3c_master_controller;
> +struct i3c_bus;
> +
> +/**
> + * struct i3c_i2c_dev - I3C/I2C common information
> + * @node: node element used to insert the device into the I2C or I3C device
> + *	  list
> + * @bus: I3C bus this device is connected to
> + * @master: I3C master that instantiated this device. Will be used to send
> + *	    I2C/I3C frames on the bus
> + * @master_priv: master private data assigned to the device. Can be used to
> + *		 add master specific information
> + *
> + * This structure is describing common I3C/I2C dev information.
> + */
> +struct i3c_i2c_dev {
> +	struct list_head node;
> +	struct i3c_bus *bus;
> +	struct i3c_master_controller *master;
> +	void *master_priv;
> +};
> +
> +#define I3C_LVR_I2C_INDEX_MASK		GENMASK(7, 5)
> +#define I3C_LVR_I2C_INDEX(x)		((x) << 5)
> +#define I3C_LVR_I2C_FM_MODE		BIT(4)
> +
> +#define I2C_MAX_ADDR			GENMASK(9, 0)
why 10-bit address?
> +
> +/**
> + * struct i2c_device - I2C device object
> + * @common: inherit common I3C/I2C description
> + * @info: I2C board info used to instantiate the I2C device. If you are
> + *	  using DT to describe your hardware, this will be filled for you
> + * @client: I2C client object created by the I2C framework. This will only
> + *	    be valid after i3c_master_register() returns
> + * @lvr: Legacy Virtual Register value as described in the I3C specification
> + *
> + * I2C device object. Note that the real I2C device is represented by
> + * i2c_device->client, but we need extra information to handle the device when
> + * it's connected to an I3C bus, hence the &struct i2c_device wrapper.
> + *
> + * The I2C framework is not impacted by this new representation.
> + */
> +struct i2c_device {
> +	struct i3c_i2c_dev common;
> +	struct i2c_board_info info;
> +	struct i2c_client *client;
> +	u8 lvr;
> +};
> +
It is usefull to know the speed limitations of the device.
> +
> +/**
> + * enum i3c_addr_slot_status - I3C address slot status
> + * @I3C_ADDR_SLOT_FREE: address is free
> + * @I3C_ADDR_SLOT_RSVD: address is reserved
> + * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
> + * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
> + * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
> + *
> + * On an I3C bus, addresses are assigned dynamically, and we need to know which
> + * addresses are free to use and which ones are already assigned.
> + *
> + * Addresses marked as reserved are those reserved by the I3C protocol
> + * (broadcast address, ...).
> + */
> +enum i3c_addr_slot_status {
> +	I3C_ADDR_SLOT_FREE,
> +	I3C_ADDR_SLOT_RSVD,
> +	I3C_ADDR_SLOT_I2C_DEV,
> +	I3C_ADDR_SLOT_I3C_DEV,
> +	I3C_ADDR_SLOT_STATUS_MASK = 3,
> +};
> +
> +/**
> + * struct i3c_bus - I3C bus object
> + * @dev: device to be registered to the device-model
> + * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
> + *		this can change over the time. Will be used to let a master
> + *		know whether it needs to request bus ownership before sending
> + *		a frame or not
> + * @id: bus ID. Assigned by the framework when register the bus
> + * @addrslots: a bitmap with 2-bits per-slot to encode the address status and
> + *	       ease the DAA (Dynamic Address Assignment) procedure (see
> + *	       &enum i3c_addr_slot_status)
> + * @mode: bus mode (see &enum i3c_bus_mode)
> + * @scl_rate: SCL signal rate for I3C and I2C mode
> + * @devs: 2 lists containing all I3C/I2C devices connected to the bus
> + * @lock: read/write lock on the bus. This is needed to protect against
> + *	  operations that have an impact on the whole bus and the devices
> + *	  connected to it. For example, when asking slaves to drop their
> + *	  dynamic address (RSTDAA CCC), we need to make sure no one is trying
> + *	  to send I3C frames to these devices.
> + *	  Note that this lock does not protect against concurrency between
> + *	  devices: several drivers can send different I3C/I2C frames through
> + *	  the same master in parallel. This is the responsibility of the
> + *	  master to guarantee that frames are actually sent sequentially and
> + *	  not interlaced
> + *
> + * The I3C bus is represented with its own object and not implicitly described
> + * by the I3C master to cope with the multi-master functionality, where one bus
> + * can be shared amongst several masters, each of them requesting bus ownership
> + * when they need to.
> + */
> +struct i3c_bus {
> +	struct device dev;
> +	struct i3c_device *cur_master;
> +	int id;
> +	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
> +	enum i3c_bus_mode mode;
> +	struct {
> +		unsigned long i3c;
> +		unsigned long i2c;
> +	} scl_rate;
> +	struct {
> +		struct list_head i3c;
> +		struct list_head i2c;
> +	} devs;
> +	struct rw_semaphore lock;
> +};
Can you explain the addrslots[] ?
> +
> +static inline struct i3c_device *dev_to_i3cdev(struct device *dev)
> +{
> +	return container_of(dev, struct i3c_device, dev);
> +}
> +
> +struct i3c_master_controller;
> +
> +/**
> + * struct i3c_master_controller_ops - I3C master methods
> + * @bus_init: hook responsible for the I3C bus initialization. This
> + *	      initialization should follow the steps described in the I3C
> + *	      specification. This hook is called with the bus lock held in
> + *	      write mode, which means all _locked() helpers can safely be
> + *	      called from there
> + * @bus_cleanup: cleanup everything done in
> + *		 &i3c_master_controller_ops->bus_init(). This function is
> + *		 optional and should only be implemented if
> + *		 &i3c_master_controller_ops->bus_init() attached private data
> + *		 to I3C/I2C devices. This hook is called with the bus lock
> + *		 held in write mode, which means all _locked() helpers can
> + *		 safely be called from there
> + * @supports_ccc_cmd: should return true if the CCC command is supported, false
> + *		      otherwise
> + * @send_ccc_cmd: send a CCC command
> + * @send_hdr_cmds: send one or several HDR commands. If there is more than one
> + *		   command, they should ideally be sent in the same HDR
> + *		   transaction
> + * @priv_xfers: do one or several private I3C SDR transfers
> + * @i2c_xfers: do one or several I2C transfers
> + * @request_ibi: attach an IBI handler to an I3C device. This implies defining
> + *		 an IBI handler and the constraints of the IBI (maximum payload
> + *		 length and number of pre-allocated slots).
> + *		 Some controllers support less IBI-capable devices than regular
> + *		 devices, so this method might return -%EBUSY if there's no
> + *		 more space for an extra IBI registration
> + * @free_ibi: free an IBI previously requested with ->request_ibi(). The IBI
> + *	      should have been disabled with ->disable_irq() prior to that
> + * @enable_ibi: enable the IBI. Only valid if ->request_ibi() has been called
> + *		prior to ->enable_ibi(). The controller should first enable
> + *		the IBI on the controller end (for example, unmask the hardware
> + *		IRQ) and then send the ENEC CCC command (with the IBI flag set)
> + *		to the I3C device
> + * @disable_ibi: disable an IBI. First send the DISEC CCC command with the IBI
> + *		 flag set and then deactivate the hardware IRQ on the
> + *		 controller end
> + * @recycle_ibi_slot: recycle an IBI slot. Called every time an IBI has been
> + *		      processed by its handler. The IBI slot should be put back
> + *		      in the IBI slot pool so that the controller can re-use it
> + *		      for a future IBI
> + *
> + * One of the most important hooks in these ops is
> + * &i3c_master_controller_ops->bus_init(). Here is a non-exhaustive list of
> + * things that should be done in &i3c_master_controller_ops->bus_init():
> + *
> + * 1) call i3c_master_set_info() with all information describing the master
> + * 2) ask all slaves to drop their dynamic address by sending the RSTDAA CCC
> + *    with i3c_master_rstdaa_locked()
> + * 3) ask all slaves to disable IBIs using i3c_master_disec_locked()
> + * 4) start a DDA procedure by sending the ENTDAA CCC with
> + *    i3c_master_entdaa_locked(), or using the internal DAA logic provided by
> + *    your controller
You mean SETDASA CCC command?
> + * 5) assign a dynamic address to each I3C device discovered during DAA and
> + *    for each of them, call i3c_master_add_i3c_dev_locked()
> + * 6) propagate device table to secondary masters by calling
> + *    i3c_master_defslvs_locked()
> + *
> + * Note that these steps do not include all controller specific initialization.
> + */
> +struct i3c_master_controller_ops {
> +	int (*bus_init)(struct i3c_master_controller *master);
> +	void (*bus_cleanup)(struct i3c_master_controller *master);
> +	bool (*supports_ccc_cmd)(struct i3c_master_controller *master,
> +				 const struct i3c_ccc_cmd *cmd);
> +	int (*send_ccc_cmd)(struct i3c_master_controller *master,
> +			    struct i3c_ccc_cmd *cmd);
> +	int (*send_hdr_cmds)(struct i3c_master_controller *master,
> +			     const struct i3c_hdr_cmd *cmds,
> +			     int ncmds);
> +	int (*priv_xfers)(struct i3c_master_controller *master,
> +			  const struct i3c_priv_xfer *xfers,
> +			  int nxfers);
> +	int (*i2c_xfers)(struct i3c_master_controller *master,
> +			 const struct i2c_msg *xfers, int nxfers);
> +	int (*request_ibi)(struct i3c_master_controller *master,
> +			   struct i3c_device *dev,
> +			   const struct i3c_ibi_setup *req);
> +	void (*free_ibi)(struct i3c_master_controller *master,
> +			 struct i3c_device *dev);
> +	int (*enable_ibi)(struct i3c_master_controller *master,
> +			  struct i3c_device *dev);
> +	int (*disable_ibi)(struct i3c_master_controller *master,
> +			   struct i3c_device *dev);
> +	void (*recycle_ibi_slot)(struct i3c_master_controller *master,
> +				 struct i3c_device *dev,
> +				 struct i3c_ibi_slot *slot);
> +};
> +
>

Best regards,
Vitor Soares

--------------A0BB601FD83C89E4F6A1B8E3
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Boris,<br>
    </p>
    <br>
    <div class="moz-cite-prefix">Às 3:16 PM de 12/14/2017, Boris
      Brezillon escreveu:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">+
      <pre wrap="">+enum i3c_addr_slot_status i3c_bus_get_addr_slot_status(struct i3c_bus *bus,
+						       u16 addr)
+{
+	int status, bitpos = addr * 2;
+
+	if (addr &gt; I2C_MAX_ADDR)
+		return I3C_ADDR_SLOT_RSVD;
+
+	status = bus-&gt;addrslots[bitpos / BITS_PER_LONG];
+	status &gt;&gt;= bitpos % BITS_PER_LONG;
+
+	return status &amp; I3C_ADDR_SLOT_STATUS_MASK;
+}</pre>
    </blockquote>
    I don't understand the size of addr. The I3C only allow 7-bit
    addresses.<br>
    <br>
    Is the addrslots used to store the addresses and its status? <br>
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">+
+void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+				  enum i3c_addr_slot_status status)
+{
+	int bitpos = addr * 2;
+	unsigned long *ptr;
+
+	if (addr &gt; I2C_MAX_ADDR)
+		return;
+
+	ptr = bus-&gt;addrslots + (bitpos / BITS_PER_LONG);
+	*ptr &amp;= ~(I3C_ADDR_SLOT_STATUS_MASK &lt;&lt; (bitpos % BITS_PER_LONG));
+	*ptr |= status &lt;&lt; (bitpos % BITS_PER_LONG);
+}
+
+bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
+{
+	enum i3c_addr_slot_status status;
+
+	status = i3c_bus_get_addr_slot_status(bus, addr);
+
+	return status == I3C_ADDR_SLOT_FREE;
+}
+
+int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
+{
+	enum i3c_addr_slot_status status;
+	u8 addr;
+
+	for (addr = start_addr; addr &lt; I3C_MAX_ADDR; addr++) {
+		status = i3c_bus_get_addr_slot_status(bus, addr);
+		if (status == I3C_ADDR_SLOT_FREE)
+			return addr;
+	}
+
+	return -ENOMEM;
+}
+
+static void i3c_bus_init_addrslots(struct i3c_bus *bus)
+{
+	int i;
+
+	/* Addresses 0 to 7 are reserved. */
+	for (i = 0; i &lt; 8; i++)
+		i3c_bus_set_addr_slot_status(bus, i, I3C_ADDR_SLOT_RSVD);
+
+	/*
+	 * Reserve broadcast address and all addresses that might collide
+	 * with the broadcast address when facing a single bit error.
+	 */
+	i3c_bus_set_addr_slot_status(bus, I3C_BROADCAST_ADDR,
+				     I3C_ADDR_SLOT_RSVD);
+	for (i = 0; i &lt; 7; i++)
+		i3c_bus_set_addr_slot_status(bus, I3C_BROADCAST_ADDR ^ BIT(i),
+					     I3C_ADDR_SLOT_RSVD);
+}
+
+static const char * const i3c_bus_mode_strings[] = {
+	[I3C_BUS_MODE_PURE] = "pure",
+	[I3C_BUS_MODE_MIXED_FAST] = "mixed-fast",
+	[I3C_BUS_MODE_MIXED_SLOW] = "mixed-slow",
+};
+
+static ssize_t mode_show(struct device *dev,
+			 struct device_attribute *da,
+			 char *buf)
+{
+	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(i3cbus);
+	if (i3cbus-&gt;mode &lt; 0 ||
+	    i3cbus-&gt;mode &gt; ARRAY_SIZE(i3c_bus_mode_strings) ||
+	    !i3c_bus_mode_strings[i3cbus-&gt;mode])
+		ret = sprintf(buf, "unknown\n");
+	else
+		ret = sprintf(buf, "%s\n", i3c_bus_mode_strings[i3cbus-&gt;mode]);
+	i3c_bus_normaluse_unlock(i3cbus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(mode);
+
+static ssize_t current_master_show(struct device *dev,
+				   struct device_attribute *da,
+				   char *buf)
+{
+	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(i3cbus);
+	ret = sprintf(buf, "%s\n", dev_name(&amp;i3cbus-&gt;cur_master-&gt;dev));
+	i3c_bus_normaluse_unlock(i3cbus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(current_master);
+
+static ssize_t i3c_scl_frequency_show(struct device *dev,
+				      struct device_attribute *da,
+				      char *buf)
+{
+	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(i3cbus);
+	ret = sprintf(buf, "%ld\n", i3cbus-&gt;scl_rate.i3c);
+	i3c_bus_normaluse_unlock(i3cbus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(i3c_scl_frequency);
+
+static ssize_t i2c_scl_frequency_show(struct device *dev,
+				      struct device_attribute *da,
+				      char *buf)
+{
+	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(i3cbus);
+	ret = sprintf(buf, "%ld\n", i3cbus-&gt;scl_rate.i2c);
+	i3c_bus_normaluse_unlock(i3cbus);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(i2c_scl_frequency);
+
+static struct attribute *i3c_busdev_attrs[] = {
+	&amp;dev_attr_mode.attr,
+	&amp;dev_attr_current_master.attr,
+	&amp;dev_attr_i3c_scl_frequency.attr,
+	&amp;dev_attr_i2c_scl_frequency.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(i3c_busdev);
+
+static void i3c_busdev_release(struct device *dev)
+{
+	struct i3c_bus *bus = container_of(dev, struct i3c_bus, dev);
+
+	while (!list_empty(&amp;bus-&gt;devs.i2c)) {
+		struct i2c_device *i2cdev;
+
+		i2cdev = list_first_entry(&amp;bus-&gt;devs.i2c, struct i2c_device,
+					  common.node);
+		list_del(&amp;i2cdev-&gt;common.node);
+		of_node_put(i2cdev-&gt;info.of_node);
+		kfree(i2cdev);
+	}
+
+	while (!list_empty(&amp;bus-&gt;devs.i3c)) {
+		struct i3c_device *i3cdev;
+
+		i3cdev = list_first_entry(&amp;bus-&gt;devs.i3c, struct i3c_device,
+					  common.node);
+		list_del(&amp;i3cdev-&gt;common.node);
+		put_device(&amp;i3cdev-&gt;dev);
+	}
+
+	mutex_lock(&amp;i3c_core_lock);
+	idr_remove(&amp;i3c_bus_idr, bus-&gt;id);
+	mutex_unlock(&amp;i3c_core_lock);
+
+	of_node_put(bus-&gt;dev.of_node);
+	kfree(bus);
+}
+
+static const struct device_type i3c_busdev_type = {
+	.groups	= i3c_busdev_groups,
+};
+
+void i3c_bus_unref(struct i3c_bus *bus)
+{
+	put_device(&amp;bus-&gt;dev);
+}
+
+struct i3c_bus *i3c_bus_create(struct device *parent)
+{
+	struct i3c_bus *i3cbus;
+	int ret;
+
+	i3cbus = kzalloc(sizeof(*i3cbus), GFP_KERNEL);
+	if (!i3cbus)
+		return ERR_PTR(-ENOMEM);
+
+	init_rwsem(&amp;i3cbus-&gt;lock);
+	INIT_LIST_HEAD(&amp;i3cbus-&gt;devs.i2c);
+	INIT_LIST_HEAD(&amp;i3cbus-&gt;devs.i3c);
+	i3c_bus_init_addrslots(i3cbus);
+	i3cbus-&gt;mode = I3C_BUS_MODE_PURE;
+	i3cbus-&gt;dev.parent = parent;
+	i3cbus-&gt;dev.of_node = of_node_get(parent-&gt;of_node);
+	i3cbus-&gt;dev.bus = &amp;i3c_bus_type;
+	i3cbus-&gt;dev.type = &amp;i3c_busdev_type;
+	i3cbus-&gt;dev.release = i3c_busdev_release;
+
+	mutex_lock(&amp;i3c_core_lock);
+	ret = idr_alloc(&amp;i3c_bus_idr, i3cbus, 0, 0, GFP_KERNEL);
+	mutex_unlock(&amp;i3c_core_lock);
+	if (ret &lt; 0)
+		goto err_free_bus;
+
+	i3cbus-&gt;id = ret;
+	device_initialize(&amp;i3cbus-&gt;dev);
+
+	return i3cbus;
+
+err_free_bus:
+	kfree(i3cbus);
+
+	return ERR_PTR(ret);
+}
+
+void i3c_bus_unregister(struct i3c_bus *bus)
+{
+	device_unregister(&amp;bus-&gt;dev);
+}
+
+int i3c_bus_register(struct i3c_bus *i3cbus)
+{
+	struct i2c_device *i2cdev;
+
+	i3c_bus_for_each_i2cdev(i3cbus, i2cdev) {
+		switch (i2cdev-&gt;lvr &amp; I3C_LVR_I2C_INDEX_MASK) {
+		case I3C_LVR_I2C_INDEX(0):
+			if (i3cbus-&gt;mode &lt; I3C_BUS_MODE_MIXED_FAST)
+				i3cbus-&gt;mode = I3C_BUS_MODE_MIXED_FAST;
+			break;
+
+		case I3C_LVR_I2C_INDEX(1):
+		case I3C_LVR_I2C_INDEX(2):
+			if (i3cbus-&gt;mode &lt; I3C_BUS_MODE_MIXED_SLOW)
+				i3cbus-&gt;mode = I3C_BUS_MODE_MIXED_SLOW;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (!i3cbus-&gt;scl_rate.i3c)
+		i3cbus-&gt;scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
+
+	if (!i3cbus-&gt;scl_rate.i2c) {
+		if (i3cbus-&gt;mode == I3C_BUS_MODE_MIXED_SLOW)
+			i3cbus-&gt;scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
+		else
+			i3cbus-&gt;scl_rate.i2c = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
+	}
+
+	/*
+	 * I3C/I2C frequency may have been overridden, check that user-provided
+	 * values are not exceeding max possible frequency.
+	 */
+	if (i3cbus-&gt;scl_rate.i3c &gt; I3C_BUS_MAX_I3C_SCL_RATE ||
+	    i3cbus-&gt;scl_rate.i2c &gt; I3C_BUS_I2C_FM_PLUS_SCL_RATE) {
+		return -EINVAL;
+	}
+
+	dev_set_name(&amp;i3cbus-&gt;dev, "i3c-%d", i3cbus-&gt;id);
+
+	return device_add(&amp;i3cbus-&gt;dev);
+}
+
+static int __init i3c_init(void)
+{
+	return bus_register(&amp;i3c_bus_type);
+}
+subsys_initcall(i3c_init);
+
+static void __exit i3c_exit(void)
+{
+	idr_destroy(&amp;i3c_bus_idr);
+	bus_unregister(&amp;i3c_bus_type);
+}
+module_exit(i3c_exit);
+
+MODULE_AUTHOR("Boris Brezillon <a class="moz-txt-link-rfc2396E" href="mailto:boris.brezillon@free-electrons.com">&lt;boris.brezillon@free-electrons.com&gt;</a>");
+MODULE_DESCRIPTION("I3C core");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
new file mode 100644
index 000000000000..dcf51150b7cb
--- /dev/null
+++ b/drivers/i3c/device.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <a class="moz-txt-link-rfc2396E" href="mailto:boris.brezillon@free-electrons.com">&lt;boris.brezillon@free-electrons.com&gt;</a>
+ */
+
+#include &lt;linux/slab.h&gt;
+
+#include "internals.h"
+
+/**
+ * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
+ *				specific device
+ *
+ * @dev: device with which the transfers should be done
+ * @xfers: array of transfers
+ * @nxfers: number of transfers
+ *
+ * Initiate one or several private SDR transfers with @dev.
+ *
+ * This function can sleep and thus cannot be called in atomic context.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_do_priv_xfers(struct i3c_device *dev,
+			     struct i3c_priv_xfer *xfers,
+			     int nxfers)
+{
+	struct i3c_master_controller *master;
+	int i, ret;
+
+	master = i3c_device_get_master(dev);
+	if (!master)
+		return -EINVAL;
+
+	i3c_bus_normaluse_lock(master-&gt;bus);
+	for (i = 0; i &lt; nxfers; i++)
+		xfers[i].addr = dev-&gt;info.dyn_addr;
+
+	ret = i3c_master_do_priv_xfers_locked(master, xfers, nxfers);
+	i3c_bus_normaluse_unlock(master-&gt;bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);</pre>
    </blockquote>
    The controller should know the speed mode for each xfer. The SDR0
    mode is used by default but if any device have read or write speed
    limitations the controller can use SDRx.<br>
    <br>
    This could be also applied to i2c transfers.
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">+#endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
new file mode 100644
index 000000000000..1c85abac08d5
--- /dev/null
+++ b/drivers/i3c/master.c
@@ -0,0 +1,1433 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <a class="moz-txt-link-rfc2396E" href="mailto:boris.brezillon@free-electrons.com">&lt;boris.brezillon@free-electrons.com&gt;</a>
+ */
+
+#include &lt;linux/slab.h&gt;
+
+#include "internals.h"
+
+/**
+ * i3c_master_entdaa_locked() - start a DAA (Dynamic Address Assignment)
+ *				procedure
+ * @master: master used to send frames on the bus
+ *
+ * Send a ENTDAA CCC command to start a DAA procedure.
+ *
+ * Note that this function only sends the ENTDAA CCC command, all the logic
+ * behind dynamic address assignment has to be handled in the I3C master
+ * driver.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_entdaa_locked(struct i3c_master_controller *master)
+{
+	struct i3c_ccc_cmd_dest dest = { };
+	struct i3c_ccc_cmd cmd = { };
+	int ret;
+
+	dest.addr = I3C_BROADCAST_ADDR;
+	cmd.dests = &amp;dest;
+	cmd.ndests = 1;
+	cmd.rnw = false;
+	cmd.id = I3C_CCC_ENTDAA;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &amp;cmd);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_master_entdaa_locked);</pre>
    </blockquote>
    can you explain the process?  the command is only execute once, what
    if there is more devices on the bus?<br>
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">+
+/**
+ * i3c_master_defslvs_locked() - send a DEFSLVS CCC command
+ * @master: master used to send frames on the bus
+ *
+ * Send a DEFSLVS CCC command containing all the devices known to the @master.
+ * This is useful when you have secondary masters on the bus to propagate
+ * device information.
+ *
+ * This should be called after all I3C devices have been discovered (in other
+ * words, after the DAA procedure has finished) and instantiated in
+ * i3c_master_controller_ops-&gt;bus_init().
+ * It should also be called if a master ACKed an Hot-Join request and assigned
+ * a dynamic address to the device joining the bus.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_defslvs_locked(struct i3c_master_controller *master)
+{
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = I3C_BROADCAST_ADDR,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.id = I3C_CCC_DEFSLVS,
+		.dests = &amp;dest,
+		.ndests = 1,
+	};
+	struct i3c_ccc_defslvs *defslvs;
+	struct i3c_ccc_dev_desc *desc;
+	struct i3c_device *i3cdev;
+	struct i2c_device *i2cdev;
+	struct i3c_bus *bus;
+	bool send = false;
+	int ndevs = 0, ret;
+
+	if (!master)
+		return -EINVAL;
+
+	bus = i3c_master_get_bus(master);
+	i3c_bus_for_each_i3cdev(bus, i3cdev) {
+		ndevs++;
+		if (I3C_BCR_DEVICE_ROLE(i3cdev-&gt;info.bcr) == I3C_BCR_I3C_MASTER)
+			send = true;
+	}
+
+	/* No other master on the bus, skip DEFSLVS. */
+	if (!send)
+		return 0;
+
+	i3c_bus_for_each_i2cdev(bus, i2cdev)
+		ndevs++;
+
+	dest.payload.len = sizeof(*defslvs) +
+			   ((ndevs - 1) * sizeof(struct i3c_ccc_dev_desc));
+	defslvs = kzalloc(dest.payload.len, GFP_KERNEL);
+	if (!defslvs)
+		return -ENOMEM;
+
+	dest.payload.data = defslvs;
+
+	defslvs-&gt;count = ndevs;
+	defslvs-&gt;master.bcr = master-&gt;this-&gt;info.bcr;
+	defslvs-&gt;master.dcr = master-&gt;this-&gt;info.dcr;
+	defslvs-&gt;master.dyn_addr = master-&gt;this-&gt;info.dyn_addr;
+	defslvs-&gt;master.static_addr = I3C_BROADCAST_ADDR;</pre>
    </blockquote>
    Why defslvs-&gt;master.static_addr = I3C_BROADCAST_ADDR?
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">
+
+	desc = defslvs-&gt;slaves;
+	i3c_bus_for_each_i2cdev(bus, i2cdev) {
+		desc-&gt;lvr = i2cdev-&gt;lvr;
+		desc-&gt;static_addr = i2cdev-&gt;info.addr;
+		desc++;
+	}
+
+	i3c_bus_for_each_i3cdev(bus, i3cdev) {
+		/* Skip the I3C dev representing this master. */
+		if (i3cdev == master-&gt;this)
+			continue;
+
+		desc-&gt;bcr = i3cdev-&gt;info.bcr;
+		desc-&gt;dcr = i3cdev-&gt;info.dcr;
+		desc-&gt;dyn_addr = i3cdev-&gt;info.dyn_addr;
+		desc-&gt;static_addr = i3cdev-&gt;info.static_addr;
+		desc++;
+	}
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &amp;cmd);
+	kfree(defslvs);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_defslvs_locked);
+




+
+static int i3c_master_i2c_adapter_xfer(struct i2c_adapter *adap,
+				       struct i2c_msg *xfers, int nxfers)
+{
+	struct i3c_master_controller *master = i2c_adapter_to_i3c_master(adap);
+	int i, ret;
+
+	for (i = 0; i &lt; nxfers; i++) {
+		enum i3c_addr_slot_status status;
+
+		status = i3c_bus_get_addr_slot_status(master-&gt;bus,
+						      xfers[i].addr);
+		if (status != I3C_ADDR_SLOT_I2C_DEV)
+			return -EINVAL;
+	}
+
+	ret = i3c_master_do_i2c_xfers(master, xfers, nxfers);
+	if (ret)
+		return ret;
+
+	return nxfers;
+}
+
+static u32 i3c_master_i2c_functionalities(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
+}</pre>
    </blockquote>
    Is I2C_FUNC_10BIT_ADDR allowed ?<br>
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">
diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
new file mode 100644
index 000000000000..ff3e1a3e2c4c
--- /dev/null
+++ b/include/linux/i3c/ccc.h
@@ -0,0 +1,380 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <a class="moz-txt-link-rfc2396E" href="mailto:boris.brezillon@free-electrons.com">&lt;boris.brezillon@free-electrons.com&gt;</a>
+ */
+
+
+/**
+ * enum i3c_ccc_test_mode - enum listing all available test modes
+ *
+ * @I3C_CCC_EXIT_TEST_MODE: exit test mode
+ * @I3C_CCC_VENDOR_TEST_MODE: enter vendor test mode
+ */
+enum i3c_ccc_test_mode {
+	I3C_CCC_EXIT_TEST_MODE,
+	I3C_CCC_VENDOR_TEST_MODE,
+};
+
+/**
+ * struct i3c_ccc_enttm - payload passed to ENTTM CCC
+ *
+ * @mode: one of the &amp;enum i3c_ccc_test_mode modes
+ *
+ * Information passed to the ENTTM CCC to instruct an I3C device to enter a
+ * specific test mode.
+ */
+struct i3c_ccc_enttm {
+	u8 mode;
+} __packed;
+
+/**
+ * struct i3c_ccc_setda - payload passed to ENTTM CCC
+ *
+ * @mode: one of the &amp;enum i3c_ccc_test_mode modes
+ *
+ * Information passed to the ENTTM CCC to instruct an I3C device to enter a
+ * specific test mode.
+ */
+struct i3c_ccc_setda {
+	u8 addr;
+} __packed;</pre>
    </blockquote>
    what do you mean with struct? Maybe setdasa? if so, what is the
    addr?<br>
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">
+/**
+ * enum i3c_sdr_max_data_rate - max data rate values for private SDR transfers
+ */
+enum i3c_sdr_max_data_rate {
+	I3C_SDR_DR_FSCL_MAX,
+	I3C_SDR_DR_FSCL_8MHZ,
+	I3C_SDR_DR_FSCL_6MHZ,
+	I3C_SDR_DR_FSCL_4MHZ,
+	I3C_SDR_DR_FSCL_2MHZ,
+};</pre>
    </blockquote>
    Can you change the names to:<br>
    <pre wrap="">I3C_SDR0_FSCL_MAX,
I3C_SDR1_FSCL_8MHZ,
I3C_SDR2_FSCL_6MHZ,
I3C_SDR3_FSCL_4MHZ,
I3C_SDR4_FSCL_2MHZ,

thus the data rate isn't repeated.  
</pre>
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">
+
+/**
+ * enum i3c_tsco - clock to data turn-around
+ */
+enum i3c_tsco {
+	I3C_TSCO_LT_8NS,
+	I3C_TSCO_LT_9NS,
+	I3C_TSCO_LT_10NS,
+	I3C_TSCO_LT_11NS,
+	I3C_TSCO_LT_12NS,
+};</pre>
    </blockquote>
    what's the meaning of _LT_ ?
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">+
+#endif /* I3C_CCC_H */
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
new file mode 100644
index 000000000000..83958d3a02e2
--- /dev/null
+++ b/include/linux/i3c/device.h
@@ -0,0 +1,321 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <a class="moz-txt-link-rfc2396E" href="mailto:boris.brezillon@free-electrons.com">&lt;boris.brezillon@free-electrons.com&gt;</a>
+ */
+
+#ifndef I3C_DEV_H
+#define I3C_DEV_H
+
+#include &lt;linux/device.h&gt;
+#include &lt;linux/i2c.h&gt;
+#include &lt;linux/mod_devicetable.h&gt;
+#include &lt;linux/module.h&gt;
+
+/**
+ * enum i3c_hdr_mode - HDR mode ids
+ * @I3C_HDR_DDR: DDR mode
+ * @I3C_HDR_TSP: TSP mode
+ * @I3C_HDR_TSL: TSL mode
+ */
+enum i3c_hdr_mode {
+	I3C_HDR_DDR,
+	I3C_HDR_TSP,
+	I3C_HDR_TSL,
+};
+
+/**
+ * struct i3c_hdr_cmd - I3C HDR command
+ * @mode: HDR mode selected for this command
+ * @code: command opcode
+ * @addr: I3C dynamic address
+ * @ndatawords: number of data words (a word is 16bits wide)
+ * @data: input/output buffer
+ */
+struct i3c_hdr_cmd {
+	enum i3c_hdr_mode mode;
+	u8 code;
+	u8 addr;
+	int ndatawords;
+	union {
+		u16 *in;
+		const u16 *out;
+	} data;
+};
+
+/* Private SDR read transfer */
+#define I3C_PRIV_XFER_READ		BIT(0)
+/*
+ * Instruct the controller to issue a STOP after a specific transfer instead
+ * of a REPEATED START.
+ */
+#define I3C_PRIV_XFER_STOP		BIT(1)
+
+/**
+ * struct i3c_priv_xfer - I3C SDR private transfer
+ * @addr: I3C dynamic address
+ * @len: transfer length in bytes of the transfer
+ * @flags: combination of I3C_PRIV_XFER_xxx flags
+ * @data: input/output buffer
+ */
+struct i3c_priv_xfer {
+	u8 addr;
+	u16 len;
+	u32 flags;
+	struct {
+		void *in;
+		const void *out;
+	} data;
+};</pre>
    </blockquote>
    Same as above, i3c_sdr_max_data_rate to change the bus scl.<br>
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">
+
+/**
+ * enum i3c_dcr - I3C DCR values
+ * @I3C_DCR_GENERIC_DEVICE: generic I3C device
+ */
+enum i3c_dcr {
+	I3C_DCR_GENERIC_DEVICE = 0,
+};
+
+#define I3C_PID_MANUF_ID(pid)		(((pid) &amp; GENMASK_ULL(47, 33)) &gt;&gt; 33)
+#define I3C_PID_RND_LOWER_32BITS(pid)	(!!((pid) &amp; BIT_ULL(32)))
+#define I3C_PID_RND_VAL(pid)		((pid) &amp; GENMASK_ULL(31, 0))
+#define I3C_PID_PART_ID(pid)		(((pid) &amp; GENMASK_ULL(31, 16)) &gt;&gt; 16)
+#define I3C_PID_INSTANCE_ID(pid)	(((pid) &amp; GENMASK_ULL(15, 12)) &gt;&gt; 12)
+#define I3C_PID_EXTRA_INFO(pid)		((pid) &amp; GENMASK_ULL(11, 0))
+
+#define I3C_BCR_DEVICE_ROLE(bcr)	((bcr) &amp; GENMASK(7, 6))
+#define I3C_BCR_I3C_SLAVE		(0 &lt;&lt; 6)
+#define I3C_BCR_I3C_MASTER		(1 &lt;&lt; 6)
+#define I3C_BCR_HDR_CAP			BIT(5)
+#define I3C_BCR_BRIDGE			BIT(4)
+#define I3C_BCR_OFFLINE_CAP		BIT(3)
+#define I3C_BCR_IBI_PAYLOAD		BIT(2)
+#define I3C_BCR_IBI_REQ_CAP		BIT(1)
+#define I3C_BCR_MAX_DATA_SPEED_LIM	BIT(0)
+
+/**
+ * struct i3c_device_info - I3C device information
+ * @pid: Provisional ID
+ * @bcr: Bus Characteristic Register
+ * @dcr: Device Characteristic Register
+ * @static_addr: static/I2C address
+ * @dyn_addr: dynamic address
+ * @hdr_cap: supported HDR modes
+ * @max_read_ds: max read speed information
+ * @max_write_ds: max write speed information
+ * @max_ibi_len: max IBI payload length
+ * @max_read_turnaround: max read turn-around time in micro-seconds
+ * @max_read_len: max private SDR read length in bytes
+ * @max_write_len: max private SDR write length in bytes
+ *
+ * These are all basic information that should be advertised by an I3C device.
+ * Some of them are optional depending on the device type and device
+ * capabilities.
+ * For each I3C slave attached to a master with
+ * i3c_master_add_i3c_dev_locked(), the core will send the relevant CCC command
+ * to retrieve these data.
+ */
+struct i3c_device_info {
+	u64 pid;
+	u8 bcr;
+	u8 dcr;
+	u8 static_addr;
+	u8 dyn_addr;
+	u8 hdr_cap;
+	u8 max_read_ds;
+	u8 max_write_ds;
+	u8 max_ibi_len;
+	u32 max_read_turnaround;
+	u16 max_read_len;
+	u16 max_write_len;
+};
+
</pre>
    </blockquote>
    is this information filled with data provided from CCC commands?<br>
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">
+
+#endif /* I3C_DEV_H */
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
new file mode 100644
index 000000000000..7ec9a4821bac
--- /dev/null
+++ b/include/linux/i3c/master.h
@@ -0,0 +1,564 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <a class="moz-txt-link-rfc2396E" href="mailto:boris.brezillon@free-electrons.com">&lt;boris.brezillon@free-electrons.com&gt;</a>
+ */
+
+#ifndef I3C_MASTER_H
+#define I3C_MASTER_H
+
+#include &lt;linux/i2c.h&gt;
+#include &lt;linux/i3c/ccc.h&gt;
+#include &lt;linux/i3c/device.h&gt;
+#include &lt;linux/spinlock.h&gt;
+
+#define I3C_HOT_JOIN_ADDR		0x2
+#define I3C_BROADCAST_ADDR		0x7e
+#define I3C_MAX_ADDR			GENMASK(6, 0)
+
+struct i3c_master_controller;
+struct i3c_bus;
+
+/**
+ * struct i3c_i2c_dev - I3C/I2C common information
+ * @node: node element used to insert the device into the I2C or I3C device
+ *	  list
+ * @bus: I3C bus this device is connected to
+ * @master: I3C master that instantiated this device. Will be used to send
+ *	    I2C/I3C frames on the bus
+ * @master_priv: master private data assigned to the device. Can be used to
+ *		 add master specific information
+ *
+ * This structure is describing common I3C/I2C dev information.
+ */
+struct i3c_i2c_dev {
+	struct list_head node;
+	struct i3c_bus *bus;
+	struct i3c_master_controller *master;
+	void *master_priv;
+};
+
+#define I3C_LVR_I2C_INDEX_MASK		GENMASK(7, 5)
+#define I3C_LVR_I2C_INDEX(x)		((x) &lt;&lt; 5)
+#define I3C_LVR_I2C_FM_MODE		BIT(4)
+
+#define I2C_MAX_ADDR			GENMASK(9, 0)</pre>
    </blockquote>
    why 10-bit address?<br>
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">
+
+/**
+ * struct i2c_device - I2C device object
+ * @common: inherit common I3C/I2C description
+ * @info: I2C board info used to instantiate the I2C device. If you are
+ *	  using DT to describe your hardware, this will be filled for you
+ * @client: I2C client object created by the I2C framework. This will only
+ *	    be valid after i3c_master_register() returns
+ * @lvr: Legacy Virtual Register value as described in the I3C specification
+ *
+ * I2C device object. Note that the real I2C device is represented by
+ * i2c_device-&gt;client, but we need extra information to handle the device when
+ * it's connected to an I3C bus, hence the &amp;struct i2c_device wrapper.
+ *
+ * The I2C framework is not impacted by this new representation.
+ */
+struct i2c_device {
+	struct i3c_i2c_dev common;
+	struct i2c_board_info info;
+	struct i2c_client *client;
+	u8 lvr;
+};
+
</pre>
    </blockquote>
    It is usefull to know the speed limitations of the device.<br>
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">
+
+/**
+ * enum i3c_addr_slot_status - I3C address slot status
+ * @I3C_ADDR_SLOT_FREE: address is free
+ * @I3C_ADDR_SLOT_RSVD: address is reserved
+ * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
+ * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
+ * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
+ *
+ * On an I3C bus, addresses are assigned dynamically, and we need to know which
+ * addresses are free to use and which ones are already assigned.
+ *
+ * Addresses marked as reserved are those reserved by the I3C protocol
+ * (broadcast address, ...).
+ */
+enum i3c_addr_slot_status {
+	I3C_ADDR_SLOT_FREE,
+	I3C_ADDR_SLOT_RSVD,
+	I3C_ADDR_SLOT_I2C_DEV,
+	I3C_ADDR_SLOT_I3C_DEV,
+	I3C_ADDR_SLOT_STATUS_MASK = 3,
+};
+
+/**
+ * struct i3c_bus - I3C bus object
+ * @dev: device to be registered to the device-model
+ * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
+ *		this can change over the time. Will be used to let a master
+ *		know whether it needs to request bus ownership before sending
+ *		a frame or not
+ * @id: bus ID. Assigned by the framework when register the bus
+ * @addrslots: a bitmap with 2-bits per-slot to encode the address status and
+ *	       ease the DAA (Dynamic Address Assignment) procedure (see
+ *	       &amp;enum i3c_addr_slot_status)
+ * @mode: bus mode (see &amp;enum i3c_bus_mode)
+ * @scl_rate: SCL signal rate for I3C and I2C mode
+ * @devs: 2 lists containing all I3C/I2C devices connected to the bus
+ * @lock: read/write lock on the bus. This is needed to protect against
+ *	  operations that have an impact on the whole bus and the devices
+ *	  connected to it. For example, when asking slaves to drop their
+ *	  dynamic address (RSTDAA CCC), we need to make sure no one is trying
+ *	  to send I3C frames to these devices.
+ *	  Note that this lock does not protect against concurrency between
+ *	  devices: several drivers can send different I3C/I2C frames through
+ *	  the same master in parallel. This is the responsibility of the
+ *	  master to guarantee that frames are actually sent sequentially and
+ *	  not interlaced
+ *
+ * The I3C bus is represented with its own object and not implicitly described
+ * by the I3C master to cope with the multi-master functionality, where one bus
+ * can be shared amongst several masters, each of them requesting bus ownership
+ * when they need to.
+ */
+struct i3c_bus {
+	struct device dev;
+	struct i3c_device *cur_master;
+	int id;
+	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
+	enum i3c_bus_mode mode;
+	struct {
+		unsigned long i3c;
+		unsigned long i2c;
+	} scl_rate;
+	struct {
+		struct list_head i3c;
+		struct list_head i2c;
+	} devs;
+	struct rw_semaphore lock;
+};</pre>
    </blockquote>
    Can you explain the addrslots[] ?<br>
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">
+
+static inline struct i3c_device *dev_to_i3cdev(struct device *dev)
+{
+	return container_of(dev, struct i3c_device, dev);
+}
+
+struct i3c_master_controller;
+
+/**
+ * struct i3c_master_controller_ops - I3C master methods
+ * @bus_init: hook responsible for the I3C bus initialization. This
+ *	      initialization should follow the steps described in the I3C
+ *	      specification. This hook is called with the bus lock held in
+ *	      write mode, which means all _locked() helpers can safely be
+ *	      called from there
+ * @bus_cleanup: cleanup everything done in
+ *		 &amp;i3c_master_controller_ops-&gt;bus_init(). This function is
+ *		 optional and should only be implemented if
+ *		 &amp;i3c_master_controller_ops-&gt;bus_init() attached private data
+ *		 to I3C/I2C devices. This hook is called with the bus lock
+ *		 held in write mode, which means all _locked() helpers can
+ *		 safely be called from there
+ * @supports_ccc_cmd: should return true if the CCC command is supported, false
+ *		      otherwise
+ * @send_ccc_cmd: send a CCC command
+ * @send_hdr_cmds: send one or several HDR commands. If there is more than one
+ *		   command, they should ideally be sent in the same HDR
+ *		   transaction
+ * @priv_xfers: do one or several private I3C SDR transfers
+ * @i2c_xfers: do one or several I2C transfers
+ * @request_ibi: attach an IBI handler to an I3C device. This implies defining
+ *		 an IBI handler and the constraints of the IBI (maximum payload
+ *		 length and number of pre-allocated slots).
+ *		 Some controllers support less IBI-capable devices than regular
+ *		 devices, so this method might return -%EBUSY if there's no
+ *		 more space for an extra IBI registration
+ * @free_ibi: free an IBI previously requested with -&gt;request_ibi(). The IBI
+ *	      should have been disabled with -&gt;disable_irq() prior to that
+ * @enable_ibi: enable the IBI. Only valid if -&gt;request_ibi() has been called
+ *		prior to -&gt;enable_ibi(). The controller should first enable
+ *		the IBI on the controller end (for example, unmask the hardware
+ *		IRQ) and then send the ENEC CCC command (with the IBI flag set)
+ *		to the I3C device
+ * @disable_ibi: disable an IBI. First send the DISEC CCC command with the IBI
+ *		 flag set and then deactivate the hardware IRQ on the
+ *		 controller end
+ * @recycle_ibi_slot: recycle an IBI slot. Called every time an IBI has been
+ *		      processed by its handler. The IBI slot should be put back
+ *		      in the IBI slot pool so that the controller can re-use it
+ *		      for a future IBI
+ *
+ * One of the most important hooks in these ops is
+ * &amp;i3c_master_controller_ops-&gt;bus_init(). Here is a non-exhaustive list of
+ * things that should be done in &amp;i3c_master_controller_ops-&gt;bus_init():
+ *
+ * 1) call i3c_master_set_info() with all information describing the master
+ * 2) ask all slaves to drop their dynamic address by sending the RSTDAA CCC
+ *    with i3c_master_rstdaa_locked()
+ * 3) ask all slaves to disable IBIs using i3c_master_disec_locked()
+ * 4) start a DDA procedure by sending the ENTDAA CCC with
+ *    i3c_master_entdaa_locked(), or using the internal DAA logic provided by
+ *    your controller</pre>
    </blockquote>
    You mean SETDASA CCC command?<br>
    <blockquote type="cite"
      cite="mid:20171214151610.19153-3-boris.brezillon@free-electrons.com">
      <pre wrap="">
+ * 5) assign a dynamic address to each I3C device discovered during DAA and
+ *    for each of them, call i3c_master_add_i3c_dev_locked()
+ * 6) propagate device table to secondary masters by calling
+ *    i3c_master_defslvs_locked()
+ *
+ * Note that these steps do not include all controller specific initialization.
+ */
+struct i3c_master_controller_ops {
+	int (*bus_init)(struct i3c_master_controller *master);
+	void (*bus_cleanup)(struct i3c_master_controller *master);
+	bool (*supports_ccc_cmd)(struct i3c_master_controller *master,
+				 const struct i3c_ccc_cmd *cmd);
+	int (*send_ccc_cmd)(struct i3c_master_controller *master,
+			    struct i3c_ccc_cmd *cmd);
+	int (*send_hdr_cmds)(struct i3c_master_controller *master,
+			     const struct i3c_hdr_cmd *cmds,
+			     int ncmds);
+	int (*priv_xfers)(struct i3c_master_controller *master,
+			  const struct i3c_priv_xfer *xfers,
+			  int nxfers);
+	int (*i2c_xfers)(struct i3c_master_controller *master,
+			 const struct i2c_msg *xfers, int nxfers);
+	int (*request_ibi)(struct i3c_master_controller *master,
+			   struct i3c_device *dev,
+			   const struct i3c_ibi_setup *req);
+	void (*free_ibi)(struct i3c_master_controller *master,
+			 struct i3c_device *dev);
+	int (*enable_ibi)(struct i3c_master_controller *master,
+			  struct i3c_device *dev);
+	int (*disable_ibi)(struct i3c_master_controller *master,
+			   struct i3c_device *dev);
+	void (*recycle_ibi_slot)(struct i3c_master_controller *master,
+				 struct i3c_device *dev,
+				 struct i3c_ibi_slot *slot);
+};
+

</pre>
    </blockquote>
    <br>
    Best regards,<br>
    Vitor Soares<br>
  </body>
</html>

--------------A0BB601FD83C89E4F6A1B8E3--

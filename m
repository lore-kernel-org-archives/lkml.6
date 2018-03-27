Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeC0Wuk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:50:40 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37599 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeC0Wuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:50:37 -0400
X-Google-Smtp-Source: AIpwx49fKvgywpP37RA/CiIz/oT1HfMcBa1O/u+41Fe8XEgCfIINAbBF4tMdIxNLctHcs5ZVcFucSg==
Subject: Re: [PATCH v3 1/2] of_net: Implement of_get_nvmem_mac_address helper
To: Mike Looijmans <mike.looijmans@topic.nl>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andrew@lunn.ch, robh+dt@kernel.org, frowand.list@gmail.com
References: <1522144346-32367-1-git-send-email-mike.looijmans@topic.nl>
 <1522144346-32367-2-git-send-email-mike.looijmans@topic.nl>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <8623d20b-5a01-b2bd-39f2-900177f96595@gmail.com>
Date: Tue, 27 Mar 2018 15:50:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522144346-32367-2-git-send-email-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 02:52 AM, Mike Looijmans wrote:
> It's common practice to store MAC addresses for network interfaces into
> nvmem devices. However the code to actually do this in the kernel lacks,
> so this patch adds of_get_nvmem_mac_address() for drivers to obtain the
> address from an nvmem cell provider.
> 
> This is particulary useful on devices where the ethernet interface cannot
> be configured by the bootloader, for example because it's in an FPGA.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  Documentation/devicetree/bindings/net/ethernet.txt |  2 ++
>  drivers/of/of_net.c                                | 40 ++++++++++++++++++++++
>  include/linux/of_net.h                             |  6 ++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet.txt b/Documentation/devicetree/bindings/net/ethernet.txt
> index 2974e63..cfc376b 100644
> --- a/Documentation/devicetree/bindings/net/ethernet.txt
> +++ b/Documentation/devicetree/bindings/net/ethernet.txt
> @@ -10,6 +10,8 @@ Documentation/devicetree/bindings/phy/phy-bindings.txt.
>    the boot program; should be used in cases where the MAC address assigned to
>    the device by the boot program is different from the "local-mac-address"
>    property;
> +- nvmem-cells: phandle, reference to an nvmem node for the MAC address;
> +- nvmem-cell-names: string, should be "mac-address" if nvmem is to be used;
>  - max-speed: number, specifies maximum speed in Mbit/s supported by the device;
>  - max-frame-size: number, maximum transfer unit (IEEE defined MTU), rather than
>    the maximum frame size (there's contradiction in the Devicetree
> diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
> index d820f3e..1c5d372 100644
> --- a/drivers/of/of_net.c
> +++ b/drivers/of/of_net.c
> @@ -7,6 +7,7 @@
>   */
>  #include <linux/etherdevice.h>
>  #include <linux/kernel.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of_net.h>
>  #include <linux/phy.h>
>  #include <linux/export.h>
> @@ -80,3 +81,42 @@ const void *of_get_mac_address(struct device_node *np)
>  	return of_get_mac_addr(np, "address");
>  }
>  EXPORT_SYMBOL(of_get_mac_address);
> +
> +/**
> + * Obtain the MAC address from an nvmem provider named 'mac-address' through
> + * device tree.
> + * On success, copies the new address into memory pointed to by addr and
> + * returns 0. Returns a negative error code otherwise.
> + * @np:		Device tree node containing the nvmem-cells phandle
> + * @addr:	Pointer to receive the MAC address using ether_addr_copy()
> + */
> +int of_get_nvmem_mac_address(struct device_node *np, void *addr)
> +{
> +	struct nvmem_cell *cell;
> +	const void *mac;
> +	size_t len;
> +	int ret;
> +
> +	cell = of_nvmem_cell_get(np, "mac-address");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	mac = nvmem_cell_read(cell, &len);
> +
> +	nvmem_cell_put(cell);
> +
> +	if (IS_ERR(mac))
> +		return PTR_ERR(mac);
> +
> +	if (len < 6 || !is_valid_ether_addr(mac)) {
> +		ret = -EINVAL;

Just one nit here, can you use ETH_ALEN instead of 6? With that fixed:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

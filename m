Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeC2Fxo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 01:53:44 -0400
Received: from out2-2.antispamcloud.com ([185.201.17.2]:46390 "EHLO
        out2-2.antispamcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeC2Fxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 01:53:42 -0400
Subject: Re: [PATCH v3 1/2] of_net: Implement of_get_nvmem_mac_address helper
To: Florian Fainelli <f.fainelli@gmail.com>, <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <frowand.list@gmail.com>
References: <1522144346-32367-1-git-send-email-mike.looijmans@topic.nl>
 <1522144346-32367-2-git-send-email-mike.looijmans@topic.nl>
 <8623d20b-5a01-b2bd-39f2-900177f96595@gmail.com>
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <c4531eec-9478-72c2-96cc-39c380784aa4@topic.nl>
Date: Thu, 29 Mar 2018 07:31:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8623d20b-5a01-b2bd-39f2-900177f96595@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: nl
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.80.121]
X-EXCLAIMER-MD-CONFIG: 9833cda7-5b21-4d34-9a38-8d025ddc3664
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
X-Originating-IP: 37.74.225.130
X-AntiSpamCloud-Domain: topic.nl
X-AntiSpamCloud-Username: 37.74.225.128/28
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=37.74.225.128/28@topic.nl
X-AntiSpamCloud-Outgoing-Class: ham
X-AntiSpamCloud-Outgoing-Evidence: SB/global_tokens (1.76076772265e-05)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sIZgii4SaH4KREPm8ZdBMZ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO+96+QNheGL52p7CTJb/LLt8LN00Y2guNhbTSbk1sIe8Djyy3a2E4FE0gyEv2paMgx45
 AsU7PjkWSgJ6hT/5f3wrrJmmz4s33KZpQU8Y2YPnnIHffehafz06faNDpQLUo+pO6OZGArYx3jVR
 0FzGbpJE0tZVvGWHby+kMvFw6BnFciVEJd6cOUIWe2I+rBWBOhjrdLldmwqWZjEw2lWOqOM0rUNY
 P4JmLf0OrncMHnx/MQelomI6zEsIJFw1+DPdKEnbGAUM6/AxF4f+pHkpaAompiaXshAUGr287VWd
 k0Mxg8CBO1Snvm6qXHQp7O9kdR4X9ttL/sdiZKQ2uSPWcVNz4UuEee9x9b4ll3Y/llQTWCEWK4MJ
 jQR0Pz5bwy7RNp196BWWwnqth/mDG0UytXilIs0ttKbf3XFoG+46FpMiQJtR4QxWMOifmt9LOcQX
 1afTF2zzHOUj1s00F3rRRprij+9G/7d5MDq+6sd/vjq9CgncP+OvP+isXZUr+1RZeaNJa3F8c06f
 uQ0QpMkrp1CBhp6T+J6jJzHlv+Uzoe0HOqw59LUzlXJicKiPCbtp3rfA7PB4TLvALLgvlz9CFnU1
 FbJeDLLxromwh8BCwKxll4R0equGbXKeYbboZORQXcIDzcKcwQNyxDThuFIOpesTX5D0NHhhtAZG
 f9IIVVIxTXdwUerr2rMiAujZBN/w9K0jiD6XqsJZtjQxlyCdseyfXcFcWmZidP5aKfbJuK/ktI6s
 NBpNq/qNiGfYr4kLUmP/cmcY9OlhjbZZJHFKG4bQLVmf+x+3/4WOR8nj5+zcspR2Bf+pGyJhJtVV
 /lTQTL7dXKyY7IzvePnYpgBB8GKt85jdQ1W7xM52M4KvSDiboYmK0iD+RkCYf6CIyFevjxck91ZG
 SgDiy2Q6y0jepX36VQfb/c2NIfGrBGJmxhrC0so9z2+TU8E4Ku/o6XnMIeiRrPxsGMX79rpZUwEJ
 JAGItXys+GNHq6q6V0beRcXLa8zked5itrDd+BzMviaERTiSFTUMT/tCu8s86nJbTOP/sxEpZE8X
 UgjXA30aIXHoVgW9/bktU41htiJ8fk7NkDTmDyM+MpzGu6WUOIYvxxr8kAd/OGj8ERJDHlmjCvMP
X-Report-Abuse-To: spam@quarantine2.antispamcloud.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿On 28-03-18 00:50, Florian Fainelli wrote:
> On 03/27/2018 02:52 AM, Mike Looijmans wrote:
>> It's common practice to store MAC addresses for network interfaces into
>> nvmem devices. However the code to actually do this in the kernel lacks,
>> so this patch adds of_get_nvmem_mac_address() for drivers to obtain the
>> address from an nvmem cell provider.
>>
>> This is particulary useful on devices where the ethernet interface cannot
>> be configured by the bootloader, for example because it's in an FPGA.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>   Documentation/devicetree/bindings/net/ethernet.txt |  2 ++
>>   drivers/of/of_net.c                                | 40 ++++++++++++++++++++++
>>   include/linux/of_net.h                             |  6 ++++
>>   3 files changed, 48 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/ethernet.txt b/Documentation/devicetree/bindings/net/ethernet.txt
>> index 2974e63..cfc376b 100644
>> --- a/Documentation/devicetree/bindings/net/ethernet.txt
>> +++ b/Documentation/devicetree/bindings/net/ethernet.txt
>> @@ -10,6 +10,8 @@ Documentation/devicetree/bindings/phy/phy-bindings.txt.
>>     the boot program; should be used in cases where the MAC address assigned to
>>     the device by the boot program is different from the "local-mac-address"
>>     property;
>> +- nvmem-cells: phandle, reference to an nvmem node for the MAC address;
>> +- nvmem-cell-names: string, should be "mac-address" if nvmem is to be used;
>>   - max-speed: number, specifies maximum speed in Mbit/s supported by the device;
>>   - max-frame-size: number, maximum transfer unit (IEEE defined MTU), rather than
>>     the maximum frame size (there's contradiction in the Devicetree
>> diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
>> index d820f3e..1c5d372 100644
>> --- a/drivers/of/of_net.c
>> +++ b/drivers/of/of_net.c
>> @@ -7,6 +7,7 @@
>>    */
>>   #include <linux/etherdevice.h>
>>   #include <linux/kernel.h>
>> +#include <linux/nvmem-consumer.h>
>>   #include <linux/of_net.h>
>>   #include <linux/phy.h>
>>   #include <linux/export.h>
>> @@ -80,3 +81,42 @@ const void *of_get_mac_address(struct device_node *np)
>>   	return of_get_mac_addr(np, "address");
>>   }
>>   EXPORT_SYMBOL(of_get_mac_address);
>> +
>> +/**
>> + * Obtain the MAC address from an nvmem provider named 'mac-address' through
>> + * device tree.
>> + * On success, copies the new address into memory pointed to by addr and
>> + * returns 0. Returns a negative error code otherwise.
>> + * @np:		Device tree node containing the nvmem-cells phandle
>> + * @addr:	Pointer to receive the MAC address using ether_addr_copy()
>> + */
>> +int of_get_nvmem_mac_address(struct device_node *np, void *addr)
>> +{
>> +	struct nvmem_cell *cell;
>> +	const void *mac;
>> +	size_t len;
>> +	int ret;
>> +
>> +	cell = of_nvmem_cell_get(np, "mac-address");
>> +	if (IS_ERR(cell))
>> +		return PTR_ERR(cell);
>> +
>> +	mac = nvmem_cell_read(cell, &len);
>> +
>> +	nvmem_cell_put(cell);
>> +
>> +	if (IS_ERR(mac))
>> +		return PTR_ERR(mac);
>> +
>> +	if (len < 6 || !is_valid_ether_addr(mac)) {
>> +		ret = -EINVAL;
> 
> Just one nit here, can you use ETH_ALEN instead of 6? With that fixed:
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 

Ok, implemented and tested it, and v4 is on the way with that change.


Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail

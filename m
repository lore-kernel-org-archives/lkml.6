Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeC0H3D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:29:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33880 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeC0H2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:28:53 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180327072851euoutp025cdfc0657e22122bd9e497c96f9cf360~ftmImm9ac2326323263euoutp02J
X-AuditID: cbfec7f2-1dbff70000011644-7d-5ab9f2af5061
Subject: Re: [PATCH v6 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder
 driver
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <df124c8f-7c71-7941-9969-977dd19c7d1b@samsung.com>
Date: Tue, 27 Mar 2018 09:28:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <30381869-9bc8-b6aa-a37a-598d9c8f280d@mentor.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURiFvTPT6UAsuRQJv2gw1iUuLK5hDEpIJGYeTDS+SHgQq0yQAMW0
        srmFgmiLLMqmXSJgIJiqNKmCgmsKWolLBTQiQiBYFTR1AQtBUWQYiLyd/7vn3Hv+5DKk/BQd
        yCSqjvBqlTJZQXtTjY/HnSHW4abYdVcc4WzhizaCzdG5JWxl6wsJ+8rzjWY/dt8j2NwGD2Id
        v69LWf35Ginb2Wym2YahrwTbf9VNs7Vv2gnWUVEkYfPutUrZZ5ZuKfvxYSMdhblrl64hrrOo
        kOD6yycJrsnYK+VMOoOEm+waIDmbRU9z9hYd4m6N9ku4vrMOgrvjyUHcp84xmjOPj1LciC1o
        t0+s99Z4PjkxnVeHRe73PuQ6byUOm9Zm2syDVDbKXpaPvBjAm6C0TkvkI29Gjq8gMOfVUOLw
        E8HzbyWE4JLjEQTltf6ziUcXimcSdQjKnM6ZwY2g0TwoyUcM44d3wUQTLfAF+D0Bph9aUhhI
        nIOgoy2XFK6i8Wr4c+MtLWgZjoTTPRenwxReAVUTewXsj2OguvwDEi2+0GZwUYL2mrIX37gs
        FTSJl0Bug4kUdQB0uyqnCwG+y4BeaybF2tEwZnpCidoPPjtuSkW9GJ6WFszwY/B2MIcSwzoE
        fb/P0OJBBLQ42qfLkVOlrc1hIt4GD0t7kYAB+0CX21fs4AMljRdIEctAd1ouupdC3/OGmTYB
        UPvSQ59Dy4xzNjPO2cY4Zxvj/3erEGVBAXyaJiWB16xX8RmhGmWKJk2VEHowNcWGpv7m07+O
        4dvI03HAjjCDFPNlUXRTrFyiTNdkpdgRMKRigSypdgrJ4pVZR3l1apw6LZnX2NEihlIEyPat
        OhkrxwnKI3wSzx/m1bOnBOMVmI2S/V8PGGpWHvieWTZk0mZYgrT1e6zh7pcDfza+k2RUjiZk
        RX0pUzifbXb9CozpeT9UbTn+tzM1vSU4Tn8/fJ4t9ERMxPJoaUSFCbdff+c+6cobCa7zC8nf
        tcLgcwz16euthgc7Bxf6hnht2nDXaWcKtjh7VOe273igC+yaNKIzuQpKc0i5fg2p1ij/AXMO
        6NmXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsVy+t/xe7qrPu2MMjjXom7Re+4kk0VTx1tW
        i/lHzrFaXPn6ns3i2a29TBbNW78yWhz/vZbdonPiEnaLy7vmsFlsffmOyeLB6rdsFkuvX2Sy
        OD6tj9Wide8Rdoszq26xWzw7sI3NQcBjzbw1jB6X+3qZPB5M/c/ksXPWXXaP2R0zWT3+33jE
        7LFpVSebx6HDHYwe2789YPW4332cyWP31yZGj+eXv7N5zPn5jcXj8ya5AL4oPZui/NKSVIWM
        /OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwnE9czFczWrtg05wVL
        A2ODchcjJ4eEgInE0en9TF2MXBxCAksZJX69OMUCkRCX2D3/LTOELSzx51oXG4gtJPCaUWLJ
        JpcuRg4OYQFfiZd3xUF6RQQeM0k0vNnECuIwCzQxSkyY/Qlq6kQmiW1TT7GCdLMJaEr83XwT
        bBKvgJ1E250ZrCCTWARUJRb8CQcJiwpESHSunM8CUSIocXLmEzCbE6i8f/MidhCbWUBd4s+8
        S8wQtrxE89bZULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yYW1ya
        l66XnJ+7iRGYKLYd+7l5B+OljcGHGAU4GJV4eGdw7IwSYk0sK67MPcQowcGsJMKbvRQoxJuS
        WFmVWpQfX1Sak1p8iNEU6LeJzFKiyfnAJJZXEm9oamhuYWlobmxubGahJM573qAySkggPbEk
        NTs1tSC1CKaPiYNTqoFxAuvG9hcnXc1P8+9SXvxFb1fjxoCZm5f+ijH5EPF50tPNE5cWnsiY
        YzzH9lWqzfU1jbMjxWoyfbmEZpafcVjONEFV0/Pa78K2zQv/zbXx3DTj7/tGn9Mvc7duqFTu
        udHZ0FjPcFVg6f4ne1as97p92dOQdeeEl10HPGPUMj46Hj2vt/PQ8fxVDUosxRmJhlrMRcWJ
        AGCHS5UqAwAA
X-CMS-MailID: 20180327072843eucas1p19825f2b477afd43466b41785bf1c5852
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180327072843eucas1p19825f2b477afd43466b41785bf1c5852
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180327062437epcas5p3389cb070d15669febeb6f504cff2cf6f
X-RootMTR: 20180327062437epcas5p3389cb070d15669febeb6f504cff2cf6f
References: <1521213399-31947-1-git-send-email-jacopo+renesas@jmondi.org>
        <1521213399-31947-3-git-send-email-jacopo+renesas@jmondi.org>
        <CGME20180327062437epcas5p3389cb070d15669febeb6f504cff2cf6f@epcas5p3.samsung.com>
        <30381869-9bc8-b6aa-a37a-598d9c8f280d@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.2018 08:24, Vladimir Zapolskiy wrote:
> Hi Jacopo,
>
> On 03/16/2018 05:16 PM, Jacopo Mondi wrote:
>> Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
>> output converter.
>>
>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>> ---
>>  drivers/gpu/drm/bridge/Kconfig        |   6 +
>>  drivers/gpu/drm/bridge/Makefile       |   1 +
>>  drivers/gpu/drm/bridge/thc63lvd1024.c | 255 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 262 insertions(+)
>>  create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c
>>
>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>> index 3b99d5a..5815a20 100644
>> --- a/drivers/gpu/drm/bridge/Kconfig
>> +++ b/drivers/gpu/drm/bridge/Kconfig
>> @@ -92,6 +92,12 @@ config DRM_SII9234
>>  	  It is an I2C driver, that detects connection of MHL bridge
>>  	  and starts encapsulation of HDMI signal.
>>  
>> +config DRM_THINE_THC63LVD1024
>> +	tristate "Thine THC63LVD1024 LVDS decoder bridge"
>> +	depends on OF
>> +	---help---
>> +	  Thine THC63LVD1024 LVDS/parallel converter driver.
>> +
>>  config DRM_TOSHIBA_TC358767
>>  	tristate "Toshiba TC358767 eDP bridge"
>>  	depends on OF
>> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
>> index 373eb28..fd90b16 100644
>> --- a/drivers/gpu/drm/bridge/Makefile
>> +++ b/drivers/gpu/drm/bridge/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
>>  obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
>>  obj-$(CONFIG_DRM_SII902X) += sii902x.o
>>  obj-$(CONFIG_DRM_SII9234) += sii9234.o
>> +obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
>>  obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
>>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
>>  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
>> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
>> new file mode 100644
>> index 0000000..02a54c2
>> --- /dev/null
>> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
>> @@ -0,0 +1,255 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * THC63LVD1024 LVDS to parallel data DRM bridge driver.
>> + *
>> + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
>> + */
>> +
>> +#include <drm/drmP.h>
>> +#include <drm/drm_bridge.h>
>> +#include <drm/drm_panel.h>
>> +
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/of_graph.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +enum {
>> +	THC63_LVDS_IN0,
>> +	THC63_LVDS_IN1,
>> +	THC63_DIGITAL_OUT0,
>> +	THC63_DIGITAL_OUT1,
>> +};
>> +
>> +static const char * const thc63_reg_names[] = {
>> +	"vcc", "lvcc", "pvcc", "cvcc",
>> +};
>> +
>> +struct thc63_dev {
>> +	struct device *dev;
>> +
>> +	struct regulator *vccs[ARRAY_SIZE(thc63_reg_names)];
>> +
>> +	struct gpio_desc *pdwn;
>> +	struct gpio_desc *oe;
>> +
>> +	struct drm_bridge bridge;
>> +	struct drm_bridge *next;
>> +};
>> +
>> +static inline struct thc63_dev *to_thc63(struct drm_bridge *bridge)
>> +{
>> +	return container_of(bridge, struct thc63_dev, bridge);
>> +}
>> +
>> +static int thc63_attach(struct drm_bridge *bridge)
>> +{
>> +	struct thc63_dev *thc63 = to_thc63(bridge);
>> +
>> +	return drm_bridge_attach(bridge->encoder, thc63->next, bridge);
>> +}
>> +
>> +static void thc63_enable(struct drm_bridge *bridge)
>> +{
>> +	struct thc63_dev *thc63 = to_thc63(bridge);
>> +	struct regulator *vcc;
>> +	int i;
> unsigned int i;

Why? You are introducing silly bug this way, see few lines below.

>
>> +
>> +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
>> +		vcc = thc63->vccs[i];
>> +		if (!vcc)
>> +			continue;
>> +
>> +		if (regulator_enable(vcc))
>> +			goto error_vcc_enable;
>> +	}
>> +
>> +	if (thc63->pdwn)
>> +		gpiod_set_value(thc63->pdwn, 0);
>> +
>> +	if (thc63->oe)
>> +		gpiod_set_value(thc63->oe, 1);
>> +
>> +	return;
>> +
>> +error_vcc_enable:
>> +	dev_err(thc63->dev, "Failed to enable regulator %s\n",
>> +		thc63_reg_names[i]);
>> +
>> +	for (i = i - 1; i >= 0; i--) {

Here, the loop will not end if you define i unsigned.

I know one can change the loop, to make it working with unsigned. But
this clearly shows that using unsigned is more risky.
What are advantages of unsigned vs int in this case. Are there some
guidelines/discussions about it?

Regards
Andrzej

>> +		vcc = thc63->vccs[i];
>> +		if (!vcc)
>> +			continue;
>> +
>> +		regulator_disable(vcc);
>> +	}
>> +}
>> +
>> +static void thc63_disable(struct drm_bridge *bridge)
>> +{
>> +	struct thc63_dev *thc63 = to_thc63(bridge);
>> +	struct regulator *vcc;
>> +	int i;
>> +
>> +	if (thc63->oe)
>> +		gpiod_set_value(thc63->oe, 0);
>> +
>> +	if (thc63->pdwn)
>> +		gpiod_set_value(thc63->pdwn, 1);
>> +
>> +	for (i = ARRAY_SIZE(thc63->vccs) - 1; i >= 0; i--) {
>> +		vcc = thc63->vccs[i];
>> +		if (!vcc)
>> +			continue;
>> +
>> +		if (regulator_disable(vcc))
>> +			dev_dbg(thc63->dev,
>> +				"Failed to disable regulator %s\n",
>> +				thc63_reg_names[i]);
>> +	}
>> +}
>> +
>> +struct drm_bridge_funcs thc63_bridge_func = {
> Apparently you missed all my comments from v2 review.
>
> If you like to avoid non-NULL function pointers to the void, please 
> use static const storage qualifier.
>
> --
> With best wishes,
> Vladimir
>
>
>

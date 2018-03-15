Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbeCONhM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:37:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55385 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeCONhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:37:09 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180315133707euoutp01a364a8e0074a92b05ce37b0efc4ea816~cG4PoN6Xt2753927539euoutp01C
X-AuditID: cbfec7f2-1dbff70000011644-5e-5aaa77006f2c
Subject: Re: [PATCH v4 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder
 driver
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <1d98d055-fb5b-3840-e9dd-6bb8f8251bb9@samsung.com>
Date: Thu, 15 Mar 2018 14:37:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521111391-3515-3-git-send-email-jacopo+renesas@jmondi.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG/c5tR2n2tYy92H0VWNHF8I9DF4mIOGnQBQIZlS07WahTNi9Z
        EEtxriSzKC9L0+42XZI1cwOjZrXsXguvlWKmdlHDW5mleXaS/O/3vu/zPe/7wMeSiiHanz2g
        jRd0Wk20ivGhKh4NvVzilWRRLz9dPJ878aKG4FJMXTRX+OAFzb0d6GG49sYqgku1DSDONWyV
        ccdOXZZxbkc+w9k+dxNcS0kXw12pe01wruxMmkureiDjnlkaZWsn86XnSxHvzjxB8C1nRwne
        bn4v48+Z8mh+tL6V5MstxxjeWW1C/J3BFppvznARfIf7B8PnDw1SfF/5rC1ytc/qvUL0gURB
        tyx4t8/+nF8fqLjcdQcfllVQBvQt6DjyZgEHQVF7H3Ec+bAKXIygtOkSJRX9CKqz6kip6EPQ
        ffceM/6kzX2SFlmBryEYGfGVRF0IOjoyZOJgKt4M/SVGj68fthJQ0/PT40viFARvalJJUcXg
        hfDnVsOYLcvKcTBYzmwW2xReAPavvR7JNBwGF85+QiLL8RSoyWujRPbGGyHrmtHTJ/FsSLWd
        IyVWQmNboWcx4Nss3Ex/RIn+gNdDd6G/lGAqfHHdlkk8A0btol7kw9DQmUJJb00ImofT/0Ve
        BdWu17ToQ47dXOZYJlmugVrTBgl9ob5rinSBL5yuyCGlthxMRoXkMRean9tIiZVw5dUAk4Xm
        mSfkMk/IYp6Qxfx/bRGiLEgpJOhjIgV9oFZIWqrXxOgTtJFLI2JjytHYh3w64uqtRANv9jgR
        ZpFqkrx+3nW1gtYk6pNjnAhYUuUn3xRnUSvkezXJhwRdbLguIVrQO9F0llIp5bsCjqgVOFIT
        L0QJQpygG58SrLe/AYULrWpw1f76vs42J6QoTb21s2XlkwzrkDPr3VdSSSpsITtuhO27p5VZ
        H7tr0wYXbPcKy63dcLmAifi4ojDxYdTO7PZF/dvtgsGaU1AVRpGhjn3O6Peco/TCzhsBhpcJ
        e2Lz3yaGq54ZL94/yr8zBh6uzFy8zfE7+OqpTmJmU+gPFaXfrwlcROr0mr/DeELXjAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42I5/e/4Xd1/ZauiDB6sNrboPXeSyaKp4y2r
        xfwj51gtrnx9z2bx7NZeJovmrV8ZLY7/Xstu0TlxCbvF5V1z2Cy2vnzHZPFg9Vs2i6XXLzJZ
        HJ/Wx2rRuvcIu8WZVbfYHfg91sxbw+hxua+XyePB1P9MHjtn3WX3mN0xk9Xj/41HzB6bVnWy
        eRw63MHosf3bA1aP+93HmTyeX/7O5jHn5zcWj8+b5AJ4o/RsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQypv+6x1Iww6ni6PptLA2Mb0y6GDk5JARM
        JJ5c7mftYuTiEBJYyiix/cJDJoiEuMTu+W+ZIWxhiT/Xutggil4zSjz+288CkhAW8JX4deQJ
        E0hCRGAtk8STIwuYQRxmgSZGiQmzP4GNEhK4zSix5wQPiM0moCnxd/NNoFEcHLwCdhKrpviD
        hFkEVCV2vv4Etk1UIEKic+V8sAW8AoISJ2c+AbM5BTwlJixvYwSxmQXUJf7Mu8QMYctLNG+d
        DWWLS9x6Mp9pAqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiB
        aWHbsZ9bdjB2vQs+xCjAwajEw3tDeWWUEGtiWXFl7iFGCQ5mJRFen4JVUUK8KYmVValF+fFF
        pTmpxYcYTYGem8gsJZqcD0xZeSXxhqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg
        +pg4OKUaGC82/HneuK2F03r9+Uvz9e8U2db9UW4XaKk5LiS9c96lHZ/5TbzPZUcyh90IL+n/
        VOR4M0GrL+zu9j/Pb5avLZ+U/7pLbMbHnadabuxcaMFhGL//6jMr4U0qNpukEu0WLX2y723K
        sTkLJy1njX3d/UXWsKD7m1E8o8CvFeb7LTcvmj79j9afAw+VWIozEg21mIuKEwHQcWK+IQMA
        AA==
X-CMS-MailID: 20180315133703eucas1p22d201fc21afab5b89b063340e15e50b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180315133703eucas1p22d201fc21afab5b89b063340e15e50b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180315112237epcas1p4fba95a534dc025679b054d5c58ce013d
X-RootMTR: 20180315112237epcas1p4fba95a534dc025679b054d5c58ce013d
References: <1521111391-3515-1-git-send-email-jacopo+renesas@jmondi.org>
        <CGME20180315112237epcas1p4fba95a534dc025679b054d5c58ce013d@epcas1p4.samsung.com>
        <1521111391-3515-3-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 11:56, Jacopo Mondi wrote:
> Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
> output converter.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  drivers/gpu/drm/bridge/Kconfig        |   6 +
>  drivers/gpu/drm/bridge/Makefile       |   1 +
>  drivers/gpu/drm/bridge/thc63lvd1024.c | 255 ++++++++++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 3b99d5a..5815a20 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -92,6 +92,12 @@ config DRM_SII9234
>  	  It is an I2C driver, that detects connection of MHL bridge
>  	  and starts encapsulation of HDMI signal.
>  
> +config DRM_THINE_THC63LVD1024
> +	tristate "Thine THC63LVD1024 LVDS decoder bridge"
> +	depends on OF
> +	---help---
> +	  Thine THC63LVD1024 LVDS/parallel converter driver.
> +
>  config DRM_TOSHIBA_TC358767
>  	tristate "Toshiba TC358767 eDP bridge"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 373eb28..fd90b16 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
>  obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
>  obj-$(CONFIG_DRM_SII902X) += sii902x.o
>  obj-$(CONFIG_DRM_SII9234) += sii9234.o
> +obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
>  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
> new file mode 100644
> index 0000000..067f231
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * THC63LVD1024 LVDS to parallel data DRM bridge driver.
> + *
> + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_panel.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/of_graph.h>
> +#include <linux/regulator/consumer.h>
> +
> +enum {
> +	THC63_LVDS_IN0,
> +	THC63_LVDS_IN1,
> +	THC63_DIGITAL_OUT0,
> +	THC63_DIGITAL_OUT1,
> +};
> +
> +static const char * const thc63_reg_names[] = {
> +	"vcc", "lvcc", "pvcc", "cvcc",
> +};
> +
> +struct thc63_dev {
> +	struct device *dev;
> +
> +	struct regulator *vccs[ARRAY_SIZE(thc63_reg_names)];
> +
> +	struct gpio_desc *pdwn;
> +	struct gpio_desc *oe;
> +
> +	struct drm_bridge bridge;
> +	struct drm_bridge *next;
> +};
> +
> +static inline struct thc63_dev *to_thc63(struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct thc63_dev, bridge);
> +}
> +
> +static int thc63_attach(struct drm_bridge *bridge)
> +{
> +	struct thc63_dev *thc63 = to_thc63(bridge);
> +
> +	return drm_bridge_attach(bridge->encoder, thc63->next, bridge);
> +}
> +
> +static void thc63_enable(struct drm_bridge *bridge)
> +{
> +	struct thc63_dev *thc63 = to_thc63(bridge);
> +	struct regulator *vcc;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
> +		vcc = thc63->vccs[i];
> +		if (!vcc)
> +			continue;
> +
> +		if (regulator_enable(vcc))
> +			goto error_vcc_enable;
> +	}
> +
> +	if (thc63->pdwn)
> +		gpiod_set_value(thc63->pdwn, 0);
> +
> +	if (thc63->oe)
> +		gpiod_set_value(thc63->oe, 1);
> +
> +	return;
> +
> +error_vcc_enable:
> +	dev_err(thc63->dev, "Failed to enable regulator %u\n", i);

It would be better to use supply or regulator name instead of index.

> +
> +	for (i = i - 1; i >= 0; i--) {
> +		vcc = thc63->vccs[i];
> +		if (!vcc)
> +			continue;
> +
> +		regulator_disable(vcc);
> +	}
> +}
> +
> +static void thc63_disable(struct drm_bridge *bridge)
> +{
> +	struct thc63_dev *thc63 = to_thc63(bridge);
> +	struct regulator *vcc;
> +	int i;
> +
> +	if (thc63->oe)
> +		gpiod_set_value(thc63->oe, 0);
> +
> +	if (thc63->pdwn)
> +		gpiod_set_value(thc63->pdwn, 1);
> +
> +	for (i = ARRAY_SIZE(thc63->vccs) - 1; i >= 0; i--) {
> +		vcc = thc63->vccs[i];
> +		if (!vcc)
> +			continue;
> +
> +		if (regulator_disable(vcc))
> +			dev_dbg(thc63->dev,
> +				"Failed to disable regulator %u\n", i);

ditto

> +	}
> +}
> +
> +struct drm_bridge_funcs thc63_bridge_func = {
> +	.attach	= thc63_attach,
> +	.enable = thc63_enable,
> +	.disable = thc63_disable,
> +};
> +
> +static int thc63_parse_dt(struct thc63_dev *thc63)
> +{
> +	struct device_node *thc63_out;
> +	struct device_node *remote;
> +	int ret = 0;
> +
> +	thc63_out = of_graph_get_endpoint_by_regs(thc63->dev->of_node,
> +						  THC63_DIGITAL_OUT0, -1);
> +	if (!thc63_out) {
> +		dev_err(thc63->dev, "Missing endpoint in Port@%u\n",
> +			THC63_DIGITAL_OUT0);
> +		return -ENODEV;
> +	}
> +
> +	remote = of_graph_get_remote_port_parent(thc63_out);
> +	if (!remote) {
> +		dev_err(thc63->dev, "Endpoint in Port@%u unconnected\n",
> +			THC63_DIGITAL_OUT0);
> +		ret = -ENODEV;
> +		goto error_put_out_node;
> +	}
> +
> +	if (!of_device_is_available(remote)) {
> +		dev_err(thc63->dev, "Port@%u remote endpoint is disabled\n",
> +			THC63_DIGITAL_OUT0);
> +		ret = -ENODEV;
> +		goto error_put_remote_node;
> +	}
> +
> +	thc63->next = of_drm_find_bridge(remote);
> +	if (!thc63->next)
> +		ret = -EPROBE_DEFER;
> +
> +error_put_remote_node:
> +	of_node_put(remote);
> +error_put_out_node:
> +	of_node_put(thc63_out);
> +
> +	return ret;
> +}
> +
> +static int thc63_gpio_init(struct thc63_dev *thc63)
> +{
> +	thc63->oe = devm_gpiod_get_optional(thc63->dev, "oe", GPIOD_OUT_LOW);
> +	if (IS_ERR(thc63->oe)) {
> +		dev_err(thc63->dev, "Unable to get \"oe-gpios\"\n");
> +		return PTR_ERR(thc63->oe);
> +	}
> +
> +	thc63->pdwn = devm_gpiod_get_optional(thc63->dev, "pdwn",
> +					      GPIOD_OUT_HIGH);
> +	if (IS_ERR(thc63->pdwn)) {
> +		dev_err(thc63->dev, "Unable to get \"pdwn-gpios\"\n");
> +		return PTR_ERR(thc63->pdwn);
> +	}
> +
> +	return 0;
> +}
> +
> +static int thc63_regulator_init(struct thc63_dev *thc63)
> +{
> +	struct regulator **reg;
> +	int i;
> +
> +	reg = &thc63->vccs[0];
> +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++, reg++) {
> +		*reg = devm_regulator_get_optional(thc63->dev,
> +						   thc63_reg_names[i]);
> +		if (IS_ERR(*reg)) {
> +			if (PTR_ERR(*reg) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			*reg = NULL;
> +		}

You could use "if (!...) continue", to avoid nesting.

With or without suggested changes:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

> +	}
> +
> +	return 0;
> +}
> +
> +static int thc63_probe(struct platform_device *pdev)
> +{
> +	struct thc63_dev *thc63;
> +	int ret;
> +
> +	thc63 = devm_kzalloc(&pdev->dev, sizeof(*thc63), GFP_KERNEL);
> +	if (!thc63)
> +		return -ENOMEM;
> +
> +	thc63->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, thc63);
> +
> +	ret = thc63_regulator_init(thc63);
> +	if (ret)
> +		return ret;
> +
> +	ret = thc63_gpio_init(thc63);
> +	if (ret)
> +		return ret;
> +
> +	ret = thc63_parse_dt(thc63);
> +	if (ret)
> +		return ret;
> +
> +	thc63->bridge.driver_private = thc63;
> +	thc63->bridge.of_node = pdev->dev.of_node;
> +	thc63->bridge.funcs = &thc63_bridge_func;
> +
> +	drm_bridge_add(&thc63->bridge);
> +
> +	return 0;
> +}
> +
> +static int thc63_remove(struct platform_device *pdev)
> +{
> +	struct thc63_dev *thc63 = platform_get_drvdata(pdev);
> +
> +	drm_bridge_remove(&thc63->bridge);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id thc63_match[] = {
> +	{ .compatible = "thine,thc63lvd1024", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, thc63_match);
> +#endif
> +
> +static struct platform_driver thc63_driver = {
> +	.probe	= thc63_probe,
> +	.remove	= thc63_remove,
> +	.driver	= {
> +		.name		= "thc63lvd1024",
> +		.of_match_table	= thc63_match,
> +	},
> +};
> +module_platform_driver(thc63_driver);
> +
> +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
> +MODULE_DESCRIPTION("Thine THC63LVD1024 LVDS decoder DRM bridge driver");
> +MODULE_LICENSE("GPL v2");

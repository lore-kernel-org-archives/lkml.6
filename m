Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeCNImv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:42:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57904 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeCNImr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:42:47 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180314084245euoutp02184abd5f7b06500d4f327a635905c8cf~bvN8JXf7B2647926479euoutp02N
X-AuditID: cbfec7f2-1dbff70000011644-d9-5aa8e08242cf
Subject: Re: [PATCH v3 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder
 driver
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <8c224e1e-9871-dce9-89d0-3dad8218a747@samsung.com>
Date: Wed, 14 Mar 2018 09:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520951425-13843-3-git-send-email-jacopo+renesas@jmondi.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxNcRj2O+fcc85t3Ry3ct/FimuNbPrYmOOrZRqHMdb8wV3FVWeFbuUe
        lYi12+JKNUxaVyS6SQp96cMaKq6rDyobKkrdQttlo6jdKd17mP573ud9nt/zvu9+NC63STzo
        g7FHeW2sOkZJOhEPnk12rNANlKj8ez/MZ7M6zBir01slbEFLh4R9Pf6NZEd6GjE2rWYcsSZb
        OcWevVBEsd0N+SRb8+Urxg7csZKs8U0nxpouZ0vY9MYWim0r7aGC5nJl18oQ152dhXEDOdMY
        V294T3FX9HkSbvrtIM5Vlp4luaZmPeJqfw5IuP5zJoz71P2L5PInfxLcj0rPXTKV0/pIPuZg
        Iq/1C9zvFN3XVU3EX910bKwzC09FH1ZlIJoGZiWknnHOQE60nClBMDg0RYrFGAJd2W0kFj8Q
        dBU/JjKQ1OHoNdoosXELwc2KdNLekDNWBHdeS+3YldkJp43vCbvIjSnHwPxtwlHgjG7mKXMa
        bleRjA/8rnrncMuYQKiotTgiCMYb9JZLDt6d2QOFOcNI1MwDc56okTLb4MXLbMqOccYLaq35
        uIgV0GMpwOxhwNymwZB/gxTnDoYG/VNMxK4waqqmRLwQpusL/vIn4N1nHSGa9Qj6bWf+mtdB
        s6lTYj8ZPjP1vQY/kd4AF6czSfGSLvDWOk+cwQUuPsjFRVoG+tNyUb0Y+ttrcBErwPhqnDyP
        lhhmbWaYtY1h1jaG/7nXEVGKFHyCoInihYBYPslXUGuEhNgo34g4TSWa+ZKtU6bvdWi860AT
        YmikdJbNeXVLJZeoE4VkTRMCGle6yWoWlqjkskh18nFeG7dPmxDDC01oAU0oFbLwZadUciZK
        fZQ/zPPxvPZfF6OlHqmIF8wnPua1G+OY7Z4HnLcMdz+KjldszEwZDZRSbSP6u15wP2+NP0E0
        pOzaG/pw7VLbYNAYPK37+jmu+JAme6KvyE+6uu7IlytbW7HOydzykieFpE9aqPfcHWGuqVnh
        zWHByYtCrFObI7yGd28JcYcqYah4NOlk0CWLTGB9njcqlIQQrQ5YjmsF9R/dFTgzjgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t/xe7r1D1ZEGaz9a2PRe+4kk0VTx1tW
        i/lHzrFaXPn6ns3i2a29TBbNW78yWhz/vZbdonPiEnaLy7vmsFlsffmOyeLB6rdsFkuvX2Sy
        OD6tj9Wide8Rdoszq26xO/B7rJm3htHjcl8vk8eDqf+ZPHbOusvuMbtjJqvH/xuPmD02repk
        8zh0uIPRY/u3B6we97uPM3k8v/ydzWPOz28sHp83yQXwRunZFOWXlqQqZOQXl9gqRRtaGOkZ
        WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl3Lm0haVgrnPFl4u9zA2M90y7GDk5JARM
        JG4v/c3excjFISSwlFFi573rjBAJcYnd898yQ9jCEn+udbFBFL1mlFhxthmsSFjAV+JcUxcj
        SEJEYC2TxJMjC5hBHGaBJkaJCbM/MUG03GWUuNW6BqyFTUBT4u/mm2wgNq+AncTG7U9YQGwW
        AVWJjidTwOKiAhESnSvns0DUCEqcnAlRwyngJXHqfB87iM0soC7xZ94lZghbXmL72zlQtrjE
        rSfzmSYwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJEZgath37
        uWUHY9e74EOMAhyMSjy8DBeWRwmxJpYVV+YeYpTgYFYS4d0qsyJKiDclsbIqtSg/vqg0J7X4
        EKMp0HMTmaVEk/OBaSuvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwen
        VANj/5WY8gavV1+6U9mL+Cctu+Z08uPb0p572QItb38K8sdtbfywYOLcCSwu7TqiT4++6T78
        KuXz1aqmKd84t5/+leQ5Ybqm02bu60vnl1+KPqm0b9+Kyklv4v8vaPGK2m7dVayZLJ/TVDbh
        yaHIlksC+iuOP3qhntEQncr4wW3L/RdCoh+PXso5pcRSnJFoqMVcVJwIAPGiWXcjAwAA
X-CMS-MailID: 20180314084241eucas1p1d8b58981713a2a52100eb0997cc7e156
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180314084241eucas1p1d8b58981713a2a52100eb0997cc7e156
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180313143057epcas4p4c747ed8c1b333a557eef5aa8e15376fd
X-RootMTR: 20180313143057epcas4p4c747ed8c1b333a557eef5aa8e15376fd
References: <1520951425-13843-1-git-send-email-jacopo+renesas@jmondi.org>
        <CGME20180313143057epcas4p4c747ed8c1b333a557eef5aa8e15376fd@epcas4p4.samsung.com>
        <1520951425-13843-3-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.2018 15:30, Jacopo Mondi wrote:
> Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
> output decoder.

IMO converter suits here better, but it is just suggestion.

>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  drivers/gpu/drm/bridge/Kconfig        |   7 +
>  drivers/gpu/drm/bridge/Makefile       |   1 +
>  drivers/gpu/drm/bridge/thc63lvd1024.c | 241 ++++++++++++++++++++++++++++++++++
>  3 files changed, 249 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 3b99d5a..facf6bd 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -92,6 +92,13 @@ config DRM_SII9234
>  	  It is an I2C driver, that detects connection of MHL bridge
>  	  and starts encapsulation of HDMI signal.
>  
> +config DRM_THINE_THC63LVD1024
> +	tristate "Thine THC63LVD1024 LVDS decoder bridge"
> +	depends on OF
> +	select DRM_PANEL_BRIDGE

You don't use PANEL_BRIDGE, it should be possible to drop the select.

> +	---help---
> +	  Thine THC63LVD1024 LVDS decoder bridge driver.

Decoder to what?
Maybe it would be better to say it is LVDS/parallel or LVDS/RGB
converter or bridge.

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
> index 0000000..4b059c0
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
> @@ -0,0 +1,241 @@
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
> +static const char * const thc63_reg_names[] = {
> +	"vcc", "lvcc", "pvcc", "cvcc", };
> +
> +struct thc63_dev {
> +	struct device *dev;
> +
> +	struct regulator *vccs[ARRAY_SIZE(thc63_reg_names)];
> +
> +	struct gpio_desc *pwdn;
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
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
> +		vcc = thc63->vccs[i];
> +		if (vcc) {
> +			ret = regulator_enable(vcc);
> +			if (ret)
> +				goto error_vcc_enable;
> +		}
> +	}
> +
> +	if (thc63->pwdn)
> +		gpiod_set_value(thc63->pwdn, 0);
> +
> +	if (thc63->oe)
> +		gpiod_set_value(thc63->oe, 1);
> +
> +	return;
> +
> +error_vcc_enable:
> +	dev_err(thc63->dev, "Failed to enable regulator %u\n", i);
> +}
> +
> +static void thc63_disable(struct drm_bridge *bridge)
> +{
> +	struct thc63_dev *thc63 = to_thc63(bridge);
> +	struct regulator *vcc;
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
> +		vcc = thc63->vccs[i];
> +		if (vcc) {
> +			ret = regulator_disable(vcc);
> +			if (ret)
> +				goto error_vcc_disable;

I think in disable path you can report an error and continue - should be
safer.

> +		}
> +	}
> +
> +	if (thc63->pwdn)
> +		gpiod_set_value(thc63->pwdn, 1);
> +
> +	if (thc63->oe)
> +		gpiod_set_value(thc63->oe, 0);

Usually disable uses reverse order. Ie first disable oe, then, pwdn,
then regulators, also in reverse order.
Looks more reasonable.

> +
> +	return;
> +
> +error_vcc_disable:
> +	dev_err(thc63->dev, "Failed to disable regulator %u\n", i);
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
> +	thc63_out = of_graph_get_endpoint_by_regs(thc63->dev->of_node, 2, -1);

Please define and use enums for port number, it will be more clear.

> +	if (!thc63_out) {
> +		dev_err(thc63->dev, "Missing endpoint in Port@2\n");
> +		return -ENODEV;
> +	}
> +
> +	remote = of_graph_get_remote_port_parent(thc63_out);
> +	if (!remote) {
> +		dev_err(thc63->dev, "Endpoint in Port@2 unconnected\n");
> +		ret = -ENODEV;
> +		goto error_put_out_node;
> +	}
> +
> +	if (!of_device_is_available(remote)) {
> +		dev_err(thc63->dev, "Port@2 remote endpoint is disabled\n");
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
> +	thc63->pwdn = devm_gpiod_get_optional(thc63->dev, "pwdn",
> +					      GPIOD_OUT_LOW);
Shouldn't be GPIOD_OUT_HIGH - bridge initially disabled?

Regards
Andrzej
> +	if (IS_ERR(thc63->pwdn)) {
> +		dev_err(thc63->dev, "Unable to get GPIO \"pwdn\"\n");
> +		return PTR_ERR(thc63->pwdn);
> +	}
> +
> +	thc63->oe = devm_gpiod_get_optional(thc63->dev, "oe", GPIOD_OUT_LOW);
> +	if (IS_ERR(thc63->oe)) {
> +		dev_err(thc63->dev, "Unable to get GPIO \"oe\"\n");
> +		return PTR_ERR(thc63->oe);
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

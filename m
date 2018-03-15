Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeCOJoy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:44:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47884 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeCOJou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:44:50 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180315094448euoutp010f06fd29a8da032248b53d687bf391dc~cDtZ2lyDh1136211362euoutp016
X-AuditID: cbfec7f5-b5fff700000028a9-39-5aaa408e131c
Subject: Re: [PATCH v3 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder
 driver
To: jacopo mondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <4204d21d-080f-b275-1f89-828cfdcdf90a@samsung.com>
Date: Thu, 15 Mar 2018 10:44:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314100902.GB16424@w540>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvTPT6VApuRYMJ2owFjcg7jyMQQmJROdFkcREJEatMoJKETui
        4hYCqAUCYQkIBa0bsZS6AAJqQCIlNkZFDS4FxaIW65KKiICCirQDkbf/fOc/95w/uQypGJFM
        Y3Yl7Oc1Cap4JS2j6u79erwgJ8wYvbiheDKb3XqfYFO1Tgmrb2mVsM/6e2j2Q0cjwabV9iPW
        MnxFynY60hGbkXdJyrbdLqPZ2k9fCbar0kmz5S+fEqylKEfCnmhskbIPjR3SMMyZzpoQ15aT
        TXBdhSMEd0vXKeVKtSUSbsT6juSqjRk012zWIq5+oEvC2bIsBOdoG6S5sl8DFNdX7bdeHi1b
        EcPH7zrAaxaFbpPFtTdoycRXGw4ZrItTUFN4JvJgAAdDqambzEQyRoENCN58e4/E4gcC/bUK
        qVj0IfjS+IkeHzFVnSFdWoEvIzDZVosmJwJDaqXE1fDGEXCyvJNyaR88G6462miXicRVJJzI
        c7gbNA6APzXt7lflOBQeF/W5OYXnwPPBEjefiqPgfGE3Ej1T4H6J3e3xwIFgKMx2cxLPhHpn
        GSlqX+iw6wnXMsAVDKTa/5Di2eFwXVdGiNobPltuSEU9A0Zu6cf4EWj/mEqJw1oEtuFTY5lD
        wGx5OhqNGd0QANduLxLxSsg31yEXBuwFVucU8QYvyK87TYpYDtqTCtE9C2yPaseu8YXyJ/10
        LvLXTUimm5BGNyGN7v/ec4gyIl8+SVDH8sKyBP7gQkGlFpISYhfu2KuuRqPf8sFfS/9NdOf3
        9maEGaT0lFv9K6IVEtUBIVndjIAhlT5y275RJI9RJR/mNXu3apLieaEZTWcopa98y/zj0Qoc
        q9rP7+H5RF4z3iUYj2kpKCj48Gb1qrj5F4nng5vMmgt1Fvp7WO7GNS++Nh3qKaLsih+RBWa9
        sWCtxp7mGdLtuJuWV7AuKI0ejpr7M6Z1p2x5QFQvXx9Z86An00+YxB8bmlOpmtxqtQqlw/Pa
        m54NHfTOyJoeERT8tqV4paIq3Wdp3L65xen63Yblib1HG15blJQQp1oSSGoE1T8AOH98kgMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsVy+t/xu7o9DquiDOadN7DoPXeSyaKp4y2r
        xfwj51gtrnx9z2bx7NZeJovmrV8ZLY7/Xstucfd5C6NF58Ql7BaXd81hs9j68h2TxYPVb9ks
        ll6/yGRxfFofq0Xr3iPsFmdW3WJ3EPBYM28No8flvl4mjwdT/zN57Jx1l91jdsdMVo//Nx4x
        e2xa1cnmcehwB6PH9m8PWD3udx9n8nh++Tubx5yf31g8Pm+SC+CN0rMpyi8tSVXIyC8usVWK
        NrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4uaeDueB2SMWKGwYNjPtduhg5
        OSQETCTWbJzL3MXIxSEksJRR4vbp+awQCXGJ3fPfMkPYwhJ/rnWxQRS9ZgTqeM8OkhAW8JU4
        19TFCGKLCKhIrHt+GayIWWAjs8S8XftYITo2MUn8ufAEbCybgKbE38032UBsXgE7ifPTPrOA
        2CwCqhJXv88Ei4sKREh0rpzPAlEjKHFy5hMwm1NAS2LF1F6wbcwC6hJ/5l1ihrDlJba/nQNl
        i0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgQli
        27Gfm3cwXtoYfIhRgINRiYf3hvLKKCHWxLLiytxDjBIczEoivPcLgUK8KYmVValF+fFFpTmp
        xYcYTYGem8gsJZqcD0xeeSXxhqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4
        OKUaGDV3M7Pn/U0+e614ZlK0GnfUlsWt+SEbGQW9WCwT1rGkKVYw9Yk6pT824t745svfU6e/
        7PBOeRVbv6d16aI6Gd2brtq1pm7fS/1XH1e8zvd4TbX62+VijOoy4sySAXdfC53gX1AobHCt
        Sfsef5DFj4NNUcuvdSY8bGuYf1M6YPpl6fO/5FYoKbEUZyQaajEXFScCAMXNC6smAwAA
X-CMS-MailID: 20180315094445eucas1p1fdceba9199354a72054827b8b97d6237
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180315094445eucas1p1fdceba9199354a72054827b8b97d6237
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180313143057epcas4p4c747ed8c1b333a557eef5aa8e15376fd
X-RootMTR: 20180313143057epcas4p4c747ed8c1b333a557eef5aa8e15376fd
References: <1520951425-13843-1-git-send-email-jacopo+renesas@jmondi.org>
        <CGME20180313143057epcas4p4c747ed8c1b333a557eef5aa8e15376fd@epcas4p4.samsung.com>
        <1520951425-13843-3-git-send-email-jacopo+renesas@jmondi.org>
        <8c224e1e-9871-dce9-89d0-3dad8218a747@samsung.com>
        <20180314100902.GB16424@w540>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.2018 11:09, jacopo mondi wrote:
> Hi Andrzej,
>     thanks for review
>
> On Wed, Mar 14, 2018 at 09:42:36AM +0100, Andrzej Hajda wrote:
>> On 13.03.2018 15:30, Jacopo Mondi wrote:
>>> Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
>>> output decoder.
>> IMO converter suits here better, but it is just suggestion.
>>
>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>> ---
>>>  drivers/gpu/drm/bridge/Kconfig        |   7 +
>>>  drivers/gpu/drm/bridge/Makefile       |   1 +
>>>  drivers/gpu/drm/bridge/thc63lvd1024.c | 241 ++++++++++++++++++++++++++++++++++
>>>  3 files changed, 249 insertions(+)
>>>  create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c
>>>
>>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>>> index 3b99d5a..facf6bd 100644
>>> --- a/drivers/gpu/drm/bridge/Kconfig
>>> +++ b/drivers/gpu/drm/bridge/Kconfig
>>> @@ -92,6 +92,13 @@ config DRM_SII9234
>>>  	  It is an I2C driver, that detects connection of MHL bridge
>>>  	  and starts encapsulation of HDMI signal.
>>>
>>> +config DRM_THINE_THC63LVD1024
>>> +	tristate "Thine THC63LVD1024 LVDS decoder bridge"
>>> +	depends on OF
>>> +	select DRM_PANEL_BRIDGE
>> You don't use PANEL_BRIDGE, it should be possible to drop the select.
>>
> Ack
>
>>> +	---help---
>>> +	  Thine THC63LVD1024 LVDS decoder bridge driver.
>> Decoder to what?
>> Maybe it would be better to say it is LVDS/parallel or LVDS/RGB
>> converter or bridge.
> "LVDS to digital CMOS/TTL parallel data converter" as the manual
> describes the chip?

Should work, unless we want some consistency in interface names, we have
already: parallel / DPI / RGB. I am little bit confused about relations
between them so I do not want to enforce any.


>
>>> +
>>>  config DRM_TOSHIBA_TC358767
>>>  	tristate "Toshiba TC358767 eDP bridge"
>>>  	depends on OF
>>> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
>>> index 373eb28..fd90b16 100644
>>> --- a/drivers/gpu/drm/bridge/Makefile
>>> +++ b/drivers/gpu/drm/bridge/Makefile
>>> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
>>>  obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
>>>  obj-$(CONFIG_DRM_SII902X) += sii902x.o
>>>  obj-$(CONFIG_DRM_SII9234) += sii9234.o
>>> +obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
>>>  obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
>>>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
>>>  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
>>> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
>>> new file mode 100644
>>> index 0000000..4b059c0
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
>>> @@ -0,0 +1,241 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * THC63LVD1024 LVDS to parallel data DRM bridge driver.
>>> + *
>>> + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
>>> + */
>>> +
>>> +#include <drm/drmP.h>
>>> +#include <drm/drm_bridge.h>
>>> +#include <drm/drm_panel.h>
>>> +
>>> +#include <linux/gpio/consumer.h>
>>> +#include <linux/of_graph.h>
>>> +#include <linux/regulator/consumer.h>
>>> +
>>> +static const char * const thc63_reg_names[] = {
>>> +	"vcc", "lvcc", "pvcc", "cvcc", };
>>> +
>>> +struct thc63_dev {
>>> +	struct device *dev;
>>> +
>>> +	struct regulator *vccs[ARRAY_SIZE(thc63_reg_names)];
>>> +
>>> +	struct gpio_desc *pwdn;
>>> +	struct gpio_desc *oe;
>>> +
>>> +	struct drm_bridge bridge;
>>> +	struct drm_bridge *next;
>>> +};
>>> +
>>> +static inline struct thc63_dev *to_thc63(struct drm_bridge *bridge)
>>> +{
>>> +	return container_of(bridge, struct thc63_dev, bridge);
>>> +}
>>> +
>>> +static int thc63_attach(struct drm_bridge *bridge)
>>> +{
>>> +	struct thc63_dev *thc63 = to_thc63(bridge);
>>> +
>>> +	return drm_bridge_attach(bridge->encoder, thc63->next, bridge);
>>> +}
>>> +
>>> +static void thc63_enable(struct drm_bridge *bridge)
>>> +{
>>> +	struct thc63_dev *thc63 = to_thc63(bridge);
>>> +	struct regulator *vcc;
>>> +	unsigned int i;
>>> +	int ret;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
>>> +		vcc = thc63->vccs[i];
>>> +		if (vcc) {
>>> +			ret = regulator_enable(vcc);
>>> +			if (ret)
>>> +				goto error_vcc_enable;
>>> +		}
>>> +	}
>>> +
>>> +	if (thc63->pwdn)
>>> +		gpiod_set_value(thc63->pwdn, 0);
>>> +
>>> +	if (thc63->oe)
>>> +		gpiod_set_value(thc63->oe, 1);
>>> +
>>> +	return;
>>> +
>>> +error_vcc_enable:
>>> +	dev_err(thc63->dev, "Failed to enable regulator %u\n", i);
>>> +}
>>> +
>>> +static void thc63_disable(struct drm_bridge *bridge)
>>> +{
>>> +	struct thc63_dev *thc63 = to_thc63(bridge);
>>> +	struct regulator *vcc;
>>> +	unsigned int i;
>>> +	int ret;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
>>> +		vcc = thc63->vccs[i];
>>> +		if (vcc) {
>>> +			ret = regulator_disable(vcc);
>>> +			if (ret)
>>> +				goto error_vcc_disable;
>> I think in disable path you can report an error and continue - should be
>> safer.
>>
> Ack
>
>>> +		}
>>> +	}
>>> +
>>> +	if (thc63->pwdn)
>>> +		gpiod_set_value(thc63->pwdn, 1);
>>> +
>>> +	if (thc63->oe)
>>> +		gpiod_set_value(thc63->oe, 0);
>> Usually disable uses reverse order. Ie first disable oe, then, pwdn,
>> then regulators, also in reverse order.
>> Looks more reasonable.
>>
> Indeed! I will invert the order.
>
> (I wonder if the regulator disabling order actually makes a difference
> though).
>>> +
>>> +	return;
>>> +
>>> +error_vcc_disable:
>>> +	dev_err(thc63->dev, "Failed to disable regulator %u\n", i);
>>> +}
>>> +
>>> +struct drm_bridge_funcs thc63_bridge_func = {
>>> +	.attach	= thc63_attach,
>>> +	.enable = thc63_enable,
>>> +	.disable = thc63_disable,
>>> +};
>>> +
>>> +static int thc63_parse_dt(struct thc63_dev *thc63)
>>> +{
>>> +	struct device_node *thc63_out;
>>> +	struct device_node *remote;
>>> +	int ret = 0;
>>> +
>>> +	thc63_out = of_graph_get_endpoint_by_regs(thc63->dev->of_node, 2, -1);
>> Please define and use enums for port number, it will be more clear.
>>
> yup
>
>>> +	if (!thc63_out) {
>>> +		dev_err(thc63->dev, "Missing endpoint in Port@2\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	remote = of_graph_get_remote_port_parent(thc63_out);
>>> +	if (!remote) {
>>> +		dev_err(thc63->dev, "Endpoint in Port@2 unconnected\n");
>>> +		ret = -ENODEV;
>>> +		goto error_put_out_node;
>>> +	}
>>> +
>>> +	if (!of_device_is_available(remote)) {
>>> +		dev_err(thc63->dev, "Port@2 remote endpoint is disabled\n");
>>> +		ret = -ENODEV;
>>> +		goto error_put_remote_node;
>>> +	}
>>> +
>>> +	thc63->next = of_drm_find_bridge(remote);
>>> +	if (!thc63->next)
>>> +		ret = -EPROBE_DEFER;
>>> +
>>> +error_put_remote_node:
>>> +	of_node_put(remote);
>>> +error_put_out_node:
>>> +	of_node_put(thc63_out);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int thc63_gpio_init(struct thc63_dev *thc63)
>>> +{
>>> +	thc63->pwdn = devm_gpiod_get_optional(thc63->dev, "pwdn",
>>> +					      GPIOD_OUT_LOW);
>> Shouldn't be GPIOD_OUT_HIGH - bridge initially disabled?
> No, the PWDN gpio is active low, it puts the chip in power down mode
> when the physical line level is set to 0.
>
> That's another confusing thing, when requesting the GPIO, the actual
> physical line value has to be provided, while when "set_value()" the
> logical one is requested, iirc.

I think it is opposite, only *raw* functions uses physical level. Other
uses logical level.

>
> Being the GPIO defined as active low, in power enable we set it to
> "logical inactive" == "physical 1", while during power disable it has
> to be set to "logical active" == "physical 0"
>
> Not the right place to complain here, but imo that's not consistent.
> Or have I misinterpreted the APIs? I cannot do much test, as in my setup
> the PWDN pin is hardwired to +vcc (through a physical switch, not
> controlled through a GPIO though).

devm_gpiod_get_optional calls (indirectly) gpiod_configure_flags, which
calls gpiod_direction_output which uses logical levels.

Regards
Andrzej

>
> Thanks
>    j
>
>> Regards
>> Andrzej
>>> +	if (IS_ERR(thc63->pwdn)) {
>>> +		dev_err(thc63->dev, "Unable to get GPIO \"pwdn\"\n");
>>> +		return PTR_ERR(thc63->pwdn);
>>> +	}
>>> +
>>> +	thc63->oe = devm_gpiod_get_optional(thc63->dev, "oe", GPIOD_OUT_LOW);
>>> +	if (IS_ERR(thc63->oe)) {
>>> +		dev_err(thc63->dev, "Unable to get GPIO \"oe\"\n");
>>> +		return PTR_ERR(thc63->oe);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int thc63_regulator_init(struct thc63_dev *thc63)
>>> +{
>>> +	struct regulator **reg;
>>> +	int i;
>>> +
>>> +	reg = &thc63->vccs[0];
>>> +	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++, reg++) {
>>> +		*reg = devm_regulator_get_optional(thc63->dev,
>>> +						   thc63_reg_names[i]);
>>> +		if (IS_ERR(*reg)) {
>>> +			if (PTR_ERR(*reg) == -EPROBE_DEFER)
>>> +				return -EPROBE_DEFER;
>>> +			*reg = NULL;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int thc63_probe(struct platform_device *pdev)
>>> +{
>>> +	struct thc63_dev *thc63;
>>> +	int ret;
>>> +
>>> +	thc63 = devm_kzalloc(&pdev->dev, sizeof(*thc63), GFP_KERNEL);
>>> +	if (!thc63)
>>> +		return -ENOMEM;
>>> +
>>> +	thc63->dev = &pdev->dev;
>>> +	platform_set_drvdata(pdev, thc63);
>>> +
>>> +	ret = thc63_regulator_init(thc63);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = thc63_gpio_init(thc63);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = thc63_parse_dt(thc63);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	thc63->bridge.driver_private = thc63;
>>> +	thc63->bridge.of_node = pdev->dev.of_node;
>>> +	thc63->bridge.funcs = &thc63_bridge_func;
>>> +
>>> +	drm_bridge_add(&thc63->bridge);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int thc63_remove(struct platform_device *pdev)
>>> +{
>>> +	struct thc63_dev *thc63 = platform_get_drvdata(pdev);
>>> +
>>> +	drm_bridge_remove(&thc63->bridge);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +#ifdef CONFIG_OF
>>> +static const struct of_device_id thc63_match[] = {
>>> +	{ .compatible = "thine,thc63lvd1024", },
>>> +	{ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, thc63_match);
>>> +#endif
>>> +
>>> +static struct platform_driver thc63_driver = {
>>> +	.probe	= thc63_probe,
>>> +	.remove	= thc63_remove,
>>> +	.driver	= {
>>> +		.name		= "thc63lvd1024",
>>> +		.of_match_table	= thc63_match,
>>> +	},
>>> +};
>>> +module_platform_driver(thc63_driver);
>>> +
>>> +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
>>> +MODULE_DESCRIPTION("Thine THC63LVD1024 LVDS decoder DRM bridge driver");
>>> +MODULE_LICENSE("GPL v2");
>>

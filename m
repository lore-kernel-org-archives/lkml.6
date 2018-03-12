Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeCLI0r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:26:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49328 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeCLI0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:26:40 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180312082637euoutp0239857dc9d31d318cc3992fcc58d5587a~bHtSNraud0691406914euoutp02J
X-AuditID: cbfec7f2-1c1ff70000011644-77-5aa639bbee70
Subject: Re: [PATCH v2 2/3] drm: bridge: Add LVDS decoder driver
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <c698987c-5fec-da8a-c2a0-80bf11b579a8@samsung.com>
Date: Mon, 12 Mar 2018 09:26:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520603500-15218-3-git-send-email-jacopo+renesas@jmondi.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRTm/W77tFavM9thZdHE0CxNEP2iNAPDr0io/BP7US39MMlLbJla
        VDK7zFs3qWja3VtqpNYyLX80yzEtTddFJXOUZRbLsKxkqTm/Rf57znPOc87zwGFJmYNWsIkp
        +wRNijpJybhT91rGOlY8WFWmWllVH8AVtFsITqe309yVx+0092J0mOE+9jYRXLZxFHFmxy0J
        l3OmRMJZG4sZzjj0leBsVXaGK33dSXDm8ydp7ljTYwn3tLJXEjmXr75cjXjryQKCt52bJPgG
        Q5+EL9JfpPnJ7nckX1eZw/CmZj3i63/aaL4/z0zwg9ZfDF889pPiv9ct2ixVua+JF5IS9wua
        oIid7rvv3hwh9pYEZbRmLc9CnUtzkRsLOARyeyx0LnJnZbgCwanrD1zFDwR/XpcTYvEdwVHb
        E+qfRO9472qUT0leTrgkdgT5753L3FhPHAmNVSMSZ2MevkWAZfg35SxIrEPQZckmnVMM9ofx
        Oz2ME0txBLTozNOYwr5gKjgxjb3wNrh27gMSZzzAcnFgahHLuuGN0DGe7qRJvBiyjUWkiOXQ
        O3Bl2h7gUhZqy9okou8osJ5vYkTsCZ/Nd138QmgrzHdlOwg9n3SUKNYj6HeccAlWQ7O5k3Ye
        JqdM324MEulwcNSYJE4a8BzotnuIHubA2XsXSJGWgv64TJxeAv3PjKSI5VD6fJQ5jXwMM4IZ
        ZqQxzEhj+H/3KqIqkVxI0yYnCNrgFCE9UKtO1qalJATGpSbXoamXbJswj9xHo127TAizSDlb
        GllTqpLR6v3azGQTApZUzpO+8S9TyaTx6swDgiZ1hyYtSdCa0AKWUsql2/0Oq2Q4Qb1P2CMI
        ewXNvy7BuimyEFW+9nKB93BctPTGr4kJ28g6fVJFtLpvxZCCMM3fFPrtXe3vL+tDtlaXzwoe
        HlNUT4Ycis2PCbAXxnyu9xiM2hi2zW/LqwyF70OvS7E+QbpluOpRelxO5trWaGsE7jOseauo
        bHhbW2gM8y4aO3I6IjSvfkN7ONe9qtgrr6HIL6dLrqS0u9XBy0iNVv0XfGDq8o4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42I5/e/4Pd1dlsuiDNY1mVn0njvJZNHU8ZbV
        Yv6Rc6wWV76+Z7N4dmsvk0Xz1q+MFsd/r2W36Jy4hN3i8q45bBZbX75jsniw+i2bxdLrF5ks
        jk/rY7Vo3XuE3eLMqlvsDvwea+atYfS43NfL5PFg6n8mj52z7rJ7zO6Yyerx/8YjZo9NqzrZ
        PA4d7mD02P7tAavH/e7jTB7PL39n85jz8xuLx+dNcgG8UXo2RfmlJakKGfnFJbZK0YYWRnqG
        lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZW1Z+YipYol9xqkGngfGiWhcjJ4eEgIlE
        x+/HTF2MXBxCAksZJe6fes0GkRCX2D3/LTOELSzx51oXG0TRa0aJb08WsIMkhAUcJHat/sQO
        khARWMsk8eTIAmYQh1mgiVFiwuxPUHPvAjmPfrCAtLAJaEr83XwTbAevgJ3EsabjYDaLgKrE
        od52MFtUIEKic+V8FogaQYmTM58A2RwcnAJeEuf/loOEmQXUJf7Mu8QMYctLNG+dDWWLS9x6
        Mp9pAqPQLCTds5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBaWHbsZ+b
        dzBe2hh8iFGAg1GJh3fGpqVRQqyJZcWVuYcYJTiYlUR472guixLiTUmsrEotyo8vKs1JLT7E
        aAr020RmKdHkfGDKyiuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnV
        wBj+Rkvsw5nsIw0Tv7uznTqpqnfu0NzLW7etmNw6Y8U6pvnGSvMKoqvfs3HLtGa2BhvslP3D
        pj75cz9bym/D4CCjfZkf+kMWTwqvELq3YK3eVZdOfomVc8OfRTY+bjO2LzZh/vj307J/KjYh
        rsGub4oZ42+8Df+dclfYQu6YyXp3l7l+YfdUqpVYijMSDbWYi4oTAf/DZMshAwAA
X-CMS-MailID: 20180312082635eucas1p2afec8684135fc2e4b765342e3b3bc8ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180312082635eucas1p2afec8684135fc2e4b765342e3b3bc8ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180309135214epcas5p26c0b31def45b1fb5a41c7adcc9a45f92
X-RootMTR: 20180309135214epcas5p26c0b31def45b1fb5a41c7adcc9a45f92
References: <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org>
        <CGME20180309135214epcas5p26c0b31def45b1fb5a41c7adcc9a45f92@epcas5p2.samsung.com>
        <1520603500-15218-3-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.2018 14:51, Jacopo Mondi wrote:
> Add transparent LVDS decoder driver.
>
> A transparent LVDS decoder is a DRM bridge device that does not require
> any configuration and converts LVDS input to digital CMOS/TTL parallel
> data output.

Neither code, neither bindings are LVDS specific, this is driver for any
bridge w/o configuration.
I  am not sure how many bridges does not need configuration, usually
they need to be powered at least.
I guess in many cases power line is always on, but this is board
specific not device specific.

Looking at previous version of the patchset it looks little bit as a
hack, and certainly it will be a hack in case of R-Car Gen3 V3M Eagle,
which I guess you want to use it.

> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  drivers/gpu/drm/bridge/Kconfig        |   8 +++
>  drivers/gpu/drm/bridge/Makefile       |   1 +
>  drivers/gpu/drm/bridge/lvds-decoder.c | 129 ++++++++++++++++++++++++++++++++++
>  3 files changed, 138 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/lvds-decoder.c
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 3b99d5a..e52a5af 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -32,6 +32,14 @@ config DRM_DUMB_VGA_DAC
>  	help
>  	  Support for RGB to VGA DAC based bridges
>
> +config DRM_LVDS_DECODER
> +	tristate "Transparent LVDS to parallel decoder support"
> +	depends on OF
> +	select DRM_PANEL_BRIDGE
> +	help
> +	  Support for transparent LVDS to parallel decoders that don't require
> +	  any configuration.
> +
>  config DRM_LVDS_ENCODER
>  	tristate "Transparent parallel to LVDS encoder support"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 373eb28..edc2332 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
>  obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
> +obj-$(CONFIG_DRM_LVDS_DECODER) += lvds-decoder.o
>  obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
>  obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
>  obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
> diff --git a/drivers/gpu/drm/bridge/lvds-decoder.c b/drivers/gpu/drm/bridge/lvds-decoder.c
> new file mode 100644
> index 0000000..319f4d5
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lvds-decoder.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LVDS to parallel data DRM bridge driver.
> + *
> + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_panel.h>
> +
> +#include <linux/of_graph.h>
> +
> +struct lvds_decoder {
> +	struct device *dev;
> +
> +	struct drm_bridge bridge;
> +	struct drm_bridge *next;
> +	struct drm_encoder *bridge_encoder;

Unused field.


Regards
Andrzej

> +};
> +
> +static inline struct lvds_decoder *to_lvds_decoder(struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct lvds_decoder, bridge);
> +}
> +
> +static int lvds_decoder_attach(struct drm_bridge *bridge)
> +{
> +	struct lvds_decoder *lvds = to_lvds_decoder(bridge);
> +
> +	return drm_bridge_attach(bridge->encoder, lvds->next, bridge);
> +}
> +
> +struct drm_bridge_funcs lvds_dec_bridge_func = {
> +	.attach	= lvds_decoder_attach,
> +};
> +
> +static int lvds_decoder_parse_dt(struct lvds_decoder *lvds)
> +{
> +	struct device_node *lvds_output;
> +	struct device_node *remote;
> +	int ret = 0;
> +
> +	lvds_output = of_graph_get_endpoint_by_regs(lvds->dev->of_node, 1, -1);
> +	if (!lvds_output) {
> +		dev_err(lvds->dev, "Missing endpoint in Port@1\n");
> +		return -ENODEV;
> +	}
> +
> +	remote = of_graph_get_remote_port_parent(lvds_output);
> +	if (!remote) {
> +		dev_err(lvds->dev, "Endpoint in Port@1 unconnected\n");
> +		ret = -ENODEV;
> +		goto error_put_lvds_node;
> +	}
> +
> +	if (!of_device_is_available(remote)) {
> +		dev_err(lvds->dev, "Port@1 remote endpoint is disabled\n");
> +		ret = -ENODEV;
> +		goto error_put_remote_node;
> +	}
> +
> +	lvds->next = of_drm_find_bridge(remote);
> +	if (!lvds->next)
> +		ret = -EPROBE_DEFER;
> +
> +error_put_remote_node:
> +	of_node_put(remote);
> +error_put_lvds_node:
> +	of_node_put(lvds_output);
> +
> +	return ret;
> +}
> +
> +static int lvds_decoder_probe(struct platform_device *pdev)
> +{
> +	struct lvds_decoder *lvds;
> +	int ret;
> +
> +	lvds = devm_kzalloc(&pdev->dev, sizeof(*lvds), GFP_KERNEL);
> +	if (!lvds)
> +		return -ENOMEM;
> +
> +	lvds->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, lvds);
> +
> +	ret = lvds_decoder_parse_dt(lvds);
> +	if (ret)
> +		return ret;
> +
> +	lvds->bridge.driver_private = lvds;
> +	lvds->bridge.of_node = pdev->dev.of_node;
> +	lvds->bridge.funcs = &lvds_dec_bridge_func;
> +
> +	drm_bridge_add(&lvds->bridge);
> +
> +	return 0;
> +}
> +
> +static int lvds_decoder_remove(struct platform_device *pdev)
> +{
> +	struct lvds_decoder *lvds = platform_get_drvdata(pdev);
> +
> +	drm_bridge_remove(&lvds->bridge);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id lvds_decoder_match[] = {
> +	{ .compatible = "lvds-decoder", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, lvds_decoder_match);
> +#endif
> +
> +static struct platform_driver lvds_decoder_driver = {
> +	.probe	= lvds_decoder_probe,
> +	.remove	= lvds_decoder_remove,
> +	.driver	= {
> +		.name		= "lvds_decoder",
> +		.of_match_table	= lvds_decoder_match,
> +	},
> +};
> +module_platform_driver(lvds_decoder_driver);
> +
> +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
> +MODULE_DESCRIPTION("Transparent LVDS to parallel data decoder");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
>
>
>
